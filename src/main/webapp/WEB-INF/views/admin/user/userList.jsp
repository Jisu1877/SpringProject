<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
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
      	
      	function submitForm() {
      		$('#searchForm').submit();
      		return false;
      	}
      	
    	/* 상세 검색*/
		function searchCheck() {
			let search = $("select[name=search]").val();
			let searchValue = $("#searchValue").val();
			let pageSize = $("#pageSize").val();
			let part = $("select[name=part]").val();
			
			if(search != "" && searchValue == "") {
				alert("상세 조건을 선택하세요.");
				return false;
			}
			if(search == "" && searchValue != "") {
				alert("상세 검색 내용을 입력하세요.");
				return false;
			}
			
			return true;
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
		    	회원 관리
		    </div>
		</header>
		<form id="searchForm" name="searchForm" method="GET" action="${ctp}/admin/user/userList" onsubmit="return searchCheck();">		
			<div class="w3-row-padding" style="margin:0 -16px;">
	          <div class="w3-third w3-margin-bottom">
	            <select name="search" id="search" class="w3-select w3-border">
	   				<option value="">상세 조건 선택</option>
	   				<option value="user_id" ${search == 'user_id' ? 'selected' : '' }>아이디</option>
	   				<option value="name" ${search == 'name' ? 'selected' : '' }>성명</option>
	   				<option value="email" ${search == 'email' ? 'selected' : '' }>이메일</option>
	   				<option value="tel" ${search == 'tel' ? 'selected' : '' }>전화번호</option>
	   			</select>
	          </div>
	          <div class="w3-third w3-margin-bottom">
	          	<input type="text" class="w3-input w3-border" type="text" placeholder="상세검색 내용 입력" name="searchValue" id="searchValue" value="${searchValue}" />
	          </div>
	          <div class="w3-third w3-margin-bottom">
	     		<a class="w3-button w3-2019-soybean" onclick="return submitForm();"><i class="fa fa-search w3-margin-right"></i> Search</a>
	     		<select name="pageSize" id="pageSize" onchange="pageCheck()" class="w3-select w3-right mr-3" style="width:20%">
						<option value="5" ${pageVo.pageSize == 5 ? 'selected' : '' }>5건</option>
						<option value="10" ${pageVo.pageSize == 10 ? 'selected' : '' }>10건</option>
						<option value="15" ${pageVo.pageSize == 15 ? 'selected' : '' }>15건</option>
						<option value="20" ${pageVo.pageSize == 20 ? 'selected' : '' }>20건</option>
					</select>
					<select name="part" onchange="partCheck()"class="w3-select w3-right mr-3" style="width:25%">
						<option value="전체" ${pageVo.part == '전체' ? 'selected' : ''}>전체</option>
						<option value="판매중" ${pageVo.part == '판매중' ? 'selected' : ''}>활동중</option>
						<option value="판매중" ${pageVo.part == '판매중' ? 'selected' : ''}>탈퇴</option>
						<option value="전시중지" ${pageVo.part == '전시중지' ? 'selected' : ''}>골드레벨</option>
						<option value="품절" ${pageVo.part == '품절' ? 'selected' : ''}>실버레벨</option>
					</select>
	    	  </div>
	        </div>
			<div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped table-bordered w3-white" style="width:auto;">
	        	<tr>
	        		<th class="text-center"><i class="fa-solid fa-check"></i></th>
	        		<th class="text-center">아이디</th>
	        		<th class="text-center">성명</th>
	        		<th class="text-center" width="15%">이메일</th>
	        		<th class="text-center" width="15%">전화번호</th>
	        		<th class="text-center">상태</th>
	        		<th class="text-center">레벨</th>
	        		<th class="text-center">가입일</th>
	        	</tr>
	        	<c:forEach var="user" items="${userList}">
	        		<tr>
	        			<td class="text-center"><input type="checkbox"></td>
	        			<td class="text-center">${user.user_id}</td>
	        			<td>${user.name}</td>
	        			<td class="text-center">${user.email}</td>
	        			<td class="text-center">${user.tel}</td>
	        			<td class="text-center">
	        				<c:if test="${user.status_code == 9}">
		        				활동중
	        				</c:if>
	        				<c:if test="${user.status_code == 0}">
		        				<font color="red">탈퇴</font>
	        				</c:if>
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${user.level == 0}">
	        					관리자
	        				</c:if>
	        				<c:if test="${user.level == 1}">
	        					골드
	        				</c:if>
	        				<c:if test="${user.level == 2}">
	        					실버
	        				</c:if>
	        			</td>
	        			<td class="text-center">${user.created_date}</td>
	        		</tr>
	        	</c:forEach>
	        </table>
	     </div>
	    </form>
	     <!-- 블록 페이징 처리 -->
	  <div class="w3-center w3-padding-32">
	 	 <div class="mb-2"><b>${pageVo.pag} Page</b></div>
	    <div class="w3-bar w3-white">
	      <c:if test="${pageVo.pag > 1}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=1&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">«</a>
	      </c:if>
	      <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}">
	      	<c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
	      </c:forEach>
		  <c:if test="${pageVo.pag != pageVo.totPage}">
		  	<a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
 	</div>
</div>
</body>
</html>