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
<script src="js/main.js"></script>

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
            start: '2023-07-24',
            end: '2023-07-28',
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
          start: '2023-07-09T16:00:00'
        },
        {
          groupId: 999,
          title: '반복',
          start: '2023-07-16T16:00:00'
        },
        {
          title: '회의',
          start: '2023-07-11',
          end: '2023-07-13'
        },
        {
          title: '미팅',
          start: '2023-07-12T10:30:00',
          end: '2023-07-12T12:30:00'
        },
        {
          title: '점식약속',
          start: '2023-07-12T12:00:00'
        },
        {
          title: 'url이동',
          url: 'http://google.com/',
          start: '2023-07-28'
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

  

</style>

<script>
$(document).ready(function(){	
	$('#write_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
    }
	});
	$('#apply_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	    }
	});
	$('#group_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	    }
	});
	$('#add_btn').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	    }
	});
});
</script>
</head>
<body>
	<%session.setAttribute("session_id", request.getAttribute("id")); %>
	<%@ include file="../header.jsp" %>
	
    <div id="top">
    	<a href="meeting/write	" id="add_btn"><button><h2>모임 생성</h2></button></a>
    	<img alt="배경이미지" src="img/back.jpg" id="back">
    </div>
    <div id="body">
	    <div id="content">
	    	<div id="my_page">
			    <div id="group">
			    	<h1 class="text">
			    		나의 모임
			    		<span class="more"><a href="" id="group_more">전체보기</a></span>
			    	</h1>
			    	
			    	<c:forEach items="${mygroup}" var="group" begin="0" end="2">
			    		<h3 class="group_list"><a href="schedule">${group}</a></h3>
			    	</c:forEach>
			    </div>
		    	<div id="writing">
			    	<h1 class="text">
			    		작성한 모집글
			    		<span class="more"><a href="meeting/my" id="write_more">전체보기</a></span>
			    	</h1>
			    	<c:forEach items="${mywrite}" var="write" begin="0" end="2">
		    			<h3 class="writing_list"><a href="meeting/detailed?seq=${write.seq}">${write.title}</a></h3>
		    		</c:forEach>
			    </div>
			    <div id="apply">
			    	<h1 class="text">
			    		신청한 모집글
			    		<span class="more"><a href="meeting/myapp" id="apply_more">전체보기</a></span>
			    	</h1>
			    	<c:forEach items="${myapplication}" var="application" begin="0" end="2">
		    			<h3 class="apply_list"><a href="meeting/detailed?seq=${application.seq}">${application.title}</a></h3>
		    		</c:forEach>
			    </div>
			    
			</div>
		    <div id="schedule">
		    	<h1 class="text">나의 일정</h1>
		    	<div id='calendar'></div>
		    	
		    </div>
		    <div id="rank">
		    	<h1 class="text">
		    		인기 글
		    		<span class="more"><a href="meeting" id="rank_more">전체보기</a></span>
		    	</h1>
			    <c:forEach items="${ranklist}" var="rank" begin="0" end="4">
		    			<h2 class="rank_list"><a href="meeting/detailed?seq=${rank.seq}">${rank.title}</a></h2>
		    			<span class="rank_contents">${rank.contents}</span>
		    	</c:forEach>
			</div>
	    </div>
	    <div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
		<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=a860b9470c235ea7b99c9c4e99ca3f14&libraries=services"></script>
		<script>
		var markers = [];

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();  
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});

		// 키워드로 장소를 검색합니다
		searchPlaces();

		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

		    var keyword = document.getElementById('keyword').value;

		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }

		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);

		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);

		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		        alert('검색 결과가 존재하지 않습니다.');
		        return;

		    } else if (status === kakao.maps.services.Status.ERROR) {

		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;

		    }
		}

		

		
		</script>
    </div>
    <div>
    <%@ include file="../footer.jsp" %>
    </div>
</body>
</html>