<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<tags:page title="About">
    <jsp:attribute name="description">
        ZoaTrack is a free-to-use web-based platform for analysing and visualising
        individual-based animal location data.
    </jsp:attribute>
    <jsp:attribute name="head">
        <style type="text/css">
            #about-buttons .btn {
                margin: 9px 0;
                height: 60px;
                line-height: 40px;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="tail">
        <script type="text/javascript">
            $(document).ready(function() {
                $('#navAbout').addClass('active');
            });
        </script>
    </jsp:attribute>
    <jsp:attribute name="breadcrumbs">
        <a href="${pageContext.request.contextPath}/">Home</a>
        &rsaquo; <span class="active">About</span>
    </jsp:attribute>
    <jsp:body>
        <h1>About ZoaTrack</h1>
        <h2>Australian initiative</h2>
        <p>ZoaTrack emerged from the OzTrack system which was originally developed at The University of Queensland in 2010-11 with the support of the Australian National Data Service (ANDS).  It was then funded under the  NeCTAR-funded eResearch Tool project from 2012 to 2014 and is now supported and maintained by the <a href="https://github.com/atlasoflivingaustralia" target="_blank">Atlas of Living Australia</a>.</p>

        <h2>Swedish adaptation</h2>
        <p>This website is an adaptation of the open-source <a href="https://zoatrack.org/" target="_blank">Australian version</a>, you can find <a href="https://github.com/bioatlas/zoa-docker" target="_blank">our code here</a>. We currently work on a more advanced module that could be able to handle different tracking and sensor data.</p> 
        <p>If you're interested in it, please contact Johan Bäckman or Mathieu Blanchet at zoatrack@bioatlas.se</p>
            

        <h2>Further information</h2>
        <div id="about-buttons" class="row">
           <c:if test="${not empty settings.publicationsText}">
            <div class="span6">
                <a class="btn btn-large btn-block" href="${pageContext.request.contextPath}/about/publications">Publications</a>
            </div>
            </c:if>
            <div class="span6">
                <a class="btn btn-large btn-block" href="${pageContext.request.contextPath}/about/software">Software information</a>
            </div>
            <div class="span6">
                <a class="btn btn-large btn-block" href="${pageContext.request.contextPath}/about/layers">Environmental layers</a>
            </div>
            <div class="span6">
                <a class="btn btn-large btn-block" href="${pageContext.request.contextPath}/about/artwork">Artwork credits</a>
            </div>
            <div class="span6">
            </div>
        </div>
    </jsp:body>
</tags:page>
