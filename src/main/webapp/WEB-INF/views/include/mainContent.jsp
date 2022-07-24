<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
	function categorySearch(code,name) {
		location.href="${ctp}/main/categorySearch?code="+code+"&name="+name;
	}
	
	function categorySearch2(code,idx,name,groupName) {
		location.href="${ctp}/main/categorySearch2?code="+code+"&name="+name+"&idx="+idx+"&groupName="+groupName;
	}
	
</script>
  <!-- Category 보이기  -->
  <div style="margin-bottom: 50px; margin-left: 16px;">
	<div class="w3-bar" style="font-size: 13px;">
	   <c:forEach var="vo" items="${categoryVOS}" varStatus="st">
			<div class="w3-dropdown-hover">
				<button class="btn w3-white w3-hover-white" style="font-size: 18px; border-radius:0" onclick="categorySearch('${vo.category_group_code}','${vo.category_group_name}')">${vo.category_group_name}</button>
				<div class="w3-dropdown-content w3-bar-block w3-hover-white">
					<c:set var="i" value="0"/>
					<c:forEach var="cVO" items="${vo.categoryList}">
						<a onclick="categorySearch2('${vo.category_group_code}',${cVO.category_idx},'${cVO.category_name}','${vo.category_group_name}')" class="w3-bar-item btn">${cVO.category_name}</a>
					 </c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
  </div>
  <jsp:include page="/WEB-INF/views/include/mainItemContent.jsp" />

 
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