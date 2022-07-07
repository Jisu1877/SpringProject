<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.menu {
		font-size: 16px;
		border-bottom: 1px solid white;
		padding-bottom: 17px;
		padding-top: 17px;
	}
	button {
		border-style: none;
	}
	a:hover {
		color : burlywood;
		font-weight : 600;
	}
</style>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-2019-brown-granite" style="z-index:3;width:250px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s12 w3-bar w3-center">
      <p class="w3-center" style="margin-top: 20px;">
      	<%-- <img src="${ctp}/data/member/${vo.save_file_name}" class="w3-circle" style="height:106px;width:106px"> --%>
      	<img src="${ctp}/images/noimage.jpg" class="w3-circle" style="height:100px;width:100px">
      </p>
      <span>Welcome, <strong> ${sUser_id}</strong></span><br>
      <!-- 
  	  <a href="#" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-user"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-cog"></i></a>
       -->
    </div>
  </div>
  <hr>
  <div class="w3-container">
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(1)" class="w3-2019-brown-granite menu"><strong>일반상품 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo1" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/category/categoryHome">카테고리 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/item/itemInsert">상품 등록</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/item/itemList">상품 조회/수정</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">사진 보관함</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">배송정보 관리</a></button>
	  </div>
	</div>
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(2)" class="w3-2019-brown-granite menu"><strong>일반판매 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo2" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">주문통합검색</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">배송현황 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">구매확정 내역</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">취소 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">반품 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">교환 관리</a></button>
	  </div>
	</div>
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(3)" class="w3-2019-brown-granite menu"><strong>경매판매 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo3" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">경매상품 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">판매자 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">낙찰(주문) 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">배송현황 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">구매확정 내역</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">취소 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">반품 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">판매방해 관리</a></button>
	  </div>
	</div>
  </div>
</nav>

<script>
let sw = 0;
function slideDown(flag) {
	if(sw == 0) {
		$("#Demo"+flag).slideDown(300);
		sw = 1;
	}
	else {
		$("#Demo"+flag).slideUp(300);
		sw = 0;
	}
}
</script>