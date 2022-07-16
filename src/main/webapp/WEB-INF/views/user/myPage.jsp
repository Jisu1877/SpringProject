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
	         <h5 class="w3-center">${userVO.name} 
	         	<a href="#" title="프로필 사진 변경"><i class="fa-solid fa-gear" style="font-size:13px;"></i></a>
	         </h5>
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
					- 식물 경매 참여 가능
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
	         <p><i class="fa-solid fa-at w3-margin-right w3-text-theme"></i> ${userVO.email}</p>
	         <p><i class="fa-solid fa-mobile-screen-button w3-margin-right w3-text-theme"></i> ${userVO.tel}</p>
	         <p><i class="fa-solid fa-arrow-pointer w3-margin-right w3-text-theme"></i> 로그인 횟수 : ${userVO.login_count}회</p>
	         <p><i class="fa-solid fa-credit-card w3-margin-right w3-text-theme"></i> 구매 횟수 : ${userVO.buy_count}회</p>
	         <p><i class="fa-solid fa-hand-holding-dollar w3-margin-right w3-text-theme"></i> 구매 총 금액 : <fmt:formatNumber value="${userVO.buy_price}"/>원</p>
		     <p class="text-right" title="회원정보 수정"><a href="#"><i class="fa-solid fa-user-gear"></i></a></p>
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
	          <div class="w3-card w3-round w3-2019-sweet-corn">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🧾
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>주문</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderList.size()}</div>
	            </div>
	          </div>
	        </div>
	        <div class="w3-quarter text-center">
	          <div class="w3-card w3-round w3-2019-sweet-corn">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🚚
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>배송중</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderList.size()}</div>
	            </div>
	          </div>
	        </div>
	        <div class="w3-quarter text-center">
	          <div class="w3-card w3-round w3-2019-sweet-corn">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		📦
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>배송완료</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderList.size()}</div>
	            </div>
	          </div>
	        </div>
	        <div class="w3-quarter text-center">
	          <div class="w3-card w3-round w3-2019-sweet-corn">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🔙
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>취소/반품/교환</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderList.size()}</div>
	            </div>
	          </div>
	        </div>
	      </div>
	      
         <form>
	      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <div class="w3-row-padding" style="margin:0 -16px;">
		          <div class="w3-third w3-margin-bottom">
		            <label><i class="fa fa-calendar-o"></i>&nbsp; 주문 조회</label>
		            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="start" id="start" autocomplete="off">
		          </div>
		          <div class="w3-third">
		            <label>&nbsp;</label>
		            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="end" id="end" autocomplete="off">
		          </div>
		          <div class="w3-third">
		          	<div class="w3-row">
		          		<div class="w3-half">
		          			<label>&nbsp;</label>
		          			<select name="order_status_code" id="order_status_code" class="w3-select w3-border">
		          				<option value="0">전체조회</option>
		          				<option value="1">결제완료</option>
		          				<option value="2">배송확인</option>
		          				<option value="3">취소</option>
		          				<option value="4">배송중</option>
		          				<option value="5">배송완료</option>
		          				<option value="6">교환</option>
		          				<option value="7">환불</option>
		          				<option value="8">구매완료</option>
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
	      <div class="w3-container w3-card w3-white w3-round w3-margin">
	      	  <div class="w3-padding-16" style="font-size:22px;"><span class="pl-2 pr-2 date">${nowDate}</span></div>
	      	  <hr>
	          <c:if test="${orderListOnlyThisMonth.size() == 0}">
	          	  <div class="w3-padding-16" style="font-size:16px;">
					<i class="fa-solid fa-circle-exclamation"></i>&nbsp; 이번 달 주문 내역이 없습니다☺️
	          	  </div>
	          </c:if>
	          <c:if test="${orderListOnlyThisMonth.size() != 0}">
	          	<c:forEach var="vo" items="${orderListOnlyThisMonth}">
	          	<div>
		          <img src="${ctp}/data/item/${vo.item_image}" class="w3-left w3-margin-right" style="width:90px">
		          <span class="w3-right w3-opacity">${fn:substring(vo.created_date, 0, 19)}</span>
		          <h5>${vo.item_name}</h5><br>
		          <hr class="w3-clear">
		          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		          <button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button> 
		          <button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>  Comment</button>
		        </div>
		        </c:forEach>
	          </c:if>
	      </div>  
	
	      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <img src="/w3images/avatar6.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
	        <span class="w3-right w3-opacity">32 min</span>
	        <h4>Angie Jane</h4><br>
	        <hr class="w3-clear">
	        <p>Have you seen this?</p>
	        <img src="/w3images/nature.jpg" style="width:100%" class="w3-margin-bottom">
	        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	        <button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button> 
	        <button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>  Comment</button> 
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
</script>
</body>
</html>