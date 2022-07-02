<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>카테고리 관리</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
	}
</style>
<script>
	'use strict';
	function category_group_input() {
		let category_group_name = myForm.category_group_name.value;
		let category_group_level = myForm.category_group_level.value;
		
		if(category_group_name == "") {
			alert("대분류명을 입력하세요.");
			myForm.category_group_name.focus();
			return false;
		}
		else if(category_group_name.length > 10) {
			alert("대분류명은 10자 이내로 입력하세요.");
			myForm.category_group_name.focus();
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/admin/category_group_input",
			data : {category_group_name : category_group_name,
					category_group_level : category_group_level
			},
			success : function(data) {
				if(data == 1) {
					location.reload();
				}
				else {
					alert("대분류 등록에 실패했습니다. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
		
		
	}
</script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

    <!-- Header -->
	<header class="w3-container" style="padding-top:22px;">
		<p style="margin-top:20px; font-size:23px;">카테고리 관리</p>
	</header>
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
 		<div class="w3-col s11">
 		<form name="myForm">
 			<div class="box w3-border">
				<div class="w3-white w3-padding">
					<div style="padding: 5px;">- 카테고리를 등록하고 순서를 조정할 수 있습니다.<br>- '대분류'를 등록한 뒤에, '중분류' 등록이 가능합니다.</div>
					<div class="w3-white" style="border: 10px solid lightslategray;">
						<table class="table table-borderless w3-2020-brilliant-white" style="margin:0px;">
							<tr><td colspan="3">&nbsp;</td></tr>
							<tr>
								<td width="10%">노출 순서</td>
								<td>분류명</td>
								<td>카테고리 코드</td>
								<td>사용유무</td>
								<td>삭제유무</td>
							</tr>
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<tr>
									<td>
										<input type="text" value="${vo.category_group_level}" name="category_group_level" class="w3-input w3-center">
									</td>
									<td>
										<input type="text" value="${vo.category_group_name}" name="category_group_name" class="w3-input">
									</td>
									<td>
										${vo.category_group_code}
									</td>
									<td>
										<input type="button" class="w3-btn w3-2020-navy-blazer w3-small" value="사용" onclick="category_group_input()">
										<input type="button" class="w3-btn w3-2020-navy-blazer w3-small" value="사용안함" onclick="category_group_input()">
									</td>		
									<td>
										<input type="button" class="w3-btn w3-2020-navy-blazer w3-small" value="삭제" onclick="category_group_input()">
									</td>		
								</tr>
							</c:forEach>
							<tr>
								<td class="text-center">
									<span name="category_group_level" value="${vos.size() + 1}">${vos.size() + 1}</span>
								</td>
								<td colspan="3">
									<input type="text" name="category_group_name" placeholder="대분류명을 입력하세요.(10자 이내)" class="w3-input">
								</td>
								<td>
									<input type="button" class="w3-btn w3-2020-navy-blazer w3-small" value="등록" onclick="category_group_input()">
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="w3-white w3-padding">
					<div>
						<input type="button" value="변경사항 저장" class="w3-button w3-dark-grey w3-hover-dark-grey w3-small">
					</div>
				</div>
			</div>
		</form>
		</div>
		<div class="w3-col s1"></div>
	</div>

  <!-- End page content -->
</div>

</body>
</html>
