<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="main.MainDAO"%>
<%@page import="main.MainService"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인|언제만나</title>
<script src="js/jquery-3.6.4.min.js"></script>
<script src='js/cal.js'></script>

<link rel="icon" href="/img/icon.svg">

<link rel="stylesheet" href="css/schedule_location.css">

<script>
$(document).ready(function(){	
	$('.modal_bg').on('click',function(){
		$('#modal_wrap').hide();
		$('#schedule_click').hide();
	});
	
	$('#modal_wrap').hide();
	$('#write_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	      location.href = "/login";
    }
	});
	$('#apply_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	      location.href = "/login";
	    }
	});
	$('#group_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	      location.href = "/login";
	    }
	});
	$('#add_btn').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	      location.href = "/login";
	    }
	});
});
var currentDate = new Date();

var year = currentDate.getFullYear();
var month = String(currentDate.getMonth() + 1).padStart(2, '0');
var day = String(currentDate.getDate()).padStart(2, '0');

var formattedDate = year + '-' + month + '-' + day;
var sclist = `${sclist}`;
var scjson = JSON.parse(sclist);
console.log(scjson);
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,timeGridDay'
      },
      initialDate: formattedDate,
      navLinks: true, // 링크클릭가능
      businessHours: true, 
      selectable: true,
      selectMirror: true,
      dayMaxEvents: true, // 더보기
      select: function(arg) {
    	  function formatDate(dateString) {
    		  const dateObj = new Date(dateString);
    		  const year = dateObj.getFullYear();
    		  const month = String(dateObj.getMonth() + 1).padStart(2, '0'); // Months are 0-based, so add 1 and pad with leading zeros
    		  const day = String(dateObj.getDate()).padStart(2, '0'); // Pad with leading zeros if needed
    		  return `${year}-${month}-${day}`;
    		}
    	  $('#modal_wrap').show();
      	  $('#firstDate').val((arg.start.getFullYear() + "-" + String(arg.start.getMonth()+1).padStart(2,'0') + "-" + String(arg.start.getDate()).padStart(2,'0')));
      	  $('#endDate').val((arg.end.getFullYear() + "-" + String(arg.end.getMonth()+1).padStart(2,'0') + "-" + String(arg.end.getDate()-1).padStart(2,'0')));
	      $('#firstTime').val(String(arg.start.getHours()).padStart(2,'0')+":"+String(arg.start.getMinutes()).padStart(2,'0'));
	      $('#endTime').val(String(arg.end.getHours()).padStart(2,'0')+":"+String(arg.end.getMinutes()).padStart(2,'0'));
      	  let date1 = new Date(arg.start);
      	  let date2 = new Date(arg.end);
	      let hours1 = date1.getHours();
	      let minutes1 = date1.getMinutes();
	      let seconds1 = date1.getSeconds();
	
	      let hours2 = date2.getHours();
	      let minutes2 = date2.getMinutes();
	      let seconds2 = date2.getSeconds();

      	  if(!(hours1 === hours2 && minutes1 === minutes2 && seconds1 === seconds2)){
      		$('#endDate').val((arg.start.getFullYear() + "-" + String(arg.start.getMonth()+1).padStart(2,'0') + "-" + String(arg.start.getDate()).padStart(2,'0')));
      		$("#check1").prop("checked", false);
      		$("#check1").trigger("change");
      	  }else{
      		$("#check1").prop("checked", true);
      		$("#check1").trigger("change");
          }
        },
        eventClick: function(arg) {
        	$('#schedule_title2').attr('readonly',true);
    		$('#check2').attr('readonly',true);
    		$('#firstDate2').attr('readonly',true);
    		$('#endDate2').attr('readonly',true);
    		$('#firstTime2').attr('readonly',true);
    		$('#endTime2').attr('readonly',true);
    		$('#location2').attr('readonly',true);
    		$('#memo2').attr('readonly',true);
        	$('#info_btn').show();
    		$('#mod_btn').hide();
        	var s = arg.event.start;
        	var e = arg.event.end;
        	start = s.getFullYear() + "-" + String(s.getMonth()+1).padStart(2,'0') + "-" + String(s.getDate()).padStart(2,'0') + " " + String(s.getHours()).padStart(2, '0') +":"+ String(s.getMinutes()).padStart(2, '0');
        	end = e.getFullYear() + "-" + String(e.getMonth()+1).padStart(2,'0') + "-" + String(e.getDate()).padStart(2,'0')+ " " + String(e.getHours()).padStart(2, '0') +":" + String(e.getMinutes()).padStart(2, '0');
			if(arg.event.allDay){
				start = start.substring(0, 10);
				end = end.substring(0,10);
				$('#check2').prop('checked',true);
		        $("#check2").trigger("change");
			}else{
				$('#check2').prop('checked',false);
		        $("#check2").trigger("change");
			}
        	$('#schedule_click').show();
        	$.ajax({
  		      url: '/getscheduleone', 
  		      method: 'POST',
  		      data: {
  		    	title:arg.event.title,
  		    	start:start,
  		    	end:end,
  		        user_id: "${session_id}"
  		      },
  		      success: function(response) {
  		    	console.log(response);
  		    	var rs = response.schedule;
  		        $('#schedule_title2').val(rs.title);
  		        $('#location2').val(rs.address);
	        	$('#memo2').val(rs.memo);
  		        if(rs.startTime.length == 10){
  		        	
  		        	$('#firstDate2').val(rs.startTime);
  		        	var myDate = new Date(rs.endTime);
  		        	
	  		        myDate.setDate(myDate.getDate() - 1);
	  		        var year = myDate.getFullYear();
	  		        var month = String(myDate.getMonth() + 1).padStart(2, '0');
	  		        var day = String(myDate.getDate()).padStart(2, '0');
	  		        var formattedDate = year + "-" + month + "-" + day;
  		        	$('#endDate2').val(formattedDate); 	
  		        	$('label[for="check2"]').on('click', function(event) {
  		        	    event.preventDefault();
  		        	});	
  		        }else{
  		        	var startDate = rs.startTime.split(" ");
  		        	var endDate = rs.endTime.split(" ");
  		        	var myDate = new Date(endDate[0]);
	  		        myDate.setDate(myDate.getDate() - 1);
	  		        var year = myDate.getFullYear();
	  		        var month = String(myDate.getMonth() + 1).padStart(2, '0');
	  		        var day = String(myDate.getDate()).padStart(2, '0');
	  		        var formattedDate = year + "-" + month + "-" + day;
  		        	$('#firstDate2').val(startDate[0]);
  		        	$('#endDate2').val(formattedDate);
  		        	$('#firstTime2').val(startDate[1]);
  		        	$('#endTime2').val(endDate[1]);
  		        }
  		      },
  		      error: function(xhr, status, error) {
  		        console.log(error);
  		      }
  		}); 
        	
        	
        },
      events: [
	   	/* {
            start: '2023-07-24',
            end: '2023-07-28',
            overlap: false,
            display: 'background',
            color: '#ff9f89'
        }, */
        /* {
          title: 'url이동',
          url: 'http://google.com/',
          start: '2023-07-28'
        } */
      ]
    });

    calendar.render();
    if(scjson.length != 0){
		scjson.map(item => {
			
			calendar.addEvent({
	            title: item.title,
	            start: item.startTime,
	            end: item.endTime
	          })
		});
	}
  });
	
