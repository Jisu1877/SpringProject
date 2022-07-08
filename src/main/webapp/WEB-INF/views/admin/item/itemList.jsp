<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 조회/수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
		body,h1 {font-family: "Montserrat", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
			text-decoration: none;	
		}
		.box {
	   		box-shadow: 0 16px 18px -20px rgba(0, 0, 0, 0.7);
	   		margin-right: 10px;
		}
		.tableStyle {
	  		width:100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  	}
	</style>
	<script>
		let itemCode = "";
		let remember = 0;
		/*function checkOnlyOne(element, code) {
			
		  itemCode = code;
		  const checkboxes 
		      = document.getElementsByName("itemCheck");
		  
		  checkboxes.forEach((cb) => {
		    cb.checked = false;
		  });
		  
		  element.checked = true;
		  
		  $("input[name=itemCheck]").prop("checked", false);
		  $(element).prop("checked", true);
		}*/
		
		function itemCheck(idx) {
			if($("#itemCheck"+idx).is(":checked") == true) {
				$("input:checkbox[id='itemCheck"+idx+"']").prop("checked", false);
				remember = 0;
			}
			else {
				$("input[name=itemCheck]").prop("checked", false);
				$("input:checkbox[id='itemCheck"+idx+"']").prop("checked", true);
				remember = 1;
			}
		}
		
		function itemInquire() {
			if(remember == 0){
				alert("조회를 원하는 상품을 선택하세요.");
				return false;
			}
			itemCode = $("input[name=itemCheck]:checked").data("code");
			location.href = "${ctp}/admin/item/itemInquire?item_code="+itemCode;
		}
		
		function itemUpdate() {
			if(remember == 0){
				alert("수정을 원하는 상품을 선택하세요.");
				return false;
			}
			itemCode = $("input[name=itemCheck]:checked").data("code");
			location.href = "${ctp}/admin/item/itemUpdate?item_code="+itemCode;
		}
		
	</script>
</head>
<body class="w3-light-grey">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px;margin-top:43px;">

    <!-- Header -->
	<header class="w3-container" style="padding-top:22px;">
		<p style="margin-top:20px; font-size:23px;">상품 조회/수정</p>
		<p></p>
	</header>
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
		<div style="margin-bottom:10px;">
			<a href="javascript:itemInquire()" class="w3-btn w3-small w3-2021-buttercream">상품조회</a>&nbsp;&nbsp;
			<a href="javascript:itemUpdate()" class="w3-btn w3-small w3-2020-sunlight">상품수정</a>&nbsp;&nbsp;
			<a href="#" class="w3-btn w3-small w3-2021-desert-mist">상품삭제</a>&nbsp;&nbsp;
		</div>
 		<div class="box w3-border w3-white">
 			<div class="w3-responsive tableStyle">
				<table class="table w3-striped table-bordered" style="width:auto;">
		        	<tr>
		        		<th><i class="fa-solid fa-check"></i></th>
		        		<th class="text-center">상품코드</th>
		        		<th class="text-center">상품명</th>
		        		<th class="text-center">판매가</th>
		        		<th class="text-center">할인가</th>
		        		<th class="text-center">포인트 지급여부</th>
		        		<th class="text-center">지급포인트</th>
		        		<th class="text-center">판매상태</th>
		        		<th class="text-center">전시상태</th>
		        		<th class="text-center">재고수량</th>
		        		<th class="text-center">재입고 예정일</th>
		        		<th class="text-center">상품등록일</th>
		        	</tr>
		        	<c:forEach var="vo" items="${vos}">
		        		<tr onclick="itemCheck(${vo.item_idx})">
		        			<td class="text-center">
		        				<input type="checkbox" id="itemCheck${vo.item_idx}" name="itemCheck" data-code="${vo.item_code}" onclick="itemCheck(${vo.item_idx})">
		        			</td>
		        			<td class="text-center">${vo.item_code}</td>
		        			<td>${vo.item_name}</td>
		        			<td class="text-center">
		        				<c:set var="priceFmt" value="${vo.sale_price}"/>
				        		<fmt:formatNumber value="${priceFmt}"/>원
		        			</td>
		        			<td class="text-center">
		        				<c:set var="discountPriceFmt" value="${vo.seller_discount_amount}"/>
				        		<fmt:formatNumber value="${discountPriceFmt}"/>원
		        			</td>
		        			<td class="text-center">
		        				<c:if test="${vo.seller_point_flag == 'y'}">
		        					<i class="fa-solid fa-o"></i>
		        				</c:if>
		        				<c:if test="${vo.seller_point_flag == 'n'}">
		        					<i class="fa-solid fa-x"></i>
		        				</c:if>
		        			</td>
		        			<td class="text-center">
		        				<c:if test="${vo.seller_point_flag == 'y'}">
		        					${vo.seller_point}Point
		        				</c:if>
		        				<c:if test="${vo.seller_point_flag == 'n'}">
		        					-
		        				</c:if>
		        			</td>
		        			<td class="text-center">
		        				<c:if test="${vo.sold_out == '0'}">
		        					판매 중
		        				</c:if>
		        				<c:if test="${vo.sold_out == '1'}">
		        					품절
		        				</c:if>
		        			</td>
		        			<td class="text-center">
		        				<c:if test="${vo.display_flag == 'y'}">
		        					전시 중
		        				</c:if>
		        				<c:if test="${vo.display_flag == 'n'}">
		        					전시 중지
		        				</c:if>
		        			</td>
		        			<td class="text-center">
		        				${vo.stock_quantity}개
		        			</td>
		        			<td class="text-center">
		        				<c:if test="${vo.sold_out == '1'}">
		        					${vo.stock_schedule_date}
		        				</c:if>
		        				<c:if test="${vo.sold_out == '0'}">
		        					-
		        				</c:if>
		        			</td>
		        			<td class="text-center">
		        				${fn:substring(vo.created_date, 0,19)}
		        			</td>
		        		</tr>
		        	</c:forEach>
		        </table>
		     </div>		
	 	</div>
 	</div>
</div>
</body>
</html>