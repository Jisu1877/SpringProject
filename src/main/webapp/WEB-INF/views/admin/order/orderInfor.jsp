<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세 정보</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:24%;
    	}
    </style>
    <script type="text/javascript">
    	$(function() {
			$("#messageInputbtn").hide();
		});
    
    	function messageInput(sw) {
    		if(sw == 0) {
	    		$("#memoNo").removeAttr("disabled");
    		}
    		if(sw == 1) {
    			$("#memoYes").removeAttr("disabled");
    		}
    		
    		document.getElementById("messagebtn").style.display = "none";
    		$("#messageInputbtn").show();
    	}
    	
    	function messageInputOk(sw,idx) {
    		let memo;
    		if(sw == 0) {
    			memo = $("#memoNo").val();
    		}
    		if(sw == 1) {
    			memo = $("#memoYes").val();
    		}
    		
    		$.ajax({
				type : "post",
				url : "${ctp}/admin/order/orderMemoInput",
				data : {memo : memo,
						idx : idx},
				success : function(data) {
					if(data == "1") {
						location.reload();
					}
				},
				error : function() {
					alert("전송오류.");
				}
    		});
		}
    	
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
	<div class="w3-bar w3-border w3-2019-princess-blue">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">주문 상세 정보</span>
	</div>
	<div style="margin-top:40px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div>
					<label class="w3-yellow"><b>주문 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>주문번호</th>
							<td>${orderList[0].order_idx}</td>
						</tr>
						<tr>
							<th>주문일</th>
							<td>${fn:substring(orderList[0].created_date, 0, 19)}</td>
						</tr>
						<tr>
							<th>결제 총금액</th>
							<td><fmt:formatNumber value="${orderList[0].order_total_amount}"/>원</td>
						</tr>
					</table>
					<br>
					<label class="w3-yellow"><b>구매자 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>회원 아이디</th>
							<td>${orderList[0].user_id}</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${orderList[0].tel}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${orderList[0].email}</td>
						</tr>
					</table>
					<br>
					<label class="w3-yellow"><b>배송 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>배송지명</th>
							<td>${deliveryVO.title}</td>
						</tr>
						<tr>
							<th>수령인 성명</th>
							<td>${deliveryVO.delivery_name}</td>
						</tr>
						<tr>
							<th>수령인 연락처</th>
							<td>${deliveryVO.delivery_tel}</td>
						</tr>
						<tr>
							<th>배송지</th>
							<td>
								(${deliveryVO.postcode})<br> ${deliveryVO.roadAddress} ${deliveryVO.detailAddress} ${deliveryVO.extraAddress}  
							</td>
						</tr>
						<tr>
							<th>배송 메세지</th>
							<td>${deliveryVO.message}</td>
						</tr>
					</table>
					<br>
					<label class="w3-yellow"><b>주문 상품 정보</b></label>
					<c:forEach var="vo" items="${orderList}" varStatus="st">
						<div>${st.count}.</div>
						<table class="table w3-bordered">
							<tr>
								<th>상품명</th>
								<td>${vo.item_name}</td>
							</tr>
							<tr>
								<th>수량</th>
								<td>${vo.order_quantity}개</td>
							</tr>
							<tr>
								<th>금액</th>
								<td><fmt:formatNumber value="${vo.item_price}"/>원</td>
							</tr>
							<c:if test="${vo.item_option_flag == 'y'}">
								<tr>
									<th>옵션명</th>
									<td>${vo.option_name}</td>
								</tr>
								<tr>
									<th>옵션가격</th>
									<td><fmt:formatNumber value="${vo.option_price}"/>원 X ${vo.order_quantity}</td>
								</tr>
							</c:if>
							<tr>
								<th>주문상태</th>
								<td>
									<c:if test="${vo.order_status_code == '1'}">
										<font size="3" color="gray">결제완료</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '2'}">
										<font size="3" color="gray">확인완료</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '3'}">
										<font size="3" color="red">취소완료</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '4'}">
										<font size="3" color="gray">배송중</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '5'}">
										<font size="3" color="gray">배송완료</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '6'}">
										<font size="3" color="gray">구매완료</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '7'}">
										<font size="3" color="red">교환신청 처리 중</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '8'}">
										<font size="3" color="red">교환승인 완료</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '9'}">
										<font size="3" color="red">배송중(교환)</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '10'}">
										<font size="3" color="red">교환거부</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '11'}">
										<font size="3" color="red">환불신청 처리 중</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '12'}">
										<font size="3" color="red">환불승인</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '13'}">
										<font size="3" color="red">환불완료</font><br>
									</c:if>					
									<c:if test="${vo.order_status_code == '14'}">
										<font size="3" color="red">환불거부</font><br>
									</c:if>
								</td>
							</tr>
						</table>
					</c:forEach>
				</div>
				<label class="w3-yellow"><b>관리자 메세지</b></label>
				<br>
				<c:set var="sw"/>
				<c:if test="${orderList[0].order_admin_memo == null}">
					<textarea rows="5" cols="50" disabled id="memoNo"></textarea>
					<c:set var="sw" value="0"/>
				</c:if>
				<c:if test="${orderList[0].order_admin_memo != null}">
					<textarea rows="5" cols="50" disabled id="memoYes">${orderList[0].order_admin_memo}</textarea>
					<c:set var="sw" value="1"/>
				</c:if>
				<a id="messagebtn" class="w3-btn w3-amber w3-small mt-1" href="javascript:messageInput(${sw})">메세지 작성</a>
				<a id="messageInputbtn" class="w3-btn w3-amber w3-small mt-1" href="javascript:messageInputOk(${sw},${orderList[0].order_idx})">메세지 등록</a>
				
				<div class="text-center mt-3"><a class="w3-btn w3-2019-princess-blue" onclick="window.close();">닫기</a></div>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>