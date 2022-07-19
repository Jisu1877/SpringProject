<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 조회/수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script src="${ctp}/js/orderManagement.js"></script>
    <style>
		body,h1 {font-family: "Montserrat", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
			text-decoration: none;	
		}
		.tableStyle {
	  		width:100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  		border-radius: 15px;
	  		background-color: white;
	  	}
	</style>
	<script>
		//페이지사이즈 검색
		function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${pag}&pageSize="+pageSize;
		}
	
		//분류별 검색
		function partCheck() {
			let part = $("select[name=part]").val();
			let pageSize = $("#pageSize").val();
			location.href="${ctp}/admin/item/itemList?part="+part+"&pag=${pag}&pageSize="+pageSize;
		}
		
		function orderCancelInfor(listIdx) {
			let url = "/javagreenS_ljs/order/orderCancelInfor?listIdx=" + listIdx;
			let winX = 500;
		    let winY = 650;
		    let x = (window.screen.width/2) - (winX/2);
		    let y = (window.screen.height/2) - (winY/2)
			window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		}
	</script>
</head>
<body class="w3-light-grey">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px;margin-top:43px;">
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
	    <!-- Header -->
		<header style="padding-top:22px;">
			<div class="w3-bottombar w3-light-grey w3-padding" style="margin-bottom: 20px; font-size:23px;">
		    	주문관리
		    </div>
		</header>
 		<div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-third w3-margin-bottom">
            <label><i class="fa fa-calendar-o"></i>&nbsp; 조회 기간</label>
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
          			<select name="part" id="order_status_code" class="w3-select w3-border">
          				<option value="0" ${code == 0 ? 'selected' : '' }>전체조회(주문상태)</option>
		   				<option value="1" ${code == 1 ? 'selected' : '' }>결제완료</option>
		   				<option value="2" ${code == 2 ? 'selected' : '' }>주문확인(배송준비)</option>
		   				<option value="3" ${code == 3 ? 'selected' : '' }>취소</option>
		   				<option value="4" ${code == 4 ? 'selected' : '' }>배송중</option>
		   				<option value="5" ${code == 5 ? 'selected' : '' }>배송완료</option>
		   				<option value="6" ${code == 6 ? 'selected' : '' }>구매확정완료</option>
		   				<option value="7" ${code == 7 ? 'selected' : '' }>교환신청</option>
		   				<option value="8" ${code == 8 ? 'selected' : '' }>교환승인(수거처리)</option>
		   				<option value="9" ${code == 9 ? 'selected' : '' }>배송중(교환)</option>
		   				<option value="10" ${code == 10 ? 'selected' : '' }>교환거부</option>
		   				<option value="11" ${code == 11 ? 'selected' : '' }>환불신청</option>
		   				<option value="12" ${code == 12 ? 'selected' : '' }>환불승인(수거처리)</option>
		   				<option value="13" ${code == 13 ? 'selected' : '' }>환불완료</option>
		   				<option value="14" ${code == 14 ? 'selected' : '' }>환불거부</option>
          			</select>
          		</div>
          		<div class="w3-half pl-4">
          			<label>&nbsp;</label><br>
          			<!-- <a class="w3-button w3-2019-soybean" onclick="searchCheck()"><i class="fa fa-search w3-margin-right"></i> Search</a> -->
          		</div>
          	</div>
          </div>
        </div>
        <div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-third w3-margin-bottom">
            <label><i class="fa-solid fa-circle-info"></i>&nbsp; 상세 조건</label>
            <select name="search" id="search" class="w3-select w3-border">
   				<option value="0" ${code == 0 ? 'selected' : '' }>전체(검색조건)</option>
   				<option value="1" ${code == 1 ? 'selected' : '' }>수취인명</option>
   				<option value="2" ${code == 2 ? 'selected' : '' }>구매자명</option>
   				<option value="3" ${code == 3 ? 'selected' : '' }>구매자연락처</option>
   				<option value="4" ${code == 4 ? 'selected' : '' }>구매자 ID</option>
   				<option value="5" ${code == 5 ? 'selected' : '' }>주문번호</option>
   				<option value="6" ${code == 6 ? 'selected' : '' }>상품번호</option>
   				<option value="7" ${code == 7 ? 'selected' : '' }>송장번호</option>
   			</select>
          </div>
          <div class="w3-third w3-margin-bottom">
          	<label>&nbsp;</label>
          	<input type="text" class="w3-input w3-border" type="text" placeholder="상세검색 내용 입력" name="searchValue" id="searchValue" />
          </div>
          <div class="w3-third w3-margin-bottom">
     		<label>&nbsp;</label><br>
     		<a class="w3-button w3-2019-soybean" onclick="searchCheck()"><i class="fa fa-search w3-margin-right"></i> Search</a>
     		<select name="pageSize" id="pageSize" onchange="pageCheck()" class="w3-select w3-right mr-3" style="width:30%">
				<option value="5" ${pageVo.pageSize == 5 ? 'selected' : '' }>5건</option>
				<option value="10" ${pageVo.pageSize == 10 ? 'selected' : '' }>10건</option>
				<option value="15" ${pageVo.pageSize == 15 ? 'selected' : '' }>15건</option>
				<option value="20" ${pageVo.pageSize == 20 ? 'selected' : '' }>20건</option>
			</select>
    	  </div>
        </div>
		<div class="w3-responsive tableStyle">
			<table class="w3-table table-bordered" style="border-collapse:separate;">
				<thead>
		        	<tr class="w3-2019-princess-blue">
		        		<th class="text-center">구매자 아이디</th>
		        		<th class="text-center">주문번호</th>
		        		<th class="text-center">상품번호</th>
		        		<th class="text-center">상품명</th>
		        		<th class="text-center">옵션명</th>
		        		<th class="text-center">수량</th>
		        		<th class="text-center">결제금액</th>
		        		<th class="text-center">주문일시</th>
		        		<th class="text-center">상세정보</th>
		        		<th class="text-center">주문상태</th>
		        		<th class="text-center">처리</th>
		        	</tr>
				</thead>
				<tbody>
	        	<c:forEach var="vo" items="${orderList}">
	        		<tr data-idx="${vo.order_idx}">
	        			<td width="9%"class="text-center id_${vo.order_idx}" style="vertical-align: middle;">${vo.user_id}</td>
	        			<td width="5%" class="text-center idx_${vo.order_idx}" style="vertical-align: middle;">${vo.order_idx}</td>
	        			<td width="5%" class="text-center">${vo.item_idx}</td>
	        			<td>${vo.item_name}</td>
	        			<td width="8%">${vo.option_name}</td>
	        			<td class="text-center">${vo.order_quantity} 개</td>
	        			<td class="text-center">
	        				<fmt:formatNumber value="${vo.item_price}"/> 원	
	        			</td>
	        			<td class="text-center" style="vertical-align: middle;">
	        				${fn:substring(vo.created_date, 0, 19)}
	        			</td>
	        			<td class="text-center infor_${vo.order_idx}" style="vertical-align: middle;">
	        				<a onclick="orderListInfor(${vo.order_idx})">조회</a>
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${vo.order_status_code == '1'}">
								<font size="3" color="gray">결제완료</font><br>
							</c:if>					
							<c:if test="${vo.order_status_code == '2'}">
								<font size="3" color="gray">주문확인(배송준비)</font><br>
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
	        			<td class="text-center">
	        				<c:if test="${vo.order_status_code == '1'}">
								<input type="button" value="주문확인" class="btn btn-sm w3-2020-navy-blazer" onclick="orderCodeChange1(${vo.order_list_idx})"/>
							</c:if>					
							<c:if test="${vo.order_status_code == '2'}">
								<a onclick="" class="btn w3-2021-mint btn-sm">송장 입력</a>
							</c:if>					
							<c:if test="${vo.order_status_code == '3'}">
								<a onclick="orderCancelInfor(${vo.order_list_idx})" class="btn w3-yellow btn-sm">내용 확인</a>
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
	        	</c:forEach>
	        	</tbody>
	        </table>
	    </div>
	    <!-- 블록 페이징 처리 -->
	  <div class="w3-center w3-padding-32">
	 	 <div class="mb-2"><b>${pageVo.pag} Page</b></div>
	    <div class="w3-bar w3-white">
	      <c:if test="${pageVo.pag > 1}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=1&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">«</a>
	      </c:if>
	    <%--   <c:if test="${pageVo.curBlock > 0}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-black w3-button">◁</a>
	      </c:if> --%>
	      <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}">
	      	<c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
	      </c:forEach>
	     <%--  <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">▷</a>
		  </c:if> --%>
		  <c:if test="${pageVo.pag != pageVo.totPage}">
		  	<a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
 	</div>
</div>
</body>
</html>