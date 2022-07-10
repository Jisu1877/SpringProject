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
<style>
	#pageContent {
		font-family: 'MaruBuriExtraLight' !important;
		font-family: 'MaruBuriLight' !important;
		font-family: 'MaruBuri' !important;
		font-family: 'MaruBuriBold' !important;
		font-family: 'MaruBuriSemiBold' !important;
	}
	
	#discountPrice {
		text-decoration: line-through;
	}
	
	#benefits {
		margin: 10px;
		padding: 10px;
		background-color: whitesmoke;
		font-family: 'Montserrat', sans-serif;
		font-size: 12px;
	}
	
	.montserrat {
		font-family: 'Montserrat', sans-serif;
	}
	
	#elevate_zoom {
		display:block;
	}
	
	/*set a border on the images to prevent shifting*/
	#gallery_01 img {
		border: 1px solid white;
	}
	
	/*Change the colour*/
	.active img {
		opacity: 1 !important;
	}
	
	.zoomWindowContainer {
		width: 510px !important;
	}
	
	#small {
		display: none;
	}
 	
	@media screen and (max-width:1200px) { 
	 	#elevate {
	 		display: none;
	 	}
	 	#small {
			display: block;
		}
	}
</style>
<script>
	let totalAmount = 0;
	let totalPrice = $("#sale_price").val();
	console.log(totalPrice);
	function optionSelect(ths) {
		const idx = $(ths).val();
		const option = $(ths).find('option:selected').data('label');
		const price = $(ths).find('option:selected').data('price');
		const price2 = Math.floor(price).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		let order_min_quantity = $("#order_min_quantity").val();
		let order_max_quantity = $("#order_max_quantity").val();
		totalAmount++;
		
		if(option == "") {
			return false;
		}
		else if($("#option_"+idx).length > 0){
			alert("이미 선택한 옵션입니다.");
			$("#optionSelect").val("").prop("selected", true);
			totalAmount--;
			return false;
		}
		else if(totalAmount > order_max_quantity) {
			$("#optionSelect").val("").prop("selected", true);
			alert("최대 구매 가능 수량은 " +order_max_quantity+ "개 입니다.");
			totalAmount--;
			return false;
		}
		
		
		let optionDiv = $("#option_tmp_div").clone();
		
		optionDiv.attr("style", "display:block;");
		optionDiv.attr("id", "option_"+idx);
		optionDiv.find(".option").html(option);
		optionDiv.find(".option_cnt").html(order_min_quantity);
		optionDiv.find(".option_cnt").attr("data-idx", idx);
		optionDiv.find(".option_cnt").attr("id", "option_cnt_"+idx);
		optionDiv.find(".option_price").html(price2 + "원");
		optionDiv.find(".option_price").attr("data-price", price);
		
		$("#optonDemo").append(optionDiv);
		let optionLength = $(".option_div").length;
		if(optionLength > (Number(order_max_quantity) + 1)) {
			$("#optionSelect").val("").prop("selected", true);
			alert("최대 구매 수량은 " +order_max_quantity+ "개 입니다. 선택한 옵션을 삭제하고 추가하세요.");
			$( 'div' ).remove( '#option_'+idx);
		}
		
		$("#optionSelect").val("").prop("selected", true);
		
		totalPrice += price;
		let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		$("#totalCnt").html(totalAmount);
		$("#totalPrice").html(total);
		$("#totalInfor").attr("style", "margin:30px; display:block; font-size:22px;");
	}
	
	function minus(ths) {
		const id = $(ths).parents("div.option_div").attr("id");
		let amount = $(ths).siblings("span.option_cnt").html();
		let order_min_quantity = $("#order_min_quantity").val();		
		amount--;
		
		if(order_min_quantity > amount) {
			$("#optionSelect").val("").prop("selected", true);
			alert("최소 구매 가능 수량은 " +order_min_quantity+ "개 입니다.");
			return false;
		}
		totalAmount--;
		
		let price = $("#"+id).find(".option_price").data('price');
		let price2 = price * Number(amount);
		let price3 = Math.floor(price2).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		$("#"+id).find(".option_price").html(price3 + "원");
		$(ths).siblings("span.option_cnt").html(amount);
		totalPrice -= price;
		
		let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		$("#totalCnt").html(totalAmount);
		$("#totalPrice").html(total);
	}
	
	function plus(ths) {
		const id = $(ths).parents("div.option_div").attr("id");
		let amount = $(ths).siblings("span.option_cnt").html();
		const price = ($("#"+id).find(".option_price").data('price')) * (Number(amount) + 1);
		let order_max_quantity = $("#order_max_quantity").val();		
		const price2 = Math.floor(price).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		amount++;
		totalAmount++;
		
		if(order_max_quantity < amount) {
			$("#optionSelect").val("").prop("selected", true);
			alert("최대 구매 가능 수량은 " +order_max_quantity+ "개 입니다.");
			totalAmount--;
			return false;
		}
		else if(totalAmount > order_max_quantity) {
			$("#optionSelect").val("").prop("selected", true);
			alert("최대 구매 가능 수량은 " +order_max_quantity+ "개 입니다.");
			totalAmount--;
			return false;
		}
		$(ths).siblings("span.option_cnt").html(amount);
		
		totalPrice = price;
		$("#"+id).find(".option_price").html(price2 + "원");
		let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		$("#totalCnt").html(totalAmount);
		$("#totalPrice").html(total);
	}
	
	function deleteOption(ths) {
		let amount = $(ths).parents().find(".option_cnt").html();
		amount = Number(amount);
		totalAmount -= amount;
		const id = $(ths).parents("div.option_div").attr("id");
 		let price = $("#"+id).find(".option_price").data('price');
 		let price2 = Number(price) * Number(amount);
		
 		totalPrice -= price2;
 		let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
 		$("#totalCnt").html(totalAmount);
 		$("#totalPrice").html(total);
		
 		$( 'div' ).remove('#'+id);
	}
