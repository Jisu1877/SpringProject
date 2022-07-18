<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- 현재 판매 중인 신상품 List-->
 <p style="text-align:center;"><span class="w3-white w3-xlarge mt-2">신상품</span></p>
  <div class="w3-row-padding w3-padding-16 w3-center">
  	<c:set var="sw" value="1"/>
  	<c:forEach var="itemVO" items="${itemVOS}" varStatus="st">
	  <c:if test="${sw == '1'}">
  		<div class="w3-quarter">
	  		<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
	  			<div class="w3-display-container">
	  				<c:if test="${itemVO.sold_out == 0}">
			        <div class="w3-display-topleft w3-2019-princess-blue w3-padding" style="font-size:8px;">NEW</div>
			        </c:if>
	  				<c:if test="${itemVO.sold_out == 1}">
			        <div class="w3-display-topleft w3-2020-flame-scarlet w3-padding" style="font-size:8px;">Sold Out</div>			        
			        </c:if>
					<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:100%; margin-top:0px;">
			    </div>
				<div>
					<h5 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
						<strong>
							 ${fn:substring(itemVO.item_summary, 0, 21)}
						    <c:if test="${fn:length(itemVO.item_summary) > 20}">
						    ...
						    </c:if>
		  					<%-- ${itemVO.item_summary} --%>
		  				</strong>
					</h5>
				</div>
				<div class="text-left">
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
				        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
				        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
				        		<fmt:formatNumber value="${calPriceFmt}"/>원
			        		</span>
			        		<span style="font-size: 19px; margin-left: 10px; color:brown">
			        			<!-- (할인율) = (할인액) / (정가) X 100 -->
			        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
			        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
			        			<i class="fa-solid fa-percent"></i> 할인
			        		</span>
			        	</b></div>
					</c:if>
				</div>
	  		</a>
			<div class="text-left mb-4">
				<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
				<c:forEach var="keyword" items="${keywords}" varStatus="g">
					<c:if test="${keyword != ''}">
						<a href="#" style="font-size:12px;" class="w3-2021-buttercream">#${keyword}</a>
					</c:if>
				</c:forEach> 
			</div>
  		</div>
  		<c:if test="${st.count == 4}">
  			<c:set var="sw" value="0"/>
  		</c:if>
  	</c:if>
  	</c:forEach>
  </div>
  
<!-- 현재 판매 중인 신상품 List-->
 <p style="text-align:center; margin-top:30px;"><span class="w3-white w3-xlarge mt-2">베스트</span></p>
  <div class="w3-row-padding w3-padding-16 w3-center">
  	<c:set var="bestsw" value="1"/>
  	<c:forEach var="itemVO" items="${itemBestList}" varStatus="st">
	  <c:if test="${bestsw == '1'}">
  		<div class="w3-quarter">
	  		<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
	  			<div class="w3-display-container">
	  				<c:if test="${itemVO.sold_out == 0}">
			        	<div class="w3-display-topleft w3-2021-mint w3-padding" style="font-size:11px;">Best</div>
			        </c:if>
	  				<c:if test="${itemVO.sold_out == 1}">
			        <div class="w3-display-topleft w3-2020-flame-scarlet w3-padding" style="font-size:8px;">Sold Out</div>			        
			        </c:if>
					<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:100%; margin-top:0px;">
			    </div>
				<div>
					<h5 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
						<strong>
							 ${fn:substring(itemVO.item_summary, 0, 21)}
						    <c:if test="${fn:length(itemVO.item_summary) > 20}">
						    ...
						    </c:if>
		  					<%-- ${itemVO.item_summary} --%>
		  				</strong>
					</h5>
				</div>
				<div class="text-left">
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
				        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
				        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
				        		<fmt:formatNumber value="${calPriceFmt}"/>원
			        		</span>
			        		<span style="font-size: 19px; margin-left: 10px; color:brown">
			        			<!-- (할인율) = (할인액) / (정가) X 100 -->
			        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
			        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
			        			<i class="fa-solid fa-percent"></i> 할인
			        		</span>
			        	</b></div>
					</c:if>
				</div>
	  		</a>
			<div class="text-left mb-4">
				<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
				<c:forEach var="keyword" items="${keywords}" varStatus="g">
					<c:if test="${keyword != ''}">
						<a href="#" style="font-size:12px;" class="w3-2021-buttercream">#${keyword}</a>
					</c:if>
				</c:forEach> 
			</div>
  		</div>
  		<c:if test="${st.count == 4}">
  			<c:set var="bestsw" value="0"/>
  		</c:if>
  	</c:if>
  	</c:forEach>
  </div>
  
  
<!-- 현재 판매 중인 전체상품 List-->
 <p style="text-align:center; margin-top:30px"><span class="w3-white w3-xlarge mt-5">전체 상품</span></p>
  <div class="w3-row-padding w3-padding-16 w3-center">
  	<c:forEach var="itemVO" items="${itemVOS}" varStatus="st">
  		<div class="w3-quarter">
	  		<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
	  			<div class="w3-display-container">
	  				<c:if test="${itemVO.sold_out == 1}">
			        	<div class="w3-display-topleft w3-2020-flame-scarlet w3-padding" style="font-size:8px;">Sold Out</div>			        
			        </c:if>
	  				<c:if test="${itemVO.stock_quantity == 1}">
				        <div class="w3-display-topleft w3-2021-marigold w3-padding" style="font-size:10px;">품절 임박</div>
	  				</c:if>
					<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:100%; margin-top:0px;">
			    </div>
				<div>
					<h5 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
						<strong>
							 ${fn:substring(itemVO.item_summary, 0, 21)}
						    <c:if test="${fn:length(itemVO.item_summary) > 20}">
						    ...
						    </c:if>
		  					<%-- ${itemVO.item_summary} --%>
		  				</strong>
					</h5>
				</div>
				<div class="text-left">
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
				        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
				        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
				        		<fmt:formatNumber value="${calPriceFmt}"/>원
			        		</span>
			        		<span style="font-size: 19px; margin-left: 10px; color:brown">
			        			<!-- (할인율) = (할인액) / (정가) X 100 -->
			        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
			        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
			        			<i class="fa-solid fa-percent"></i> 할인
			        		</span>
			        	</b></div>
					</c:if>
				</div>
	  		</a>
			<div class="text-left mb-4">
				<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
				<c:forEach var="keyword" items="${keywords}" varStatus="g">
					<c:if test="${keyword != ''}">
						<a href="#" style="font-size:12px;" class="w3-2021-buttercream">#${keyword}</a>
					</c:if>
				</c:forEach> 
			</div>
  		</div>
  	</c:forEach>
  </div>
  