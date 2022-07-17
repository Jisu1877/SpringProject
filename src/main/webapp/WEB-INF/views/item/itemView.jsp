<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품정보조회</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<link rel="stylesheet" type="text/css" href="${ctp}/css/itemView.css" />
<script src="${ctp}/js/itemView.js"></script>
<script>
	$(function() {
		itemJson = ${itemJson};
	});
</script>
</head>
<body>
<!-- Nav  -->
<span id="navBar">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
</span>
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:70px;">
    	<div class="w3-content" style="max-width:1200px;">
    		<div class="w3-col m5 l6">
   				<div class="box">
   					<div id="small">
					 <img class="mySlides" src="${ctp}/data/item/${itemVO.item_image}" style="width:100%;">
   					 <c:forEach var="vo" items="${itemVO.itemImageList}" varStatus="st">
   					 	<img class="mySlides" src="${ctp}/data/item/${vo.image_name}" style="width:100%;display:none">
					 </c:forEach>
					  <div class="w3-row-padding w3-section">
					  	<img class="demo w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${itemVO.item_image}" style="width:52px; cursor:pointer" onclick="currentDiv(1)">
					    <c:forEach var="vo" items="${itemVO.itemImageList}" varStatus="st">
						 	<c:if test="${itemVO.item_image != vo.image_name}">
						 		<img class="demo w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${vo.image_name}" style="width:52px; cursor:pointer" onclick="currentDiv(${st.count + 1})">
						  	</c:if>
					 	</c:forEach>
					  </div>
   					</div>
   					<div id="elevate">
		    			<img class="mySlides" id="elevate_zoom" src="${ctp}/data/item/${itemVO.item_image}" data-zoom-image="${ctp}/data/item/${itemVO.item_image}" style="width:510px;">
						 <div class="w3-row-padding w3-section" id="image_list">
						     <a data-image="${ctp}/data/item/${itemVO.item_image}" data-zoom-image="${ctp}/data/item/${itemVO.item_image}">
					  		 	<img class="w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${itemVO.item_image}" style="width:52px;cursor:pointer">
						     </a>
							 <c:forEach var="vo" items="${itemVO.itemImageList}" varStatus="st">
							 	<c:if test="${itemVO.item_image != vo.image_name}">
							 		<a data-image="${ctp}/data/item/${vo.image_name}" data-zoom-image="${ctp}/data/item/${vo.image_name}" onclick="resetEzPlus()">
							  			<img class="w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${vo.image_name}" style="width:52px;cursor:pointer">
							 		</a>
							  	</c:if>
						 	</c:forEach>
					 	</div>
				 	</div>
				</div>
			</div>
		</div>
		<div class="mb-2 montserrat">
			<a href="${ctp}/main/mainHome">홈</a> &nbsp; <i class="fa-solid fa-angle-right"></i> &nbsp;
			<a href="${ctp}/main/categorySearch?code=${category_group_code}&name=${itemVO.category_group_name}">${itemVO.category_group_name}</a>
			<span class="w3-dropdown-click">
				<a onclick="myFunction()"><i class="fa-solid fa-caret-down"></i></a> &nbsp;
				<div id="Demo" class="w3-dropdown-content w3-bar-block w3-border">
					<c:forEach var="category" items="${itemVO.categoryGroupList}">
					    <a href="${ctp}/main/categorySearch?code=${category_group_code}&name=${category.category_group_name}" class="w3-bar-item w3-btn">${category.category_group_name}</a>
					</c:forEach>
			    </div>
			</span>
			<c:if test="${itemVO.category_name != 'NO'}">
				<i class="fa-solid fa-angle-right"></i> &nbsp; 
				<a href="${ctp}/main/categorySearch2?code=${category_group_code}&name=${itemVO.category_name}&idx=${category_idx}&groupName=${category.category_group_name}">${itemVO.category_name}</a>
			</c:if>
		</div>
		<div class="w3-col m7 l6" style="margin-bottom:50px;">
			<div class="box w3-border">
				<div style="font-size: 20px; padding:30px; margin: 10px;">
					<b>${itemVO.item_summary}</b>
				</div>
				<div style="padding-right:30px; text-align: right; font-size: 20px; margin-right:10px;">
	        		<c:if test="${itemVO.seller_discount_flag == 'n'}">
	        			<c:set var="priceFmt" value="${itemVO.sale_price}"/>
		        		<fmt:formatNumber value="${priceFmt}"/>원
	        		</c:if>
	        		<c:if test="${itemVO.seller_discount_flag == 'y'}">
	        		<div style="font-size: 19px; color:brown">
	        			<!-- (할인율) = (할인액) / (정가) X 100 -->
	        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
	        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
	        			<i class="fa-solid fa-percent"></i> 할인
	        		</div>
					<span id="discountPrice" style="font-size:16px;">
						<c:set var="priceFmt" value="${itemVO.sale_price}"/>
		        		<fmt:formatNumber value="${priceFmt}"/>원
		        	</span>
	        		<span>
		        		&nbsp;<i class="fa-solid fa-arrow-trend-down" style="font-size: 16px"></i>&nbsp;
		        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
		        		<fmt:formatNumber value="${calPriceFmt}"/>원
	        		</span>
	        		</c:if>
				</div>
				<div class="w3-border" style="margin:30px; padding:10px;">
					<div class="w3-row">
						<c:if test="${itemVO.seller_point_flag == 'y'}">
							<c:set var="point" value="${itemVO.seller_point + 100}"/>
							&nbsp;&nbsp;최대 적립포인트&nbsp;&nbsp;&nbsp;
							${point}Point
							<span class="w3-dropdown-click">
								<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
								<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
									더 가든 고객을 위한 혜택!
									<hr>
									구매적립 <i class="fa-solid fa-caret-right"></i> ${itemVO.seller_point}Point<br>
									리뷰적립 <i class="fa-solid fa-caret-right"></i> 100Point
									<hr>
									- 모든 포인트와 쿠폰은 구매확정 이후 적립 및 발급됩니다.
							    </div>
							</span>
						</c:if>
						<c:if test="${itemVO.seller_point_flag == 'n'}">
							&nbsp;&nbsp;최대 적립포인트&nbsp;&nbsp;&nbsp;
							100Point
							<span class="w3-dropdown-click">
								<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
								<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
									더 가든 고객을 위한 혜택!
									<hr>
									리뷰적립 <i class="fa-solid fa-caret-right"></i> 100Point<br>
									<span style="font-size: 8px;">구매적립이 없는 상품입니다.</span>
									<hr>
									- 모든 포인트와 쿠폰은 구매확정 이후 적립 및 발급됩니다.
							    </div>
							</span>
						</c:if>
						</div>
						<div class="w3-border" id="benefits">
							<span><font color="red"><b>TIP.</b> </font>추가 혜택 누리는 방법</span><br>
							<i class="fa-solid fa-circle-check"></i>&nbsp; 가입 후 첫 구매시 10% 할인쿠폰 발급<br>
							<i class="fa-solid fa-circle-check"></i>&nbsp; 10만원 이상 결제시 10% 할인쿠폰 발급
						</div>
					</div>
					<div style="margin:30px;">
						<hr>
					</div>
					<%-- <div style="margin-left:30px;">남은 재고 수량 : ${itemVO.stock_quantity}</div> --%>
					<div style="margin-left:30px; font-size:14px;">( 최소 구매 수량 : ${itemVO.order_min_quantity}개&nbsp;)</div>
					<c:if test="${itemVO.item_option_flag == 'y'}">
						<div class="w3-border" style="margin:30px;">
							<select id="optionSelect" name="optionSelect" class="w3-select" onchange="optionSelect(this)">
									<option value="" selected>옵션을 선택하세요.</option>
								<c:forEach var="vo" items="${itemVO.itemOptionList}" varStatus="st">
									<option id="option${st.count}" value="${vo.item_option_idx}" data-label="${vo.option_name}" data-price="${vo.option_price}">${vo.option_name}(+${vo.option_price})</option>
								</c:forEach>
							</select>
						</div>
						<div style="margin:30px;">
							<hr>
						</div>
					</c:if>
					<div style="margin:30px;" id="optonDemo"></div>
					<c:if test="${itemVO.item_option_flag == 'n'}">
						<div class="w3-row" style="margin:30px;">
							<div class="w3-half">
								<a onclick="minus2(this)"><i class="fa-solid fa-square-minus" style="font-size:23px"></i></a>
								<span class="option_cnt" style="font-size:16px; vertical-align:top; margin:10px" data-cnt="0">${itemVO.order_min_quantity}</span>
								<a onclick="plus2(this)"><i class="fa-solid fa-square-plus" style="font-size:23px"></i></a>
							</div>
							<div class="w3-half" style="text-align:right; font-size:19px">
								<span class="option_price"></span>
							</div>
						</div>
						<div id="totalInfor" class="w3-row" style="margin:30px; font-size:22px;">
						<div class="w3-half">
							총 상품금액
						</div>
						<div class="w3-half" style="text-align:right;">
							<span><font size="2">총 수량(<span id="totalCnt">${itemVO.order_min_quantity}</span>개)</font></span>
							<c:if test="${itemVO.seller_discount_flag == 'n'}">
								<c:set var="priceFmt2" value="${itemVO.sale_price * itemVO.order_min_quantity}"/>
								<span id="totalPrice"><fmt:formatNumber value="${priceFmt2}"/></span>원
							</c:if>
							<c:if test="${itemVO.seller_discount_flag == 'y'}">
								<c:set var="priceFmt3" value="${(itemVO.sale_price - itemVO.seller_discount_amount) * itemVO.order_min_quantity}"/>
								<span id="totalPrice"><fmt:formatNumber value="${priceFmt3}"/></span>원
							</c:if>
						</div>
						</div>
					</c:if>
					<div id="totalInfor" class="w3-row" style="display:none">
						<div class="w3-half">
							총 상품금액
						</div>
						<div class="w3-half" style="text-align:right;">
							<span><font size="2">총 수량(<span id="totalCnt"></span>개)</font></span>
							<span id="totalPrice"></span>원
						</div>
					</div>
					<div style="margin:30px;">
						<a class="w3-button w3-2021-marigold form-control btn-lg" style="font-family: 'Montserrat', sans-serif" onclick="buyItem()">구매하기</a>
					</div>
					<div class="w3-row w3-center" style="margin:30px; font-family: 'Montserrat', sans-serif">
						<div class="w3-third">
							<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%">
								<span class="iconify" data-icon="ooui:ongoing-conversation-rtl"></span>&nbsp;문의하기
							</a>
						</div>
						<div class="w3-third">
							<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%">
								<span class="iconify" data-icon="akar-icons:heart"></span>&nbsp;찜하기
							</a>
						</div>
						<div class="w3-third">
							<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%" onclick="inputCart()">
								<i class="fa-solid fa-cart-arrow-down"></i>&nbsp;장바구니
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-row">
			    <a href="javascript:void(0)" onclick="openCity(event, 'infor');">
			      <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">상세정보</div>
			    </a>
			    <a href="javascript:void(0)" onclick="openCity(event, 'review');">
			      <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">리뷰</div>
			    </a>
			    <a href="javascript:void(0)" onclick="openCity(event, 'QA');">
			      <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Q&A</div>
			    </a>
			</div>
			<div id="infor" class="w3-container info" style="display:none">
			    <h4 style="font-family: 'MaruBuriBold';">상품 정보</h4>
			    <table class="table table-border">
					<tr>
						<td>상품코드</td><td>${itemVO.item_code}</td>
						<td>브랜드</td><td>${itemVO.brand}</td>
					</tr>			    
					<tr>
						<td>모델명</td><td>${itemVO.item_model_name}</td>
						<td>원산지</td><td>${itemVO.origin_country}</td>
					</tr>			    
					<tr>
						<td>형태</td><td>${itemVO.form}</td>
						<td>A/S안내</td><td>${itemVO.after_service}</td>
					</tr>			    
			    </table>
			    <div>
			    	${itemVO.detail_content}
			    </div>
			    <hr>
			    <div class="text-left mb-4">
			    	<h4>#keyword</h4>
					<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
					<c:forEach var="keyword" items="${keywords}" varStatus="g">
						<c:if test="${keyword != ''}">
							<a href="#" style="font-size:16px;" class="w3-2021-buttercream">#${keyword}</a>
						</c:if>
					</c:forEach> 
				</div>
				<hr>
				<h4 style="font-family: 'MaruBuriBold';">상품 정보 고시</h4>
				<table class="table table-border">
					<tr>
						<td>품명/모델명</td><td>${itemVO.notice_value1}</td>
					</tr>			    
					<tr>
						<td>법에 의한 인증, 허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항</td><td>${itemVO.notice_value2}</td>
					</tr>			    
					<tr>
						<td>제조자(사)</td><td>${itemVO.notice_value3}</td>
					</tr>			    
					<tr>
						<td>제조국</td><td>${itemVO.notice_value4}</td>
					</tr>			    
					<tr>
						<td>소비자상담 관련 전화번호</td><td>${itemVO.notice_value5}</td>
					</tr>			    
			    </table>
			</div>
			<div id="review" class="w3-container info" style="display:none">
			    <h2>Paris</h2>
			    <p>Paris is the capital of France.</p> 
			</div>
			<div id="QA" class="w3-container info" style="display:none">
			    <h2>Tokyo</h2>
			    <p>Tokyo is the capital of Japan.</p>
			</div>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="item_idx" value="${itemVO.item_idx}">
