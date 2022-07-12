<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<style>
  	#discountPrice {
	text-decoration: line-through;
}
</style>
<script>

	function checkAll(check) {
		$("input[name=check_item]").prop("checked", check);
		calcTotalPrice(check);
	}
	
	function calcTotalPrice(check) {
		let total = 0;
		$("[data-price]").each(function() {
			total += $(this).data('price');
		});
		const result = check? total : 0;
		
		$("#total_price").html(result);
	}
	
	function calcSelected(cartIdx) {
		let total = 0;
		$("input[name=check_item]:checked").each(function() {
			const idx = $(this).data('idx');
			const price = $("#section_" + idx).find(".data_holder").data('price');
			total += price;
		});
		
		$("#total_price").html(total);
	}
	
</script>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-left:30px; margin-right:30px;">
    	<div class="w3-bottombar w3-light-grey w3-padding">
    		<input type="checkbox" class="w3-check" name="check_all" onclick="checkAll(this.checked);">&nbsp;
    		장바구니[${cartList.size()}]
    	</div>
    	<form>
   		<div class="w3-row" style="padding:20px;">
   			<table class="w3-table">
   				<c:forEach var="cartVO" items="${cartList}" varStatus="st">
   					<tr id="section_${cartVO.cart_idx}">
   						<td width="5%">
		   					<input type="checkbox" class="w3-check" name="check_item" id="check_${cartVO.cart_idx}" onchange="calcSelected();" data-idx="${cartVO.cart_idx}">
   						</td>
   						<td width="15%">
   							<img src="${ctp}/data/item/${cartVO.item_image}" width="150px;"/>
   						</td>
   						<td width="15%">
   							${cartVO.item_name}
   						</td>
   						<td>
   							<c:if test="${cartVO.seller_discount_flag == 'n'}">
								<c:set var="priceFmt" value="${cartVO.sale_price}"/>
					        	<div class="mt-2"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
							</c:if>
							<c:if test="${cartVO.seller_discount_flag == 'y'}">
								<div class="w3-row mt-2"><b>
						        	<span id="discountPrice">
										<c:set var="priceFmt" value="${cartVO.sale_price}"/>
						        		<fmt:formatNumber value="${priceFmt}"/>원
						        	</span>
					        		<span>
						        		<i class="fa-solid fa-arrow-trend-down"></i>
						        		<c:set var="calPriceFmt" value="${cartVO.sale_price - cartVO.seller_discount_amount}"/>
						        		<fmt:formatNumber value="${calPriceFmt}"/>원
					        		</span><br>
					        		<span style="font-size: 13px; color:brown">
					        			<!-- (할인율) = (할인액) / (정가) X 100 -->
					        			<c:set var="calDiscountFmt" value="${(cartVO.seller_discount_amount / cartVO.sale_price) * 100}"/>
					        			(<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
					        			<i class="fa-solid fa-percent"></i> 할인)
					        		</span>
					        	</b></div>
							</c:if>
   						</td>
   						<td>
   							<c:if test="${cartVO.item_option_flag == 'n'}">
		   						상품 주문 수량 : <span id="totalQuantity${cartVO.cart_idx}">${cartVO.quantity}</span> 개
		   					</c:if>
		   					<c:if test="${cartVO.item_option_flag == 'y'}">
		   						상품 주문 수량 : <span id="totalQuantity${cartVO.cart_idx}">${cartVO.quantity}</span> 개<br>
		   						옵션 : ${cartVO.option_name} (+ <span>${cartVO.option_price}</span>)
		   					</c:if>
		   					<div class="mt-3">
			   					<a onclick="minus(this)"><i class="fa-solid fa-square-minus" style="font-size:23px"></i></a>&nbsp;
								<a onclick="plus(this)"><i class="fa-solid fa-square-plus" style="font-size:23px"></i></a>
							</div>
   						</td>
						<td>
							<b>상품 금액</b><br>
							<c:set var="addPrice" value="${cartVO.item_option_flag == 'y' ? cartVO.option_price : 0}" />
							<c:if test="${cartVO.seller_discount_flag == 'y'}">
								<b><span class="data_holder" data-price="${(calPriceFmt + addPrice) * cartVO.quantity}"><fmt:formatNumber value="${(calPriceFmt + addPrice) * cartVO.quantity}"/>원</span></b>
							</c:if>
							<c:if test="${cartVO.seller_discount_flag == 'n'}">
								<b><span class="data_holder" data-price="${(priceFmt + addPrice) * cartVO.quantity}"><fmt:formatNumber value="${(priceFmt + addPrice) * cartVO.quantity}"/>원</span></b>
							</c:if>
						</td>
					</tr>
   				</c:forEach>
			</table>
   		</div>
    	</form>
    	<div id="total_price"></div>
    	<c:if test="${cartList.size() == 0}">
   			<div class="text-center">
				<span class="w3-tag w3-xxxlarge w3-padding w3-2021-marigold w3-center">
				    <strong>
				    The shopping cart<br>
				    is<br>
				    empty !
				    </strong>
				</span>
   			</div>
   			<div class="text-center mt-4">
				<a href="#" class="w3-btn w3-2021-mint">베스트 상품 보러가기</a>
   			</div>
    	</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>