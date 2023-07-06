/**
 * 
 */
//리스트 삭제하기
function deleteBtn(element){
	var temp = $("#DoItContainer");
	temp = temp.children();
	temp = temp.children().eq(element);
	var result = confirm("하위 항목이 모두 사라집니다. 정말로 삭제하시겠습니까?");
	if(result){
		temp.remove();
	}else{
		return false;
	}	
}
function deleteBtn2(element){
	var temp = $("#DoItListChild");
	temp = temp.children().eq(element);
	var result = confirm("정말로 삭제하시겠습니까?");
	if(result){
		temp.remove();
	}else{
		return false;
	}	
}
//간트차트 수정화면 자식리스트 열기
function openDoItList(element){
	var var1 = "#DoItCheck" + element;
	var var2 = "#DoItListChild" + element;
	var checkbox = $(var1);
	var childUl = $(var2);
	
	if($(checkbox).attr("alt") == "0"){
		childUl.show();
		$(checkbox).attr("alt" , "1");
	}else{
		childUl.hide();
		$(checkbox).attr("alt",  "0");
	}
}
//디데이 달력, 시간 표시하기
function changeDate(){
	var result = $("#finalDate").val();
	$("#DdayEditDate").text("날짜 : " + result);
}
function changeTime1(){
	var result = $("#finalStartTime").val();
	$("#DdayEditTime1").text("시작 시각 : " + result);
}
function changeTime2(){
	var result = $("#finalEndTime").val();
	$("#DdayEditTime2").text("종료 시각 : " + result);
}
//일정표 기간 표시하기
function getDayOfWeek(string){
	var day = new Date(string[0], string[1], string[2]);
    const week = ['일', '월', '화', '수', '목', '금', '토'];

    const dayOfWeek = week[day.getDay()];

    return dayOfWeek;

}
function changeWeek(){
	var result1 = $("#firstDate").val();
	var result2 = $("#EndDate").val();
	
	if (result1 == "" || result2 == ""){
		alert("올바른 기간을 입력해주세요.");
		return false;
	}
	
	var results1 = result1.split("-")
	var results2 = result2.split("-")
	var temp1 = results1[0]+results1[1]+results1[2];
	var temp2 = results2[0]+results2[1]+results2[2];
	temp1 *= 1;
	temp2 *= 1;
	
	if (temp1 > temp2){
		alert("올바른 기간을 입력해주세요.");
		return false;
	}else{
		$("#updateDateView .first").text(results1[0]+"/"+results1[1]+"/"+results1[2]+ " ("+getDayOfWeek(results1)+")");
		$("#updateDateView .second").text(results2[0]+"/"+results2[1]+"/"+results2[2]+ " ("+getDayOfWeek(results2)+")");	
		WpopClose();
	}
}

// table 컬러 바꾸기
function tbColorChange(element){
	if( $(element).attr("alt") != "1"){
	$(element).css({
		"background" : "rgba(242, 82, 135, 1)"
	});
	$(element).attr("alt", "1");
	}
	else if ($(element).attr("alt") == "1"){
		$(element).css({
		"background" : "rgba(0,0,0,0)"
	});
	$(element).attr("alt", "0");
	}
}

//유저 팝업을 열기
function popOpen(element){
	var modalPop = $('.user_modal');
	var modalBg = $('.user_modal_bg');
	$(".modalUserName").text(element);
	$(modalPop).show();
	$(modalBg).show();
}
//유저 팝업 닫기
function popClose(){
	var modalPop = $('.user_modal');
	var modalBg = $('.user_modal_bg');
	$(modalPop).hide();
	$(modalBg).hide();
}
//주 팝업을 열기
function WpopOpen(){
	var modalPop = $('.week_modal');
	var modalBg = $('.week_modal_bg');
	$(modalPop).show();
	$(modalBg).show();
}
//주 팝업 닫기
function WpopClose(){
	var modalPop = $('.week_modal');
	var modalBg = $('.week_modal_bg');
	$(modalPop).hide();
	$(modalBg).hide();
}
//할일 팝업을 열기
function DpopOpen(element, childs){
	var list = $("#DoItListChild");
	var child = [];
	child = childs.split(",");
	child[0] = child[0].replace("[", "");
	child[child.length-1] = child[child.length-1].replace("]", "");
	
	var modalPop = $('.DoIt_modal');
	var modalBg = $('.DoIt_modal_bg');
	
	$(".modalDoItName").text(element);
	
		
	for (var i = 0; i < child.length; i++){
		list.append('<li><div class = "DoItListItem" style = "width : 98%; " >&nbsp;'+child[i]+'</div></li>');
		$("#DoItListChild").children().eq(i).children().append('<button type = "button" class = "deleteBtn" onclick="deleteBtn2('+i+')">✕</button>');
	}
	$(modalPop).show();
	$(modalBg).show();
}
//할일 팝업 닫기
function DpopClose(){
	var list = $("#DoItListChild *");
	var modalPop = $('.DoIt_modal');
	var modalBg = $('.DoIt_modal_bg');
	$(modalPop).hide();
	$(modalBg).hide();	
	list.remove();
}

