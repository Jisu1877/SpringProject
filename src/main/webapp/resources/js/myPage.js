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
			  yearSuffix: '년',
			  //beforeShowDay: disableSelectedDates
        });
       /*let today = new Date();
       today.setDate(today.getDate() + 1);*/
       
       //$('#start').datepicker("option", "minDate", today);
       $('#start').datepicker("option", "maxDate", $("#end").val());
       $('#start').datepicker("option", "onClose", function (selectedDate){
           $("#end").datepicker( "option", "minDate", selectedDate );
           });
       
       $('#end').datepicker();
       $('#end').datepicker("option", "minDate", $("#start").val());
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