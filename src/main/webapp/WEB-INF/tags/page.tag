<!DOCTYPE html>
<%@ tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ tag import="org.oztrack.app.OzTrackApplication" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="description" required="false" %>
<%@ attribute name="head" required="false" fragment="true" %>
<%@ attribute name="tail" required="false" fragment="true" %>
<%@ attribute name="breadcrumbs" required="false" fragment="true" %>
<%@ attribute name="navExtra" required="false" fragment="true" %>
<%@ attribute name="sidebar" required="false" fragment="true" %>
<%@ attribute name="fluid" required="false" type="java.lang.Boolean" %>
<c:set var="baseUrl"><%= OzTrackApplication.getApplicationContext().getBaseUrl() %></c:set>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <c:if test="${not empty description}">
        <meta name="description" content="${description}" />
    </c:if>
    <title>ZoaTrack${(not empty title) ? ': ' : ' - '}${(not empty title) ? title : 'Free Animal Tracking Software'}</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/optimised/core.css"/>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ala-docker/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ala-docker/css/ala-styles.css"/>
    <link rel='stylesheet' id='fontawesome-css'  href='//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css?ver=4.7.0' type='text/css' media='all' />

    <jsp:invoke fragment="head"/>
</head>
<body>

<style>
.topnav .icon {
  display: none;
}

@media screen and (max-width: 1200px) {
  .topnav li {display: none;}
  .topnav a.icon {
    float: right;
    display: block;
  }
}

@media screen and (max-width: 1200px) {
  .topnav.responsive {position: relative;}
  .topnav.responsive .icon {
    position: absolute;
    right: 0;
    top: 0;
  }
  .topnav.responsive li {
    float: none;
    display: block;
    text-align: left;
  }

  #container-navbar-custom {
    width:auto;
  }
}
</style>


<script>
function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
    x.className += " responsive";
  } else {
    x.className = "topnav";
  }
}
</script>

<div id="header_custom" class="navbar navbar-default navbar-fixed-top" style="width:100%;">
    <div id="container-navbar-custom" class="container${fluid ? '-fluid' : ''}">
        <div class="navbar-static-top">
            <div id="myTopnav" class="topnav">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                   <img src="${pageContext.request.contextPath}/img/zoatrack_logo.png"/></a>
                <a class="navbar-brand" href="https://bioatlas.se/" target="_blank"><img alt="Brand" src="https://bioatlas.se/wp-content/themes/atlas/img/bas-logo-2016-inline.png"></a>   
                <ul class="nav">
                    <c:if test="${!empty navExtra}">
                        <jsp:invoke fragment="navExtra"/>
                    </c:if>
                    <li id="liSearch" class="dropdown">
                        <a id="navSearch" role="button" href="${pageContext.request.contextPath}/projects">Data</b></a>
                    </li>
                    <li id="navToolkit" class="dropdown">
                        <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">About<b class="caret"></b></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="drop2">
                            <!--<li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/projects/new">Create a Project</a></li>-->
                            <li role="presentation" class="divider"></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/toolkit/getstarted">Getting Started</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/toolkit/analysis">The Analysis Toolkit</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/toolkit/datamgt">Data Management</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/toolkit/doi">Publication & Citation</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/about/layers">Environment Layers</a></li>
                            <li role="presentation" class="divider"></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/about">About ZoaTrack</a></li>
                        </ul>
                    </li>
                    <li id="navContact"><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                   <c:choose>
                        <c:when test="${currentUser != null}">
                            <li id="navLogin" class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-user icon-white"></i>&nbsp;&nbsp;<c:out value="${currentUser.fullName}"/> <b class="caret"></b></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/projects">Projects</a></li>
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/projects/new">Create a Project</a></li>
                                    <li role="presentation" class="divider"></li>
                                    <li><a href="${pageContext.request.contextPath}/users/${currentUser.id}/edit">Edit profile</a></li>
                                    <c:if test="${currentUser.admin}">
                                        <li><a href="${pageContext.request.contextPath}/settings">Settings</a></li>
                                    </c:if>
                                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <%--<li><a href="${fn:replace(baseUrl, 'http://', 'https://')}/login">Login</a></li>
                            <li><a href="${fn:replace(baseUrl, 'http://', 'https://')}/users/new">Register</a></li>--%>
                            <li><a href="/login">Login</a></li>
                            <!--<li><a href="/users/new">Register</a></li>-->
                        </c:otherwise>
                    </c:choose>
                </ul>
                <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <i class="fa fa-bars"></i>
  </a>
            </div>
        </div>
    </div>
</div>


<div id="main">
    <div class="container${fluid ? '-fluid' : ''}">
        <c:if test="${!empty breadcrumbs}">
            <div id="crumbs">
                <jsp:invoke fragment="breadcrumbs"/>
            </div>
        </c:if>
        <jsp:invoke var="sidebarContent" fragment="sidebar"/>
        <div class="row${fluid ? '-fluid' : ''}">
            <c:if test="${!empty sidebarContent}">
                <div id="left-menu" class="span3">
                        ${sidebarContent}
                </div>
            </c:if>
            <div id="content" class="${empty sidebarContent ? 'span12' : 'span9'}">
                <jsp:doBody/>
                <div style="clear:both;"></div>
            </div> <!-- content -->
        </div>
    </div>
</div>

<c:if test="${not fluid}">
    <div id="footer">
        <%@ include file="../../ala-docker/footer.html" %>
    </div>
</c:if>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/optimised/core.js"></script>
<jsp:invoke fragment="tail"/>
<c:out value="${customJs}" escapeXml="false"/>
</body>
</html>