//로딩창 종료하기
function loadingClose(){
	var loadPage = $(".loader");
	$(loadPage).hide();
}


$(document).ready(function () {
	//버튼 조작
	let dateP = $("#meeting_date");
	let locateP = $("#meeting_location");
	let ganttP = $("#gantt_chart");
	let detailP = $("#group_detail");

	let dateB = $("#meeting_date_btn");
	let locateB = $("#meeting_location_btn");
	let ganttB = $("#gantt_chart_btn");
	let detailB = $("#group_detail_btn");
	
	dateB.css({
				"background-color" : "#f25287", "color" : "white",
				"border" :	"3px solid #b40347", "filter" : "drop-shadow(6px 5px 5px white)"
			});	
	
	dateB.click( function(){
			dateP.show();
			locateP.hide();
			ganttP.hide();
			detailP.hide();
			$(".btns2").css({
				"background-color" : "white", "color" : "black",
				"border" :	"3px solid #f25287", "filter" : "None"
			});
			dateB.css({
				"background-color" : "#f25287", "color" : "white",
				"border" :	"3px solid #b40347", "filter" : "drop-shadow(6px 5px 5px white)"
			});			
	});
	locateB.click( function(){
			dateP.hide();
			locateP.show();
			ganttP.hide();
			detailP.hide();
			$(".btns2").css({
				"background-color" : "white", "color" : "black",
				"border" :	"3px solid #f25287", "filter" : "None"
			});
			locateB.css({
				"background-color" : "#f25287", "color" : "white",
				"border" :	"3px solid #b40347", "filter" : "drop-shadow(6px 5px 5px white)"
			});		
	});
	ganttB.click( function(){
			dateP.hide();
			locateP.hide();
			ganttP.show();
			detailP.hide();
			$(".btns2").css({
				"background-color" : "white", "color" : "black",
				"border" :	"3px solid #f25287", "filter" : "None"
			});
			ganttB.css({
				"background-color" : "#f25287", "color" : "white",
				"border" :	"3px solid #b40347", "filter" : "drop-shadow(6px 5px 5px white)"
			});		
	});
	detailB.click( function(){
			dateP.hide();
			locateP.hide();
			ganttP.hide();
			detailP.show();
			$(".btns2").css({
				"background-color" : "white", "color" : "black",
				"border" :	"3px solid #f25287", "filter" : "None"
			});
			detailB.css({
				"background-color" : "#f25287", "color" : "white",
				"border" :	"3px solid #b40347", "filter" : "drop-shadow(6px 5px 5px white)"
			});		
	});

/* 미팅 일정 */
$("#ScheduleSaveBtn").click(function(){
	$("#total_table").show();
	$("#chart_area").css({
		"border" : "None"
	});
	$("#timeTable").hide();
})
$("#ScheduleEditBtn").click(function(){
	$("#total_table").hide();
	$("#chart_area").css({
		"border" : "5px solid #F25287"
	});
	$("#timeTable").show();
})
$(".editDate").click(function(){
	$("#Dday_edit").show();
	$("#DdayInit").hide();
	$("#Dday").hide();
})
$("#endEditDate").click(function(){
	$("#Dday_edit").hide();
	$("#DdayInit").hide();
	$("#Dday").show();
})
$("#Dday_frm .submitBtn").click(function(){
	$("#Dday_edit").hide();
	$("#Dday").show();
})

});