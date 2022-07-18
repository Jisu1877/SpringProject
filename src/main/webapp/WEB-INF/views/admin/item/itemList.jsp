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
			width : 100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  	}
	  	.switch {
		  position: relative;
		  display: inline-block;
		  width: 60px;
		  height: 34px;
		}
		
		.switch input { 
		  opacity: 0;
		  width: 0;
		  height: 0;
		}
		
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 26px;
		  width: 26px;
		  left: 4px;
		  bottom: 4px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
			  	
	  	input:checked + .slider {
		  background-color: #2196F3;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
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
		
		function itemDelete() {
			if(remember == 0){
				alert("삭제를 원하는 상품을 선택하세요.");
				return false;
			}
			itemCode = $("input[name=itemCheck]:checked").data("code");
			location.href = "${ctp}/admin/item/itemDelete?item_code="+itemCode;
		}
		
		function displayFlag(idx,flag) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/item/displayFlagSW",
				data : {item_idx : idx,
						display_flag : flag},
				success : function(res) {
					location.reload();
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
		
    	//페이지사이즈 검색
      	function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href="${ctp}/admin/item/itemList?part=${pageVo.part}&pag=${pag}&pageSize="+pageSize;
		}
    	
      	//분류별 검색
    	function partCheck() {
			let part = $("select[name=part]").val();
			let pageSize = $("#pageSize").val();
			location.href="${ctp}/admin/item/itemList?part="+part+"&pag=${pag}&pageSize="+pageSize;
		}
	</script>
</head>
<body class="w3-light-grey">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px;margin-top:43px;">

 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
	    <!-- Header -->
		<header style="padding-top:22px;">
			<div class="w3-bottombar w3-light-grey w3-padding" style="margin-bottom: 20px; font-size:23px;">
		    	상품 관리
		    </div>
		</header>
		<div class="w3-row" style="margin-bottom:10px;">
			<div class="w3-half">
				<a href="javascript:itemInquire()" class="w3-btn w3-small w3-2021-buttercream">상품조회</a>&nbsp;&nbsp;
				<a href="javascript:itemUpdate()" class="w3-btn w3-small w3-2020-sunlight">상품수정</a>&nbsp;&nbsp;
				<a href="javascript:itemDelete()" class="w3-btn w3-small w3-2021-desert-mist">상품삭제</a>&nbsp;&nbsp;
			</div>
			<div class="w3-half">
				<select name="pageSize" id="pageSize" onchange="pageCheck()" class="w3-select w3-right mr-3" style="width:15%">
					<option value="5" ${pageVo.pageSize == 5 ? 'selected' : '' }>5건</option>
					<option value="10" ${pageVo.pageSize == 10 ? 'selected' : '' }>10건</option>
					<option value="15" ${pageVo.pageSize == 15 ? 'selected' : '' }>15건</option>
					<option value="20" ${pageVo.pageSize == 20 ? 'selected' : '' }>20건</option>
				</select>
				<select name="part" onchange="partCheck()"class="w3-select w3-right mr-3" style="width:20%">
					<option value="전체" ${pageVo.part == '전체' ? 'selected' : ''}>전체</option>
					<option value="판매중" ${pageVo.part == '판매중' ? 'selected' : ''}>판매중</option>
					<option value="전시중지" ${pageVo.part == '전시중지' ? 'selected' : ''}>전시중지</option>
					<option value="품절" ${pageVo.part == '품절' ? 'selected' : ''}>품절</option>
				</select>
			</div>
		</div>
			<div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped table-bordered w3-white" style="width:auto;">
	        	<tr>
	        		<th><i class="fa-solid fa-check"></i></th>
	        		<th class="text-center">상품코드</th>
	        		<th class="text-center">상품명</th>
	        		<th class="text-center" width="15%">판매가</th>
	        		<th class="text-center" width="15%">할인가</th>
	        		<th class="text-center">포인트지급</th>
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
	        				<c:if test="${vo.sold_out == '0' && vo.display_flag == 'y'}">
        						판매 중
	        				</c:if>
	        				<c:if test="${vo.sold_out == '0' && vo.display_flag == 'n'}">
        						전시중지
	        				</c:if>
	        				<c:if test="${vo.sold_out == '1'}">
	        					품절
	        				</c:if>
	        			</td>
	        			<td class="text-center">
	        				<label class="switch">
	        					<input type="checkbox" ${vo.display_flag == 'y' ? 'checked' : ''} onclick="displayFlag('${vo.item_idx}','${vo.display_flag}')">
						  		<span class="slider round"></span>
							</label>
	        			</td>
	        			<td class="text-center">
	        				${vo.stock_quantity}개
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${vo.sold_out == '1'}">
	        					${vo.stock_schedule_date}
	        					<c:if test="${vo.stock_schedule_date == ''}">
	        						등록 요망
	        					</c:if>
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
     <!-- 블록 페이징 처리 -->
	  <div class="w3-center w3-padding-32">
	    <div class="w3-bar w3-white">
	      <c:if test="${pageVo.pag > 1}">
		      <a href="${ctp}/admin/item/itemList?part=${pageVo.part}&pag=1&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">«</a>
	      </c:if>
	      <c:if test="${pageVo.curBlock > 0}">
		      <a href="${ctp}/admin/item/itemList?part=${pageVo.part}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-black w3-button">◁</a>
	      </c:if>
	      <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}">
	      	<c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
		      <a href="${ctp}/admin/item/itemList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		      <a href="${ctp}/admin/item/itemList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
	      </c:forEach>
	      <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		      <a href="${ctp}/admin/item/itemList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">▷</a>
		  </c:if>
		  <c:if test="${pageVo.pag != pageVo.totPage}">
		  	<a href="${ctp}/admin/item/itemList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
 	</div>
</div>
</body>
</html>