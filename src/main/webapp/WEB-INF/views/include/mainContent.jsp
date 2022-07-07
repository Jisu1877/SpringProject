<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
  <!-- Category 보이기  -->
  <div style="margin-bottom: 50px; margin-left: 16px;">
	<div class="w3-bar" style="font-size: 13px;">
	   <c:forEach var="vo" items="${categoryVOS}" varStatus="st">
			<div class="w3-dropdown-hover">
				<button class="btn w3-white w3-hover-white" style="font-size: 18px;">${vo.category_group_name}</button>
				<div class="w3-dropdown-content w3-bar-block w3-hover-white">
					<c:set var="i" value="0"/>
					<c:forEach var="cVO" items="${vo.categoryList}">
						<a href="#" class="w3-bar-item btn">${cVO.category_name}</a>
					 </c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
  </div>
  <jsp:include page="/WEB-INF/views/include/mainItemContent.jsp" />

  <!-- Pagination -->
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
      <a href="#" class="w3-bar-item w3-button w3-hover-black">«</a>
      <a href="#" class="w3-bar-item w3-black w3-button">1</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">2</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">3</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">4</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">»</a>
    </div>
  </div>
  
  <hr id="about">

  <!-- About Section -->
  <div class="w3-container w3-padding-32 w3-center">  
    <h3>About Me, The Food Man</h3><br>
    <img src="${ctp}/images/chef.jpg" alt="Me" class="w3-image" style="display:block;margin:auto" width="800" height="533">
    <div class="w3-padding-32">
      <h4><b>I am Who I Am!</b></h4>
      <h6><i>With Passion For Real, Good Food</i></h6>
      <p>Just me, myself and I, exploring the universe of unknownment. I have a heart of love and an interest of lorem ipsum and mauris neque quam blog. I want to share my world with you. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
  </div>
  <hr>