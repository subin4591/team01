<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정|언제만나</title>
<link rel = "stylesheet" href = "css/schedule_css.css">
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src = "js/schedule_js.js"></script>
<script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b4c5e3499f85cf245295753dba018dc"
></script>
</head>
<%
// 사용자 프로필 에러남
String userImgErr = "img/user_logo.png";
%>

<body>
<div class = "schedule_page">
	<!-- 헤더 위치 -->
	<!-- 
	<header class = "schedule_header">
		<div class = "user_icon">
		<a href = "/" >
			<img src = "img/userEmpty.png"  
			onError = "<%=userImgErr %>" 
			alt = "유저 프로필 사진" class = "userIcon"/>
		</a>
		</div>
		<div class = "logo">
		<a href = "/">
			<img src = "img/logo.svg" alt = "메인 로고 이미지" class = "mainLogo"/>
		</a>
		</div>
	</header>
	-->
	
	<%@ include file="../header.jsp" %>
	
	<!-- 맴버 리스트 -->
	<div class = "member_list">
		<!-- 맴버 리스트 제목  -->
		<div class = "member_list_title">
			<h2>맴버 목록</h2>
		</div>
		<!-- 맴버 리스트 -->
		<div class = "member_list_content">
			<ul class = memberList>
			<%
			
			String memberName = "방장쓰";
			
			for(int i = 0; i < 10; i++){
				String Img = "img/방장표시.svg";
				boolean host = false;
				boolean subhost = false;
				if (i == 0){ 
					host = true;
				}
				if (i == 1){ 
					subhost = true;
					Img = "img/부방장표시.svg";
				}
			%>
				<li>
				<!-- 모달 팝업 열기-->
				<a href="#" class = "user_open" onclick="javascript:popOpen();">
				<div class = "member">				
					<!-- 유저 프로필 이미지 설정 -->
					<div class = "Uimage">
						<img src = "<%= userImgErr %>" 
							onError = "<%= userImgErr %>" 
							alt = "유저 프로필 이미지" class = "userProfile"/>
					</div>
					<!-- 유저 이름 설정-->
					<div class = "text">
						<h2><%= memberName %></h2>
						
					<!-- 방장 및 부방장 설정-->	
						<%if(host || subhost){ %>
						<img src = "<%= Img %>" alt = "방장 표시" 
							class = "hostMark">
						<%}; %>						
					</div>
					
				</div>
				</a>
				</li>
		<%} %>
		</ul>
		</div>
	</div>
	<!-- 모달 팝업 -->
	<div class = "user_modal_bg" onclick = "javascript:popClose();"></div>
	<div class = "user_modal">
		<span>유저 정보를 표시해요</span>
	</div>
	
	<!-- 그룹 정보 -->
	<div id="section_two">
        <p class="main_header">감자 프로젝트 그룹</p>
        
        <div id="section_two_right">
			<div id="review_area"></div>
        	<div id="review_btn">
        		<div id = "white_btn_area">
            		<button type="button" onclick="location.href='#'" style = "margin : 5px"class="btns">
              			비공개
            		</button>
            		<button type="button" onclick="location.href='#'" style = "margin : 5px" class="btns">
              			공유
            		</button>
            	</div>
            	<button type="button" onclick="location.href='#'" id="delete_btn">
              		그룹 탈퇴
            	</button>
          </div>
		</div>
      </div>
    
	<!-- 하단 상자 -->
	<div id="second_section">
		<div id="second_btns">
			<button class="btns2" href="#" id = "meeting_date_btn" >미팅 일정</button>
			<button class="btns2" href="#" id="meeting_location_btn">미팅 위치</button>
			<button class="btns2" href="#" id = "gantt_chart_btn">간트 차트</button>
			<button class="btns2" href="#" id = "group_detail_btn">그룹 정보</button>
		</div>

