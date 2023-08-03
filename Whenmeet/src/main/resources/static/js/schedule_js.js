/**
 * 
 */
//방장의 관리
function IamHost(groupId){
	$("#SubHostForm").show();
	$("#Dday_area .editDate").show();
	$("#delete_btn").text("그룹 관리");
	$("#delete_btn").hover(	function(){
		$(this).css({"background-color": "white", "color" : "black",  "border": "3px solid #f25287"});
	}, function(){
		$(this).css({"background-color": "#f25287", "color" : "white"});
	})
	$("#delete_btn").on("click", function(){
		location.replace("/group/change/" + groupId);
	})
	$("#ganttInitBtn").show();
	$("#ganttResultEditBtn").show();
	$("#ganttCreateBtn").show();
	$("#ganttCreate").children().eq(1).hide();
	
	//그룹카드 관련
	$("#group_detail_left").children().eq(1).children('span').text("방장");
}
//부방장의 관리
function IamSubHost(){
	$("#Dday_area .editDate").show();
	$("#ganttInitBtn").show();
	$("#ganttResultEditBtn").show();
	$("#ganttCreateBtn").show();
	$("#ganttCreate").children().eq(2).hide();
	
	//그룹카드 관련
	$("#group_detail_left").children().eq(1).children('span').text("부방장");
}
//그룹 탈퇴
function deleteGroupUser(){
	if ("그룹 관리"!=$("#delete_btn").text()){
		var result = confirm("정말로 탈퇴하시겠습니까?");
		if (result){
			return true;
		}
		else{
			return false;
		}
	}else{
		return false;
	}
}
//슬라이드 테이블
var slidecount = 1;
function slideTable(max, LR){
	var ul = $("#tableSlide ul");
	var ul2 = $("#tableSlide2 ul");
	
	if (LR == 0 && slidecount > 1){
		slidecount--;
	}		
	else if (LR == 1 && slidecount < max){
		slidecount++;
	}
	
	ul.css({
			"transform": "translateX("+(-680*(slidecount-1))+"px)"
	});
	ul2.css({
			"transform": "translateX("+(-660.8*(slidecount-1))+"px)"
	});
	
	if(max == 1){
		$(".total_table_left").css("color", "#C9C9C9");
		$(".total_table_right").css("color", "#C9C9C9");
	}else{
		$(".total_table_right").css("color", "#F25287");
	}
	if (slidecount == 1){
		$(".total_table_left").css("color", "#C9C9C9")
	}else{
		$(".total_table_left").css("color", "#F25287")
	}
	if (slidecount == max){
		$(".total_table_right").css("color", "#C9C9C9")
	}else{
		$(".total_table_right").css("color", "#F25287")
	}
}
//간트차트
function drawChart2(data) {
	// index : int로 된 big_todo 배열
	// Name : String으로 된 big_todo_content 배열
	// SDate : Y- M - D 로 이루어진 날짜 배열. split 필요
	// EDate : 위와 동일
	// PC : double로 된 배열
	var Index = data[0];
	var Name = data[1];
	var SDate = data[2];
	var EDate = data[3];
	var PC = data[4];
	

	var total = Index.length;
	
	var valueIndex = [];
	var valueName = [];
	var valueSDate = [];
	var valueEDate = [];
	var valuePC = [];
	
		for (var t = 0; t < total; t++){

  			valueIndex.push(Index[t] + "");
  			valueName.push(Name[t] + "");

  		 	valueSDate.push(new Date(SDate[t].split('-')[0]*1, SDate[t].split('-')[1]*1-1, SDate[t].split('-')[2]*1));
 	   	 	valueEDate.push(new Date(EDate[t].split('-')[0]*1, EDate[t].split('-')[1]*1-1, EDate[t].split('-')[2]*1));
 	    
	    	valueDur.push(null);
	    	valuePC.push(PC[t]*1);
		}
	      var data = new google.visualization.DataTable();
	      data.addColumn('string', 'Task ID');
	      data.addColumn('string', 'Task Name');
	      data.addColumn('date', 'Start Date');
	      data.addColumn('date', 'End Date');
	      data.addColumn('number', 'Duration');
	      data.addColumn('number', 'Percent Complete');
	      data.addColumn('string', 'Dependencies'); 
	      
	      for (var i = 0; i < total; i ++){
	      	data.addRow([
	      		valueIndex.at(i), valueName.at(i), valueSDate.at(i), valueEDate.at(i),
	      		null, valuePC.at(i), null
				]);
			}

		let today = new Date();
	  	var rowHeight = 50;

	      var options = {
			width : 800,
			height: data.getNumberOfRows() * rowHeight+rowHeight,      
			gantt: {
				barHeight: 40,
				trackHeight: 50,
				
				
				innerGridHorizLine:{
					stroke : "#F9F3F3"
				},
				innerGridDarkTrack: {
					fill: "#F9F3F3"
				},
				
				labelStyle: {
					fontSize : 22
				},
				
				palette: [{
					"color" : "#FF86AE",
					"dark" : "#F25287",
					"light" : "#FFB4CD"
				}]		
	        },
	        
	        hAxis:{
	        	format: 'yy-MM-dd'
	        	}

	      };
	      
	      var options2 = {
	  			width : 700,
	  			height: data.getNumberOfRows() * rowHeight+rowHeight,      
	  			gantt: {
	  				barHeight: 40,
	  				trackHeight: 50,
	  				defaultStartDate: today,
	  				
	  				innerGridHorizLine:{
	  					stroke : "#F9F3F3"
	  				},
	  				innerGridDarkTrack: {
	  					fill: "#F9F3F3"
	  				},
	  				
	  				labelStyle: {
	  					fontSize : 22
	  				},
	  				
	  				palette: [{
	  					"color" : "#FF86AE",
	  					"dark" : "#F25287",
	  					"light" : "#FFB4CD"
	  				}]		
	  	        },
	  	        
	  	        hAxis:{
	  	        	format: 'yy-MM-dd'
	  	        	}

	  	      };

	      var chart1 = new google.visualization.Gantt(document.getElementById('chart_div1'));
	      var chart2 = new google.visualization.Gantt(document.getElementById('chart_div2'));
	
	      chart1.draw(data, options2);
	      chart2.draw(data, options);
	  }
