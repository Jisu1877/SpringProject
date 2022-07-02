<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>관리자 HOME</title>
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
   		/* box-shadow: 0 13px 10px -18px rgba(0, 0, 0, 1); */
	}
</style>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main w3-collapse" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
  </header>

  <%-- <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-quarter">
    	<a href="${ctp}/lod_management.ad">
	      <div class="w3-container w3-lime w3-padding-16">
	        <div class="w3-left w3-text-white"><i class="fa-solid fa-tents w3-xxxlarge"></i></div>
	        <div class="w3-right  w3-text-white">
	          <h3>${lodCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4 class="w3-text-white">Lodging</h4>
	      </div>
	    </a>
    </div>
    <div class="w3-quarter">
    	<a href="${ctp}/">
	      <div class="w3-container w3-blue w3-padding-16">
	        <div class="w3-left"><i class="fa-solid fa-calendar-check w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h3>${resCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4>Reservation</h4>
	      </div>
	    </a>
    </div>
    <div class="w3-quarter">
    	<a href="${ctp}/">
	      <div class="w3-container w3-teal w3-padding-16">
	        <div class="w3-left"><i class="fa-solid fa-file-pen w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h3>${revCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4>Review</h4>
	      </div>
	    </a>
    </div>
    <div class="w3-quarter">
    	<a href="${ctp}/mem_management.ad">
	      <div class="w3-container w3-orange w3-text-white w3-padding-16">
	        <div class="w3-left"><i class="fa fa-users w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <h3>${memCnt}</h3>
	        </div>
	        <div class="w3-clear"></div>
	        <h4>Member</h4>
	      </div>
	    </a>
    </div>
  </div>
 --%>
  <div class="w3-panel">
    <div class="w3-row-padding" style="margin:0 -16px">
      <div class="w3-third">
        <table class="table w3-white box">
        	<tr>
        		<th colspan="3">신규회원</th>
        	</tr>
        	<tr>
        		<td class="text-center">번호</td>
        		<td class="text-center">아이디</td>
        		<td class="text-center">가입일</td>
        	</tr>
	        <c:forEach var="memVo" items="${memList}" begin="1" end="5" step="1">
	        	<tr>
	        		<td class="text-center">${memVo.idx}</td>
	        		<td class="text-center">${memVo.mid}</td>
	        		<td class="text-center">${fn:substring(memVo.create_date,0,19)}</td>
	        	</tr>
	        </c:forEach>
        </table>
      </div>
      <div class="w3-twothird">
        <table class="table w3-white">
          <tr>
          	<th colspan="4">주문/배송</th>
          </tr>
          <tr style="height: 47px;">
          	<td style="padding-top: 13px;">고객번호</td>
          	<td style="padding-top: 13px;">숙소명</td>
          	<td style="padding-top: 13px;">결제금액</td>
          	<td style="padding-top: 13px;">상태</td>
          </tr>
          <c:forEach var="resVo" items="${resList}" begin="1" end="6" step="1">
          	<tr>
	          	<td class="text-center">${resVo.mem_idx}</td>
	          	<td>${resVo.lodVo.lod_name}</td>
	          	<td><fmt:formatNumber value="${resVo.payment_price}"/>원</td>
	          	<td>
	          		<c:if test="${resVo.state == '예약'}"><font color="red">${resVo.state}</font></c:if>
       				<c:if test="${resVo.state == '사용완료' || resVo.state == '확정완료'}">${resVo.state}</c:if>
       				<c:if test="${resVo.state == '예약취소'}"><font color="gray">${resVo.state}</font></c:if>
       				<c:if test="${resVo.state == '사용중'}"><font color="blue">${resVo.state}</font></c:if>
	          	</td>
          	</tr>
          </c:forEach>
        </table>
      </div>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
      <tr>
        <td>분류</td>
        <td>숙소명</td>
        <td>주소</td>
        <td>예약된 횟수</td>
      </tr>
     <c:forEach var="bestlod" items="${BestlodList}">
     	<tr>
     		<td>
     			<c:if test="${bestlod.detail_category_code == 300}">최고의 전망</c:if>
     			<c:if test="${bestlod.detail_category_code == 301}">디자인</c:if>
     			<c:if test="${bestlod.detail_category_code == 302}">해변근처</c:if>
     			<c:if test="${bestlod.detail_category_code == 303}">캠핑장</c:if>
     			<c:if test="${bestlod.detail_category_code == 304}">돔하우스</c:if>
     			<c:if test="${bestlod.detail_category_code == 305}">동굴</c:if>
     			<c:if test="${bestlod.detail_category_code == 306}">서핑</c:if>
     			<c:if test="${bestlod.detail_category_code == 307}">호숫가</c:if>
     			<c:if test="${bestlod.detail_category_code == 308}">한적한 시골</c:if>
     			<c:if test="${bestlod.detail_category_code == 309}">열대지역</c:if>
     			<c:if test="${bestlod.detail_category_code == 310}">멋진 수영장</c:if>
     			<c:if test="${bestlod.detail_category_code == 311}">캐슬</c:if>
     			<c:if test="${bestlod.detail_category_code == 312}">북극</c:if>
     		</td>
     		<td>${bestlod.lod_name}</td>
     		<td>${bestlod.address}</td>
     		<td>${bestlod.cnt}</td>
     	</tr>
     </c:forEach>
    </table><br>
    <button class="w3-button w3-dark-grey" onclick="location.href='${ctp}/lod_input.ad?pag=1&pageSize=10';">문의 관리</button>
  </div>
  <hr>

  <!-- End page content -->
</div>

</body>
</html>
