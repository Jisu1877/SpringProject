'use strict';
let categoryFlag = 0;
let seller_discount_flag = 0;
let seller_point_flag = 0;

function itemInsert() {
	let categoryGroup = basicForm.categoryGroup.value;
	let category = basicForm.category.value;
	let item_name = basicForm.item_name.value;
	let item_summary = basicForm.item_summary.value;
	let sale_price = basicForm.sale_price.value;
	let seller_discount_amount = basicForm.seller_discount_amount.value;
	let seller_point = basicForm.seller_point.value;
	let stock_quantity = basicForm.stock_quantity.value;
	let order_min_quantity = basicForm.order_min_quantity.value;
	let order_max_quantity = basicForm.order_max_quantity.value;
	
	if(categoryGroup == "") {
		alert("대분류를 선택하세요.");
		return false;
	}
	else if(categoryFlag == 1 && category == "") {
		alert("중분류를 선택하세요.");
		return false;
	}
	else if(item_name == "") {
		alert("상품명을 입력하세요.");
		basicForm.item_name.focus();
		return false;
	}
	else if(item_name.length > 100) {
		alert("상품명은 100자 이내로 입력하세요.");
		basicForm.item_name.focus();
		return false;
	}
	else if(item_summary == "") {
		alert("상품 간단설명을 입력하세요.");
		basicForm.item_summary.focus();
		return false;
	}
	else if(item_summary.length > 200) {
		alert("상품 간단설명은 200자 이내로 입력하세요.");
		basicForm.item_summary.focus();
		return false;
	}
	else if(sale_price == "") {
		alert("판매가를 입력하세요.");
		basicForm.sale_price.focus();
		return false;
	}
	else if(seller_discount_amount == "" && seller_discount_flag == 1) {
		alert("할인금액을 입력하세요.");
		basicForm.seller_discount_amount.focus();
		return false;
	}
	else if(seller_point == "" && seller_point_flag == 1) {
		alert("지급 포인트를 입력하세요.");
		basicForm.seller_point.focus();
		return false;
	}
	else if(stock_quantity == "") {
		alert("재고 수량을 입력하세요.");
		basicForm.stock_quantity.focus();
		return false;
	}
	else if(order_min_quantity > order_max_quantity) {
		alert("최대 주문 수량을 최소 주문 수량보다 적을 수 없습니다.");
		basicForm.order_max_quantity.focus();
		return false;
	}
	
}

//할인여부 설정
$(document).ready(function(){
	$("input[name='seller_discount_flag']").change(function(){
		let seller_flag = $("input[name='seller_discount_flag']:checked").val();
		if(seller_flag == 'y') {
			document.getElementById("seller_discount_flagForm").style.display = "block";
			seller_discount_flag = 1;
		}
		else {
			document.getElementById("seller_discount_flagForm").style.display = "none";
			seller_discount_flag = 0;
		}
	});

});

//포인트지급여부 설정
$(document).ready(function(){
	$("input[name='seller_point_flag']").change(function(){
		let seller_point_flag_value = $("input[name='seller_point_flag']:checked").val();
		if(seller_point_flag_value == 'y') {
			document.getElementById("seller_pointForm").style.display = "block";
			seller_point_flag = 1;
		}
		else {
			document.getElementById("seller_pointForm").style.display = "none";
			seller_point_flag = 0;
		}
	});

});

function calPrice() {
	let sale_price = basicForm.sale_price.value;
	let discount_price = basicForm.seller_discount_amount.value;
	
	if(sale_price <= discount_price) {
		alert("할인금액은 판매가보다 적은 금액을 입력해야합니다.");
		basicForm.seller_discount_amount.value = "";
		basicForm.seller_discount_amount.focus();
		return false;
	}
	else if(discount_price < 1) {
		alert("할인금액은 최소 1원 이상이어야 합니다.");
		basicForm.seller_discount_amount.value = "";
		basicForm.seller_discount_amount.focus();
		return false;
	}
	
	let calPrice = sale_price - discount_price;
	
	$("#calPrice").html(calPrice);
}

function stock_quantityForm() {
	let stock_quantity = basicForm.stock_quantity.value;
	
	if(stock_quantity < 0 && stock_quantity != "") {
		alert("재고 수량은 음수값을 입력할 수 없습니다.");
		basicForm.stock_quantity.value = "";
		basicForm.stock_quantity.focus();
		return false;
	}
	
	if(stock_quantity == 0 && stock_quantity != "") { 
		document.getElementById("schedule_date").style.display = "block";
	}
	else {
		document.getElementById("schedule_date").style.display = "none";
	}
}

function minValueCheck1() {
	let sale_price = basicForm.sale_price.value;
	
	if(sale_price <= 0) {
		alert("판매가를 0원 이상 입력하세요.");
		basicForm.sale_price.value = "";
		basicForm.sale_price.focus();
		return false;
	}
	
}

function minValueCheck2() {
	let seller_point = basicForm.seller_point.value;
	
	if(seller_point <= 0) {
		alert("지급 포인트를 0원 이상 입력하세요.");
		basicForm.seller_point.value = "";
		basicForm.seller_point.focus();
		return false;
	}
}

function minValueCheck3() {
	let order_min_quantity = basicForm.order_min_quantity.value;
	
	if(order_min_quantity < 1 && order_min_quantity != "") {
		alert("최소 구매 수량은 1개 이상이어야 합니다.");
		basicForm.order_min_quantity.value = "";
		basicForm.order_min_quantity.focus();
		return false;
	}
}

