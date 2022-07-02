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
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">

	<!-- Header -->
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	
	<!-- Shop -->
	<p class="w3-padding-16"><span class="w3-white w3-hover-white w3-xxlarge mt-2">SHOP</span></p>
	<!-- 
	<div class="w3-row" id="myGrid" style="margin-bottom:128px">
	  <div class="w3-third">
	    <img src="/w3images/rocks.jpg" style="width:100%">
	    <img src="/w3images/sound.jpg" style="width:100%">
	    <img src="/w3images/woods.jpg" style="width:100%">
	    <img src="/w3images/rock.jpg" style="width:100%">
	    <img src="/w3images/nature.jpg" style="width:100%">
	    <img src="/w3images/mist.jpg" style="width:100%">
	  </div>
	
	  <div class="w3-third">
	    <img src="/w3images/coffee.jpg" style="width:100%">
	    <img src="/w3images/bridge.jpg" style="width:100%">
	    <img src="/w3images/notebook.jpg" style="width:100%">
	    <img src="/w3images/london.jpg" style="width:100%">
	    <img src="/w3images/rocks.jpg" style="width:100%">
	    <img src="/w3images/avatar_g.jpg" style="width:100%">
	  </div>
	
	  <div class="w3-third">
	    <img src="/w3images/mist.jpg" style="width:100%">
	    <img src="/w3images/workbench.jpg" style="width:100%">
	    <img src="/w3images/gondol.jpg" style="width:100%">
	    <img src="/w3images/skies.jpg" style="width:100%">
	    <img src="/w3images/lights.jpg" style="width:100%">
	    <img src="/w3images/workshop.jpg" style="width:100%">
	  </div>
	</div>
	 -->

<!-- footer  -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
 
<!-- End Page Content -->
</div>
 
</body>
</html>
