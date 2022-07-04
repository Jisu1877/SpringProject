<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<p style="margin-top:20px; font-size:23px;">상품 등록</p>
	</header>
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
 		<div class="w3-col s11">
 			<div class="box w3-border">
				<div class="w3-white w3-padding">
	 			<form name="basicForm" method="post" class="was-validated mt-3">
				    	<div class="form-group">
				    		<label for="user_id" style="font-size:18px;">복사 등록</label>
				      		<div class="input-group-append mb-3">
				    			<input class="w3-input" id="copy_name" name="copy_name" type="text" placeholder="복사할 상품명을 입력하세요.">
				    			<div class="input-group-append" id="copy_search">
					    			<button class="btn w3-white" onclick="()" id="copy_searchBtn">
					    				<i class="fa-solid fa-magnifying-glass"></i>
					    			</button>
				    			</div>
				    		</div>
				    	</div><br>
				    	<div class="form-group">
				    		<label for="user_id">카테고리 <span style="color:red;">🔸&nbsp;</span></label>
				    			<div class="w3-row">
					    			<div class="w3-quarter">
					    			</div>
					    			<div class="w3-quarter">
						      			<select name="categoryGroup" id="categoryGroup" class="w3-select w3-border">
											    <option value="" selected>대분류</option>
											    <c:forEach var="vo" items="${categoryVOS}">
													<option value="${vo.category_group_idx}">${vo.category_group_name}</option>
												</c:forEach>
										</select>
					    			</div>
					    			<div class="w3-quarter">
					    			</div>
					    			<div class="w3-quarter" style="padding-left: 20px;">
						      			<select name="category" id="category" class="w3-select w3-border">
											    <option value="" selected>중분류</option>
										</select>
					    			</div>
				    			</div>
				    	</div>
				    	<div class="form-group">
				    		<label for="item_name">상품명 <span style="color:red;">🔸&nbsp;</span></label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_name" name="item_name" type="text" placeholder="상품명을 입력하세요." required>
				    		</div>
						    <div id="pwdDemo"></div>
				    	</div>
				    	<div class="form-group">
				    		<label for="item_summary">상품 간단 설명 <span style="color:red;">🔸&nbsp;</span></label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_summary" name="item_summary" type="text" placeholder="상품 간단 설명을 입력하세요." required>
				    		</div>
				    	</div><hr>
				    	<div class="form-group">
					      <label for="display_flag">전시상태 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="display_flag" name="display_flag" value="y" checked>&nbsp;&nbsp;전시&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="display_flag" name="display_flag" value="n">&nbsp;&nbsp;전시중지
							</div>
						  </div>
					  	</div>
					  	<div class="w3-light-gray p-2">
						  	<div style="font-size:20px;">판매가</div><br>
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="sale_price">판매가 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" id="sale_price" name="sale_price" type="number" placeholder="숫자만 입력" required>
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
								    <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="y">&nbsp;&nbsp;설정&nbsp;&nbsp;&nbsp;
								    <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="n" checked>&nbsp;&nbsp;설정안함
								</div>
							  </div>
						  	</div>
						  	<div class="w3-row" id="seller_discount_amount">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="seller_discount_amount">할인금액 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" id="seller_discount_amount" name="seller_discount_amount" type="number" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
					        <div>
					        	<span style="font-size:20xpx; font-weight:bold;">최종 판매가</span>
					        	<span id="calPrice" style="font-size:20xpx; font-weight:bold;"></span>
					        	<span style="font-size:20xpx; font-weight:bold;">원</span>
					        </div>
					    </div><hr>
					    <div class="form-group">
					      <label for="seller_point_flag">포인트 지급 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="y" checked>&nbsp;&nbsp;지급&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="n">&nbsp;&nbsp;미지급
							</div>
						  </div>
					  	</div>
					    <div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <label for="seller_point">지급 포인트 <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" id="seller_point" name="seller_point" type="number" placeholder="숫자만 입력" required>
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
						      <label for="stock_quantity">재고수량 <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" id="stock_quantity" name="stock_quantity" type="number" placeholder="숫자만 입력" required>
					    			<div class="input-group-append">
								      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
								    </div>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third" style="padding-left: 20px;">
					        	<div class="form-group">
						      <label for="stock_schedule_date">재입고 예정일자</label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="w3-input" id="stock_schedule_date" name="stock_schedule_date" type="text" placeholder="YYYY-DD-MM" autocomplete="off">
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
						    			<input class="input w3-padding-16 w3-border form-control" id="order_min_quantity" name="order_min_quantity" type="number" placeholder="숫자만 입력" required>
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
						    			<input class="input w3-padding-16 w3-border form-control" id="order_max_quantity" name="order_max_quantity" type="number" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  <p><br></p>
				    </form>
				</div>
 			</div>
 			
 			<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
	 			<form name="optionForm" method="post">
					  	<div class="w3-light-gray p-2">
					  		<div class="form-group" style="margin-bottom: 15px;">
							  	<label for="item_option_flag" style="font-size:20px;">옵션</label>
							  	<div class="form-check-inline">
						        	<div class="form-check">
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="y">&nbsp;&nbsp;사용&nbsp;&nbsp;&nbsp;
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="n" checked>&nbsp;&nbsp;사용안함
									</div>
								  </div>
							 </div>
						  	<div class="w3-row">
						    	<div class="form-group">
							      <table class="w3-table w3-striped w3-bordered">
							      	<tr>
							      		<th><i class="fa-solid fa-square-plus" style="font-size: 20px;" title="옵션 추가하기"></i></th>
							      		<th>옵션명</th>
							      		<th>추가금액</th>
							      		<th>재고수량</th>
							      		<th></th>
							      	</tr>
							      	<tr>
							      		<td></td>
							      		<td>
							      			<input class="input w3-padding-16 w3-border form-control" id="option_price" name="seller_point" type="text" placeholder="옵션 이름">
							      		</td>
							      		<td>
							      			<input class="input w3-padding-16 w3-border form-control" id="option_price" name="seller_point" type="number" placeholder="옵션 추가금액">
							      		</td>
							      		<td>
							      			<input class="input w3-padding-16 w3-border form-control" id="option_price" name="seller_point" type="number" placeholder="재고수량">
							      		</td>
							      		<td>
							      			<i class="fa-solid fa-trash-can" style="font-size: 20px; padding-top:5px;" title="옵션지우기"></i>
							      		</td>
							      	</tr>
							      </table>
						        </div>
					        </div>
					        <div>
					        	<span style="font-size:20xpx; font-weight:bold;">총 재고수량</span>
					        	<span id="itemCnt" style="font-size:20xpx; font-weight:bold;"></span>
					        	<span style="font-size:20xpx; font-weight:bold;">개</span>
					        </div>
					    </div><hr>
			     </form>
			     <form name="imageForm" method="post" enctype="multipart/form-data">
				  		<div class="form-group" style="margin-bottom: 15px;">
						  	<label for="item_option_flag" style="font-size:20px;">상품 이미지 <span style="color:red;">🔸&nbsp;</span></label>
						 </div>
					  	<div class="w3-row">
					    	<div class="w3-third">
					    		<div style="margin-bottom:10px;">대표 이미지 <span style="color:red;">🔸&nbsp;</span></div>
					    		<button onclick="javascript:$('#myphoto').click();" style="background-color: white">
						    		<div id="addImageBtn">
						    			<div><img src="${ctp}/images/plusImage.png" width="300px;"></div>
						    		</div>
						    		<div id='previewId'></div>
					    		</button>
				    			<input type="button" id="photoDelete" value="삭제" class="w3-btn w3-2020-orange-peel w3-padding-small w3-small" style="display:none; margin-top:5px; margin-left:6px;" onclick="previewDelete()"/>
				    			<input type="file" name="myphoto" id="myphoto" onchange="previewImage(this,'previewId')" class="form-control input" accept=".png, .jpg, .jpeg, .jfif, .gif" hidden="true">
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><br>
				        <div class="w3-row">
				        	<div class="w3-half">
			        			<label for="seller_point_flag" style="margin-left:5px; margin-right: 10px;">추가 이미지</label>
						        <input type="button" value="이미지 추가" onclick="fileBoxAppend()" class="btn w3-lime btn-sm mb-2"/>
				        		<span style="color:red;">🔸&nbsp;</span> 추가 이미지 최소 1장 등록 필수
				        		<div class="mb-3">
					    			<div id="fBox1">
					    				- image
										<input type="file" name="file1" id="file1" class="w3-input" accept=".png, .jpg, .jpeg, .jfif, .gif"/>
								    </div>
				    		 	 </div>
								<div id="fileBoxInsert"></div>
				        	</div>
				        	<div class="w3-half"></div>
			        	</div>
					    <hr>
					</form>
					<form name="contentForm" method="post" class="was-validated" enctype="multipart/form-data">
					    <div class="form-group">
					      <label for="detail_content_falg" style="font-size:20px;">상품상세설명 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="detail_content_falg" name="seller_point_flag" value="1" checked>&nbsp;&nbsp;이미지 등록&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="detail_content_falg" name="seller_point_flag" value="0">&nbsp;&nbsp;직접입력
							</div>
						  </div>
					  	</div>
					    <div>
				  			<div class="detail_content_image">
				    			<span>- 상품상세설명 이미지 등록<span style="color:red;">🔸&nbsp;</span></span>
								<input type="file" name="detail_content_image" id="detail_content_image" class="w3-input" accept=".png, .jpg, .jpeg, .jfif, .pdf"/>
							</div>
							<div class="detail_content mt-5">
								<div style="margin-bottom: 10px;">- 상품상세설명 직접입력 <span style="color:red;">🔸&nbsp;</span></div>
								<textarea rows="10" name="content" id="CKEDITOR" class="form-control" required></textarea>
							</div>
							<script>
					      	  CKEDITOR.replace("content",{
					      		  height:500,
					      		  filebrowserUploadUrl : "${ctp}/imageUpload",
					      		  uploadUrl : "${ctp}/imageUpload"
					      	  });
					       </script>
				        </div>
			        </div>
		    	</form>
			</div>
			
			<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
	 			<form name="inforForm" method="post" class="was-validated mt-3">
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
						    			<label for="origin_country" style="margin-left:5px;">원산지 : </label>
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
						    			<label for="item_model_name" style="margin-left:5px;">모델명 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="item_model_name" name="item_model_name" type="text" required>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="after_service" style="margin-left:5px;">A/S안내 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="after_service" name="after_service" type="text" required>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
				    </form>
				    <form name="noticeForm" method="post" class="was-validated mt-3">
										    
				    </form>
				</div>
 			</div>
			
		</div>
 		<div class="w3-col s1"></div>
 	</div>
</div>
</body>
</html>