</script>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	<%session.setAttribute("session_id", request.getAttribute("id")); %>
	<%@ include file="../header.jsp" %>
<script>
$(document).ready(function(){
	  $("#check1").on("change", function() {
	    // Check if the checkbox is checked
	    if ($(this).is(":checked")) {
	      $('#firstTime').hide();
	      $('#endTime').hide();
	      $(".arrow").css("margin-bottom", "-180px");
	      $('.modal_schedule').css("height","420px");
	      $(".arrow img").css("top", "-189px"); 
	      $(".schedule_date").css("top","-115px");
	    } else {
	    	$('#firstTime').show();
		    $('#endTime').show();
		    $(".arrow").css("margin-bottom", "-215px");
		    $('.modal_schedule').css("height","460px");
		    $(".arrow img").css("top", "-263px"); 
		    $(".schedule_date").css("top","-148px");
	    }
	  });
	  $("#check2").on("change", function() {
		    // Check if the checkbox is checked
		    if ($(this).is(":checked")) {
		      $('#firstTime2').hide();
		      $('#endTime2').hide();
		      $(".arrow").css("margin-bottom", "-180px");
		      $('.modal_schedule').css("height","420px");
		      $(".arrow img").css("top", "-189px"); 
		      $(".schedule_date").css("top","-115px");
		    } else {
		    	$('#firstTime2').show();
			    $('#endTime2').show();
			    $(".arrow").css("margin-bottom", "-215px");
			    $('.modal_schedule').css("height","460px");
			    $(".arrow img").css("top", "-263px"); 
			    $(".schedule_date").css("top","-148px");
		    }
		  });
	  $('.cancelBtn').on('click',function(){
		  $('#modal_wrap').hide();
		  $('#schedule_click').hide();
		  
	  })
	
	$('.submitBtn').on('click',function(e){
		var title = $('#schedule_title').val();
		var start = $('#firstDate').val() + " " + $('#firstTime').val();
		var end = $('#endDate').val() + " " + $('#endTime').val();
		var address = $('#location').val();
		var memo = $('#memo').val();
		if($('#check1').prop('checked') == true){
			start = $('#firstDate').val();
			end = $('#endDate').val();
		}
		var date1 = new Date(start);
		var date2 = new Date(end);
		if($('#check1').prop('checked') == true){
			date2.setDate(date2.getDate()+1);
			end = date2.getFullYear() + "-" + String(date2.getMonth()+1).padStart(2,'0') + "-" + String(date2.getDate()).padStart(2,'0');
		}
		if(title == ""){
			alert("제목을 입력하세요.");
			return;
		}
		if(date1 >= date2){
			alert("잘못된 시간입니다.");
			return;
		}
		console.log(start);
		console.log(end);
		 $.ajax({
		      url: '/scheduleAdd', 
		      method: 'POST', 
		      data: {
		    	title:title,
		    	start:start,
		    	end:end,
		        address: address,
		        memo:memo,
		        user_id: "${session_id}"
		      },
		      success: function(response) {
		        console.log(response);
		      },
		      error: function(xhr, status, error) {
		        console.log(error);
		      }
		}); 
		e.stopPropagation();
		location.reload(true);
	  });
	  $('.deleteBtn').on('click',function(){
		  var title = $('#schedule_title2').val();
		  var start = $('#firstDate2').val() + " " + $('#firstTime2').val();
		  var myDate = new Date($('#endDate2').val());
	      myDate.setDate(myDate.getDate() + 1);
	      var year = myDate.getFullYear();
	      var month = String(myDate.getMonth() + 1).padStart(2, '0');
	      var day = String(myDate.getDate()).padStart(2, '0');
	      var formattedDate = year + "-" + month + "-" + day;
		  var end = formattedDate + " " + $('#endTime2').val();
		  
		  if($('#check2').prop('checked') == true){
				start = $('#firstDate2').val();
				end = formattedDate;
			}
		  $.ajax({
		      url: '/scheduledelete', 
		      method: 'POST', 
		      data: {
		    	title:title,
		    	start:start,
		    	end:end,
		        user_id: "${session_id}"
		      },
		      success: function(response) {
		        console.log(response);
		      },
		      error: function(xhr, status, error) {
		        console.log(error);
		      }      
	  	});
		location.reload();
	});
	$('.changeBtn').on('click',function(){
		var p_title = $('#schedule_title2').val();
		var p_start = $('#firstDate2').val() + " " + $('#firstTime2').val();
		var p_end = $('#endDate2').val() + " " + $('#endTime2').val();
		if($('#check2').prop('checked') == true){
			p_start = $('#firstDate2').val();
			p_end = $('#endDate2').val();
		}
		var date1 = new Date(p_start);
		var date2 = new Date(p_end);
		if($('#check2').prop('checked') == true){
			date2.setDate(date2.getDate()+1);
			p_end = date2.getFullYear() + "-" + String(date2.getMonth()+1).padStart(2,'0') + "-" + String(date2.getDate()).padStart(2,'0');
		}
		$('#info_btn').hide();
		$('#mod_btn').show();
		$('#schedule_title2').attr('readonly',false);
		$('#check2').attr('readonly',false);
		$('#firstDate2').attr('readonly',false);
		$('#endDate2').attr('readonly',false);
		$('#firstTime2').attr('readonly',false);
		$('#endTime2').attr('readonly',false);
		$('#location2').attr('readonly',false);
		$('#memo2').attr('readonly',false);
		$('.confirmBtn').on('click',function(e){
			var title = $('#schedule_title2').val();
			var start = $('#firstDate2').val() + " " + $('#firstTime2').val();
			var end = $('#endDate2').val() + " " + $('#endTime2').val();
			var address = $('#location2').val();
			var memo = $('#memo2').val();
			if($('#check2').prop('checked') == true){
				start = $('#firstDate2').val();
				end = $('#endDate2').val();
			}
			date1 = new Date(start);
			date2 = new Date(end);
			if($('#check2').prop('checked') == true){
				date2.setDate(date2.getDate()+1);
				end = date2.getFullYear() + "-" + String(date2.getMonth()+1).padStart(2,'0') + "-" + String(date2.getDate()).padStart(2,'0');
			}
				if(date1 >= date2){
					alert("잘못된 시간입니다.");
					return;
				}
			
				 $.ajax({
				      url: '/schedulechange', 
				      method: 'POST', 
				      data: {
				    	p_title : p_title,
				    	p_start : p_start,
				    	p_end : p_end,
				    	
				    	title:title,
				    	start:start,
				    	end:end,
				        address: address,
				        memo:memo,
				        user_id: "${session_id}"
				      },
				      success: function(response) {
				        console.log(response);
				      },
				      error: function(xhr, status, error) {
				        console.log(error);
				      }
				}); 
				e.stopPropagation();
				location.reload(); 
		})
	});
	$('#modal_wrap').on('click',function(){
		$('#modal_wrap').hide();
	});
	$('.modal_schedule').on('click',function(e){
		e.stopPropagation();
	});
	$('#schedule_click').on('click',function(){
		$('#schedule_click').hide();
	});

});
</script>
<%
	LocalDateTime currentDateTime = LocalDateTime.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	String today = currentDateTime.format(formatter);
	DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("HH:mm");
    String time = currentDateTime.format(formatter2);

