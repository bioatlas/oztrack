<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<tags:page title="Environmental layers">
    <jsp:attribute name="description">
        ZoaTrack is a free-to-use web-based platform for analysing and visualising
        individual-based animal location data. ZoaTrack incorporates a number of
        external environmental layers.
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
        &rsaquo; <a href="${pageContext.request.contextPath}/about">About</a>
        &rsaquo; <span class="active">Environmental layers</span>
    </jsp:attribute>
    <jsp:body>
        <h1>Environmental layers</h1>
        <ul class="icons">
            <li class="layer">
                <a href="https://developers.google.com/maps/documentation/javascript/maptypes">Google Satellite</a>,
                <a href="https://developers.google.com/maps/documentation/javascript/maptypes">Google Physical</a>,
                <a href="https://developers.google.com/maps/documentation/javascript/maptypes">Google Streets</a>,
                <a href="https://developers.google.com/maps/documentation/javascript/maptypes">Google Hybrid</a>:<br />
                accessed via the <a href="https://developers.google.com/maps/documentation/javascript/">Google Maps JavaScript API</a>;<br />
                used according to the <a href="https://developers.google.com/maps/terms">Google Maps/Google Earth APIs Terms of Service</a>.
            </li>

        </ul>
    </jsp:body>
</tags:page>