function minValueCheck4() {
	let order_max_quantity = basicForm.order_max_quantity.value;
	
	if(order_max_quantity < 1 && order_max_quantity != "") {
		alert("최대 구매 수량은 1개 이상이어야 합니다.");
		basicForm.order_max_quantity.value = "";
		basicForm.order_max_quantity.focus();
		return false;
	}
}


$(function(){
	$("#categoryGroup").change(function(){
		let categoryGroup = $(this).val();
		if(categoryGroup == "") {
			alert("대분류를 선택하세요.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "getCategory",
			data : {category_group_idx : categoryGroup},
			success : function(vos) {
				let cnt = 0;
				let str = '';
				str += '<option value="">중분류</option>';
				for(let i=0; i<vos.length; i++) {
					if(vos[i].category_name == null) break;
					cnt++;
					str += '<option value="'+vos[i].category_idx+'">'+vos[i].category_name+'</option>'
				}
				if(cnt > 0) {
					categoryFlag = 1;
				}
				else {
					categoryFlag = 0;
				}
				$("#category").html(str);
			},
			error : function() {
				
			}
		});
	});
});

 $.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    showMonthAfterYear: true,
    yearSuffix: '년'
    
});


$(function() {
	let today = new Date();
	$("#stock_schedule_date").datepicker();
	$('#stock_schedule_date').datepicker("option", "minDate", today);
}); 



// 대표이미지 미리보기
function previewImage(targetObj, previewId) { 
	let fName = imageForm.myphoto.value;
	let ext = fName.substring(fName.lastIndexOf(".")+1); //파일 확장자 발췌
	let uExt = ext.toUpperCase(); //확장자를 대문자로 변환
	let maxSize = 1024 * 1024 * 10 //업로드할 회원사진의 용량은 10MByte까지로 제한한다.
	
	let fileSize = document.getElementById("myphoto").files[0].size;  //첫번째 파일의 사이즈..! 아이디를 예약어인 file 로 주기.

	if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
		alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF'파일입니다.") 					
		return false;
	}
	else if(fName.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
		alert("업로드 파일명에 공백을 포함할 수 없습니다.");
		return false;
	}
	else if(fileSize > maxSize) {
		alert("업로드 파일의 크기는 10MByte를 초과할 수 없습니다.");
		return false;
	}
	
	document.getElementById("addImageBtn").style.display = "none";
	document.getElementById("photoDelete").style.display = "block";
	document.getElementById("previewId").style.display = "block";
	
	var preview = document.getElementById(previewId);  
	var ua = window.navigator.userAgent; 
	if (ua.indexOf("MSIE") > -1) { 
		targetObj.select(); 
		try { 
			var src = document.selection.createRange().text; 
			var ie_preview_error = document .getElementById("ie_preview_error_" + previewId); 
			
			if (ie_preview_error) { 
				preview.removeChild(ie_preview_error); 
				
			} 
			
			var img = document.getElementById(previewId); //이미지가 뿌려질 곳 
			
			img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='scale')"; 
			
		} catch (e) { 
			if (!document.getElementById("ie_preview_error_" + previewId)) { 
				var info = document.createElement("<p>"); 
				info.id = "ie_preview_error_" + previewId; info.innerHTML = "a"; 
				preview.insertBefore(info, null);
				
			} 
			
		} 
	
	} else {  
		var files = targetObj.files; 
		for ( var i = 0; i < files.length; i++) {
			var file = files[i];
			var imageType = /image.*/;   //이미지 파일일경우만.. 뿌려준다.
			if (!file.type.match(imageType)) 
				continue; 
			
			var prevImg = document.getElementById("prev_" + previewId);  //이전에 미리보기가 있다면 삭제
			if (prevImg) { 
				preview.removeChild(prevImg); 
				
			} 
			var img = document.createElement("img");  
			img.id = "prev_" + previewId; 
			img.classList.add("obj"); 
			img.file = file; 
			img.style.width = '300px';
			img.style.height = '300px'; 
			
			preview.appendChild(img); 
			
			if (window.FileReader) { // FireFox, Chrome, Opera 확인. 
				
				var reader = new FileReader(); 
				reader.onloadend = (function(aImg) { 
					return function(e) {
						aImg.src = e.target.result;
						
					}; 
					
				})(img); 
				reader.readAsDataURL(file);
				
			} else { // safari is not supported FileReader 
				//alert('not supported FileReader'); 
			if (!document.getElementById("sfr_preview_error_" + previewId)) {
				var info = document.createElement("p");
				info.id = "sfr_preview_error_" + previewId;
				info.innerHTML = "not supported FileReader";
				preview.insertBefore(info, null);
				
				}
				
			}
				
		}
			
	}
		
}

// 프로필 사진 삭제
function previewDelete() {
	document.getElementById("addImageBtn").style.display = "block";
	document.getElementById("previewId").style.display = "none";
	document.getElementById("photoDelete").style.display = "none";
}


let cnt = 1;
function fileBoxAppend() {
	cnt++;
	
	if(cnt == 10) {
		alert("추가 이미지는 최대 9장까지 등록가능합니다.");
		return false;
	}
	
	let fileBox = "";
	fileBox += '<div id="fBox'+cnt+'" class="mb-3">';
	fileBox += '- image ';
	fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="w3-btn w3-2020-orange-peel w3-padding-small w3-small ml-2"/>';
	fileBox += '<input type="file" name="file'+cnt+'" id="file'+cnt+'" class="w3-input"/>';
	fileBox += '<div>';
	$("#fileBoxInsert").append(fileBox);
}


function deleteBox(cnt) {
	$("#fBox"+cnt).remove();
}


