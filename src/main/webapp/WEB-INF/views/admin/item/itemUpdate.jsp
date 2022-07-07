<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${ctp}/js/itemInsert.js"></script>
    <style>
		body,h1 {font-family: "Montserrat", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
			text-decoration: none;	
		}
		.box {
	   		box-shadow: 0 16px 18px -20px rgba(0, 0, 0, 0.7);
		}
		#schedule_date {
			padding-left:20px;
		}
	</style>
</head>
<body class="w3-light-grey">
<!-- Top container -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

    <!-- Header -->
	<header class="w3-container" style="padding-top:22px;">
		<p style="margin-top:20px; font-size:23px;">상품 수정</p>
		<p><span style="color:red;">🔸&nbsp;</span> 표시가 있는 사항은 필수입력입니다.</p>
	</header>
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
		<form name="myForm" method="post" class="was-validated mt-3" enctype="multipart/form-data" onsubmit="return itemInsert();">
 		<div class="w3-col s11">
 			<div class="box w3-border">
				<div class="w3-white w3-padding">
			    		<label for="user_id">카테고리 <span style="color:red;">🔸&nbsp;</span> <font color="red">(수정 불가)</font></label>
		    			<div>
		    				<b>대분류</b> | ${itemVO.category_group_name}&nbsp;&nbsp; 
		    				<c:if test="${itemVO.category_name == 'NO'}">
		    					<b>중분류</b> | 없음	
		    				</c:if>
		    				<c:if test="${itemVO.category_name != 'NO'}">
		    					<b>중분류</b> | ${itemVO.category_name} 
		    				</c:if>
		    			</div>
		    			<hr>
				    	<div class="form-group">
				    		<label for="item_name">상품명 <span style="color:red;">🔸&nbsp;</span></label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_name" name="item_name" type="text" placeholder="상품명을 입력하세요.(100자 이내)" value="${itemVO.item_name}" required>
				    		</div>
						    <div id="pwdDemo"></div>
				    	</div>
				    	<div class="form-group">
				    		<label for="item_summary">상품 간단 설명 <span style="color:red;">🔸&nbsp;</span></label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_summary" name="item_summary" type="text" placeholder="상품 간단 설명을 입력하세요.(200자 이내)" value="${itemVO.item_summary}" required>
				    		</div>
				    	</div><hr>
				    	<div class="form-group">
					      <label for="display_flag">전시상태 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="display_flag" name="display_flag" value="y" ${itemVO.display_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;전시&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="display_flag" name="display_flag" value="n" ${itemVO.display_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;전시중지 
							</div>
						  </div>
					  	</div>
					  	 <div class="w3-light-gray p-4">
						  	<div style="font-size:20px;">판매가</div><br>
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="sale_price">판매가 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.sale_price}" id="sale_price" name="sale_price" type="number" onchange="minValueCheck1()" placeholder="숫자만 입력" min="0" onkeydown="javascript: return event.keyCode == 69 ? false : true" required>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
					       <div class="form-group">
						      <label for="seller_discount_flag">할인 <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="form-check-inline">
					        	<div class="form-check">
								    <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="y" ${itemVO.seller_discount_flag == 'y' ? 'checked' : ''} onkeypress="seller_discount_flag()">&nbsp;&nbsp;설정&nbsp;&nbsp;&nbsp;
								    <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="n" ${itemVO.seller_discount_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;설정안함
								</div>
							  </div>
						  	</div>
						  	<div id="seller_discount_flagForm" ${itemVO.seller_discount_flag == 'n' ? 'style="display:none"' : ''}>
							  	<div class="w3-row">
							  		<div class="w3-third">
							    	<div class="form-group">
								      <label for="seller_discount_amount">할인금액 <span style="color:red;">🔸&nbsp;</span></label>
								      <div class="input-group mb-3" style="margin-bottom:0px">
							    			<input class="input w3-padding-16 w3-border form-control" id="seller_discount_amount" min="0" name="seller_discount_amount" type="number" onchange="calPrice()" value="${itemVO.seller_discount_amount}" placeholder="숫자만 입력" onkeydown="javascript: return event.keyCode == 69 ? false : true">
							    			<div class="input-group-append">
										      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
										    </div>
						    		  </div>
							        </div>
							        </div>
							        <div class="w3-third"></div>
							        <div class="w3-third"></div>
						        </div>
						        <div style="font-weight:bold;" id="calPrice">
						        	<span>최종 판매가&nbsp;:&nbsp;</span>
						        	<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
						        	<span><fmt:formatNumber value="${calPriceFmt}"/>원</span>
						        </div>
						         <div style="font-weight:bold; display:none">
						        	<span>최종 판매가&nbsp;:&nbsp;</span>
						        	<span id="calPrice"></span>
						        	<span>원</span>
						        </div>
					        </div>
					    </div><hr>
					    <div class="form-group">
					      <label for="seller_point_flag">포인트 지급 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="y" ${itemVO.seller_point_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;지급&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="n" ${itemVO.seller_point_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;미지급
							</div>
						  </div>
					  	</div>
					    <div id="seller_pointForm" class="w3-row" ${itemVO.seller_point_flag == 'n' ? 'style="display:none"' : ''}>
					  		<div class="w3-third">
					    	<div class="form-group">
						      <label for="seller_point">지급 포인트 <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.seller_point}" id="seller_point" min="0" name="seller_point" onchange="minValueCheck2()" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력">
					    			<div class="input-group-append">
								      	<input type="button" value="Point" size="2" class="btn w3-black" disabled='disabled' />
								    </div>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><hr>
					    <div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="stock_quantity">재고수량 <span style="color:red;">🔸&nbsp;</span><br>(옵션재고수량 입력시, 자동계산되어 등록됩니다.)</label>
							      <div class="input-group mb-3">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.stock_quantity}" id="stock_quantity" min="0" name="stock_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" onchange="stock_quantityForm()" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" id="schedule_date" ${itemVO.sold_out == 0 ? 'style="display:none"' : ''}>
					        	<div class="form-group">
							      <label for="stock_schedule_date">재입고 예정일자 <br>&nbsp;</label>
							      <div class="input-group mb-3">
						    			<input class="w3-input" id="stock_schedule_date" value="${itemVO.stock_schedule_date}" name="stock_schedule_date" type="text" placeholder="YYYY-DD-MM" autocomplete="off">
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
					   <div class="w3-row">
					  		<div class="w3-third">
					    		<div class="form-group">
							      <label for="order_min_quantity">최소 주문 수량 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.order_min_quantity}" min="1" id="order_min_quantity" onchange="minValueCheck3()" name="order_min_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="padding-left: 20px;">
					        	<div class="form-group">
							      <label for="order_max_quantity">최대 주문 수량 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.order_max_quantity}" min="1" id="order_max_quantity" onchange="minValueCheck4()" name="order_max_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  <p><br></p>
				</div>
 			</div>
 		 	<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
					  	<div class="w3-light-gray p-4">
					  		<div class="form-group" style="margin-bottom: 15px;">
							  	<label for="item_option_flag" style="font-size:20px;">옵션</label>
							  	<div class="form-check-inline">
						        	<div class="form-check">
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="y" ${itemVO.item_option_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;사용&nbsp;&nbsp;&nbsp;
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="n" ${itemVO.item_option_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;사용안함
									</div>
								  </div>
							 </div>
							<div id="item_option_flagForm" ${itemVO.item_option_flag == 'n' ? 'style="display:none"' : ''}>
							  	<div class="w3-row">
							    	<div class="form-group">
								      <table class="w3-table w3-striped w3-bordered">
								      	<c:set var="i" value="1"/>
								      	<tr>
								      		<th><a onclick="javascript:addOptions(${i})"><i class="fa-solid fa-square-plus" style="font-size: 20px;" title="옵션 추가하기"></i></a></th>
								      		<th>옵션명</th>
								      		<th>추가금액</th>
								      		<th>재고수량</th>
								      		<th></th>
								      	</tr>
								      	<c:forEach var="vo" items="${itemVO.itemOptionList}" varStatus="st">
								      	<tr>
								      		<td>
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" id="option_name${i}" value="${vo.option_name}" name="option_names" type="text" placeholder="옵션 이름">
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" value="${vo.option_price}" onchange="optionPriceCheck(1)" min="0" id="option_price${i}" name="option_prices" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="옵션 추가금액">
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" value="${vo.option_stock_quantity}" onchange="optionStockCheck(1)" min="0" id="option_stock_quantity${i}" name="option_stock_quantities" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="재고수량">
								      		</td>
								      		 <td width="5%">
								      		 	<c:if test="${i != 1}">
								      		 		<a href="javascript:deleteOptions(${i})"><i class="fa-solid fa-trash-can" style="font-size: 20px; padding-top:5px;" title="옵션지우기"></i></a>
								      		 	</c:if>
								      		</td>
								      		<c:set var="i" value="${i + 1}"/>
								      	</tr>
								      	</c:forEach>
								      </table>
								      <table class="w3-table w3-striped w3-bordered" id="addOption">
								      	
								      </table>
							        </div>
						        </div>
					        </div>
					    </div><hr>
				  		<div class="form-group" style="margin-bottom: 15px;">
						  	<label for="item_image" style="font-size:20px;">상품 이미지 <span style="color:red;">🔸&nbsp;</span></label>
						 </div>
					  	<div class="w3-row">
					    	<div class="w3-third">
					    		<div style="margin-bottom:10px;">대표 이미지 <span style="color:red;">🔸&nbsp;</span></div>
					    		<a onclick="javascript:$('#myphoto').click(); return false;" style="background-color: white">
						    		<div id="addImageBtn">
						    			<div><img src="${ctp}/data/item/${itemVO.item_image}" width="300px;"></div>
						    		</div>
						    		<div id='previewId'></div>
					    		</a>
				    			<input type="button" id="photoDelete" value="삭제" class="w3-btn w3-2020-orange-peel w3-padding-small w3-small" style="display:none; margin-top:5px; margin-left:6px;" onclick="previewDelete()"/>
				    			<input type="file" name="file" id="myphoto" onchange="previewImage(this,'previewId')" class="form-control input" accept=".png, .jpg, .jpeg, .jfif, .gif" hidden="true">
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><br>
				        <div class="w3-row">
				        	<div class="w3-half">
			        			<label for="seller_point_flag" style="margin-left:5px; margin-right: 10px;">추가 이미지</label>
						        <input type="button" value="이미지 추가" onclick="fileBoxAppend()" class="btn w3-lime btn-sm mb-2"/>
				        		<span style="color:red;">🔸&nbsp;</span> 추가 이미지 최소 1장 등록 필수<br>
				        		 [등록된 사진]<br>
									<c:set var="thumbFile_save_file_name" value=""/>
									<div style="font-size:13px; color:gray; margin-top:0px"><i class="fa-solid fa-circle-exclamation"></i> <font color="red">사진 삭제시 새로 입력한 모든 값이 리셋됩니다.</font></div>
									<c:forEach var="vo" items="${itemVO.itemImageList}" varStatus="st">
										<div class="file_item" id="file_${vo.item_image_idx}">
											${st.count}. ${vo.image_name}
											<c:if test="${st.count != 1}">
												<a href="javascript:photoDel('${vo.item_image_idx}');" style="font-size: 13px; color:red;" data-index="${vo.item_image_idx}">삭제</a>
											</c:if>
										<c:if test="${st.count == 1 }">
											<c:set var="thumbFile_file_name" value="${vo.image_name}"/>
											<span style="color:bule; font-size: 13px;">(썸네일)</span>
										</c:if><br>
										</div>
									</c:forEach>
				        		<div class="mb-3">
					    			<div id="fBox1">
					    				- image
										<input type="file" name="file" id="file1" class="w3-input" accept=".png, .jpg, .jpeg, .jfif, .gif"/>
								    </div>
				    		 	 </div>
								<div id="fileBoxInsert"></div>
				        	</div>
				        	<div class="w3-half"></div>
			        	</div>
					    <hr>
					    <div class="form-group">
					      <label for="detail_content" style="font-size:20px;">상품상세설명 <span style="color:red;">🔸&nbsp;</span></label>
					  	</div>
						<div class="detail_content" id="detail_contentForm">
							<div style="margin-bottom: 10px;">- 상품상세설명 직접입력 <span style="color:red;">🔸&nbsp;</span></div>
							<textarea rows="10" name="detail_content" id="CKEDITOR" class="form-control"></textarea>
						</div>
						<script>
				      	  CKEDITOR.replace("detail_content",{
				      		  height:500,
				      		  filebrowserUploadUrl : "${ctp}/imageUpload",
				      		  uploadUrl : "${ctp}/imageUpload"
				      	  });
			      	    </script>
			        </div>
			</div>
			<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
					  	<div style="font-size:20px;">상품 주요 정보</div><br>
					  	<div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="brand" style="margin-left:5px;">브랜드 : </label>
					    			<input class="w3-input w3-2020-brilliant-white" id="brand" name="brand" type="text">
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="form" style="margin-left:5px;">형태 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="form" name="form" type="text">
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="origin_country" style="margin-left:5px;">원산지<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="origin_country" name="origin_country" type="text" required>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="item_model_name" style="margin-left:5px;">모델명<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="item_model_name" name="item_model_name" type="text" required>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="after_service" style="margin-left:5px;">A/S안내<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="after_service" name="after_service" type="text" required>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
					  	<div class="w3-row">
					  		<div class="w3-third">
							<div><span  style="font-size:20px;">상품 정보 고시</span></div>
							 - 기타 재화 -<br><br>
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="notice_title1" style="margin-left:5px;">품명/모델명<span style="color:red;">🔸&nbsp;</span> : </label>
					    			<input class="w3-input w3-2020-brilliant-white" id="notice_value1" name="notice_value1" type="text" required>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third">
					        	<input type="checkbox" id="noticeAllInput" name="noticeAllInput"> 상품상세 참조로 전체 입력
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-half">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title2" style="margin-left:5px;">법에 의한 인증, 허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="notice_value2" name="notice_value2" type="text" required>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-half"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title3" style="margin-left:5px;">제조자(사)<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="notice_value3" name="notice_value3" type="text" required>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title4" style="margin-left:5px;">제조국<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="notice_value4" name="notice_value4" type="text" required>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
				        <div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="notice_title5" style="margin-left:5px;">소비자상담 관련 전화번호<span style="color:red;">🔸&nbsp;</span> : </label>
					    			<input class="w3-input w3-2020-brilliant-white" id="notice_value5" name="notice_value5" type="text" required>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div>
				</div>
 			</div>
			
			<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
	 				<div class="w3-light-gray p-4">
				    	<div style="font-size:20px;">배송</div>
				    	<div class="form-group">
					      <label for="shipment_type_flag">배송비 구분 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="shipment_type" name="shipment_type" value="2" checked>&nbsp;&nbsp;판매자 조건부&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="shipment_type" name="shipment_type" value="1">&nbsp;&nbsp;무료배송
							</div>
						  </div>
					  	</div>
					  	<div id="shipmentPriceFrom">
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_price">배송비 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="2500" id="shipping_price" name="shipping_price" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_free_amount">조건부 무료배송 금액 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="50000" id="shipping_free_amount" name="shipping_free_amount" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
					        <div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_extra_charge">제주도 추가 배송비 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="5000" id="shipping_extra_charge" name="shipping_extra_charge" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
				        </div>
				        <hr>
				        <div class="form-group">
					      <label for="item_return_flag">반품 가능여부 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="item_return_flag" name="item_return_flag" value="y" checked>&nbsp;&nbsp;가능&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="item_return_flag" name="item_return_flag" value="n">&nbsp;&nbsp;불가능
							</div>
						  </div>
					  	</div>
					  	<div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <label for="shipping_return_price">교환/반품 배송비(편도기준) <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" id="shipping_return_price" name="shipping_return_price" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
					    			<div class="input-group-append">
								      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
								    </div>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><hr>
				        <div class="w3-row">
				        	<div class="w3-half">
						        <div class="form-group">
							      <label for="shipment_address">출고지<span style="color:red;">🔸&nbsp;</span> </label><br>
									<div class="input-group mb-1">
										<input type="text" name="shipment_postcode" id="sample6_postcode1" placeholder="우편번호" class="form-control w3-border" required>
										<div class="input-group-append">
											<input type="button" onclick="sample6_execDaumPostcode(1)" value="우편번호 찾기" class="btn w3-2020-orange-peel">
										</div>
									</div>
									<input type="text" name="shipment_roadAddress" id="sample6_address1" size="50" placeholder="주소" class="form-control mb-1 w3-border" required>
									<div class="input-group mb-1">
										<input type="text" name="shipment_detailAddress" id="sample6_detailAddress1" placeholder="상세주소" class="form-control w3-border" required> &nbsp;&nbsp;
										<div class="input-group-append">
											<input type="text" name="shipment_extraAddress" id="sample6_extraAddress1" placeholder="참고항목" class="form-control w3-border">
										</div>
									</div>
							   </div>
						   </div>
						   <div class="w3-half"></div>
						</div>
				        <div class="w3-row">
				        	<div class="w3-half">
						        <div class="form-group">
							      <label for="shipment_return_address">반송지<span style="color:red;">🔸&nbsp;</span> </label><br>
									<div class="input-group mb-1">
										<input type="text" name="shipment_return_postcode" id="sample6_postcode2" placeholder="우편번호" class="form-control w3-border" required>
										<div class="input-group-append">
											<input type="button" onclick="sample6_execDaumPostcode(2)" value="우편번호 찾기" class="btn w3-2020-orange-peel">
										</div>
									</div>
									<input type="text" name="shipment_return_roadAddress" id="sample6_address2" size="50" placeholder="주소" class="form-control mb-1 w3-border" required>
									<div class="input-group mb-1">
										<input type="text" name="shipment_return_detailAddress" id="sample6_detailAddress2" placeholder="상세주소" class="form-control w3-border" required> &nbsp;&nbsp;
										<div class="input-group-append">
											<input type="text" name="shipment_return_extraAddress" id="sample6_extraAddress2" placeholder="참고항목" class="form-control w3-border">
										</div>
									</div>
							   </div>
						   </div>
						   <div class="w3-half"></div>
						</div>
			        </div><hr>
					  	<div style="font-size:20px;">상품 대표 키워드</div><br>
					  	<div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="keyword1" style="margin-left:5px;">키워드1 : </label>
					    			<input class="w3-input w3-2020-sunlight" id="keyword1" name="keyword" type="text">
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword2" style="margin-left:5px;">키워드2 : </label>
						    			<input class="w3-input w3-2020-sunlight" id="keyword2" name="keyword" type="text">
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword4" style="margin-left:5px;">키워드4 : </label>
						    			<input class="w3-input w3-2020-sunlight" id="keyword4" name="keyword" type="text">
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword3" style="margin-left:5px;">키워드3 : </label>
						    			<input class="w3-input w3-2020-sunlight" id="keyword3" name="keyword" type="text">
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword5" style="margin-left:5px;">키워드5 : </label>
						    			<input class="w3-input w3-2020-sunlight" id="keyword5" name="keyword" type="text">
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
				        
				        <input type="hidden" name="shipment_address">
				        <input type="hidden" name="shipment_return_address">
				        <input type="hidden" name="item_keyword">
				        <input type="hidden" name="option_name">
				        <input type="hidden" name="str_option_price">
				        <input type="hidden" name="str_option_stock_quantity">
					    <div>
					    	<p style="text-align: center;">
					    		<input class="w3-btn w3-2019-brown-granite w3-padding-large" type="submit" value="상품등록">
					    	</p>
					    </div>
					</div>
	 			</div>
			</div>
 		<div class="w3-col s1"></div>
    </form>
	</div>
</div>
</body>
</html>