<input type="hidden" id="item_name" value="${itemVO.item_name}">
<input type="hidden" id="item_image" value="${itemVO.item_image}">
<input type="hidden" id="order_min_quantity" value="${itemVO.order_min_quantity}">
<input type="hidden" id="order_max_quantity" value="${itemVO.order_max_quantity}">
<input type="hidden" id="stock_quantity" value="${itemVO.stock_quantity}">
<input type="hidden" id="sale_price" value="${itemVO.sale_price}">
<input type="hidden" id="seller_discount_flag" value="${itemVO.seller_discount_flag}">
<input type="hidden" id="item_option_flag" value="${itemVO.item_option_flag}">
<input type="hidden" id="seller_discount_amount" value="${itemVO.seller_discount_amount}">


<div class="option_div" id="option_tmp_div" style="display:none;" data-option="">
	<div class="w3-row">
		<div class="w3-half">
			<div class="mb-1 option"></div>
		</div>
		<div class="w3-half" style="text-align:right; font-size:19px;">
			<a onclick="deleteOption(this)"><i class="fa-solid fa-xmark"></i></a>
		</div>
		<div class="w3-row">
			<div class="w3-half">
				<a onclick="minus(this)"><i class="fa-solid fa-square-minus" style="font-size:23px"></i></a>
				<span class="option_cnt" style="font-size:16px; vertical-align:top; margin:10px" data-cnt="0"></span>
				<a onclick="plus(this)"><i class="fa-solid fa-square-plus" style="font-size:23px"></i></a>
			</div>
			<div class="w3-half" style="text-align:right; font-size:19px">
				<span class="option_price"></span>
			</div>
		</div>
	</div>
	<hr>
