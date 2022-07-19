$(function() {
	init();
});

function init() {
	setRowspan();
	setRowspan2();
	setRowspan3();
}

function setRowspan() {
	let temp_idx = 0;
	
	$("tbody tr").each(function() {
		const idx = $(this).data('idx');
		const list = $('.idx_' + idx);
		const length = list.length;
		
		if (temp_idx == idx) {
			return true; // continue;
		}
		
		list.attr('rowspan', length);
		list.not(':first').remove();
		temp_idx = idx;
	});
}

function setRowspan2() {
	let temp_idx = 0;
	
	$("tbody tr").each(function() {
		const idx = $(this).data('idx');
		const list = $('.id_' + idx);
		const length = list.length;
		
		if (temp_idx == idx) {
			return true; // continue;
		}
		
		list.attr('rowspan', length);
		list.not(':first').remove();
		temp_idx = idx;
	});
}

function setRowspan3() {
	let temp_idx = 0;
	
	$("tbody tr").each(function() {
		const idx = $(this).data('idx');
		const list = $('.infor_' + idx);
		const length = list.length;
		
		if (temp_idx == idx) {
			return true; // continue;
		}
		
		list.attr('rowspan', length);
		list.not(':first').remove();
		temp_idx = idx;
	});
}

/* 상세조회 */
function orderListInfor(idx) {
	let url = "/javagreenS_ljs/admin/order/orderInfor?idx="+idx;
	let winX = 700;
    let winY = 700;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}

/* 주문상태 변경처리 */
function orderCodeChange1(idx) {
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/admin/order/orderCodeChange",
		data : {idx : idx,
				code : 2},
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