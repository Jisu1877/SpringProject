<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script src="${ctp}/js/myPage.js"></script>
<script>
$(document).ready(function() {
	let date = '${nowDate}';
	let dateArr = date.split('-');
	let dateNum = Number(dateArr[1]);
	let calDate = Number(dateArr[1]) - 1;
	console.log(calDate);
});
</script>
<style>
.date {
	background-color:lavender;
	border: 0.5px solid lightgray;
	border-radius: 10px;
	padding: 5px;
}
</style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent"  class="w3-container w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-top:70px;">
    	<!-- The Grid -->
	  <div class="w3-row">
	    <!-- Left Column -->
	    <div class="w3-col m3">
	      <!-- Profile -->
	      <div class="w3-card w3-round w3-white">
	        <div class="w3-container" style="padding-top: 30px;">
	         <p class="w3-center">
	         	<img src="${ctp}/data/user/${userVO.user_image}" class="w3-circle" style="height:106px;width:106px" alt="userImage"><br>
	         </p>
	         <form name="userImageForm" method="post" action="${ctp}/user/userImageChange" enctype="multipart/form-data">
	         <h5 class="w3-center">${userVO.name} 
	         	<a href="javascript:$('#user_image').click()" title="프로필 사진 변경"><i class="fa-solid fa-gear" style="font-size:13px;"></i></a>
	         	<input type="file" id="user_image" name="user_image" style="display:none" accept=".png, .jpg, .jpeg, .jfif, .gif" onchange="userImageChange();">
	         	<input type="hidden" name="myPhoto" id="myPhoto">
	         </h5>
	         </form>
	         <h6 class="w3-center">${userVO.user_id} &nbsp; |  &nbsp;
	         <c:if test="${userVO.level == 1}">
				Gold
			 </c:if>
			 <c:if test="${userVO.level == 2}">
				Silver
			 </c:if>
			 <c:if test="${userVO.level == 0}">
				Admin
			 </c:if> 
	         <span class="w3-dropdown-click text-left">
				<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
				<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
					더 가든은 회원 등급제를 운영하고 있습니다.<br>
					(Silver/Gold)
					<hr>
					Gold 레벨 변경 요건은?<br>
					- 로그인 횟수 50회 이상<br>
					- 구매 횟수 10회 이상<br>
					- 구매 총 가격 30만원 이상
					<hr>
					Gold 레벨의 혜택은?<br>
					- 적립 포인트 2배 적립
			    </div>
			 </span>
	         </h6>
	         <hr>
	         <div class="w3-row">
	         	<div class="w3-half text-center">
	         		<b>보유 포인트</b><br>
	         		<fmt:formatNumber value="${userVO.point}"/>Point
	         	</div>
	         	<div class="w3-half text-center">
	         		<b>보유 쿠폰</b><br>
	         		개
	         	</div>
	         </div>
	         <hr>
	         <p><i class="fa-solid fa-arrow-pointer w3-margin-right w3-text-theme"></i> 로그인 횟수 : ${userVO.login_count}회</p>
	         <p><i class="fa-solid fa-credit-card w3-margin-right w3-text-theme"></i> 구매 횟수 : ${userVO.buy_count}회
	         	<a onclick="myFunction3()"><i class="fa-solid fa-circle-question"></i></a>
				<div id="demo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
					구매 횟수와 구매 총금액은 상품 구매확정 시 누적됩니다.
			    </div>
	         </p>
	         <p><i class="fa-solid fa-hand-holding-dollar w3-margin-right w3-text-theme"></i> 구매 총 금액 : <fmt:formatNumber value="${userVO.buy_price}"/>원</p>
		     <p class="text-right" title="회원정보 수정"><a href="${ctp}/user/userInforUpdate"><i class="fa-solid fa-user-gear"></i>&nbsp;회원정보 수정</a></p>
	        </div>
	      </div>
	      <br>
	      
	      <!-- Accordion -->
	      <div class="w3-card w3-round">
	        <div class="w3-white">
	          <button onclick="myFunction('Demo1')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> My Groups</button>
	          <div id="Demo1" class="w3-hide w3-container">
	            <p>Some text..</p>
	          </div>
	          <button onclick="myFunction('Demo2')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i> My Events</button>
	          <div id="Demo2" class="w3-hide w3-container">
	            <p>Some other text..</p>
	          </div>
	          <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-users fa-fw w3-margin-right"></i> My Photos</button>
	          <div id="Demo3" class="w3-hide w3-container">
	         <div class="w3-row-padding">
	         <br>
	           <div class="w3-half">
	             <img src="/w3images/lights.jpg" style="width:100%" class="w3-margin-bottom">
	           </div>
	           <div class="w3-half">
	             <img src="/w3images/nature.jpg" style="width:100%" class="w3-margin-bottom">
	           </div>
	           <div class="w3-half">
	             <img src="/w3images/mountains.jpg" style="width:100%" class="w3-margin-bottom">
	           </div>
	           <div class="w3-half">
	             <img src="/w3images/forest.jpg" style="width:100%" class="w3-margin-bottom">
	           </div>
	           <div class="w3-half">
	             <img src="/w3images/nature.jpg" style="width:100%" class="w3-margin-bottom">
	           </div>
	           <div class="w3-half">
	             <img src="/w3images/snow.jpg" style="width:100%" class="w3-margin-bottom">
	           </div>
	         </div>
	          </div>
	        </div>      
	      </div>
	      <br>
	      
	      <!-- Interests --> 
	      <div class="w3-card w3-round w3-white w3-hide-small">
	        <div class="w3-container">
	          <p>Interests</p>
	          <p>
	            <span class="w3-tag w3-small w3-theme-d5">News</span>
	            <span class="w3-tag w3-small w3-theme-d4">W3Schools</span>
	            <span class="w3-tag w3-small w3-theme-d3">Labels</span>
	            <span class="w3-tag w3-small w3-theme-d2">Games</span>
	            <span class="w3-tag w3-small w3-theme-d1">Friends</span>
	            <span class="w3-tag w3-small w3-theme">Games</span>
	            <span class="w3-tag w3-small w3-theme-l1">Friends</span>
	            <span class="w3-tag w3-small w3-theme-l2">Food</span>
	            <span class="w3-tag w3-small w3-theme-l3">Design</span>
	            <span class="w3-tag w3-small w3-theme-l4">Art</span>
	            <span class="w3-tag w3-small w3-theme-l5">Photos</span>
	          </p>
	        </div>
	      </div>
	      <br>
	      
	      <!-- Alert Box -->
	      <div class="w3-container w3-display-container w3-round w3-theme-l4 w3-border w3-theme-border w3-margin-bottom w3-hide-small">
	        <span onclick="this.parentElement.style.display='none'" class="w3-button w3-theme-l3 w3-display-topright">
	          <i class="fa fa-remove"></i>
	        </span>
	        <p><strong>Hey!</strong></p>
	        <p>People are looking at your profile. Find out who.</p>
	      </div>
	    
	    <!-- End Left Column -->
	    </div>
	    
	    <!-- Middle Column -->
	    <div class="w3-col m9">
	    
	      <div class="w3-row-padding">
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyOrder">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🧾
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>주문</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyOrderCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyDelivery">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🚚
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>배송중</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyDeliveryCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyDeliveryOk">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		📦
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>배송완료</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyDeliveryOkCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyReturn">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🔙
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>취소/반품/교환</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyReturnCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	      </div>
         <form name="orderSearchForm" method="get" action="${ctp}/user/orderSearch">
	      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <div class="w3-row-padding" style="margin:0 -16px;">
		          <div class="w3-third w3-margin-bottom">
		            <label>
		            	<i class="fa fa-calendar-o"></i>&nbsp; 주문 조회 &nbsp;
		            </label>
		            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="start" id="start" value="${start}" autocomplete="off">
		          </div>
		          <div class="w3-third">
		            <label>&nbsp;</label>
		            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="end" id="end" value="${end}" autocomplete="off">
		          </div>
		          <div class="w3-third">
		          	<div class="w3-row">
		          		<div class="w3-half">
		          			<label>&nbsp;</label>
		          			<select name="order_status_code" id="order_status_code" class="w3-select w3-border">
		          				<option value="0" ${code == 0 ? 'selected' : '' }>전체조회</option>
		          				<option value="1" ${code == 1 ? 'selected' : '' }>결제완료</option>
		          				<option value="3" ${code == 3 ? 'selected' : '' }>취소</option>
		          				<option value="4" ${code == 4 ? 'selected' : '' }>배송중</option>
		          				<option value="5" ${code == 5 ? 'selected' : '' }>배송완료</option>
		          				<option value="6" ${code == 6 ? 'selected' : '' }>교환</option>
		          				<option value="7" ${code == 7 ? 'selected' : '' }>환불</option>
		          			</select>
		          		</div>
		          		<div class="w3-half pl-4">
		          			<label>&nbsp;</label><br>
		          			<a class="w3-button w3-2019-soybean" onclick="searchCheck()"><i class="fa fa-search w3-margin-right"></i> Search</a>
		          		</div>
		          	</div>
		          </div>
	        </div>
	      </div>
         </form>
         <div id="basicOrderList">
	      <div class="w3-container w3-card w3-white w3-round w3-margin">
	          <c:if test="${orderListSearch.size() == 0}">
	          	  <div class="w3-padding-16" style="font-size:16px;">
					<i class="fa-solid fa-circle-exclamation"></i>&nbsp; 조회되는 주문 내역이 없습니다☺️
	          	  </div>
	          </c:if>
	          <c:if test="${orderListSearch.size() != 0}">
          	  <c:set var="cnt" value="0"/>
	          <c:set var="idx" value="0"/>
	          <c:forEach var="vo" items="${orderListSearch}">
          		<c:set var="date" value="${fn:split(vo.created_date, '-')}"/>
          		<c:set var="date2" value="${fn:split(nowDate, '-')}"/>
	          	<c:if test="${date[1] == date2[1] && cnt == 0}">
		          	<div class="w3-padding-16" style="font-size:22px;"><span class="pl-2 pr-2 date">${nowDate}</span></div>
		      	  	<hr>
		      	  	<c:set var="cnt" value="1"/>
	      	  	</c:if>
	          	<c:if test="${date[1] != date2[1]}">
	          		<c:set var="calSub" value="${date2[1] - date[1]}"/>
	          		<c:set var="calDay" value="${date2[1] - calSub}"/>
	          		<c:set var="el" value="-"/>
	          		<c:set var="zero" value="0"/>
	          		<c:set var="calDate" value="${date[0]}${el}${zero}${calDay}"/>
		          	<div class="w3-padding-16" style="font-size:22px;"><span class="pl-2 pr-2 date">${calDate}</span></div>
		      	  	<hr>
		      	  	<c:set var="cnt" value="1"/>
	      	  	</c:if>
	          	<div class="w3-row">
	          		<c:if test="${idx != vo.order_idx}">
	          			<div class="w3-bottombar w3-2019-sweet-corn w3-padding" style="margin-bottom: 20px;">
					    	<div>
					    		<span>주문번호 <b>${vo.order_number}</b></span> &nbsp; | &nbsp;
					    		총 결제금액 : <b><fmt:formatNumber value="${vo.order_total_amount}"/>원</b>
					    	</div>
					    </div>
	          		</c:if>
	          		<div class="w3-col m2">
			          <img src="${ctp}/data/item/${vo.item_image}" class="w3-left w3-margin-right" style="width:100%">
	          		</div>
	          		<div class="w3-col m8 pl-2">
			            <h5>${vo.item_summary}</h5>
			            <c:if test="${vo.item_option_flag == 'y'}">
						  <div>옵션 : ${vo.option_name}</div>		          
			            </c:if>
					    <div>수량 : ${vo.order_quantity} 개</div>
					    <div>상품 금액 : <fmt:formatNumber value="${vo.item_price}"/>원</div>
						<hr>
						<c:if test="${vo.order_status_code == '1'}">
							<font size="3" color="gray">결제완료</font><br>
							✔️ 주문 확인 중입니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '2'}">
							<font size="3" color="gray">확인완료</font><br>
							✔️ 배송 준비 중입니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '3'}">
							<font size="3" color="red">취소완료</font><br>
							✔️ 취소처리가 완료되었습니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '4'}">
							<font size="3" color="gray">배송중</font><br>
							<i class="fa-solid fa-truck-bolt"></i> 배송 중입니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '5'}">
							<font size="3" color="gray">배송완료</font><br>
							<i class="fa-solid fa-box-check"></i> 배송이 완료되었습니다. 구매확정을 진행해주세요.
						</c:if>					
						<c:if test="${vo.order_status_code == '6'}">
						<font size="3" color="gray">구매완료</font><br>
							✔️ 구매확정이 완료되었습니다. 리뷰를 작성해주세요.
						</c:if>					
						<c:if test="${vo.order_status_code == '7'}">
						<font size="3" color="red">교환신청 처리 중</font><br>
							✔️ 교환 신청이 완료되었습니다. 관리자 승인여부 처리를 기다려주세요.
						</c:if>					
						<c:if test="${vo.order_status_code == '8'}">
						<font size="3" color="red">교환승인 완료</font><br>
							✔️ 상품 수거 처리 중입니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '9'}">
						<font size="3" color="red">배송중(교환)</font><br>
							✔️ 교환물품이 배송 중입니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '10'}">
						<font size="3" color="red">교환거부</font><br>
							✔ 교환이 거부되었습니다. 자세한 내용은 교환처리 페이지에서 확인해주세요.
						</c:if>					
						<c:if test="${vo.order_status_code == '11'}">
						<font size="3" color="red">환불신청 처리 중</font><br>
							✔ 환불 신청이 완료되었습니다. 관리자 승인여부 처리를 기다려주세요.
						</c:if>					
						<c:if test="${vo.order_status_code == '12'}">
						<font size="3" color="red">환불승인</font><br>
							✔ 상품 수거 처리 중입니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '13'}">
						<font size="3" color="red">환불완료</font><br>
							✔ 환불이 완료되었습니다.
						</c:if>					
						<c:if test="${vo.order_status_code == '14'}">
						<font size="3" color="red">환불거부</font><br>
							✔ 환불이 거부되었습니다. 자세한 내용은 환불처리 페이지에서 확인해주세요.
						</c:if>					
						<c:if test="${vo.order_status_code == '15'}">
						<font size="3" color="red">취소 요청 중</font><br>
							✔ 취소 요청을 검토중입니다. 기다려주세요.
						</c:if>					
						<c:if test="${vo.order_status_code == '16'}">
						<font size="3" color="red">취소 요청 반려</font><br>
							✔ 취소 요청이 반려되었습니다. 처리 내용을 확인해주세요.
						</c:if>					
	          		</div>
	          		<div class="w3-col m2">
	          			<div class="mb-2">
	          				<span class="w3-right w3-opacity">${fn:substring(vo.created_date, 0, 19)}</span>
	          			</div><br>
	          			<div style="margin-top: 20px;" class="w3-right">
	          				<c:if test="${vo.order_status_code == '1'}">
	          					<a onclick="orderCancel(${vo.order_list_idx},${vo.order_idx})" class="btn btn-outline-primary btn-sm">주문 취소</a>
							</c:if>
	          				<c:if test="${vo.order_status_code == '2'}">
	          					<a onclick="orderCancelRequest(${vo.order_list_idx},${vo.order_idx})" class="btn btn-outline-success btn-sm">취소 요청</a>
							</c:if>
	          				<c:if test="${vo.order_status_code == '3'}">
	          					<a onclick="orderCancelInfor(${vo.order_list_idx},${vo.order_idx})" class="btn w3-yellow btn-sm">취소 내역 확인</a>
							</c:if>
	          				<c:if test="${vo.order_status_code == '16'}">
	          					<a onclick="orderCancelRequestInfor(${vo.order_list_idx},${vo.order_idx})" class="btn w3-2020-mosaic-blue btn-sm">처리 내용 확인</a>
							</c:if>
	          			</div>
	          		</div>
		        </div><br><hr>
		        <c:set var="idx" value="${vo.order_idx}"/>
		      </c:forEach>
	          </c:if>
	      </div>
	      </div> 
	
	    <!-- End Middle Column -->
	    </div>
	    
	  <!-- End Grid -->
	  </div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
function myFunction2() {
  var x = document.getElementById("pointDemo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
function myFunction3() {
  var x = document.getElementById("demo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
</body>
</html>