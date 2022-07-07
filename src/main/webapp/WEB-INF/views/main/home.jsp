<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>The Garden</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<style type="text/css">
	#discountPrice {
		text-decoration: line-through;
	}
	img {
		margin-top: 10px;
	}
</style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">

	<!-- Header -->
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	
	<!-- Shop -->
	<p style="margin-left: 20px;"><span class="w3-white w3-xxlarge mt-2">SHOP</span></p>
	<jsp:include page="/WEB-INF/views/include/mainContent.jsp" />
 	
<!-- footer  -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
 
<!-- End Page Content -->
</div>
 
</body>
</html>
