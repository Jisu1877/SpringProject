<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
		#schedule_date {
			padding-left:20px;
		}
	</style>
</head>
<body class="w3-light-grey">
<!-- Top container -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

    <!-- Header -->
	<header class="w3-container" style="padding-top:22px;">
		<p style="margin-top:20px; font-size:23px;">상품 수정</p>
		<p><span style="color:red;">🔸&nbsp;</span> 표시가 있는 사항은 필수입력입니다.</p>
	</header>
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
	<form:form commandName="user" id="userForm" name="userForm" method="post" cssClass="was-validated mt-3" enctype="multipart/form-data" onsubmit="return itemUpdate();">
		<div class="w3-col s11">
			<div class="box w3-border">
				<div class="w3-white w3-padding">
					<div class="form-group">
						<label for="item_name">번호 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="user_idx" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
						<div id="pwdDemo"></div>
					</div>
					<div class="form-group">
						<label for="item_summary">ID <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="user_id" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">이름 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="name" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">성별 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:radiobutton path="gender" value="m" label="남자" cssClass="input w3-padding-16 w3-border" required="true" />
							<form:radiobutton path="gender" value="f" label="여자" cssClass="input w3-padding-16 w3-border" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">이메일 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="email" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">전화번호 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="tel" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">사진 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="user_image" cssClass="input w3-padding-16 w3-border form-control" required="true" />
							<img src="${ctp}/data/user/${userVO.user_image}" class="w3-circle" style="height:106px;width:106px" alt="userImage"><br>
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">상태 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:select path="status_code" cssClass="input w3-padding-16 w3-border" required="true">
								<c:forEach var="status" items="${statusList}">
									<form:option value="${status.index}">${status.label}</form:option>
								</c:forEach>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">로그인 횟수 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="login_count" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">구매 횟수 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="buy_count" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">구매 총액 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="buy_price" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">레벨 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:select path="level" cssClass="input w3-padding-16 w3-border" required="true">
								<c:forEach var="level" items="${levelList}">
									<form:option value="${level.index}">${level.label}</form:option>
								</c:forEach>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">포인트 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="point" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">판매자 여부 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:select path="seller_yn" cssClass="input w3-padding-16 w3-border" required="true">
								<c:forEach var="sellerYn" items="${sellerYnList}">
									<form:option value="${sellerYn.name()}">${sellerYn.label}</form:option>
								</c:forEach>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">동의 여부 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:select path="agreement" cssClass="input w3-padding-16 w3-border" required="true">
								<c:forEach var="agree" items="${agreeList}">
									<form:option value="${agree.value}">${agree.label}</form:option>
								</c:forEach>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">마지막 로그인 일시 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="login_date" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">회원가입일 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="created_date" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">수정일 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="updated_date" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">거부일 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="deny_date" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">탈퇴일 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="leave_date" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<div class="form-group">
						<label for="item_summary">탈퇴 사유 <span style="color: red;">🔸&nbsp;</span></label>
						<div class="input-group mb-3">
							<form:input path="leave_reason" cssClass="input w3-padding-16 w3-border form-control" required="true" />
						</div>
					</div>
					<hr>
					<div>
						<p style="text-align: center;">
							<a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}"
								class="w3-btn w3-2019-brown-granite">돌아가기</a> <input
								type="submit" class="w3-btn w3-2021-desert-mist"
								value="수정내용 등록">
						</p>
					</div>
				</div>
			</div>
		</div>
		<div class="w3-col s1"></div>
	</form:form>
	</div>
</div>
</body>
</html>