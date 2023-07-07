<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>일정|언제만나</title>
  <link rel="icon" href="/img/icon.svg">
  <link rel = "stylesheet" href = "/css/schedule_css.css">
  <link rel = "stylesheet" href = "/css/schedule_location.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script src = "/js/schedule_js.js"></script> 
</head>

<%@page import = "java.util.*"%>
<%
// 사용자 프로필 에러났을 때
String userImgErr = "/img/user_logo.png";
%>

<body>
<div class = "schedule_page">
	<!--헤더 -->
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
			//맴버 목록 데이터
			ArrayList<String> memberName = new ArrayList<String>();
			memberName.add("방장쓰");
			memberName.add("부방장쓰");
			memberName.add("맴버1");
			memberName.add("맴버2");
			memberName.add("맴버3");
			memberName.add("맴버4");
			
			//누가 방장인가
			for(int i = 0; i < memberName.size(); i++){
				String Img = "/img/방장표시.svg";
				boolean host = false;
				boolean subhost = false;
				if (i == 0){ 	//첫 번째 자리면 방장
					host = true;
				}
				if (i == 1){ 
					subhost = true;
					Img = "/img/부방장표시.svg";
				}
			%>
				<li>
				  <!-- 모달 팝업 열기-->

				  <a href="#" class = "user_open" onclick="javascript:popOpen('<%= memberName.get(i) %>'); " >
				
				    <div class = "member">				
					    <!-- 유저 프로필 이미지 설정 -->
					    <div class = "Uimage">
						    <img src = "<%= userImgErr %>" 
							    onError = "<%= userImgErr %>" 
							    alt = "유저 프로필 이미지" class = "userProfile">
					    </div>
					    
					    <div class = "text">
               				 <!-- 유저 이름 설정-->
						    <h2><%= memberName.get(i) %></h2>
						
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
		<div style = "position : relative; top : -3px; background : #F25287; width : 100%; height: 50px;">
			<h1 style = "position : relative; font-size : 28px; margin : 3px; top : 3px; text-align : center; color : white;">사용자 정보</h1>
		</div>
		<div class = "user_modal_content">
		  <img style = "position : relative; top : -3px; width : 100%; height : 100px; object-fit: cover; z-index : 1001" 
			    src = "https://plus.unsplash.com/premium_photo-1670099796196-298771740ed7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80"/>
		  <img style = "position : absolute; top : 60px; left : 0px; margin : 10px; z-index : 1002;" 
					src = "<%= userImgErr %>" 
					onError = "<%= userImgErr %>" 
					alt = "유저 프로필 이미지" class = "userProfile">
		  <div class = "profileText" style = "overflow : hidden; white-space:nowrap; text-overflow : ellipsis;">
		    <br><br><br><h1 class = "modalUserName"> 정보를 불러올 수 없습니다.</h1>
		    <br><span>@doremiAccount</span> <br><br>
		    <div style = "font-size : 20px">
			    <span><b>주소 |</b> 도레시 미파구 솔라동 시도레 마을</span> <br>
			    <span><b>전화번호 |</b> 010-1234-5678</span> <br>
			    <span><b>이메일 |</b> doremi@gmail.com</span> <br>
		    </div>
		  </div>
		</div>		
  </div>
	
	<!-- 그룹 정보 -->
	<div id="section_two">
    <p class="main_header">${groupName}</p>
        
    <div id="section_two_right">
			<div id="review_area" >
				<div id = "chart_div3" style = "margin : auto"></div>
			</div>
      <div id="review_btn">
        <div id = "white_btn_area">
          <button type="button" id = "temp" onclick="location.href='#'" style = "margin : 5px"class="btns">
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
	<!-- 일정 탭 -->
    <div id = "meeting_date" >
	    <div class="group_info">
	    	<!-- 왼쪽 표 / 우클릭 금지, 드래그 금지 -->				
			  <div id="chart_area" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
				<%@page import = "java.text.SimpleDateFormat" %>
          		<%@page import = "java.util.Calendar" %>
         		<%@page import = "java.util.Date" %>
          		<%
          			String date = "20230101";		//일요일이어야함 -> 값이 변함에 따라 테이블도 변해야 함
          			String[] dates = new String[7];		// 1주일 간 날짜를 저장
          			String[] datesY = new String[7];	// 1주일 간 년을 저장
          			String[] datesM = new String[7];	// 1주일 간 월을 저장
          			String[] datesD = new String[7];	// 1주일 간 일을 저장
          			dates[0] = date;	//String을 배열 첫날에 넣기
          			
          			SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
         			
          			Date date1 = format.parse(date);	//첫날 형식 맞추기
          			
          			Calendar cal = Calendar.getInstance(); 
         	  		cal.setTime(date1);		//첫날 넣기
         			
         				for (int i = 1; i < 7; i ++){	//1주일 동안
         					cal.add(Calendar.DATE, 1);	//하루 더하기
         					Date date2 = cal.getTime();	//저장하기
         					String temp = format.format(date2);	//다음 날 형식 맞추기
         					dates[i] = temp;	//날짜배열에 넣기
         				}
         			
         	  			//날짜배열에 있는 값들을 년/월/일로 나누기
         				for (int i = 0; i < 7; i++){
         					datesY[i] = dates[i].substring(0, 4);
         					datesM[i] = dates[i].substring(4, 6);
         					datesD[i] = dates[i].substring(6, 8);
         				}
         			
          		%>
			<!-- 수정 화면 (처음엔 숨겨짐) -->
          <div id="timeTable" style = "display : None;">
          	<!-- 수정 화면 상단 날짜 이동 영역 -->
          	<div id = "time_table_top" style = "margin : 10px; text-align : center;">						
          		<button type = "button" class = "total_table_left">◀</button>
          		<h2 style = "display : inline;">
          		  <%=datesY[0] %>/<%=datesM[0] %>/<%=datesD[0] %> - <%=datesY[6] %>/<%=datesM[6] %>/<%=datesD[6] %>
          		</h2>	
          		<button type = "button" class = "total_table_right">▶</button>
     			<hr style = "width : 50%; height : 5px; background-color : #F25287; border: 0;">	
          	</div>
          			
          	<br>
          				
          	<table class = "timeTable" border = "1"  bordercolor="#DDDDDD"  width = "100%" height = "100%" cellspacing = "0">
          		
              <thead>
          			<tr align = "center"  style="height: 54px; font-weight: bold;">
          			  <td style="width: 12.5%;">&nbsp;</td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[0] %>/<%=datesD[0] %></span><br>
								    <span style = "font-size : 20px">일</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[1] %>/<%=datesD[1] %></span><br>
								    <span style = "font-size : 20px">월</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[2] %>/<%=datesD[2] %></span><br>
								    <span style = "font-size : 20px">화</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[3] %>/<%=datesD[3] %></span><br>
								    <span style = "font-size : 20px">수</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[4] %>/<%=datesD[4] %></span><br>
								    <span style = "font-size : 20px">목</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[5] %>/<%=datesD[5] %></span><br>
								    <span style = "font-size : 20px">금</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[6] %>/<%=datesD[6] %></span><br>
								    <span style = "font-size : 20px">토</span></td>						
          				</tr>
   	       			</thead>

   	       		  <tbody>        			
          				<% 
          					for (int i = 0; i < 42; i++){
          						int count = 5;
          						count = count + i/2;
          						String spanT = " style = 'color : #F25287'";
          					%>         			
          					<tr align = "center"  style=" font-weight: bold;">	
          					  <%if ((i%2 == 0)){ %>
          						<td rowspan = "2">
          						  <span<%if (count == 12 || count == 24){%><%=spanT %><%} %>>
          						  <%= count%>:00</span>
                      </td>
          					  <%} %>
          						<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol0<%=i%>" onclick = "javascript:tbColorChange('#tbCol0<%=i%>');" alt = "0"></div></td>
								      <td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol1<%=i%>" onclick = "javascript:tbColorChange('#tbCol1<%=i%>');" alt = "0"></div></td>
								      <td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol2<%=i%>" onclick = "javascript:tbColorChange('#tbCol2<%=i%>');" alt = "0"></div></td>
								      <td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol3<%=i%>" onclick = "javascript:tbColorChange('#tbCol3<%=i%>');" alt = "0"></div></td>
								      <td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol4<%=i%>" onclick = "javascript:tbColorChange('#tbCol4<%=i%>');" alt = "0"></div></td>
								      <td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol5<%=i%>" onclick = "javascript:tbColorChange('#tbCol5<%=i%>');" alt = "0"></div></td>
							      	<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol6<%=i%>" onclick = "javascript:tbColorChange('#tbCol6<%=i%>');" alt = "0"></div></td>
          					</tr>
          				<%} %>
          			</tbody>
          			
          	</table>
          	
            <br>
               				
          	<form class = "tableForm" action = "#second_section" method = "GET">
          		<!-- for문으로 색깔이 채워져 있으면 1, 비어있으면 0 해서 기다란 STRING 으로 보낼까? -->
          		<button type = "submit" class = "btns" id = "ScheduleSaveBtn">저장</button>
          		<br>
          	</form>
          </div>
          		
          <div id = "total_table">
          	<div id = "total_table_top" style = "margin : 10px; text-align : center;">
              <button type = "button" class = "total_table_left">◀</button>
          		<h2 style = "display : inline;">
          		  <%=datesY[0] %>/<%=datesM[0] %>/<%=datesD[0] %> - <%=datesY[6] %>/<%=datesM[6] %>/<%=datesD[6] %>
          		</h2>	
          		<button type = "button" class = "total_table_right">▶</button>
     					<hr style = "width : 50%; height : 5px; background-color : #F25287; border: 0;">	
          	</div>
          			
          	<br>
          			
          	<table class = "totalTable" border = "1"  bordercolor="#DDDDDD"  width = "100%" height = "100%" cellspacing = "0">
          		
              <thead>
          			<tr align = "center"  style="height: 54px; font-weight: bold;">
          				<td style="width: 12.5%;">&nbsp;</td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[0] %>/<%=datesD[0] %></span><br>
								    <span style = "font-size : 20px">일</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[1] %>/<%=datesD[1] %></span><br>
								    <span style = "font-size : 20px">월</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[2] %>/<%=datesD[2] %></span><br>
								    <span style = "font-size : 20px">화</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[3] %>/<%=datesD[3] %></span><br>
								    <span style = "font-size : 20px">수</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[4] %>/<%=datesD[4] %></span><br>
								    <span style = "font-size : 20px">목</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[5] %>/<%=datesD[5] %></span><br>
								    <span style = "font-size : 20px">금</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=datesM[6] %>/<%=datesD[6] %></span><br>
								    <span style = "font-size : 20px">토</span></td>										
          			</tr>
   	       		</thead>
   	       				
              <tbody>
          			<% 
          				for (int i = 0; i < 42; i++){
          					int count = 5;
          					count = count + i/2;
          					String spanT = " style = 'color : #F25287'";
          			%>			
          			<tr align = "center"  style="font-weight: bold;">	
          				<%if ((i%2 == 0)){ %>
          				<td rowspan = "2">
          					<span<%if (count == 12 || count == 24){%><%=spanT %><%} %>>
          					<%= count%>:00</span>
                  </td>
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
        
        <div id="Dday_area" >
        	<div id="Dday" style = "display : None" >
          	<a><img class = "editDate" src = "/img/방장용_수정_버튼.svg" /></a>
            <span>D-day</span>
            <span>14</span>
            <span>2022년 12월 31일 (토)</span>
            <span>14:00 - 15:30</span>
          </div>
          <div id="DdayInit" >
          	<a><img class = "editDate" src = "/img/방장용_수정_버튼.svg" /></a>
            <span>D-day가<br>아직 등록되지 않았습니다.</span>
          </div>
          		
          <div id = "Dday_edit" style = "display : None;">
          	<img class = "etc" src = "/img/수정중.svg">
          	<img ID = "endEditDate" src = "/img/엑스.svg">
          	<!-- 이 부분은 최종 결정 난 날짜와 시각을 방장 or 부방장이 수동으로 입력 -->
          	<!-- 편집 표시 자체를 방장들만 볼 수 있게 -->
          	<!-- 이미지버튼으로 캘린더 띄우기 참고 : https://velog.io/@rkio/CSS-input-type-date-캘린더-아이콘-커스텀하기 -->
          	<form action = "#second_section" method = "get" id = "Dday_frm">
          		<br><br>
          		<span><a id = "DdayEditDate">날짜 : 0000-00-00</a>
          			<input type = "date" class = "spanImg" id = "finalDate" placeholder = "" onchange = "changeDate()"/>
          		</span>          	
          		<br><br>
          		<span><a id = "DdayEditTime1">시작 시각 : 00:00</a>
          			<input type = "time" class = "spanImg" id = "finalStartTime" placeholder = "" onchange = "changeTime1()"/>
          		</span>       
            	<br><br>
            	<span><a id = "DdayEditTime2">종료 시각 : 00:00</a>
          			<input type = "time" class = "spanImg" id = "finalEndTime" placeholder = "" onchange = "changeTime2()"/>
            	<br>
            	<input type = "submit" value = "저장" alt = 0; class = "submitBtn" onclick="DdayUpdate()"/>            
          	</form>
          </div>
          <%
          	SimpleDateFormat formatToday = new SimpleDateFormat("yyyy/MM/dd (E)");
			
        	Date dateToday = new Date();
        	String today = formatToday.format(dateToday);
        	
        	Date datePlusWeek = dateToday;
        	cal.setTime(datePlusWeek);
        	cal.add(Calendar.DATE, 6);
        	datePlusWeek = cal.getTime();
        	String todayPlusWeek = formatToday.format(datePlusWeek);
        	
          %>		
          <div id="timeTableDateEdit">
            <div id="update_date">
            	<div id = "updateDateView">
                	<span><a class ="first"><%= today %></a>
							<br>-<br>
							<a class = "second"><%= todayPlusWeek %></a></span>
              		<button class = "updateDateBtn"  onclick = "WpopOpen()">수정</button>
            	</div>
            </div>
            
            <!-- 모달 팝업 -->
			<div class = "week_modal_bg" onclick = "WpopClose()"></div>
			<div class = "week_modal">
				<div style = "position : relative; top : -3px; background : #F25287; width : 100%; height: 50px;">
					<h1 style = "position : relative; font-size : 28px; margin : 3px; top : 3px; text-align : center; color : white;">일정표 날짜 변경</h1>
				</div>
				<div class = "week_modal_content">
					<form action = "#second_section" method = "get" id = "updateWeekForm">
						<span>기간 시작일 : <input type = "date" id = "firstDate" ></span>
						<span>기간 종료일 : <input type = "date"  id = "EndDate" /></span>
						<input type = "submit" value = "저장" onclick = "javasript:changeWeek();" class = "submitBtn"/>
					</form>
				</div>		
  			</div>
            		
            <div id="join_area">
              <p>참여한 사람|</p>
              <div id="join_member">
              <%
              for (int i = 0; i < 2; i++){
              %>
                <li><p>방장쓰</p></li>
              <%
              }
              %>
              </div>
            </div>
            		
          </div>
        </div>
      </div>      
    </div>
	
	  <div id = "meeting_location" style = "display : none;">
		  <div class="group_info">
 <%@ include file="schedule_location.jsp" %></div>
	  </div>
	
	  <div id = "gantt_chart" style = "display : none;">
		  <div class="group_info">		
			  <div id = "ganttCreate">
				  <button id = "ganttCreateBtn"><h1><img src = "/img/plusIcon.svg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;새로운 차트</h1></button>
			  </div>	

			  <div id = "ganttFirstEdit" style = "display : None;">
			  	<div id = "leftGanttFirstEdit">
			  		<div id = "GFEDate">
			  			<h2 style = "display : inline">시작일 : <input type = "date" name = "startDate"/><br>
			  			종료일 : <input type = "date" name = "EndDate"/></h2>
			  		</div>
			  		<div id = "GFEDoIt" >
			  			<h2 style = "margin : 0px; text-align : center">할 일 목록</h2>
			  			<hr style = "border : 3px solid #f25287">
			  			<div id = "DoItContainer">
			  				<ul style = "list-style:none; margin : 0px; padding : 0">
			  					<%
			  					List<String> DoIt = new ArrayList<String>();
			  					DoIt.add("주제 정하기");
			  					DoIt.add("토의하기");
			  					DoIt.add("과자먹기");
			  					DoIt.add("발표 준비하기");
			  					DoIt.add("잠자기");
	  					
			  					List<String>[] DoItDetail = new ArrayList[DoIt.size()];
			  					for (int i =0; i < DoIt.size(); i++){
			  						DoItDetail[i] = new ArrayList<String>();
			  					}
			  					DoItDetail[0].add("하위메뉴 1");
			  					DoItDetail[1].add("하위메뉴 2");
			  					DoItDetail[1].add("하위메뉴 3");
			  					DoItDetail[2].add("하위메뉴 4");
			  					DoItDetail[2].add("하위메뉴 5");
			  					DoItDetail[2].add("하위메뉴 6");
			  					DoItDetail[3].add("하위메뉴 7");
			  					DoItDetail[3].add("하위메뉴 8");
			  					DoItDetail[3].add("하위메뉴 9");
			  					DoItDetail[4].add("하위메뉴 10");
			  					DoItDetail[4].add("하위메뉴 11");
			  					
			  					int count = 0;
			  					for (int i = 0; i < DoIt.size(); i++){
			  						for (int j = 0; j < DoItDetail[i].size(); j++){
			  							count++;
			  						}
			  					}

			  					for (int i = 0; i < DoIt.size(); i++){
			  					%>
			  					
			  						<li>
			  							<div class = "DoItList" >
			  								<input type = "checkbox" class = "DoItCheck" id = "DoItCheck<%=i%>" alt = "0" onclick = "openDoItList('<%=i%>')">
			  								<label for = "DoItCheck<%=i%>"></label>&nbsp;<%= DoIt.get(i) %>
			  								<img src = "/img/방장용_수정_버튼.svg" class ="DoItListEditBtn" onclick = "DpopOpen('<%=DoIt.get(i) %>', '<%=DoItDetail[i]%>')"/>
			  								<button type = "button" class = "deleteBtn" onclick="deleteBtn('<%=i%>')">✕</button>
			  							</div>
			  							<div>
			  								<ul class = "DoItListChild" id = "DoItListChild<%=i%>" style = "display : None; ">
			  									<% for (int j = 0; j < DoItDetail[i].size(); j++){ %>
			  									<li>
			  										<div class = "DoItListItem" >
			  											&nbsp;&nbsp;<%=DoItDetail[i].get(j) %>
			  										</div>
			  									</li>
			  									<% } %>
			  								</ul>
			  							</div>
			  						</li>
			  					<%} %>
			  				</ul>	
			  			</div>	  		
			  			<div style = "display : flex; margin-top : 20px;">
			  				<input type = "text" placeholder = "  새 작업 추가하기" name = "newValue"/>
			  				<button name = "newValueBtn" class = "newValueBtn">+</button>
			  			</div>
			  		</div>
			  	</div>
			  	<div id = "rightGanttFirstEdit">
			  		<div id = "chart_div1_container">
			  		<br>
			  		<h2 style = "text-align : center">차트 미리보기</h2>
			  			<div id="chart_div1" ></div>
			  		</div>
			  		<div id = "GFESubmitBtn" >
						<button id = "ganttFirstEditCancelBtn">취소</button>
						<button id = "ganttFirstEditSaveBtn" type = "submit">저장</button>				
			  		</div>
			  	</div>
			  	<div id = "rightEditPage" >
			  		
			  	</div>
			  </div>

			  <div id = "ganttResult" style = "display:None">
			    <!-- 
			    <div class = "loader">
				    <div class = "loaderIcon"></div>
			    </div>
			    -->
			    <div style = "display : flex; height : 100%;">
			    	<div id = "GRleft">
			    		<div id = "GRDoIt" >
			  				<h2 style = "margin : 0px; text-align : center">할 일 목록</h2>
			  				<hr style = "border : 3px solid #f25287">
			  				<div id = "GRDoItContainer">
			  					<ul style = "list-style:none; margin : 0px; padding : 0">
			  						<%
			  							for (int i = 0; i < DoIt.size(); i++){
			  						%>					
			  							<li>
			  								<div class = "DoItList"  style = "background : #f25287; color : white;">
			  									<input type = "checkbox" class = "DoItCheck" id = "DoItCheck2<%=i%>" alt = "0" onclick = "openDoItList('2<%=i%>')">
			  									<label for = "DoItCheck2<%=i%>"></label>&nbsp;<%= DoIt.get(i) %>
			  								</div>
			  								<div>
			  									<ul class = "DoItListChild" id = "DoItListChild2<%=i%>" style = "display : None;">
			  										<% for (int j = 0; j < DoItDetail[i].size(); j++){ %>
			  											<li>
			  												<input type = "checkbox"  class = "DoItCheck3" id = "DoItCheck3<%=i%><%=j%>" alt = "0" onclick = "GRchecked('<%=i%><%=j%>', <%=count%>)">
			  												<label for = "DoItCheck3<%=i%><%=j%>"></label>
			  												<div class = "DoItListItem" >
			  													<span style = "margin-left : 10px;"><%=DoItDetail[i].get(j) %></span>
			  												</div>
			  											</li>
			  										<% } %>
			  									</ul>
			  								</div>
			  							</li>
			  						<%} %>
			  					</ul>	
			  				</div>	  		
			  				<div style = " margin-top : 20px;">
			  					<h1>프로젝트 진행도 : <span style = "color : #f25287" id = "percentage">00.0</span>%</h1>
								<h2 style = "color : #f25287; font-family : '코트라'" id = "fighting">천리 길도 한 걸음부터!</h2>
			  				</div>
			  			</div>
			  		</div>
			    	<div id = "ganttResultContainer">
			    		<br>
			    		<h2 style = "margin : 0px; margin-top : 2px; text-align : center">그룹 차트</h2>
			  			<hr style = "border : 3px solid #f25287; width : 90%">
				  		<div id = "chart_div2_container" style = "border : None; width : 97%; height : 65%; background : #f9f3f3; margin-top : 0px">
					  		<br>
					  		<div id="chart_div2"></div>
				  		</div>
				  		<div id = "GRubmitBtn">
				  			<button id = "ganttInitBtn">초기화</button>
				  			<button id = "ganttResultEditBtn">수정</button>
				  		</div>
				  	</div>
				  </div>
			  </div>			
		  </div>			
	  </div>
	  	
	 <script>
	 var cnt = 0;
	//간트 결과 체크박스 이벤트
	function GRchecked(element, count){
		var temp1 = "#DoItCheck3"+element;
		var item = $(temp1).parent();
		var text = item.children('.DoItListItem');
		
		if($(temp1).attr("alt") == "0"){
			text.css({
				"color": "#D9D9D9",
				"text-decoration" : "line-through"
			});
			cnt++;
			$(temp1).attr("alt" , "1");
		}else{
			text.css({
				"color": "black",
				"text-decoration" : "None"
			});
			cnt--;
			$(temp1).attr("alt",  "0");
		}
		var result = (cnt/count)*100;
		result = result.toFixed(1);
		$("#percentage").text(result);
		
		var fight = "천리 길도 한 걸음부터!";

		if (0 < result && result < 20){
			fight = "차근차근 쌓아가보아요";
		}else if (20<= result && result < 40){
			fight = "잘하고 있어요! 이대로만 해봐요";
		}else if (40<= result && result < 60){
			fight = "목표에 점점 가까워지고 있어요";
		}else if (60<= result && result < 80){
			fight = "노력은 배신하지 않는다고 해요";
		}else if (80<= result && result < 100){
			fight = "거의 다 왔어요! 조금만 더 힘내요";
		}else if (100 == result){
			fight = "훌륭해요! 뛰어난 성과를 자랑해봐요";
		}
		$("#fighting").text(fight);
	}
	
	/*구글 차트 api*/
	google.charts.load('current', {'packages':['gantt']});
	google.charts.setOnLoadCallback(drawChart);
			  				    
	function daysToMilliseconds(days) {
		return days * 24 * 60 * 60 * 1000;
	}
			  				  
	var valueName = [];
	var valueSDate = [];
	var valueEDate = [];
	var valueDur = [];
	var valuePC = [];
	<%
  	for (int t = 0; t < DoIt.size(); t++){
  	%>
  		valueName.push('<%=DoIt.get(t)%>');
	    valueSDate.push(null);
	    valueEDate.push(new Date(2023, 8));
	    valueDur.push(null);
	    valuePC.push(0);
	<%}%>
	function drawChart() {

	      var data = new google.visualization.DataTable();
	      data.addColumn('string', 'Task ID');
	      data.addColumn('string', 'Task Name');
	      data.addColumn('date', 'Start Date');
	      data.addColumn('date', 'End Date');
	      data.addColumn('number', 'Duration');
	      data.addColumn('number', 'Percent Complete');
	      data.addColumn('string', 'Dependencies'); 
	      
	      for (var i = 0; i < valueName.length; i ++){
			  var index = i+"";
	      	data.addRow([
	        	index, valueName.at(i), valueSDate.at(i), valueEDate.at(i),
	      		valueDur.at(i), valuePC.at(i), null
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
	      var chart3 = new google.visualization.Gantt(document.getElementById('chart_div3'));

		
	      chart1.draw(data, options2);
	      chart2.draw(data, options);
	      chart3.draw(data, options);
	    }
	</script>
	<script>
	$(document).ready(function () {
	 	/* 간트 차트 */
	  	$("#ganttCreateBtn").click(function(){
	  		drawChart();
			$("#ganttFirstEdit").show();
			$("#ganttFirstEdit").css({
				"display" : "flex"
			});
			$("#ganttCreate").hide();
		})
	  	$("#ganttFirstEditCancelBtn").click(function(){
	  		drawChart();
			$("#ganttCreate").show();
			$("#ganttFirstEdit").hide();
		})	
	  	$("#ganttFirstEditSaveBtn").click(function(){
	  		drawChart();
			$("#ganttResult").show();
			$("#ganttFirstEdit").hide();
		})	
		$("#ganttResultEditBtn").click(function(){
			drawChart();
			$("#ganttFirstEdit").show();
			$("#ganttFirstEdit").css({
				"display" : "flex"
			});
			$("#ganttResult").hide();
		})
	 });
	</script>
	  <div id = "group_detail" style = "display : none;">
		  <div class="group_info">
			<div class = "group_information" style = "display : flex; margin : auto; background : white; width : 95%; height : 90%">
				<div style= " display : flex;  margin : auto; width : 90%; height : 80%">
					<div id = "group_detail_left" >
						<h1>감자 프로젝트 그룹</h1>
						<h3>개설자 : 방장쓰</h3>
						<h3></h3>
						
						<img src = "/img/user_logo.png" style = "width : 100px; height : 100px; border-radius : 50%;">
						<img src = "/img/액자.png" style = "position : absolute; width : 150px; height : 150px; top : 400px"/>
					</div>
					<div id = "group_detail_right" >
						<img src = "/img/twocat.png" style = "position : absolute; width : 200px; height : 200px; bottom : 110px; right: 120px; z-index:0; opacity : 0.3;">
						<br><br>
						<div>
							<h2>개설일 <span>|</span> </h2>
							<p>${groupCreateTime}</p>
							<h2>종료일 <span>|</span> </h2>
							<p>${ProjectEndTime}</p>
						</div>
						<br><br>
						<h2>그룹 설명 <span>|</span> </h2>
						<p style = "color : black">${groupDescription}</p>
					</div>
				</div>
			</div>
		</div>
	  </div>	
	  
	  <!-- 모달 팝업 -->
				<div class = "DoIt_modal_bg" onclick = "DpopClose()"></div>
					<div class = "DoIt_modal">
						<div style = "position : relative; top : -3px; background : #F25287; width : 100%; height: 50px;">
							<h1 style = "position : relative; font-size : 28px; margin : 3px; top : 3px; text-align : center; color : white;" class="modalDoItName">오류가 발생했습니다</h1>
						</div>
					<div class = "DoIt_modal_content" >
						<form action = "#second_section" method = "get" id = "updateDoItForm">
							<div style = "display : flex;">
								<div id = "DoItChildDate" style = "margin : 10px">
			  						<h2 style = "display : inline"> Task 시작일 : <br><input type = "date" name = "startDate"/><br><br>
			  							Task 종료일 : <br><input type = "date" name = "EndDate"/></h2> <br>
			  						<input type = "text" placeholder = "  새 작업 추가하기" name = "newValue"/>
			  						<button name = "newValueBtn" class = "newValueBtn" style = "width : 40px; height : 40px; font-size : 25px;">+</button>
			  					</div>
			  					<div id = "DoItChildList">
			  						<div class = "DoItListChild" >
			  							<ul id = "DoItListChild">
			  							
			  							</ul>
			  						</div>
			  					</div>
			  				</div>
							<input type = "submit" value = "저장" onclick = "" class = "submitBtn"  style = "left : 42%; margin-top : 10px;"/>
						</form>
					</div>		
  				</div>
			  </div>
  </div>	
  
  
	<!-- footer -->
	
	<div>
		<%@ include file="../footer.jsp" %>
	</div>
</div>
</body>
</html>