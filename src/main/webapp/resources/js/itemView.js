let totalAmount = 0;
let totalPrice = 0;
let sale_price = '';
let seller_discount_flag = '';
let seller_discount_amount = 0;
let sw = 0;
let optionIdxArr = [];
let order_quantity = [];

$(function() {
	sale_price = $("#sale_price").val();
	seller_discount_flag = $("#seller_discount_flag").val();
	seller_discount_amount = $("#seller_discount_amount").val();
	totalAmount = $("#order_min_quantity").val();
	setTotalPrice();
	
});

function setTotalPrice() {
	if(seller_discount_flag == 'y') {
		totalPrice = (Number(sale_price) - Number(seller_discount_amount)) * totalAmount;
		realPrice = Number(sale_price) - Number(seller_discount_amount);
	}
	else {
		totalPrice = Number(sale_price) * totalAmount;
	}
}

function optionSelect(ths) {
	const idx = $(ths).val();
	const option = $(ths).find('option:selected').data('label');
	const price = $(ths).find('option:selected').data('price');
	const price2 = Math.floor(price).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	let order_min_quantity = $("#order_min_quantity").val();
	let stock_quantity = $("#stock_quantity").val();
	
	if(option == "") {
		return false;
	}
	else if($("#option_"+idx).length > 0){
		alert("이미 선택한 옵션입니다.");
		$("#optionSelect").val("").prop("selected", true);
		totalAmount--;
		return false;
	}
/*	else if(stock_quantity < totalAmount) {
		alert("현재 남은 재고 수량은 "+stock_quantity+"개 입니다.");
		$("#optionSelect").val("").prop("selected", true);
		totalAmount--;
		return false;
	}*/
	
	let optionDiv = $("#option_tmp_div").clone();
	
	optionDiv.attr("style", "display:block;");
	optionDiv.attr("id", "option_"+idx);
	optionDiv.find(".option").html(option);
	optionDiv.find(".option_cnt").html(order_min_quantity);
	optionDiv.find(".option_cnt").attr("data-idx", idx);
	optionDiv.find(".option_cnt").attr("id", "option_cnt_"+idx);
	optionDiv.find(".option_price").html("+&nbsp;" + price2 + "원");
	optionDiv.find(".option_price").attr("data-price", price);
	
	$("#optonDemo").append(optionDiv);
	let optionLength = $(".option_div").length;
	/*if(optionLength > (Number(order_max_quantity) + 1)) {
		$("#optionSelect").val("").prop("selected", true);
		alert("최대 구매 수량은 " +order_max_quantity+ "개 입니다. 선택한 옵션을 삭제하고 추가하세요.");
		$( 'div' ).remove( '#option_'+idx);
	}*/
	
	$("#optionSelect").val("").prop("selected", true);
	
	totalPrice += price;
	
	if($(".option_div").length > 2) {
 		if(seller_discount_flag == 'y') {
	 		totalPrice += realPrice;
 		}
 		else {
 			totalPrice += Number(sale_price);
 		}
	}
	
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	$("#totalInfor").attr("style", "margin:30px; display:block; font-size:22px;");
	
	//옵션 idx, name, 가격, 수량 담기
	for(let i = 0; i < ($(".option_div").length)-1; i++) {
		if(optionIdxArr[i] == null) {
			optionIdxArr[i] = idx;
			order_quantity[i] = order_min_quantity;
		}
	}
}

function minus(ths) {
	const id = $(ths).parents("div.option_div").attr("id");
	let amount = $(ths).siblings("span.option_cnt").html();
	let order_min_quantity = $("#order_min_quantity").val();		
	amount--;
	
	if(order_min_quantity > amount) {
		$("#optionSelect").val("").prop("selected", true);
		alert("최소 구매 가능 수량은 " +order_min_quantity+ "개 입니다.");
		return false;
	}
	totalAmount--;
	
	let price = $("#"+id).find(".option_price").data('price');
	let price2 = price * Number(amount);
	let price3 = Math.floor(price2).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#"+id).find(".option_price").html("+&nbsp;" +price3 + "원");
	$(ths).siblings("span.option_cnt").html(amount);
	totalPrice -= price;
	if(seller_discount_flag == 'y') {
 		totalPrice -= realPrice;
	}
	else {
		totalPrice -= Number(sale_price);
	}
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	
	
	let idx = $("#"+id).find(".option_cnt").data('idx');
	//옵션 수량 수정
	for(let i = 0; i < ($(".option_div").length)-1; i++) {
		if(optionIdxArr[i] == idx) {
			order_quantity[i] = Number(order_quantity[i]) - 1;
		}
	}
}

function plus(ths) {
	const id = $(ths).parents("div.option_div").attr("id");
	let amount = $(ths).siblings("span.option_cnt").html();
	const price = ($("#"+id).find(".option_price").data('price')) * (Number(amount) + 1);
	let stock_quantity = $("#stock_quantity").val();
	const price2 = Math.floor(price).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	amount++;
	totalAmount++;
	
/*	if(stock_quantity < totalAmount) {
		alert("현재 남은 재고 수량은 "+stock_quantity+"개 입니다.");
		$("#optionSelect").val("").prop("selected", true);
		totalAmount--;
		return false;
	}*/
	
	$(ths).siblings("span.option_cnt").html(amount);
	
	totalPrice += $("#"+id).find(".option_price").data('price');
	if(seller_discount_flag == 'y') {
 		totalPrice += realPrice;
	}
	else {
		totalPrice += Number(sale_price);
	}
	$("#"+id).find(".option_price").html("+&nbsp;" +price2 + "원");
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	
	let idx = $("#"+id).find(".option_cnt").data('idx');
	//옵션 수량 수정
	for(let i = 0; i < ($(".option_div").length)-1; i++) {
		if(optionIdxArr[i] == idx) {
			order_quantity[i] = Number(order_quantity[i]) + 1;
		}
	}
	
}