%>


	<!-- 일정 생성 폼 -->
	<div id="modal_wrap">
		<div class = "modal_schedule">
			<div style = "position : relative; top : -3px; background : #F25287; width : 100%; height: 50px;">
				<h1 style = "position : relative; font-size : 28px; margin : 3px; top : 3px; text-align : center; color : white;">일정 추가</h1>
			</div>
			<div class = "week_modal_content">
				<form action = "" id = "createSchedule">
					<div class="schedule_title"><input type = "text" id="schedule_title" placeholder="제목"/></div>
					
					<div class="dayw">
						하루 종일
						<input type="checkbox" id="check1"/>
        				<label for="check1"></label>
					</div>
					<div class="schedule_date">
						<div class = "daytime">
							<input type = "date" name = "start" id = "firstDate" value="<%=today %>"/>
							<input type = "date"  name = "end" id = "endDate" value="<%=today %>" />
						</div>
						<div class = "detail_time">
							<input type="time" id="firstTime" value="<%=time %>"/>
							<input type="time" id="endTime" value="<%=time %>"/>
						</div>
					</div>
					<div class="arrow">
						<img alt="" src="img/arrow.png">
					</div>
					<div class="location">
						<input type="text" placeholder="장소" id="location">
					</div>
					<div class="memo">
						<input type="text" placeholder="메모" id="memo">
					</div>
					<div class="btn_wrap">
						<input type = "button" value = "취소"  class = "cancelBtn" 
						/><input type = "button" value = "저장"  class = "submitBtn"/>
					</div>
				</form>
			</div>		
		</div>
  	</div>
  	<!-- 일정 수정/삭제 폼 -->
  	<div id="schedule_click">
		<div class = "modal_schedule">
			<div style = "position : relative; top : -3px; background : #F25287; width : 100%; height: 50px;">
				<h1 style = "position : relative; font-size : 28px; margin : 3px; top : 3px; text-align : center; color : white;">일정 추가</h1>
			</div>
			<div class = "week_modal_content">
				<form action = "" id = "updateSchedule">
					<div class="schedule_title"><input type = "text" id="schedule_title2" placeholder="제목" readonly/></div>
					<div class="dayw">
						하루 종일
						<input type="checkbox" id="check2" readonly/>
        				<label for="check2"></label>
					</div>
					<div class="schedule_date">
						<div class = "daytime">
							<input type = "date" name = "start" id = "firstDate2" value="<%=today %>" readonly/>
							<input type = "date"  name = "end" id = "endDate2" value="<%=today %>" readonly />
						</div>
						<div class = "detail_time">
							<input type="time" id="firstTime2" value="<%=time %>" readonly/>
							<input type="time" id="endTime2" value="<%=time %>" readonly/>
						</div>
					</div>
					<div class="arrow">
						<img alt="" src="img/arrow.png">
					</div>
					<div class="location">
						<input type="text" placeholder="장소" id="location2" readonly>
					</div>
					<div class="memo">
						<input type="text" placeholder="메모" id="memo2" readonly>
					</div>
					<div class="btn_wrap" id = "info_btn">
						<input type = "button" value = "삭제"  class = "deleteBtn" 
						/><input type = "button" value = "수정"  class = "changeBtn"/>
					</div>
					<div class="btn_wrap" style = "display : None" id="mod_btn">
						<input type = "button" value = "취소"  class = "cancelBtn" id="cancel" 
						/><input type = "button" value = "저장"  class = "confirmBtn"/>
					</div>
				</form>
			</div>		
		</div>
  	</div>
    <div id="top">
    	<a href="group/invitation" id="add_btn"><button><h2>그룹 생성</h2></button></a>
    	<img alt="배경이미지" src="img/back.jpg" id="back">
    </div>
    <div id="body">
	    <div id="content">
	    	<div id="my_page">
			    <div id="group">
			    	<h1 class="text">
			    		<span class="div_header">나의 그룹</span>
			    		<span class="more"><a href="/group/list" id="group_more">전체보기</a></span>
			    	</h1>
			    	<div class="group_wrap">
				    	<c:forEach items="${mygroup}" var="group">
				    		<h3 class="group_list"><a href="schedule/${group.group_id }">${group.group_name}</a></h3>
				    	</c:forEach>
			    	</div>
			    </div>
		    	<div id="writing">
			    	<h1 class="text">
			    		<span class="div_header">작성한 모집글</span>
			    		<span class="more"><a href="meeting/my" id="write_more">전체보기</a></span>
			    	</h1>
			    	<div class="wlist_wrap">
				    	<c:forEach items="${mywrite}" var="write">
			    			<h3 class="writing_list"><a href="meeting/detailed?seq=${write.seq}">${write.title}</a></h3>
			    		</c:forEach>
		    		</div>
			    </div>
			    <div id="apply">
			    	<h1 class="text">
			    		<span class="div_header">신청한 모집글</span>
			    		<span class="more"><a href="meeting/myapp" id="apply_more">전체보기</a></span>
			    	</h1>
			    	<div class="alist_wrap">
				    	<c:forEach items="${myapplication}" var="application">
			    			<h3 class="apply_list"><a href="meeting/detailed?seq=${application.seq}">${application.title}</a></h3>
			    		</c:forEach>
		    		</div>
			    </div>
			    
			</div>
		    <div id="schedule">
		    	<h1 class="text">나의 일정</h1>
		    	<c:choose>
				    <c:when test="${session_id == null}">
				        <a href="login"><button id="null"><h2>로그인이 필요합니다.</h2></button></a>
				    </c:when>
				    <c:otherwise>
				        <div id='calendar'></div>
				        <div class="ps">날짜를 클릭하거나 드래그해서 일정을 추가하세요</div>
				    </c:otherwise>
				</c:choose>
		    
		    </div>
		    <div id="rank">
		    	<h1 class="text">
		    		<span class="div_header">인기 글</span>
		    		<span class="more"><a href="meeting" id="rank_more">전체보기</a></span>
		    	</h1>
			    <c:forEach items="${ranklist}" var="rank" begin="0" end="4">
		    			<h2 class="rank_list"><a href="meeting/detailed?seq=${rank.seq}">${rank.title}</a></h2>
		    			<span class="rank_contents" id="rank_contents${rank.seq}">${rank.contents}</span>
		    			<script>
		    				var content = $('#rank_contents${rank.seq}');
		    				content.html(content.text());
		    			</script>
		    	</c:forEach>
			</div>
	    </div>
	    <div>
		</div>
    </div>
    <div id="footer">
    <%@ include file="../footer.jsp" %>
    </div>
    
</body>
</html>