</script>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:70px;">
		<div class="mb-2 montserrat">
			<a href="${ctp}/main/mainHome">홈</a> &nbsp; <i class="fa-solid fa-angle-right"></i> &nbsp;
			<a>${itemVO.category_group_name}</a>
			<span class="w3-dropdown-click">
				<a onclick="myFunction()"><i class="fa-solid fa-caret-down"></i></a> &nbsp;
				<div id="Demo" class="w3-dropdown-content w3-bar-block w3-border">
					<c:forEach var="category" items="${itemVO.categoryGroupList}">
					    <a href="#" class="w3-bar-item w3-btn">${category.category_group_name}</a>
					</c:forEach>
			    </div>
			</span>
			<c:if test="${itemVO.category_name != 'NO'}">
				<i class="fa-solid fa-angle-right"></i> &nbsp; 
				<a>${itemVO.category_name}</a>
			</c:if>
		</div>
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
		    			<img class="mySlides" id="elevate_zoom" src="${ctp}/data/item/${itemVO.item_image}" data-zoom-image="${ctp}/data/item/${itemVO.item_image}">
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
		<div class="w3-col m5 l5">
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
									<span><font color="red">TIP.</font>추가 혜택 안내</span><br>
									<i class="fa-solid fa-circle-check"></i>&nbsp; 가입 후 첫 구매시 10% 할인쿠폰 발급<br>
									<i class="fa-solid fa-circle-check"></i>&nbsp; 10만원 이상 결제시 10% 할인쿠폰 발급
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
									리뷰적립 <i class="fa-solid fa-caret-right"></i> 100Point
									<span style="font-size: 8px;">구매적립이 없는 상품입니다.</span><br>
									<hr>
									<span><font color="red">TIP.</font>추가 혜택 안내</span><br>
									<i class="fa-solid fa-circle-check"></i>&nbsp; 가입 후 첫 구매시 10% 할인쿠폰 발급<br>
									<i class="fa-solid fa-circle-check"></i>&nbsp; 10만원 이상 결제시 10% 할인쿠폰 발급
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
					<div style="margin:30px;">최소 구매 가능 수량 : ${itemVO.order_min_quantity}개&nbsp; |&nbsp; 최대 구매 가능 수량 : ${itemVO.order_max_quantity}개</div>
					<c:if test="${itemVO.item_option_flag == 'y'}">
						<div class="w3-border" style="margin:30px;">
							<select id="optionSelect" name="optionSelect" class="w3-select" onchange="optionSelect(this)">
									<option value="" selected>옵션을 선택하세요.</option>
								<c:forEach var="vo" items="${itemVO.itemOptionList}">
									<option value="${vo.item_option_idx}" data-label="${vo.option_name}" data-price="${vo.option_price}">${vo.option_name}</option>
								</c:forEach>
							</select>
						</div>
						<div style="margin:30px;">
							<hr>
						</div>
					</c:if>
					<div style="margin:30px;" id="optonDemo"></div>
					<c:if test="${itemVO.item_option_flag == 'n' && itemVO.order_min_quantity != itemVO.order_max_quantity}">
						<div class="w3-row" style="margin:30px;">
							<div class="w3-half">
								<a onclick="minus2(this)"><i class="fa-solid fa-square-minus" style="font-size:23px"></i></a>
								<span class="option_cnt" style="font-size:16px; vertical-align:top; margin:10px" data-cnt="0">1</span>
								<a onclick="plus2(this)"><i class="fa-solid fa-square-plus" style="font-size:23px"></i></a>
							</div>
							<div class="w3-half" style="text-align:right; font-size:19px">
								<span class="option_price"></span>
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
				</div>
			</div>
			<div class="w3-col m2 l1"></div>
		</div>
	</div>
</div>


<input type="hidden" id="order_min_quantity" value="${itemVO.order_min_quantity}">
<input type="hidden" id="order_max_quantity" value="${itemVO.order_max_quantity}">
<c:if test="${itemVO.seller_discount_flag == 'n'}">
<input type="hidden" id="sale_price" value="${itemVO.sale_price}">
</c:if>
<c:if test="${itemVO.seller_discount_flag == 'y'}">
<input type="hidden" id="sale_price" value="${itemVO.sale_price - itemVO.seller_discount_amount}">
</c:if>

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


<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
/* $(function() {
	initEzPlus();
});

function initEzPlus() {
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
} */

 
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
</script>
</body>
</html>