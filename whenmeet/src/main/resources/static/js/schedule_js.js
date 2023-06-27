/**
 * 
 */
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
	$("#timeTable").hide();
})
$("#ScheduleEditBtn").click(function(){
	$("#total_table").hide();
	$("#timeTable").show();
})
$("#editDate").click(function(){
	$("#Dday_edit").show();
	$("#Dday").hide();
})
$("#endEditDate").click(function(){
	$("#Dday_edit").hide();
	$("#Dday").show();
})

/* 간트 차트 */
  	$("#ganttCreateBtn").click(function(){
		$("#ganttEdit").show();
		$("#ganttCreate").hide();
	})
  	$("#ganttEditCancelBtn").click(function(){
		$("#ganttCreate").show();
		$("#ganttEdit").hide();
	})	
  	$("#ganttEditSaveBtn").click(function(){
		$("#ganttResult").show();
		$("#ganttEdit").hide();
	})	
	$("#ganttResultEditBtn").click(function(){
		$("#ganttEdit").show();
		$("#ganttResult").hide();
	})
	
	
	/*구글 차트 api*/
    google.charts.load('current', {'packages':['gantt']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Task ID');
      data.addColumn('string', 'Task Name');
      /*data.addColumn('string', 'Resource');*/
      data.addColumn('date', 'Start Date');
      data.addColumn('date', 'End Date');
      data.addColumn('number', 'Duration');
      data.addColumn('number', 'Percent Complete');
      data.addColumn('string', 'Dependencies');

      data.addRows([
        ['0', '주제 정하기',
         null, new Date(2023, 7, 28), null, 50, null],
        ['1', '토의하기',
         new Date(2023, 6, 25), new Date(2023, 8, 20), null, 10, null],
        ['2', '개발하기',
         new Date(2023, 8, 21), new Date(2023, 11, 20), null, 100, null],
        ['3', '간식 먹기',
         new Date(2023, 11, 21), new Date(2023, 12, 21), null, 100, null],
         ]);

	let today = new Date();
      var options = {
		width : 1000,
        height: 280,
        gantt: {
			barHeight: 45,
			trackHeight: 70,
			defaultStartDate: today,
			
			innerGridHorizLine:{
				stroke : "#F9F3F3"
			},
			innerGridDarkTrack: {
				fill: "#F9F3F3"
			},
			
			labelStyle: {
				fontSize : 20
			},
			
			palette: [{
				"color" : "#FF86AE",
				"dark" : "#F25287",
				"light" : "#FFB4CD"
			}]

        }
      };

      var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

      chart.draw(data, options);
    }

	/* 미팅 위치 */
  	locateB.on("click", function () {
    	let container = document.getElementById("map");
    	let options = {
      	//지도를 생성할 때 필요한 기본 옵션
      	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
      	level: 3, //지도의 레벨(확대, 축소 정도)
    	};

    	let map = new kakao.maps.Map(container, options);
  	});
  
  		
});