//d-day 에러 체크하기
function DdayError(){
	var date = $("#finalDate").val();
	
	var temp = date.split("-");
	var Day = getDayOfWeek(temp);
	var today = new Date();
	Ddate = new Date(date);
	
	if (Math.floor((today.getTime()/(24*60*60*1000))) > (Ddate.getTime()/(24*60*60*1000)) || date == ""){
		console.log(Math.floor((today.getTime()/(24*60*60*1000))));
		console.log(Ddate.getTime()/(24*60*60*1000));
		alert("정확한 날짜를 입력해주세요.");
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
	var day = new Date(string[0], string[1]-1, string[2]);
    const week = ['일', '월', '화', '수', '목', '금', '토'];
    const dayOfWeek = week[day.getDay()];

    return dayOfWeek;

}
// 날짜가 올바른지 체크하기
function changeWeek(today){
	var result1 = $("#firstDate").val();
	var result2 = $("#EndDate").val();
	
	if (result1 == "" || result2 == ""){
		alert("기간을 입력해주세요.");
		return false;
	}
	
	var results1 = result1.split("-");
	var results2 = result2.split("-");
	var today = today.split(" ");
	today = today[0].split("/");
	var temp1 = results1[0]+results1[1]+results1[2];
	var temp2 = results2[0]+results2[1]+results2[2];
	today = today[0]+today[1]+today[2];
	temp1 *= 1;
	temp2 *= 1;
	today *= 1;
	var todayDate = new Date();
	todayDate = ""+ todayDate.getFullYear() + changeMM(todayDate.getMonth()) + todayDate.getDate();

	if (temp1 > temp2){
		alert("올바른 기간을 입력해주세요.");
		return false;
	} else if (temp1 < todayDate){
		alert("오늘 이전의 날짜는 입력할 수 없습니다.");
		return false;
	}
	else{
		$("#updateDateView .first").text(results1[0]+"/"+results1[1]+"/"+results1[2]+ " ("+getDayOfWeek(results1)+")");
		$("#updateDateView .second").text(results2[0]+"/"+results2[1]+"/"+results2[2]+ " ("+getDayOfWeek(results2)+")");	
		tbDateChange($("#updateDateView .first").text(), $("#updateDateView .second").text());
		WpopClose();
	}
}
//날짜가 올바른지 체크하기
function changeGantt(groupId, indexint){
	var result1 = $("#DoItChildDate .startDate").val();
	var result2 = $("#DoItChildDate .endDate").val();
	
	if (result1 == "" || result2 == "" || result1 == null || result2 == null){
		$.ajax({
			url : "/schedule/"+groupId+"/selectDate",
			type : "get",
			data : {
				big_todo : indexint
			},
			success : function(data){
				result1 = data[0].split('T')[0];
				result2 = data[1].split('T')[0];		
				
			}
		})
	}
	
	var results1 = result1.split("-");
	var results2 = result2.split("-");
	var temp1 = results1[0]+results1[1]+results1[2];
	var temp2 = results2[0]+results2[1]+results2[2];
	temp1 *= 1;
	temp2 *= 1;

	if (temp1 > temp2){
		alert("올바른 기간을 입력해주세요.");
		return false;
	} 
	else{
		
		$.ajax({
			url : "/schedule/"+groupId+"/InsertGantt3",
			type : "get",
			data : {
				index : indexint,
				big_todo_start : result1,
				big_todo_end : result2
			}
		})
	}
}
function tbDateChange(start, end){	// 입력 : 2000/00/00 (월)
	var start = start.split(" ")[0];
	var end = end.split(" ")[0];
	var startList = start.split("/");
	var endList = end.split("/");
	
	var DateStart = new Date(startList[0], startList[1]-1, startList[2]);
	var DateEnd = new Date(endList[0], endList[1]-1, endList[2]);
	
	var firstWeekStart = DateStart;
	var firstWeekEnd = DateStart;
	var lastWeekStart = DateEnd;
	var lastWeekEnd = DateEnd;
	
	firstWeekStart = new Date(firstWeekStart.setDate(DateStart.getDate()-DateStart.getDay()));	
	firstWeekEnd = new Date (firstWeekEnd.setDate(firstWeekStart.getDate()+6));
	lastWeekStart = new Date(lastWeekStart.setDate(DateEnd.getDate()-DateEnd.getDay()));	
	lastWeekEnd = new Date (lastWeekEnd.setDate(lastWeekStart.getDate()+6));
	
	var diffTime = Math.abs(lastWeekStart-firstWeekStart);
	var diffWeeks = Math.ceil(diffTime/(1000*60*60*24))/7+1;
	
	var result = firstWeekStart.getFullYear()+ changeMM(firstWeekStart.getMonth()) + changedd(firstWeekStart.getDate()) + "*" 
						+ firstWeekEnd.getFullYear()+ changeMM(firstWeekEnd.getMonth()) + changedd(firstWeekEnd.getDate()) + "*"
						+ diffWeeks;
	$("#updateTableData").attr("value", result);
}
function changeMM(month){	//return : 문자열
	var month = (month+1)*1;
	var result = "";
	if(0<month && month<10){
		month+="";
		result = "0"+month;
	}else{
		return month+="";
	}
	return result;
}
function changedd(day){	//return : 문자열
	var day = day*1;
	var result = "";
	if(0<day && day<10){
		day+="";
		result = "0"+day;
	}else{
		return day+="";
	}
	return result;
}

//일정표 색 저장
function  ScheduleSaveBtnClick(slideMax){
    	var columnMax = 7;
    	var iMax = 42;
    	var indexMax = slideMax;
    	var resultList = "";
    	for (var i = 1; i < indexMax+1; i ++){
    		for (var j = (i-1)* iMax*columnMax; j < i * iMax * columnMax; j ++){
					var button = $('.tdCol').eq(j);
    				
    				if (button.css("background") != "rgba(0, 0, 0, 0) none repeat scroll 0% 0% / auto padding-box border-box"){
						resultList+= "1";
					}else{
						resultList+= "0";
					}
					if ((j % 7) == 6){
						resultList+= "b";
					}
			}
			resultList+= "a";
    	}
    	$("#tableFormResult").attr("value", resultList);
   }
// table 컬러 바꾸기
var ispressed = false;
var colorfill = true;
function tbColorChange(element){
	if( $(element).attr("data-color") == "0"){
		$(element).css({
			"background" : "rgba(242, 82, 135, 1)"
		});
		$(element).attr("data-color", "1");
	}
	else if ($(element).attr("data-color") == "1"){
		$(element).css({
			"background" : "rgba(0,0,0,0)"
		});
		$(element).attr("data-color", "0");
	}
	else{
		
	}
}
//유저 팝업을 열기
function popOpen(id, name, address, phone, email, profile, host, subhost){
	var modalPop = $('.user_modal');
	var modalBg = $('.user_modal_bg');
	//이름
	$(".modalUserName").text(name);address
	//프사
	$(".user_modal_content .userProfile").attr("src", profile);
	//부방장등록버튼
	$("#SubHostForm").children('input').eq(0).attr("value", id);

	if (host == "1"){
		$(".SubHostBtn1").hide();	
		$(".SubHostBtn2").hide();	
	}
	if (subhost == "1"){
		$("#SubHostForm").children('input').eq(1).attr("value", "0");
		$(".SubHostBtn1").hide();
		$(".SubHostBtn2").show();
	}else{
		$("#SubHostForm").children('input').eq(1).attr("value", "1");
	}
	//아이디
	$(".profileText").children('span').eq(0).text("@"+id);
	//주소
	$(".profileText").children().children('span').eq(0).children('a').text(" "+address);
	//전화번호
	$(".profileText").children().children('span').eq(1).children('a').text(" "+phone);
	//이메일
	$(".profileText").children().children('span').eq(2).children('a').text(" "+email);
	$(modalPop).show();
	$(modalBg).show();
}
   
//유저 팝업 닫기
function popClose(){
	var modalPop = $('.user_modal');
	var modalBg = $('.user_modal_bg');
	$(modalPop).hide();
	$(modalBg).hide();
	$(".SubHostBtn1").show();	
	$(".SubHostBtn2").hide();	
	$("#SubHostForm").children('input').eq(1).attr("value", "0");
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

//로딩창 종료하기
function loadingClose(){
	var loadPage = $(".loader");
	$(loadPage).hide();
}


$(document).ready(function () {

	//테이블 드래그 관련
	$(".tdCol").mousedown(function(){
		console.log("mousedown" + $(this).attr("id"));
		ispressed = true;
		if ($(this).attr("data-color") == "0"){
			colorfill = true;
		}
		else	{
			colorfill = false;
		}
		tbColorChange("#"+ $(this).attr("id"));
	})
	
	$(".tdCol").mouseup(function(){
		console.log("mouseup" + $(this).attr("id"));
		ispressed = false;
	});
	
	$(".tdCol").mouseenter(function(){
		if (ispressed == true){
			if (colorfill == true && $(this).attr("data-color") == "0"){
				console.log("mouseenter" + $(this).attr("id"));
				tbColorChange("#"+ $(this).attr("id"));
			}
			else if (colorfill == false && $(this).attr("data-color") == "1"){
				console.log("mouseenter" + $(this).attr("id"));
				tbColorChange("#"+ $(this).attr("id"));
			}
		}
	});
	
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

//Dday
$(".editDate").click(function(){
	$("#Dday_edit").show();
	$("#DdayInit").hide();
	$("#Dday").hide();
})
$("#endEditDate").click(function(){
	$("#Dday_edit").hide();
	if ($("#Dday").children("span").eq(1).text() == "*"){
		$("#DdayInit").show();
	}else{
		$("#DdayInit").hide();
		$("#Dday").show();
	}
})

});