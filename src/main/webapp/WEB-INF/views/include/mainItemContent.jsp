<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- 현재 판매 중인 전체상품 List-->
  <div class="w3-row-padding w3-padding-16 w3-center">
  	<c:forEach var="itemVO" items="${itemVOS}">
  		<div class="w3-quarter">
	  		<a href="#">
	  			<!-- <div class="w3-display-container">
			        <div class="w3-display-topleft w3-black w3-padding">Summer House</div>
			    </div> -->
				<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:100%">
				<div>
					<h5 class="text-left w3-white">
						<strong>
		  					${itemVO.item_summary}
		  				</strong>
					</h5>
				</div>
				<div class="text-left">
					<c:if test="${fn:length(itemVO.item_summary) < 20}">
						<br>
				    </c:if>
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
			        		<span style="font-size: 19px; margin-left: 10px;">
			        			<!-- (할인율) = (할인액) / (정가) X 100 -->
			        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
			        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
			        			<i class="fa-solid fa-percent"></i> 할인
			        		</span>
			        	</b></div>
					</c:if>
				</div>
				<div class="text-left">
					<c:set var="keyword" value="${fn:split(itemVO.item_keyword,'/')}" />
					<c:forEach var="telNum" items="${keyword}" varStatus="g">     
						<%-- <c:if test="${g.count == 2}">${telNum}</c:if>       
						<c:if test="${g.last}">-${telNum}</c:if> --%>
					</c:forEach> 
				</div>
	  		</a>
  		</div>
  	</c:forEach>
  </div>
  
   
  <!-- Second Photo Grid-->
  <div class="w3-row-padding w3-padding-16 w3-center">
    <div class="w3-quarter">
      <img src="${ctp}/images/sandwich.jpg" alt="Popsicle" style="width:100%">
      <h3>All I Need Is a Popsicle</h3>
      <p>Lorem ipsum text praesent tincidunt ipsum lipsum.</p>
    </div>
    <div class="w3-quarter">
      <img src="${ctp}/images/sandwich.jpg" alt="Salmon" style="width:100%">
      <h3>Salmon For Your Skin</h3>
      <p>Once again, some random text to lorem lorem lorem lorem ipsum text praesent tincidunt ipsum lipsum.</p>
    </div>
    <div class="w3-quarter">
      <img src="${ctp}/images/sandwich.jpg" alt="Sandwich" style="width:100%">
      <h3>The Perfect Sandwich, A Real Classic</h3>
      <p>Just some random text, lorem ipsum text praesent tincidunt ipsum lipsum.</p>
    </div>
    <div class="w3-quarter">
      <img src="${ctp}/images/sandwich.jpg" alt="Croissant" style="width:100%">
      <h3>Le French</h3>
      <p>Lorem lorem lorem lorem ipsum text praesent tincidunt ipsum lipsum.</p>
    </div>
  </div>