</div>
<form name="payForm" method="get" action="${ctp}/order/orderCheck">
	<input type="hidden" name="order_item_idx">
	<input type="hidden" name="order_item_name">
	<input type="hidden" name="order_item_image">
	<input type="hidden" name="order_item_price">
	<input type="hidden" name="order_item_option_flag">
	<input type="hidden" name="order_option_idx">
	<input type="hidden" name="order_option_name">
	<input type="hidden" name="order_option_price">
	<input type="hidden" name="order_quantity">
	<input type="hidden" name="order_total_amount">
	<input type="hidden" name="cart_idx">
</form>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
 $(function() {
	//initEzPlus();
	document.getElementById("infor").style.display = "block";
});

/* function initEzPlus() {
	$('#elevate_zoom').ezPlus({
	    gallery: 'image_list',
	    cursor: 'pointer',
	    galleryActiveClass: 'active',
	    imageCrossfade: true,
	    loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif',
	    scrollZoom: true,
	    zoomLevel: 0.5,
	    borderSize : 1,
	    zoomWindowWidth: 510,
	    zoomWindowHeight: 510,
	    responsive: true,
	    zoomWindowPosition: 1,
	    zoomWindowOffsetX: 10
	});
}

function resetEzPlus() {
	$('#elevate_zoom').ezPlus({
	    cursor: 'pointer',
	    loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif',
	    scrollZoom: true,
	    zoomLevel: 0.5,
	    borderSize : 1,
	    zoomWindowWidth: 510,
	    zoomWindowHeight: 510,
	    responsive: true,
	    zoomWindowPosition: 1,
	    zoomWindowOffsetX: 10
	});
}
 */
 
function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-opacity-off", "");
  }
  x[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " w3-opacity-off";
}
 
function myFunction() {
  var x = document.getElementById("Demo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}

function myFunction2() {
  var x = document.getElementById("pointDemo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}

function openCity(evt, name) {
  var i, x, tablinks;
  x = document.getElementsByClassName("info");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-border-green", "");
  }
  document.getElementById(name).style.display = "block";
  evt.currentTarget.firstElementChild.className += " w3-border-green";
}

</script>
</body>
</html>