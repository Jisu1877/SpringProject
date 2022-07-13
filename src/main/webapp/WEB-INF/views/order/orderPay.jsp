<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/결제</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<style>
  	.total_price {
	font-size: 20px;
	font-weight: bold;
	margin: 20px;
}
</style>
<script>
	function deliveryInsert(flag) {
		let default_flag = '';
		if(flag == 'n') {
			default_flag = 'y';
		}
		else {
			default_flag = 'n';
		}
		
		let url = "${ctp}/delivery/deliveryInsert?flag="+default_flag;
		let winX = 700;
        let winY = 600;
        let x = (window.screen.width/2) - (winX/2);
        let y = (window.screen.height/2) - (winY/2)
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	}
	
	/* 결제하기  */
	function order() {
  /*  		<input type="hidden" name="order_item_idx" value="${orderVO.order_item_idx}">
   		<input type="hidden" name="order_item_name" value="${orderVO.order_item_name}">
   		<input type="hidden" name="order_item_image" value="${orderVO.order_item_image}">
   		<input type="hidden" name="order_item_price" value="${orderVO.order_item_price}">
   		<input type="hidden" name="order_item_option_flag" value="${orderVO.order_item_option_flag}">
   		<input type="hidden" name="order_option_name" value="${orderVO.order_option_name}">
   		<input type="hidden" name="order_option_price" value="${orderVO.order_option_price}">
   		<input type="hidden" name="order_quantity" value="${orderVO.order_quantity}">
   		<input type="hidden" name="order_total_amount" value="${orderVO.order_total_amount}"> */
		
   		let data = {
   			order_item_idx : ${orderVO.order_item_idx[0]}
   		}
   		
   		$.ajax({
   			type : "post",
   			url : "${ctp}/order/orderCheck",
   			data : data,
   			success : function(res) {
				if(res == "1") {
					alert("결제 성공");
				}
			},
			error : function() {
				alert("전송오류");
			}
   		});
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
    	<form name="payForm" method="post">
   		<div class="w3-row" style="padding:20px;">
   			<div class="m-2">
   				장바구니 &nbsp; 
   				<i class="fa-solid fa-angle-right"></i> &nbsp; <b style="font-size:17px;">주문/결제</b> &nbsp;
   				<i class="fa-solid fa-angle-right"></i> &nbsp; 완료
   			</div>
   			<div class="w3-col m7 l7">
	    	<div class="w3-bottombar w3-light-grey w3-padding" style="margin-bottom: 20px;">
	    		주문내역
	    	</div>
	    	<div style="margin-bottom: 30px;">
	    		<table class="w3-table" style="font-size:17px;">
   				<c:forEach var="i" begin="0" end="${fn:length(orderVO.order_item_name) - 1}" varStatus="st">
   					<tr>
   						<td>
   							<b>${st.count}.</b>
   						</td>
   						<td>
   							<img src="${ctp}/data/item/${orderVO.order_item_image[i]}" width="150px;"/>
   						</td>
   						<td>
   							<b>${orderVO.order_item_name[i]}</b><br>
	   						상품 주문 수량 : <span>${orderVO.order_quantity[i]}</span> 개<br>
		   					<c:if test="${orderVO.order_item_option_flag[i] == 'y'}">
		   						옵션 : ${orderVO.order_option_name[i]}<br>
		   					</c:if>
   						</td>
						<td>
							<b>상품 금액</b><br>
							<fmt:formatNumber value="${orderVO.order_item_price[i]}"/>원</span></b>
						</td>
					</tr>
   				</c:forEach>
			</table>
		  </div>
			<hr>
			<div style="margin-top: 20px;">
			  <ul>
			    <li style="font-size:21px;"><b>총 결제 금액</b></li>
			    <li class="total_price"><fmt:formatNumber value="${orderVO.order_total_amount}"/>원</li>
			    <li><input type="button" value="결제하기" class="w3-2021-desert-mist btn-lg" onclick="order()" style="width:30%"></li>
			  </ul>
			</div>
			</div>
			<div class="w3-col m5 l5" id="delivery">
		    	<div class="w3-bottombar w3-2021-buttercream w3-padding" style="margin-bottom: 20px;">
		    		배송지 정보
		    	</div>
		    	<c:if test="${deliveryFlag == 'n'}">
		    	<div class="text-center" style="font-size: 17px; margin-bottom:30px;">
		    		<div class="mb-2"><i class="fa-solid fa-triangle-exclamation" style="color:orange"></i>&nbsp;등록된 배송정보 없음<br></div>
		    		<input type="button" value="배송지 등록" class="w3-2021-buttercream btn" style="width:50%" onclick="deliveryInsert('${deliveryFlag}')">
		    	</div>
		    	</c:if>
		    	<c:if test="${deliveryFlag == 'y'}">
		    		<div class="w3-padding">
	    				<div><i class="fa-solid fa-location-dot" style="margin-bottom:10px"></i>&nbsp;기본 주소(${deliveryVO.title})</div>
		    			<table class="w3-table">
		    				<tr>
		    					<td width="20%" class="text-center">수령인</td>
		    					<td>| ${deliveryVO.delivery_name}</td>
		    				</tr>
		    				<tr>
		    					<td width="20%" class="text-center">연락처</td>
		    					<td>| ${deliveryVO.delivery_tel}</td>
		    				</tr>
		    				<tr>
		    					<td width="20%" class="text-center">주소</td>
		    					<td>| (${deliveryVO.postcode})${deliveryVO.roadAddress} ${deliveryVO.detailAddress} ${deliveryVO.extraAddress}</td>
		    				</tr>
		    				<tr>
		    					<td width="20%" class="text-center">배송메세지</td>
		    					<td>| 
		    						<c:if test="${deliveryVO.message == ''}">
		    							없음
		    						</c:if>
		    						<c:if test="${deliveryVO.message != ''}">
			    						${deliveryVO.message}
		    						</c:if>
		    					</td>
		    				</tr>
		    			</table>
		    		</div>
		    		<hr>
		    		<div class="mb-3" style="text-align:center">
			    		<input type="button" value="배송지 추가" class="w3-2021-buttercream btn" style="width:40%" onclick="deliveryInsert('y')">
			    		<input type="button" value="배송지 목록" class="w3-2021-buttercream btn" style="width:40%" onclick="">
		    		</div>
		    	</c:if>
		    	<div class="w3-bottombar w3-2020-sunlight w3-padding" style="margin-bottom: 20px;">
		    		주문자 정보
		    	</div>
		    	<div class="w3-padding" style="margin-bottom: 20px;">
    				<div><i class="fa-solid fa-user"></i>&nbsp;
    					<a href="#" style="font-size:12px;">회원정보 수정하기</a>
    				</div>
	    			<table class="w3-table">
	    				<tr>
	    					<td width="20%">주문자</td>
	    					<td>| ${userVO.name}</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">연락처</td>
	    					<td>| ${userVO.tel}</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">이메일</td>
	    					<td>| ${userVO.email}</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">회원등급</td>
	    					<td>| 
	    						<c:if test="${userVO.level == 1}">
	    							Gold
	    						</c:if>
	    						<c:if test="${userVO.level == 2}">
	    							Silver
	    						</c:if>
	    						<c:if test="${userVO.level == 0}">
	    							Admin
	    						</c:if>
	    						<span class="w3-dropdown-click">
									<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
									<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
										더 가든은 회원 등급제를 운영하고 있습니다.<br>
										(Silver/Gold)
										<hr>
										Gold 레벨 변경 요건은?<br>
										- 로그인 횟수 50회 이상<br>
										- 구매 총 가격 30만원 이상
										<hr>
										Gold 레벨의 혜택은?<br>
										- 식물 경매 참여 가능
								    </div>
								</span>
	    					</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">보유 포인트</td>
	    					<td>| <fmt:formatNumber value="${userVO.point}"/> Point</td>
	    				</tr>
	    			</table>
	    		</div>
	    		<div class="w3-bottombar w3-2021-desert-mist w3-padding" style="margin-bottom: 20px;">
		    		혜택 적용
		    	</div>
		    	<div class="w3-padding" style="margin-bottom: 20px;">
    				<div><i class="fa-solid fa-won-sign"></i>&nbsp; 포인트 사용</div>
	    			<table class="w3-table">
	    				<tr>
	    					<td>
								<div class="input-group">
					    			<input class="input" width="60%" id="point" name="usePoint" type="number" onchange="PointUse()" onkeydown="javascript: return event.keyCode == 69 ? false : true">
					    			<div class="input-group-append">
								      	<input type="button" value="전액 사용" class="btn w3-2021-buttercream" onclick="PointUseAll()"/>
								    </div>
					    		</div>
							</td>
	    				</tr>
	    			</table>
    				<div class="mt-3"><i class="fa-solid fa-ticket"></i>&nbsp; 쿠폰 적용</div>
    				<div class="mt-4"> ✔️ 쿠폰의 일련번호를 작성하세요.</div>
	    			<table class="w3-table">
	    				<tr>
	    					<td>
								<div class="input-group">
					    			<input class="input" width="60%" id="couponNum" name="couponNum" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력하세요.">
					    			<div class="input-group-append">
								      	<input type="button" value="입력" class="btn w3-2021-buttercream" onclick=""/>
								    </div>
					    		</div>
							</td>
	    				</tr>
	    			</table>
	    		</div>
			</div>
		  </div>
   		</div>
    	</form>
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