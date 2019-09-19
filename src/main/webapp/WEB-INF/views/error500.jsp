<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ page isErrorPage="true"%>

<tags:page title="Error500">
    <jsp:attribute name="description">
    	Error 500
    </jsp:attribute>

    <jsp:body>
		<b>Oops! A 500 error happened because... who knows ?</b>
	</jsp:body>
</tags:page>