<div id = "meeting_date" >
	<div class="group_info">
		
		
			<div id="chart_area">
          		<div id="map">
          				<table border = "1"  bordercolor="#DDDDDD"  width = "100%" height = "100%" cellspacing = "0">
          				<thead>
          				<tr align = "center"  style="height: 54px; font-weight: bold;">
          					<td style="width: 12.5%;">&nbsp;</td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>						
						
          					</tr>
   	       				</thead>
   	       				<tbody>
          			
          				<% 
       	   				// when2meet은 table 안 쓰고 다 div 정렬한 것 같은데...
          				// height 최소 크기 지정이 안 됨...
          					for (int i = 0; i < 42; i++){
          						int count = 5;
          						count = count + i/2;
          						String spanT = " style = 'color : #F25287'";
          					%>
          			
          					<tr align = "center"  style="height: 7.2px; font-weight: bold;">	
          					<%if ((i%2 == 0)){ %>
          						<td rowspan = "2">
          						<span<%if (count == 12 || count == 24){%><%=spanT %><%} %>>
          							<%= count%>:00</span></td>
          					<%} %>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
          					</tr>
          					<%} %>
          					</tbody>
          			
          				</table>
          				<br>
          			
          				
          			<form class = "tableForm" action = "#" method = "GET">
          				<!-- for문으로 색깔이 채워져 있으면 1, 비어있으면 0 해서 기다란 STRING 으로 보낼까? -->
          				<button type = "submit" class = "btns" id = "ScheduleSaveBtn">저장</button>
          				<br>
          			</form>
          		</div>
          		<div id = "total_table" style = "display : None;">
          				<table border = "1"  bordercolor="#DDDDDD"  width = "100%" height = "100%" cellspacing = "0">
          				<thead>
          				<tr align = "center"  style="height: 54px; font-weight: bold;">
          					<td style="width: 12.5%;">&nbsp;</td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>
							<td style="width: 12.5%;"><span style = "color : #F25287;">12/25</span><br>
								<span style = "font-size : 20px">일</span></td>						
						
          					</tr>
   	       				</thead>
   	       				<tbody>
          			
          				<% 
       	   				// when2meet은 table 안 쓰고 다 div 정렬한 것 같은데...
          				// height 최소 크기 지정이 안 됨...
          					for (int i = 0; i < 42; i++){
          						int count = 5;
          						count = count + i/2;
          						String spanT = " style = 'color : #F25287'";
          					%>
          			
          					<tr align = "center"  style="height: 7.2px; font-weight: bold;">	
          					<%if ((i%2 == 0)){ %>
          						<td rowspan = "2">
          						<span<%if (count == 12 || count == 24){%><%=spanT %><%} %>>
          							<%= count%>:00</span></td>
          					<%} %>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
								<td style="width: 12.5%;">&nbsp;</td>
          					</tr>
          					<%} %>
          					</tbody>
          			
          				</table>
          				<br>
          				<button type = "button" class = "btns" id = "ScheduleEditBtn">수정</button>
          				<br>
          			</div>
        	</div>
        
        	
        	<div id="Dday_area">
        	
          		<div id="Dday">
          				<a><img id = "editDate" src = "img/방장용_수정_버튼.svg" /></a>
            		<span>D-day</span>
            		<span>14</span>
            		<span>2022년 12월 31일 (토)</span>
            		<span>14:00 - 15:30</span>
          		</div>
          		
          		<div id = "Dday_edit" style = "display : None;">
          			<img class = "etc" src = "img/수정중.svg" />
          			<img ID = "endEditDate" src = "img/엑스.svg" />
          		</div>
          		
          		<div id="Dday_info">
            		<div id="update_date">
              			<form action="#" method="get" id="update_frm">
                			<input type="datetime-local" name="start_date" />
                			<p>-</p>
                			<input type="datetime-local" name="end_date" />
               	 			<input type="submit" value="수정" />
              			</form>
            		</div>
            		
            		<div id="join_area">
              			<p>참여한 사람|</p>
              			<div id="join_member">
                			<li><p>방장쓰</p></li>
                			<li><p>맴버1</p></li>
                			<li><p>맴버2</p></li>
              			</div>
            		</div>
            		
          		</div>
        	</div>
      </div>
      
      </div>

	
	<div id = "meeting_location" style = "display : none;">
		<div class="group_info">위치</div>
	</div>
	
	<div id = "gantt_chart" style = "display : none;">
		<div class="group_info">
		
			<div id = "ganttCreate">
				<button id = "ganttCreateBtn"><h1>十 새로운 차트</h1></button>
			</div>
			
			<div id = "ganttEdit" style = "display : None">
				<button id = "ganttEditCancelBtn"><h1>취소</h1></button>
				<button id = "ganttEditSaveBtn"><h1>저장</h1></button>				
			</div>

			<div id = "ganttResult" style = "display:None">
				<div id="chart_div"></div>
				<button id = "ganttInitBtn"><h1>초기화</h1></button>
				<button id = "ganttResultEditBtn"><h1>수정</h1></button>
			</div>			
		</div>			
	</div>
	
	<div id = "group_detail" style = "display : none;">
		<div class="group_info">상세</div>
	</div>	
</div>	
	<!-- footer -->
	
	<div>
		<%@ include file="../footer.jsp" %>
	</div>

</body>
</html>