function deleteOption(ths) {
	let amount = $(ths).parents().find(".option_cnt").html();
	amount = Number(amount);
	totalAmount -= amount;
	const id = $(ths).parents("div.option_div").attr("id");
	let price = $("#"+id).find(".option_price").data('price');
	let price2 = Number(price) * Number(amount);
	
	let idx = $("#"+id).find(".option_cnt").data('idx');
	//옵션 idx, name, 가격, 수량 삭제
	for(let i = 0; i < ($(".option_div").length)-1; i++) {
		if(optionIdxArr[i] == idx) {
			delete optionIdxArr[i];
			delete order_quantity[i];
		}
	}
	
	$( 'div' ).remove('#'+id);
	
	totalPrice -= price2;
	
	if(seller_discount_flag == 'y') {
 		totalPrice -= realPrice;
	}
	else {
		totalPrice -= Number(sale_price);
	}
	
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	if($(".option_div").length < 2) {
		setTotalPrice();
	}
	
}

function minus2(ths) {
	let amount = $(ths).siblings("span.option_cnt").html();
	let order_min_quantity = $("#order_min_quantity").val();		
	amount--;
	
	if(order_min_quantity > amount) {
		$("#optionSelect").val("").prop("selected", true);
		alert("최소 구매 가능 수량은 " +order_min_quantity+ "개 입니다.");
		return false;
	}
	totalAmount--;
	
	$(ths).siblings("span.option_cnt").html(amount);
	
	if(seller_discount_flag == 'y') {
 		totalPrice -= realPrice;
	}
	else {
		totalPrice -= Number(sale_price);
	}
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
}

function plus2(ths) {
	if(sw == 0) {
		totalAmount = 1;
		sw = 1;
	}
	let amount = $(ths).siblings("span.option_cnt").html();
	let stock_quantity = $("#stock_quantity").val();
	amount++;
	totalAmount++;
	
	$(ths).siblings("span.option_cnt").html(amount);
	
	if(seller_discount_flag == 'y') {
 		totalPrice += realPrice;
	}
	else {
		totalPrice += Number(sale_price);
	}
	
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
}

/* 구매하기 */
function buyItem() {
	let item_option_flag = $("#item_option_flag").val();
	//상품을 선택했는지 확인
	if(totalAmount == 0 && item_option_flag == 'y') {
		alert("옵션을 선택하세요.");
		return false;
	}
	
	//로그인 상태인지 확인
	$.ajax({
		type : "post",
		url : "loginCheck",
		success : function(data) {
			if(data == '0') {
				alert("로그인이 필요한 서비스입니다.");
				let url = "/javagreenS_ljs/user/userLoginOther";
	      		let winX = 1300;
	            let winY = 700;
	            let x = (window.screen.width/2) - (winX/2);
	            let y = (window.screen.height/2) - (winY/2)
	   			window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	   			setInterval(function(){
					$("#navBar").load(location.href+" #navBar>*","");
				}, 2000);
			}
		},
		error : function() {
			alert("전송오류.");
		}
	});
	
	//주문/결제 창으로 넘어가기 준비
	
}

/* 장바구니 담기 */
function inputCart() {
	/*
		필요한 자료 리스트
		1. 회원 고유번호(session에서 받아오기)
		2. 상품 고유번호
		3. 회원 아이디(session에서 받아오기)
		4. 옵션 고유번호(배열)
		7. 주문 수량
		8. 옵션 사용여부
	*/
	let item_option_flag = $("#item_option_flag").val();
	//상품을 선택했는지 확인
	if(totalAmount == 0 && item_option_flag == 'y') {
		alert("옵션을 선택하세요.");
		return false;
	}
	
	//로그인 상태인지 확인
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/user/loginCheck",
		async: false,
		success : function(data) {
			if(data == '0') {
				alert("로그인이 필요한 서비스입니다.");
				let url = "/javagreenS_ljs/user/userLoginOther";
	      		let winX = 1300;
	            let winY = 700;
	            let x = (window.screen.width/2) - (winX/2);
	            let y = (window.screen.height/2) - (winY/2)
	   			window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	   			setInterval(function(){
					$("#navBar").load(location.href+" #navBar>*","");
				}, 2000);
			}
		},
		error : function() {
			alert("전송오류.");
		}
	});
	
	let item_idx = $("#item_idx").val();
	if(totalAmount == 0) {
		totalAmount = 1;
	}
	
	let data = {
		item_idx : item_idx,
		item_option_flag : item_option_flag,
		optionIdxArr : optionIdxArr,
		option_quantity : order_quantity,
		quantity : totalAmount,
		total_price : totalPrice
	}
	
	$.ajax({
		type : "post",
		traditional: true,
		url : "/javagreenS_ljs/cart/inputCart",
		data : data,
		success : function(res) {
			if(res == '1') {
				let an = confirm("장바구니에 상품을 담았습니다. \n장바구니로 이동하시겠습니까?");
				if(an) {
					location.href="/javagreenS_ljs/cart/cartList";
				}
				else {
					location.reload();
				}
			}
		},
		error : function() {
			
		}
	});
	
}
