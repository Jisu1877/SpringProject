$(document).ready(function(){       
   $( "#start,#end" ).datepicker({
	      dateFormat: 'yy-mm-dd',
		  prevText: '이전 달',
		  nextText: '다음 달',
		  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  showMonthAfterYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜로 이동',
		  yearSuffix: '년',
		  closeText: '닫기',
		  showAnim: 'slideDown'
		  //beforeShowDay: disableSelectedDates
    });
   let today = new Date();
   today.setDate(today.getDate());
   
   //$('#start').datepicker("option", "minDate", today);
   $('#start').datepicker("option", "onClose", function (selectedDate){
	   $("#end").datepicker( "option", "minDate", selectedDate );
	   });
   
   $('#end').datepicker();
   $('#end').datepicker("option", "minDate", $("#start").val());
   $('#end').datepicker("option", "maxDate", today);
   $('#end').datepicker("option", "onClose", function (selectedDate){
       $("#start").datepicker( "option", "maxDate", selectedDate );
      });
});
		
function searchCheck() {
	let start = document.getElementById("start").value;
	let end = document.getElementById("end").value;
	
	let regDate = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
	
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
}


function userImageChange() {
	
	let user_image = document.getElementById("user_image").value;
	
	let maxSize = 1024 * 1024 * 20;
	let fileSize = 0;
	
	if (user_image.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
		alert("업로드 파일명에 공백을 포함할 수 없습니다.");
		return false;
	}
	else if (user_image != "") {
		let ext = user_image.substring(user_image.lastIndexOf(".") + 1);
		let uExt = ext.toUpperCase();
		fileSize += document.getElementById("user_image").files[0].size; //파일 선택이 1개밖에 안되기 때문에 0번 배열에만 파일이 있는 상태이다.

		if (uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
			alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
			return false;
		}
	}

	if (fileSize > maxSize) {
		alert("업로드할 파일의 총 최대 용량은 20MByte 입니다.");
		return false;
	}
	
	$("#myPhoto").val(user_image);
	
	userImageForm.submit();
}


function searchCheck() {
	let start = $("#start").val();
	let end = $("#end").val();
	
	if(start == "" || end == "") {
		alert("조회 날짜를 선택하세요.");
		return false;
	}
	orderSearchForm.submit();
}