<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<tags:page title="Toolkit">
    <jsp:attribute name="description">
        ZoaTrack is a free-to-use web-based platform
        for analysing and visualising individual-based animal location data.
    </jsp:attribute>
    <jsp:attribute name="tail">
        <style type="text/css">
            .nav-tabs > li > a {
                text-decoration:none;
                font-weight:bold

            }
            .nav > li > a:hover {
                background-color:#f0f0da;
            }
        </style>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/home.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#navToolkit').addClass('active');
                $('#toolkit-tabs a[href="#${section}"]').tab('show');
            });
        </script>
    </jsp:attribute>
    <jsp:attribute name="breadcrumbs">
        <a href="${pageContext.request.contextPath}/">Home</a>
        &rsaquo; <span class="active">Toolkit</span>
    </jsp:attribute>
    <jsp:body>

        <c:if test="${!empty section}">
            <input type="hidden" id="nav-section" value="${section}"/>
        </c:if>

        <div class="tabbable" >

            <ul class="nav nav-tabs" id="toolkit-tabs">
                <li class="active"><a href="#getstarted" data-toggle="tab">Getting Started</a></li>
                <li><a href="#analysis" data-toggle="tab">The Analysis Toolkit</a></li>
                <li><a href="#datamgt" data-toggle="tab">Data Management</a></li>
                <li><a href="#doi" data-toggle="tab">Publication & Citation</a></li>
            </ul>

            <div class="tab-content">

                <div class="tab-pane active" id="getstarted">

                    <ul style="list-style-type:none">
                        <li><a href="#data-vis">Viewing tracks</a></li>
                        <li><a href="#mov-metrics">Extracting movement metrics</a></li>
                        <li><a href="#my-data">How can I upload my data on ZoaTrack ?</a></li>
                    </ul>
                    <hr/>

                    <div class="media" id="data-vis">
                        <div class="media-body">
                            <h4 class="media-heading">Viewing tracks</h4>
                                <p>
                                    The tracks can be accessed from the Project page by clicking ‘Tracks and analysis’ (located on the top panel under the Project menu) , or by clicking the View Tracks icon in the right of the screen.
                                    Alternatively, existing tracks can be accessed from Open projects (or projects that you have access rights to) directly from the ZoaTrack Repository. These can be accessed by clicking Browse the Repository in the website header, then searching for your relevant project – e.g. “Moose Translocation”
                                    This opens an interactive map showing the relocations contained in the tracking file plotted on a Google maps layer. Also shown are the trajectory the animals took (lines) and the start and end locations (green and red points).
                                    The page always faces due north, and a scale is displayed in the bottom left of the map. In the top left of the map are tools to pan (hand) and zoom (+/-) around the map and measure distances (ruler).
                                </p>
                        </div>
                    </div>
                    <hr/>

                    <div class="media" id="mov-metrics">
                        <div class="media-body">
                            <h4 class="media-heading">Extracting movement metrics</h4>
                            <p>
                                On visualising the animal tracks, movement metrics for each tagged animal are provided in the left hand window. These include:</p>
                                <ol>
                                    <li>the date range</li>
                                    <li>the total number of locations for that animal</li>
                                    <li>the mean number of detections per day</li>
                                    <li>the maximum number of detections per day</li>
                                    <li>the distance moved along the track (km) – Estimated using Great circle distances on longitude latitude coordinates (Decimal Degrees)</li>
                                    <li>the mean step length (km)</li>
                                    <li>the mean step speed (km/h)</li>
                                </ol>
                            <p>These field are automatically updated when a new date range is provided, or if tracks are edited using the Edit tracks tool.
                            </p>
                        </div>
                    </div>

                    <div class="media" id="my-data">
                        <div class="media-body">
                            <h4 class="media-heading">How can I upload my data on ZoaTrack ?</h4>
                            <p>
                                blablabla contact us addresse@email
                            </p>
                        </div>
                    </div>

                </div>

                <div class="tab-pane" id="analysis">

                    <p>
                        ZoaTrack provides a series of tools with which to analyse your animal tracking datasets.
                        These include tools to visualise and extract movement metrics from tagged animals based on a date range (project layers: Trajectory and Detections) and tools to run more complex spatial analyses and extract home range estimates.
                        These tools are available on the Tracks and analysis page by clicking the ‘Analysis’ tab and selecting a one of the tools.
                    </p>

                    <ul style="list-style-type:none">
                        <li><a href="#home-range">Calculate home range area</a></li>
                        <c:forEach items="${analysisTypeList}" var="analysisType">
                            <li><a href="#${analysisType.toString()}"><c:out value="${analysisType.displayName}"/></a></li>
                        </c:forEach>
                    </ul>
                    <hr/>

                    <div class="media" id="home-range">
                        <h4>Calculate home range area</h4>
                        <div class="media-body">
                            <p>
                            The following tools estimate each animal’s home range as a measure of individual space usage. An animal’s home range is the area in which it lives and travels. This area is closely related to (but not identical with) the concept of "territory", which is the area that is actively defended by an individual. There are many variations of home range analysis, each has its own advantages and disadvantages depending on the data. More information and links to the respective publications are obtained by clicking the (?) located next to each home range tool. The choice of home range estimator and the parameter values can have a huge bearing on the final home range estimates.
                            It is also possible to limit the date range (Dates) and/or the Animals from which home ranges and movement metrics are generated. Simply edit the date range and select the animals you are interested in, and then run the analyses. The results are displayed under the Animals tab in the left panel of the screen.
                            </p>
                        </div>
                    </div>
                    <hr/>

                    <c:forEach items="${analysisTypeList}" var="analysisType">

                        <div class="media" id="${analysisType.toString()}">
                            <h4><c:out value="${analysisType.displayName}"/></h4>
                            <div class="media-body">
                              ${analysisType.explanation}
                            </div>
                        </div>
                        <hr/>

                    </c:forEach>

                </div>

                <div class="tab-pane" id="datamgt">

                    <ul style="list-style-type:none">
                        <li><a href="#g-earth">Exploring the data in Google Earth</a></li>
                        <li><a href="#speed">Speed Filter</a></li>
                        <li><a href="#argos">Argos Location Class and Dilution of Precision Filter</a></li>
                        <li><a href="#kalman"> Kalman filter and Kalman filter SST</a></li>
                    </ul>


                <div class="media" id="g-earth">
                    <h4>Exploring the data in Google Earth</h4>
                    <div class="media-body">
                        <p>
                            To gain a fuller understanding of the movements of the animals, it is useful to visualise the animal’s trajectory through time.
                        </p>
                        <ol>
                            <li>If not already installed, download Google earth from  http://www.google.com/earth/index.html</li>
                            <li>In ZoaTrack, make sure you are still on the ‘Animals’ tab in the Tracks and analysis page.</li>
                            <li>Below an animal ID, click ‘KML’ in the Trajectory box. This will convert the ZoaTrack -generated trajectory into a Google earth file.</li>
                            <li>Click the downloaded .kml file to open and view in Google earth.</li>
                            <li>The tracks in your ZoaTrack project are now visible with the last location represented as an arrow. You can visualise the animal’s trajectory through time by moving the time slider in the top left corner of Google Earth.</li>
                            <li>To visualise the home ranges, click ‘KML’ in the MCP results box or that of any other home ranges you may have generated. This will convert the ZoaTrack -generated home range polygon into a Google Earth file.</li>
                            <li>Click the downloaded .kml file to open and view in Google earth.
                        </ol>
                    </div>
                </div>
                <hr/>


                <div class="media" id="speed">
                    <h4>Speed filter</h4>
                    <div class="media-body">
                        <p>
                            You can select a speed filter to remove unlikely locations (i.e. those where the animal would have to attain a certain sustained velocity to achieve: e.g.> 50 km/h). To use this tool, click Speed filter and type in a Maximum speed that you animal could hypothetically obtain. Click Apply filter and those relocations exceeding this maximum will have been removed.
                            When you are happy with your tracks, click the arrow next to ‘Back to Project’ at the top of the left panel and select ‘Tracks and analysis’.
                        </p>
                    </div>
                </div>
                <hr/>

                <div class="media" id="argos">
                    <h4>Argos Location Class and Dilution of Precision Filter</h4>
                    <div class="media-body">
                        <p>
                            If your location dataset had a column containing the Argos Location Class (Argos tracking data only) or a DOP Class (GPS data only), this filter can be applied to remove locations with a low estimated accuracy. To use this tool, click the relevant filter (Argos or DOP) and apply the minimum accuracy with which you wish to visualise and run subsequent analyses on. Click Apply filter and those relocations exceeding this minimum will have been removed.
                            When you are happy with your tracks, click the arrow next to ‘Back to Project’ at the top of the left panel and select ‘Tracks and analysis’
                        </p>
                    </div>
                </div>
                <hr/>

                <div class="media" id="kalman">
                    <h4>Kalman filter and Kalman filter SST</h4>
                    <div class="media-body">
                        <p>
                            Often telemetry technologies with low precision and accuracy can result in highly improbable animal trajectories. For example, studies on the accuracy of light-based geolocation have recognized that raw geolocations are often imprecise and biased, particularly for estimates of latitude during equinox periods.
                            The state-space Kalman filter approach can estimate the “most probable” track from imprecise and biased location estimates (and sea surface information if it is available from the tag sensor). These models are adapted from the kftrack and ukfsst functions developed by Nielsen and Sibert, 2004 and Lam, Nielsen & Sibert, 2008.
                            Click Kalman filter and use your known information on the start and end date and location to match the actual days when the tag was deployed and retrieved. By providing a known start and end location, this can often provide a more realistic track for a given set of noisy data. Note, please enter the numbers only, without units (e.g. without ° E)
                            Click Run filter to run the kalman filter (kftrack) on the raw geolocation data.
                            The spinning wheel will show that ZoaTrack is processing your request. Once the Kalman filter is complete, the ‘most probable’ track (white triangles) will be overlaid on the original track. On completion the model parameters and model results will be displayed on the left of the map
                            Models can also be re-run with a new set of parameters by editing the Advanced parameters fields.  The systematic error (or bias) in the estimation of position of Longitude and Latitude can be changed to 0 degrees by deselecting bx.active and by.active buttons. The systematic error can be adjusted on the Longitude and Latitude by entering the predicted error.
                            Click Run filter to re-run the kalman filter
                            To replace the original track and calculate the movement metrics for this filtered track (i.e. track length, step length, speed), click Replace track. The original data points now appear as red crosses.
                            When you are happy with your tracks, click the arrow next to ‘Back to Project’ at the top of the left panel and select ‘Tracks and analysis’. The movement metrics for the Kalman filtered track are now displayed in the left hand window
                        </p>
                    </div>
                </div>
                <hr/>
            </div>

                <div class="tab-pane" id="doi">
                    <ul style="list-style-type:none">

                        <li><a href="#cite-2">Using and Citing data from the ZoaTrack data repository</a></li>
                        <li><a href="#cite-3">Cite the ZoaTrack platform</a></li>
                    </ul>

                    <div class="media" id="cite-2">
                        <h4>Using and Citing data from the ZoaTrack data repository</h4>
                        <div class="media-body">
                            <p>If you use data from ZoaTrack in any type of publication then you must cite the project
                            DOI (if available) or any published peer-reviewed papers associated with the study. We
                            strongly encourage you to contact the data custodians to discuss data usage and appropriate
                            accreditation.</p>
                        </div>
                    </div>

                    <div class="media" id="cite-3">
                        <h4>Cite the ZoaTrack platform</h4>
                        <div class="media-body">
                            <p>If you publish data from the ZoaTrack data repository or use any of the analysis tools
                                to process and sythesise your animal tracking data then please citethe following paper:</p>
                            <p style="font-style:italic">R. G. Dwyer, C. Brooking, W. Brimblecombe, H. A. Campbell, J. Hunter, M. E. Watts, C. E. Franklin, "An open Web-based system for the analysis and sharing of animal tracking data", Animal Biotelemetry 3:1, 29 Jan 2015, DOI 10.1186/s40317-014-0021-8.</p>
                            <p>References for specific analysis tools can be found <a href="${pageContext.request.contextPath}/toolkit/analysis#analysis">here</a>.</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>


    </jsp:body>
</tags:page>
