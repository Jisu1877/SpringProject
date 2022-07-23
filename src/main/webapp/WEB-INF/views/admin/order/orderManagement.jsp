<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>통합 주문 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
	  	td {
	  		vertical-align: middle;
	  	}
	</style>
	<script>
		//페이지사이즈 검색
		function pageCheck() {
			let pageSize = $("#pageSize").val();
			let part = $("select[name=part]").val();
			let search = $("select[name=search]").val();
			let searchValue = $("#searchValue").val();
			let start = $("#start").val();
			let end = $("#end").val();
			
			location.href="${ctp}/admin/order/orderList?part="+part+"&pag=${pag}&pageSize="+pageSize+"&search="+search+"&searchValue="+searchValue+"&start="+start+"&end="+end;
		}
	
		//분류별 검색
		function codeCheck() {
			let part = $("select[name=part]").val();
			let pageSize = $("#pageSize").val();
			let search = $("select[name=search]").val();
			let searchValue = $("#searchValue").val();
			let start = $("#start").val();
			let end = $("#end").val();
			
			location.href="${ctp}/admin/order/orderList?part="+part+"&pag=${pag}&pageSize="+pageSize+"&search="+search+"&searchValue="+searchValue+"&start="+start+"&end="+end;
		}
		
		/* 상세 검색*/
		function searchCheck() {
			let start = $("#start").val();
			let end = $("#end").val();
			let regDate = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
			let search = $("select[name=search]").val();
			let searchValue = $("#searchValue").val();
			let pageSize = $("#pageSize").val();
			let part = $("select[name=part]").val();
			
			if(start != "" && end == "") {
				alert("조회 날짜는 2개 모두 선택해야 합니다.");
				return false;
			}
			if(start == "" && end != "") {
				alert("조회 날짜는 2개 모두 선택해야 합니다.");
				return false;
			}
			if(start != "" && end != "") {
				if(!regDate.test(start)) {
					alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
					document.getElementById("start").focus();
					return false;
				}
				else if(!regDate.test(end)) {
					alert("입력하신 날짜가 날짜형식에 맞지 않습니다.");
					document.getElementById("end").focus();
					return false;
				}
			}	
			
			if(search != "" && searchValue == "") {
				alert("상세 조건을 선택하세요.");
				return false;
			}
			if(search == "" && searchValue != "") {
				alert("상세 검색 내용을 입력하세요.");
				return false;
			}
			
			location.href="${ctp}/admin/order/orderList?part="+part+"&pag=${pag}&pageSize="+pageSize+"&search="+search+"&searchValue="+searchValue+"&start="+start+"&end="+end;
		}
		
		/* 리셋 */
		function reset() {
			location.href="${ctp}/admin/order/orderList";
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
			<div class="w3-bottombar w3-light-gray w3-padding" style="margin-bottom: 20px;">
		    	<span style="font-size:23px;">통합 주문 관리</span>
		    </div>
		</header>
 		<div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-third w3-margin-bottom">
            <label><i class="fa fa-calendar-o"></i>&nbsp; 조회 기간&nbsp; <span style="font-size:14px;">※ 모든 조건을 각각 조회할 수 있습니다.</span></label>
            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="start" id="start" value="${start}" autocomplete="off">
          </div>
          <div class="w3-third">
            <label>&nbsp;</label>
            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="end" id="end" value="${end}" autocomplete="off">
          </div>
          <div class="w3-third">
          </div>
        </div>
        <div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-third w3-margin-bottom">
            <label><i class="fa-solid fa-circle-info"></i>&nbsp; 상세 조건</label>
            <select name="search" id="search" class="w3-select w3-border">
   				<option value="">상세 조건 선택</option>
   				<option value="delivery_name" ${search == 'delivery_name' ? 'selected' : '' }>수취인명</option>
   				<option value="delivery_tel" ${search == 'delivery_tel' ? 'selected' : '' }>수취인연락처</option>
   				<option value="name" ${search == 'name' ? 'selected' : '' }>구매자명</option>
   				<option value="tel" ${search == 'tel' ? 'selected' : '' }>구매자연락처</option>
   				<option value="user_id" ${search == 'user_id' ? 'selected' : '' }>구매자 ID</option>
   				<option value="order_number" ${search == 'order_number' ? 'selected' : '' }>주문번호</option>
   				<option value="item_idx" ${search == 'item_idx' ? 'selected' : '' }>상품번호</option>
   				<%-- <option value="7" ${code == 7 ? 'selected' : '' }>송장번호</option> --%>
   			</select>
          </div>
          <div class="w3-third w3-margin-bottom">
          	<label>&nbsp;</label>
          	<input type="text" class="w3-input w3-border" type="text" placeholder="상세검색 내용 입력" name="searchValue" id="searchValue" value="${searchValue}" />
          </div>
          <div class="w3-third w3-margin-bottom">
          	<label>&nbsp;</label><br>
     		<a class="w3-button w3-2019-soybean" onclick="searchCheck()"><i class="fa fa-search w3-margin-right"></i> Search</a>
    	  </div>
        </div>
   	    <div class="w3-row-padding">
       		<div class="w3-third w3-margin-bottom" style="margin-left:0px; padding-left:0px;">
       			<label>&nbsp;</label>
       			<select name="part" id="order_status_code" onchange="codeCheck()" class="w3-select w3-left mr-3" style="width:30%">
	       			<option value="0" ${code == 0 ? 'selected' : '' }>전체조회</option>
	   				<option value="1" ${code == 1 ? 'selected' : '' }>결제완료</option>
	   				<option value="2" ${code == 2 ? 'selected' : '' }>주문확인</option>
	   				<option value="3" ${code == 3 ? 'selected' : '' }>취소</option>
	   				<option value="4" ${code == 4 ? 'selected' : '' }>배송중</option>
	   				<option value="5" ${code == 5 ? 'selected' : '' }>배송완료</option>
	   				<option value="6" ${code == 6 ? 'selected' : '' }>구매확정완료</option>
	   				<option value="7" ${code == 7 ? 'selected' : '' }>교환신청</option>
	   				<option value="8" ${code == 8 ? 'selected' : '' }>교환승인</option>
	   				<option value="9" ${code == 9 ? 'selected' : '' }>배송중(교환)</option>
	   				<option value="10" ${code == 10 ? 'selected' : '' }>교환거부</option>
	   				<option value="11" ${code == 11 ? 'selected' : '' }>환불신청</option>
	   				<option value="12" ${code == 12 ? 'selected' : '' }>환불승인</option>
	   				<option value="13" ${code == 13 ? 'selected' : '' }>환불완료</option>
	   				<option value="14" ${code == 14 ? 'selected' : '' }>환불거부</option>
	   				<option value="15" ${code == 15 ? 'selected' : '' }>취소요청</option>
	   				<option value="16" ${code == 16 ? 'selected' : '' }>취소반려</option>
       			</select>
       			<label>&nbsp;</label>
	     		<select name="pageSize" id="pageSize" onchange="pageCheck()" class="w3-select w3-left" style="width:20%">
					<option value="5" ${pageVo.pageSize == 5 ? 'selected' : '' }>5건</option>
					<option value="10" ${pageVo.pageSize == 10 ? 'selected' : '' }>10건</option>
					<option value="15" ${pageVo.pageSize == 15 ? 'selected' : '' }>15건</option>
					<option value="20" ${pageVo.pageSize == 20 ? 'selected' : '' }>20건</option>
				</select>
       		</div>
   	  		<div class="w3-third w3-margin-bottom"></div>
       		<div class="w3-third w3-margin-bottom">
       			<label>&nbsp;</label>
       			<a class="w3-button w3-2021-french-blue w3-right" onclick="reset()"><i class="fa-solid fa-arrows-rotate w3-margin-right"></i>Search Reset</a>
       		</div>
        </div>
		<div class="w3-responsive tableStyle">
			<table class="w3-table table-bordered" style="border-collapse:separate;">
				<thead>
		        	<tr class="w3-2019-princess-blue">
		        		<th class="text-center">회원ID</th>
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
	        			<td width="7%"class="text-center id_${vo.order_idx}" style="vertical-align: middle;">${vo.user_id}</td>
	        			<td width="5%" class="text-center idx_${vo.order_idx}" style="vertical-align: middle;">${vo.order_number}</td>
	        			<td width="5%" class="text-center" style="padding:0px; vertical-align: middle;">${vo.item_idx}</td>
	        			<td>
	        				 ${fn:substring(vo.item_name, 0, 10)}
						    <c:if test="${fn:length(vo.item_name) > 9}">
						    ...
						    </c:if>
	        			</td>
	        			<td width="8%" class="text-center">
	        				<c:if test="${vo.option_name != ''}">
		        				${vo.option_name}
	        				</c:if>
	        				<c:if test="${vo.option_name == ''}">
	        					-
	        				</c:if>
	        			</td>
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
	        			<td class="text-center" width="7%">
	        				<c:if test="${vo.order_status_code == '1'}">
								<font size="3" color="gray">결제완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '2'}">
								<font size="3" color="gray">주문확인</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '3'}">
								<font size="3" color="red">취소완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '4'}">
								<font size="3" color="navy">배송중</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '5'}">
								<font size="3" color="navy">배송완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '6'}">
								<font size="3" color="gray">구매완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '7'}">
								<font size="3" color="red">교환신청 처리 중</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '8'}">
								<font size="3" color="red">교환승인 완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '9'}">
								<font size="3" color="red">배송중(교환)</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '10'}">
								<font size="3" color="red">교환거부</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '11'}">
								<font size="3" color="red">환불신청 처리 중</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '12'}">
								<font size="3" color="red">환불승인</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '13'}">
								<font size="3" color="red">환불완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '14'}">
								<font size="3" color="red">환불거부</font>
							</c:if>
							<c:if test="${vo.order_status_code == '15'}">
								<font size="3" color="blue">취소 요청</font>
							</c:if>
							<c:if test="${vo.order_status_code == '16'}">
								<font size="3" color="gray">취소 반려</font>
							</c:if>
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${vo.order_status_code == '1'}">
								<input type="button" value="주문확인" class="btn btn-sm w3-2020-navy-blazer" onclick="orderCodeChange1(${vo.order_list_idx})"/>
							</c:if>					
							<c:if test="${vo.order_status_code == '2' || vo.order_status_code == '16'}">
								<a onclick="location.href='${ctp}/admin/order/orderDelivery'" class="btn w3-2021-mint btn-sm">배송 처리</a>
							</c:if>					
							<c:if test="${vo.order_status_code == '3'}">
								<a onclick="orderCancelInfor(${vo.order_list_idx},${vo.order_idx})" class="btn w3-yellow btn-sm">내역 확인</a>
							</c:if>					
							<c:if test="${vo.order_status_code == '4'}">
								<a onclick="deliveryOk(${vo.order_list_idx})" class="btn w3-2021-french-blue btn-sm">완료 처리</a>
							</c:if>					
							<c:if test="${vo.order_status_code == '5'}">
								-
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
							<c:if test="${vo.order_status_code == '15'}">
								<a onclick="orderCancelRequest(${vo.order_list_idx},${vo.order_idx})" class="btn w3-2020-mosaic-blue btn-sm">요청 처리</a>
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
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=1&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">«</a>
	      </c:if>
	    <%--   <c:if test="${pageVo.curBlock > 0}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-black w3-button">◁</a>
	      </c:if> --%>
	      <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}">
	      	<c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    </c:if>
	      </c:forEach>
	     <%--  <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		      <a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}&pageSize=${pageVo.pageSize}" class="w3-bar-item w3-button w3-hover-black">▷</a>
		  </c:if> --%>
		  <c:if test="${pageVo.pag != pageVo.totPage}">
		  	<a href="${ctp}/admin/order/orderList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}&start=${start}&end=${end}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
 	</div>
</div>
</body>
</html>