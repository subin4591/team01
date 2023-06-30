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
      businessHours: true,
      editable: true,
      selectable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
	   	{
            start: '2023-06-24',
            end: '2023-06-28',
            overlap: false,
            display: 'background',
            color: '#ff9f89'
        },
        {
          title: '일하기',
          start: formattedDate
        },
        {
          groupId: 999,
          title: '반복',
          start: '2023-06-09T16:00:00'
        },
        {
          groupId: 999,
          title: '반복',
          start: '2023-06-16T16:00:00'
        },
        {
          title: '회의',
          start: '2023-06-11',
          end: '2023-06-13'
        },
        {
          title: '미팅',
          start: '2023-06-12T10:30:00',
          end: '2023-06-12T12:30:00'
        },
        {
          title: '점식약속',
          start: '2023-06-12T12:00:00'
        },
        {
          title: 'url이동',
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
    margin-left: 60px;
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
	    	<div id="my_page">
			    <div id="group">
			    	<h1 class="text">
			    		나의 그룹
			    		<span class="more">전체보기</span>
			    	</h1>
			    	
			    	<c:forEach items="${mygroup}" var="group" begin="0" end="4">
			    		<h3 class="group_list">${group}</h3>
			    	</c:forEach>
			    </div>
		    	<div id="writing">
			    	<h1 class="text">
			    		작성한 구인글
			    		<span class="more">전체보기</span>
			    	</h1>
			    	<c:forEach items="${mywrite}" var="write" begin="0" end="4">
		    			<h3 class="writing_list">${write}</h3>
		    		</c:forEach>
			    </div>
			    <div id="apply">
			    	<h1 class="text">
			    		신청한 구인글
			    		<span class="more">전체보기</span>
			    	</h1>
			    	<c:forEach items="${myapplication}" var="application" begin="0" end="4">
		    			<h3 class="apply_list">${application}</h3>
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
		    			<h2 class="rank_list">${rank}</h2>
		    	</c:forEach>
			</div>
	    </div>
    </div>
    <div>
    <%@ include file="../footer.jsp" %>
    </div>
</body>
</html>