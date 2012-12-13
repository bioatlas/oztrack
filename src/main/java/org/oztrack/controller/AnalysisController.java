package org.oztrack.controller;

import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONException;
import org.json.JSONWriter;
import org.oztrack.data.access.AnalysisDao;
import org.oztrack.data.model.Analysis;
import org.oztrack.data.model.AnalysisParameter;
import org.oztrack.data.model.Animal;
import org.oztrack.data.model.User;
import org.oztrack.data.model.types.AnalysisStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AnalysisController {
    protected final Log logger = LogFactory.getLog(getClass());

    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private AnalysisDao analysisDao;

    @Autowired
    private OzTrackPermissionEvaluator permissionEvaluator;

    @InitBinder("analysis")
    public void initAnalysisBinder(WebDataBinder binder) {
        binder.setAllowedFields();
    }

    @ModelAttribute("analysis")
    public Analysis getAnalysis(@PathVariable(value="analysisId") Long analysisId) {
        return analysisDao.getAnalysisById(analysisId);
    }

    private boolean canRead(Authentication authentication, HttpServletRequest request, Analysis analysis) {
        if (permissionEvaluator.hasPermission(authentication, analysis.getProject(), "read")) {
            return true;
        }
        User currentUser = permissionEvaluator.getAuthenticatedUser(authentication);
        if ((currentUser != null) && currentUser.equals(analysis.getCreateUser())) {
            return true;
        }
        HttpSession currentSession = request.getSession(false);
        if ((currentSession != null) && currentSession.getId().equals(analysis.getCreateSession())) {
            return true;
        }
        return false;
    }

    @RequestMapping(value="/projects/{projectId}/analyses/{analysisId}", method=RequestMethod.GET, produces="application/json")
    @PreAuthorize("permitAll")
    public void handleJSON(
        Authentication authentication,
        HttpServletRequest request,
        HttpServletResponse response,
        @ModelAttribute(value="analysis") Analysis analysis
    ) throws IOException, JSONException {
        if (!canRead(authentication, request, analysis)) {
            response.setStatus(403);
            return;
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Thu, 01 Jan 1970 00:00:00 GMT");
        JSONWriter out = new JSONWriter(response.getWriter());
        out.object();
        out.key("id").value(analysis.getId());
        out.key("params").object();
        out.key("queryType").value(analysis.getAnalysisType());
        if (analysis.getFromDate() != null) {
            out.key("fromDate").value(dateFormat.format(analysis.getFromDate()));
        }
        if (analysis.getToDate() != null) {
            out.key("toDate").value(dateFormat.format(analysis.getToDate()));
        }
        out.key("animalIds").array();
        for (Animal animal : analysis.getAnimals()) {
            out.value(animal.getId());
        }
        out.endArray();
        out.key("animalNames").array();
        for (Animal animal : analysis.getAnimals()) {
            out.value(animal.getAnimalName());
        }
        out.endArray();
        for (AnalysisParameter parameter : analysis.getParameters()) {
            out.key(parameter.getName()).value(parameter.getValue());
        }
        out.endObject();
        out.key("status").value(analysis.getStatus().name());
        if (analysis.getMessage() != null) {
            out.key("message").value(analysis.getMessage());
        }
        if (analysis.getStatus() == AnalysisStatus.COMPLETE) {
            String resultUrl = String.format("%s/projects/%d/analyses/%d/result", request.getContextPath(), analysis.getProject().getId(), analysis.getId());
            out.key("resultUrl").value(resultUrl);
        }
        out.endObject();
    }

    @RequestMapping(value="/projects/{projectId}/analyses/{analysisId}/result", method=RequestMethod.GET, produces="application/vnd.google-earth.kml+xml")
    @PreAuthorize("permitAll")
    public void handleResultKML(
        Authentication authentication,
        HttpServletRequest request,
        HttpServletResponse response,
        @ModelAttribute(value="analysis") Analysis analysis
    ) {
        if (!canRead(authentication, request, analysis)) {
            response.setStatus(403);
            return;
        }
        if (analysis.getStatus() == AnalysisStatus.FAILED) {
            response.setStatus(500);
            writeResultError(response, analysis.getMessage());
            return;
        }
        if ((analysis.getStatus() == AnalysisStatus.NEW) || (analysis.getStatus() == AnalysisStatus.PROCESSING)) {
            response.setStatus(404);
            writeResultError(response, "Processing");
            return;
        }
        String filename = analysis.getAnalysisType().name().toLowerCase(Locale.ENGLISH) + ".kml";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setContentType("application/vnd.google-earth.kml+xml");
        response.setCharacterEncoding("UTF-8");
        Reader kmlReader = null;
        Reader xslReader = null;
        try {
            kmlReader = new FileReader(analysis.getAbsoluteResultFilePath());
            xslReader = buildXslReader(analysis);
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer(new StreamSource(xslReader));
            transformer.transform(new StreamSource(kmlReader), new StreamResult(response.getOutputStream()));
        }
        catch (Exception e) {
            response.setStatus(500);
            writeResultError(response, "Error writing KML response.");
            return;
        }
        finally {
            IOUtils.closeQuietly(kmlReader);
            IOUtils.closeQuietly(xslReader);
        }
    }

    private Reader buildXslReader(Analysis analysis) {
        StringBuilder xslBuilder = new StringBuilder();
        xslBuilder.append("<?xml version=\"1.0\" ?>");
        xslBuilder.append("<xsl:stylesheet");
        xslBuilder.append("  xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"");
        xslBuilder.append("  xmlns:kml=\"http://www.opengis.net/kml/2.2\"");
        xslBuilder.append("  xmlns=\"http://www.opengis.net/kml/2.2\"");
        xslBuilder.append("  version=\"1.0\">");
        // Wwe're only making small changes to the KML, so copy elements through by default
        xslBuilder.append("  <xsl:template match=\"@*|node()\">");
        xslBuilder.append("    <xsl:copy>");
        xslBuilder.append("      <xsl:apply-templates select=\"@*|node()\"/>");
        xslBuilder.append("    </xsl:copy>");
        xslBuilder.append("  </xsl:template>");
        // Insert Style elements for each animal as the start of the Document
        xslBuilder.append("  <xsl:template match=\"//kml:Document\">");
        xslBuilder.append("    <xsl:copy>");
        for (Animal animal : analysis.getAnimals()) {
            // Convert CSS colour (RRGGBB) to KML colour (AABBGGRR)
            Matcher matcher = Pattern.compile("^#(..)(..)(..)$").matcher(animal.getColour());
            if (matcher.matches()) {
                String kmlBaseColour = matcher.group(3) + matcher.group(2) + matcher.group(1);
                String kmlLineColour = "cc" + kmlBaseColour; // 80% opacity
                String kmlPolyColour = "7f" + kmlBaseColour; // 50% opacity
                xslBuilder.append("      <Style id=\"animal-" + animal.getId() + "\">");
                xslBuilder.append("        <LineStyle>");
                xslBuilder.append("          <color>" + kmlLineColour + "</color>");
                xslBuilder.append("          <width>2</width>");
                xslBuilder.append("        </LineStyle>");
                xslBuilder.append("        <PolyStyle>");
                xslBuilder.append("          <color>" + kmlPolyColour + "</color>");
                xslBuilder.append("        </PolyStyle>");
                xslBuilder.append("      </Style>");
            }
        }
        xslBuilder.append("      <xsl:apply-templates select=\"@*|node()\"/>");
        xslBuilder.append("    </xsl:copy>");
        xslBuilder.append("  </xsl:template>");
        // Remove default styles from animals
        xslBuilder.append("  <xsl:template match=\"//kml:Placemark[.//kml:SimpleData[@name='id']]/kml:Style\">");
        xslBuilder.append("    <!-- remove default styles -->");
        xslBuilder.append("  </xsl:template>");
        // Insert styleUrl elements referring to Style for each animal
        xslBuilder.append("  <xsl:template match=\"//kml:Placemark[.//kml:SimpleData[@name='id']]\">");
        xslBuilder.append("    <xsl:copy>");
        xslBuilder.append("      <styleUrl>#animal-<xsl:apply-templates select=\".//kml:SimpleData[@name='id']/text()\"/></styleUrl>");
        xslBuilder.append("      <xsl:apply-templates select=\"@*|node()\"/>");
        xslBuilder.append("    </xsl:copy>");
        xslBuilder.append("  </xsl:template>");
        xslBuilder.append("</xsl:stylesheet>");
        return new StringReader(xslBuilder.toString());
    }

    private static void writeResultError(HttpServletResponse response, String error) {
        PrintWriter out = null;
        try {
            out = response.getWriter();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }
        out.append("<?xml version=\"1.0\"?>\n");
        out.append("<analysis-result-response xmlns=\"http://oztrack.org/xmlns#\">\n");
        out.append("    <error>" + StringUtils.trim(error) + "</error>\n");
        out.append("</analysis-result-response>\n");
    }
}