<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>엑셀 일괄 발송처리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:24%;
    	}
    </style>
    <script type="text/javascript">
    	function sendProcess() {
			
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
	<div class="w3-bar w3-border w3-2019-eden">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">엑셀 일괄 발송처리</span>
	</div>
	<div style="margin-top:20px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div class="mb-2">
					<span class="w3-yellow">
					※ '엑셀 다운로드'를 통해 다운받은 ' theGarden_excel_form ' 파일 양식만 정상 처리 가능합니다.
					</span>
				</div>
				<div class="mb-3">
					<span>
					※ 엑셀 2007 버전 이상을 이용해야 합니다.
					</span>
				</div>
				<div class="mb-3">
					<span>
					※ 같은 주문 번호인 상품은 동일 송장번호를 입력하셔야 정상 처리됩니다. 개별 발송인 경우 개별 입력 창을 이용하시길 바랍니다.
					</span>
				</div>
				<div style="border: 0.5px solid;" class="w3-padding">
					<label><b>파일 등록</b></label>
					<form>
						<input type="file" class="w3-file w3-2020-brilliant-white" accept=".xlsx"> 
						<input type="button" value="일괄 발송" onclick="sendProcess()">
					</form>
					<br>
		    </div>
			<div class="text-center mt-3"><a class="w3-btn w3-2019-eden" onclick="window.close();">닫기</a></div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>