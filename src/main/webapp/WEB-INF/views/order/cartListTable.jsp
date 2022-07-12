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
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-left:20px; margin-right:20px;">
    	<div class="w3-bottombar w3-light-grey w3-padding">
    		<input type="checkbox" class="w3-check">&nbsp;
    		장바구니[${cartVOS.size()}]
    		<c:set var="i" value="${cartVOS.size()}"/>
    	</div>
    	<form>
   		<div class="w3-row" style="padding:20px;">
   			<table class="w3-table">
   				<c:forEach var="itemVO" items="${itemVOS}" varStatus="st">
   					<tr>
   						<td width="5%">
		   					<input type="checkbox" class="w3-check">
   						</td>
   						<td width="15%">
   							<img src="${ctp}/data/item/${itemVO.item_image}" width="150px;"/>
   						</td>
   						<td width="15%">
   							${itemVO.item_name}
   						</td>
   						<td>
   							<c:if test="${itemVO.seller_discount_flag == 'n'}">
								<c:set var="priceFmt" value="${itemVO.sale_price}"/>
					        	<div class="mt-2"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
							</c:if>
							<c:if test="${itemVO.seller_discount_flag == 'y'}">
								<div class="w3-row mt-2"><b>
						        	<span id="discountPrice">
										<c:set var="priceFmt" value="${itemVO.sale_price}"/>
						        		<fmt:formatNumber value="${priceFmt}"/>원
						        	</span>
					        		<span>
						        		<i class="fa-solid fa-arrow-trend-down"></i>
						        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
						        		<fmt:formatNumber value="${calPriceFmt}"/>원
					        		</span><br>
					        		<span style="font-size: 13px; color:brown">
					        			<!-- (할인율) = (할인액) / (정가) X 100 -->
					        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
					        			(<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
					        			<i class="fa-solid fa-percent"></i> 할인)
					        		</span>
					        	</b></div>
							</c:if>
   						</td>
   						<td>
   							<c:if test="${cartVOS[st.index].item_option_flag == 'n'}">
		   						상품 주문 수량 : <span id="totalQuantity${cartVOS[st.index].cart_idx}">${cartVOS[st.index].total_quantity}</span> 개
		   					</c:if>
		   					<c:if test="${cartVOS[st.index].item_option_flag == 'y'}">
		   						상품 주문 수량 : <span id="totalQuantity${cartVOS[st.index].cart_idx}">${cartVOS[st.index].option_quantity}</span> 개<br>
		   						옵션 : ${cartVOS[st.index].option_name} (+ <span>${cartVOS[st.index].option_price}</span>)
		   					</c:if>
   						</td>
						<td>
							<b>상품 금액</b><br>
							<c:if test="${cartVOS[st.index].item_option_flag == 'n'}">	
								<c:if test="${itemVO.seller_discount_flag == 'n'}">
									<b><fmt:formatNumber value="${priceFmt}"/>원</b>
								</c:if>
								<c:if test="${itemVO.seller_discount_flag == 'y'}">
									<b><fmt:formatNumber value="${calPriceFmt}"/>원</b>
								</c:if>
							</c:if>
							<c:if test="${cartVOS[st.index].item_option_flag == 'y'}">
								<c:if test="${itemVO.seller_discount_flag == 'n'}">
									<b><fmt:formatNumber value="${priceFmt + cartVOS[st.index].option_price}"/>원</b>
								</c:if>
								<c:if test="${itemVO.seller_discount_flag == 'y'}">
									<b><fmt:formatNumber value="${calPriceFmt + cartVOS[st.index].option_price}"/>원</b>
								</c:if>
							</c:if>
						</td>
					</tr>
   				</c:forEach>
			</table>
   		</div>
    	</form>
    	<c:if test="${cartVOS.size() == 0}">
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