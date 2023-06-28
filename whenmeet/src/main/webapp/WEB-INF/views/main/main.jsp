<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언제만나?</title>
<script src="js/jquery-3.6.4.min.js"></script>
<script src='js/cal.js'></script>

<link rel="stylesheet" href="css/main.css">
<script>
var currentDate = new Date();

var year = currentDate.getFullYear();
var month = String(currentDate.getMonth() + 1).padStart(2, '0');
var day = String(currentDate.getDate()).padStart(2, '0');

var formattedDate = year + '-' + month + '-' + day;
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
      initialDate: formattedDate,
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
        {
          title: 'All Day Event',
          start: formattedDate
        },
        {
          title: 'Long Event',
          start: '2023-06-07',
          end: '2023-06-10'
        },
        {
          groupId: 999,
          title: 'Repeating Event',
          start: '2023-06-09T16:00:00'
        },
        {
          groupId: 999,
          title: 'Repeating Event',
          start: '2023-06-16T16:00:00'
        },
        {
          title: 'Conference',
          start: '2023-06-11',
          end: '2023-06-13'
        },
        {
          title: 'Meeting',
          start: '2023-06-12T10:30:00',
          end: '2023-06-12T12:30:00'
        },
        {
          title: 'Lunch',
          start: '2023-06-12T12:00:00'
        },
        {
          title: 'Meeting',
          start: '2023-06-12T14:30:00'
        },
        {
          title: 'Happy Hour',
          start: '2023-06-12T17:30:00'
        },
        {
          title: 'Dinner',
          start: '2023-06-12T20:00:00'
        },
        {
          title: 'Birthday Party',
          start: '2023-06-13T07:00:00'
        },
        {
          title: 'Click for Google',
          url: 'http://google.com/',
          start: '2023-06-28'
        }
      ]
    });

    calendar.render();
  });

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 600px;
    margin-left: 55px;
  }

</style>
<script>
$(document).ready(function(){
	var element = $("#fc-dom-1");
	if(element.get(0).innerText.includes('January')){
	    element.innerText = element.innerText.replace("January","1월");
	  }
		
});
</script>
</head>
<body>
	<%@ include file="../header.jsp" %>
	
    <div id="top">
    	<a href="" id="add_btn"><button><h2>모임 생성</h2></button></a>
    	<img alt="배경이미지" src="img/back.jpg" id="back">
    </div>
    <div id="body">
	    <div id="content">
		    <div id="group">
		    	<h1 class="text">나의 그룹</h1>
		    	<c:forEach items="${mygroup}" var="group" begin="0" end="4">
		    		<h2 class="group_list">${group}</h2>
		    	</c:forEach>
		    	<div id="writing">
			    	<h1>작성한 구인글</h1>
			    	<c:forEach items="${mywrite}" var="write" begin="0" end="4">
		    			<h2 class="writing_list">${write}</h2>
		    		</c:forEach>
			    </div>
			    <div id="apply">
			    	<h1>신청한 구인글</h1>
			    	<c:forEach items="${myapplication}" var="application" begin="0" end="4">
		    			<h2 class="writing_list">${application}</h2>
		    		</c:forEach>
			    </div>
		    </div>
		    <div id="schedule">
		    	<h1 class="text">나의 일정</h1>
		    	<div id='calendar'></div>
		    	
		    </div>
		    <div id="rank">
		    	<h1>인기 글</h1>
			    <c:forEach items="${ranklist}" var="rank" begin="0" end="4">
		    			<h2 class="writing_list">${rank}</h2>
		    	</c:forEach>
			</div>
	    </div>
    </div>
    <div>
    <%@ include file="../footer.jsp" %>
    </div>
</body>
</html>