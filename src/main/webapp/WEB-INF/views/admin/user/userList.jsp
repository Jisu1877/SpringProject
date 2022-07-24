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
			location.href="${ctp}/admin/item/itemList?part=${searchVO.part}&pag=${pag}&pageSize="+pageSize;
		}
    	
      	//분류별 검색
    	function partCheck() {
			let part = $("select[name=part]").val();
			let pageSize = $("#pageSize").val();
			location.href="${ctp}/admin/user/userList?part="+part+"&pag=${pag}&pageSize="+pageSize;
		}
      	
      	function submitForm() {
      		$('#searchForm').submit();
      		return false;
      	}
      	
    	/* 상세 검색*/
		function searchCheck() {
			let search = $("select[name=search]").val();
			let searchValue = $("#searchValue").val();
			
			if(search != "" && searchValue == "") {
				alert("상세 조건을 선택하세요.");
				return false;
			}
			if(search == "" && searchValue != "") {
				alert("상세 검색 내용을 입력하세요.");
				return false;
			}
			
			const status_code = $('#status_code').val();
			$('#status_code').attr('disabled', status_code == null || status_code == '');
			
			const level = $('#level').val();
			$('#level').attr('disabled', level == null || level == '');
			
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
	   				<option value="user_id" ${searchVO.search == 'user_id' ? 'selected' : '' }>아이디</option>
	   				<option value="name" ${searchVO.search == 'name' ? 'selected' : '' }>성명</option>
	   				<option value="email" ${searchVO.search == 'email' ? 'selected' : '' }>이메일</option>
	   				<option value="tel" ${searchVO.search == 'tel' ? 'selected' : '' }>전화번호</option>
	   			</select>
	          </div>
	          <div class="w3-third w3-margin-bottom">
	          	<input type="text" class="w3-input w3-border" type="text" placeholder="상세검색 내용 입력" name="searchValue" id="searchValue" value="${searchVO.searchValue}" />
	          </div>
	          <div class="w3-third w3-margin-bottom">
	     		<a class="w3-button w3-2019-soybean" onclick="return submitForm();"><i class="fa fa-search w3-margin-right"></i> Search</a>
	     		<select name="pageSize" id="pageSize" class="w3-select w3-right mr-3" style="width:15%">
						<option value="5" ${searchVO.pageSize == 5 ? 'selected' : '' }>5건</option>
						<option value="10" ${searchVO.pageSize == 10 ? 'selected' : '' }>10건</option>
						<option value="15" ${searchVO.pageSize == 15 ? 'selected' : '' }>15건</option>
						<option value="20" ${searchVO.pageSize == 20 ? 'selected' : '' }>20건</option>
					</select>
					<select name="status_code" id="status_code" class="w3-select w3-right mr-3" style="width:20%">
						<option value="" ${searchVO.status_code == '' ? 'selected' : ''}>전체</option>
						<option value="9" ${searchVO.status_code == '9' ? 'selected' : ''}>활동중</option>
						<option value="0" ${searchVO.status_code == '0' ? 'selected' : ''}>탈퇴</option>
					</select>
					<select name="level" id="level" class="w3-select w3-right mr-3" style="width:20%">
						<option value="" ${searchVO.level == '' ? 'selected' : ''}>전체</option>
						<option value="1" ${searchVO.level == '1' ? 'selected' : ''}>골드레벨</option>
						<option value="2" ${searchVO.level == '2' ? 'selected' : ''}>실버레벨</option>
					</select>
	    	  </div>
	        </div>
			<div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped table-bordered w3-white" style="width:100%;">
				<colgroup>
					<col style="width:5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
				</colgroup>
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
	        	<c:if test="${fn:length(userList) > 0}">
	        	<c:forEach var="user" items="${userList}">
	        		<tr>
	        			<td class="text-center"><input type="checkbox"></td>
	        			<td class="text-center">
	        				<a href="${ctp}/admin/user/userInforUpdate?user_id=${user.user_id}" alt="${searchVO.name} 회원 정보 수정">${user.user_id}</a>
	        			</td>
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
	        	</c:if>
	        	<c:if test="${fn:length(userList) == 0}">
	        		<tr>
	        			<td class="text-center" colspan="8">조회된 회원이 없습니다.</td>
	        		</tr>
	        	</c:if>
	        </table>
	     </div>
	    </form>
	     <!-- 블록 페이징 처리 -->
	  <div class="w3-center w3-padding-32">
	 	 <div class="mb-2"><b>${searchVO.pag} Page</b></div>
	    <div class="w3-bar w3-white">
	      <c:if test="${searchVO.pag > 1}">
		      <a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
	      </c:if>
	      <c:forEach var="i" begin="${(searchVO.curBlock*searchVO.blockSize)+1}" end="${(searchVO.curBlock*searchVO.blockSize)+searchVO.blockSize}">
	      	<c:if test="${i <= searchVO.totPage && i == searchVO.pag}">
		      <a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
		    <c:if test="${i <= searchVO.totPage && i != searchVO.pag}">
		      <a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
	      </c:forEach>
		  <c:if test="${searchVO.pag != searchVO.totPage}">
		  	<a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
 	</div>
</div>
</body>
</html>