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
<c:choose>
<c:when test = "${session_id == null }">
	<script>
	alert("로그인이 필요한 페이지입니다.");
	location.href = "/meeting/test";		//나중에 로그인 페이지로 수정
	</script>
</c:when>
<c:otherwise>

<div class = "schedule_page">

	<!--헤더 -->
	<%@ include file="../header.jsp" %>
	<!-- 맴버 리스트 -->
	<div class = "member_list">
		<%
			String[] allMemberId = (String[])request.getAttribute("groupAllUsersId");
			int MemberCnt = allMemberId.length;
		%>
		<!-- 맴버 리스트 제목  -->
		<div class = "member_list_title">
			<h2>맴버 목록 (<%=MemberCnt %>)</h2>
		</div>
		<!-- 맴버 리스트 -->
		<div class = "member_list_content">
			<ul class = memberList>
			<%
			//유저 아이디
			String userId = (String)request.getAttribute("userId");
			//그룹 아이디
			String groupId = (String)request.getAttribute("groupId");
			//방장 맴버
			String[] HostId = (String[])request.getAttribute("groupHostUserId");
			String[] HostName = (String[])request.getAttribute("groupHostUserName");
			String[] HostAddress = (String[])request.getAttribute("groupHostUserAddress");
			String[] HostPhone = (String[])request.getAttribute("groupHostUserPhone");
			String[] HostEmail = (String[])request.getAttribute("groupHostUserEmail");
			String[] HostProfileUrl = (String[])request.getAttribute("groupHostUserProfileUrl");
			//부방장 맴버
			String[] SubHostId = (String[])request.getAttribute("groupSubHostUsersId");
			String[] SubHostName = (String[])request.getAttribute("groupSubHostUsersName");
			String[] SubHostAddress = (String[])request.getAttribute("groupSubHostUsersAddress");
			String[] SubHostPhone = (String[])request.getAttribute("groupSubHostUsersPhone");
			String[] SubHostEmail = (String[])request.getAttribute("groupSubHostUsersEmail");
			String[] SubHostProfileUrl = (String[])request.getAttribute("groupSubHostUsersProfileUrl");
			//일반 맴버
			String[] memberId = (String[])request.getAttribute("groupMemberUsersId");
			String[] memberName = (String[])request.getAttribute("groupMemberUsersName");
			String[] memberAddress = (String[])request.getAttribute("groupMemberUsersAddress");
			String[] memberPhone = (String[])request.getAttribute("groupMemberUsersPhone");
			String[] memberEmail = (String[])request.getAttribute("groupMemberUsersEmail");
			String[] memberProfileUrl = (String[])request.getAttribute("groupMemberUsersProfileUrl");
			
			//방장>부방장>맴버 순으로 정렬
			List<String> membersId = new ArrayList<String>();
			List<String> membersName = new ArrayList<String>();
			List<String> membersAddress = new ArrayList<String>();
			List<String> membersPhone = new ArrayList<String>();
			List<String> membersEmail = new ArrayList<String>();
			List<String> membersProfileUrl = new ArrayList<String>();
			
			for (int i = 0; i < HostName.length; i++){
				membersId.add(HostId[i]);
				membersName.add(HostName[i]);
				membersAddress.add(HostAddress[i]);
				membersPhone.add(HostPhone[i]);
				membersEmail.add(HostEmail[i]);
				membersProfileUrl.add(HostProfileUrl[i]);
			}
			for (int i = 0; i < SubHostName.length; i++){
				membersId.add(SubHostId[i]);
				membersName.add(SubHostName[i]);
				membersAddress.add(SubHostAddress[i]);
				membersPhone.add(SubHostPhone[i]);
				membersEmail.add(SubHostEmail[i]);
				membersProfileUrl.add(SubHostProfileUrl[i]);
			}
			for (int i = 0; i < memberName.length; i++){
				membersId.add(memberId[i]);
				membersName.add(memberName[i]);
				membersAddress.add(memberAddress[i]);
				membersPhone.add(memberPhone[i]);
				membersEmail.add(memberEmail[i]);
				membersProfileUrl.add(memberProfileUrl[i]);
			}
			
			//출력
			for(int i = 0; i < membersName.size(); i++){
				String Img = "/img/방장표시.svg";
				int host = 0;
				int subhost = 0;
				if (i == 0){ 	//첫 번째 자리면 방장
					host = 1;
				}
				if (0 < i && i <= SubHostName.length){ 
					subhost = 1;
					Img = "/img/부방장표시.svg";
				}
			%>
				<li>
				  <!-- 모달 팝업 열기-->

				  <a href="#" class = "user_open" 
				  onclick="javascript:popOpen('<%= membersId.get(i)%>', '<%= membersName.get(i)%>', '<%= membersAddress.get(i)%>', '<%= membersPhone.get(i)%>', '<%= membersEmail.get(i)%>', '<%= membersProfileUrl.get(i)%>', '<%=host %>', '<%=subhost %>' ); " >
				
				    <div class = "member">				
					    <!-- 유저 프로필 이미지 설정 -->
					    <div class = "Uimage">
						    <img src = "<%= membersProfileUrl.get(i) %>" 
							    onError = "<%= userImgErr %>" 
							    alt = "유저 프로필 이미지" class = "userProfile">
					    </div>
					    
					    <div class = "text">
               				 <!-- 유저 이름 설정-->
						    <h2><%= membersName.get(i) %></h2>
						
					      <!-- 방장 및 부방장 설정-->	
						    <%if(host == 1 || subhost == 1){ %>
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
					
					
					<form id = "SubHostForm" action= "/schedule/${groupId}/update" method = "POST">
						<input type = "text" name = "userId" value = "${session_id}" style = "display : None"/>
						<input type = "text" name = "subHost" value = "0"  style = "display : None">
						<button type = "submit" class = "SubHostBtn1" >부방장 등록</button>
						<button type = "submit" class = "SubHostBtn2" >부방장 해제</button>
					</form>
					
		  <div class = "profileText" style = "overflow : hidden; white-space:nowrap; text-overflow : ellipsis;">
		    <br><br><br><h1 class = "modalUserName"> 정보를 불러올 수 없습니다.</h1>
		    <br><span>@doremiAccount</span><br><br>
		    <div style = "font-size : 20px; overflow : hidden; white-space:nowrap; text-overflow : ellipsis;">
			    <span><b>주소 |</b><a> 도레시 미파구 솔라동 시도레 마을</a></span> <br>
			    <span><b>전화번호 |</b><a> 010-1234-5678</a></span> <br>
			    <span><b>이메일 |</b><a> doremi@gmail.com</a></span> <br>
		    </div>
		  </div>
		</div>		
  </div>
	
	<!-- 그룹 정보 -->
	<div id="section_two">
    <p class="main_header">${groupName}</p>
        
    <div id="section_two_right">
			<div id="review_area" >
				<%@ include file="schedule_chat.jsp"%>
			</div>
      <div id="review_btn">
        <form action = "/schedule/deleteGroupUser" method ="GET"  onsubmit="return deleteGroupUser()">
        	<input type = "text" style = "display:None" name = "groupId" value = "${groupId}"/>
        	<input type = "text" style = "display:None" name = "userId" value = "${userId}"/>
        	<button type="submit" id="delete_btn">그룹 탈퇴</button>
        </form>
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
	    	<div class = "loader" style = "">
				    <div class = "loaderIcon"></div>
			    </div>
	    	<!-- 왼쪽 표 / 우클릭 금지, 드래그 금지 -->				
			  <div id="chart_area" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
				<%@page import = "java.text.SimpleDateFormat" %>
          		<%@page import = "java.util.Calendar" %>
         		<%@page import = "java.util.Date" %>
          		<%
          		
          			
          			int slideMax = 1;	//슬라이드 개수
         			if (request.getAttribute("tableListCnt") != null){
              			slideMax = (int)request.getAttribute("tableListCnt");
              		}
          			
          			Date tempDate = new Date();
          			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
          			Calendar tempCal = Calendar.getInstance();
          			tempCal.setTime(tempDate);
          			tempCal.add(Calendar.DATE, 6);
         			String[] tableListStart = {format.format(tempDate)};
         			String[] tableListLast = {format.format(tempCal.getTime())};
	
          		%>

			<!-- 수정 화면 (처음엔 숨겨짐) -->
          <div id="timeTable" style = "display : None;">	
          	<div id = "tableSlide2" style = "width :100%">               
          	<ul>         	
          	<%
          	tableListStart = (String[])request.getAttribute("tableListStart");
          	tableListLast = (String[])request.getAttribute("tableListLast");
          	Calendar tableCal = Calendar.getInstance();
          	SimpleDateFormat tempTableDateFormat = new SimpleDateFormat("MM/dd");
      		String [] topDates = new String[7];
      		
      		int[][] SundayList2 = (int[][])request.getAttribute("SundayList2");
  			int[][] MondayList2 = (int[][])request.getAttribute("MondayList2");
  			int[][] TuesdayList2 = (int[][])request.getAttribute("TuesdayList2");
  			int[][] WednesdayList2 = (int[][])request.getAttribute("WednesdayList2");
  			int[][] ThusdayList2 = (int[][])request.getAttribute("ThusdayList2");
  			int[][] FridayList2 = (int[][])request.getAttribute("FridayList2");
  			int[][] SaturdayList2 = (int[][])request.getAttribute("SaturdayList2");
  			
          	for (int index = 0; index < slideMax; index++){ 
          		String[] tempTableDate = tableListStart[index].split("/");
          		tableCal.set(Integer.parseInt(tempTableDate[0]), Integer.parseInt(tempTableDate[1])-1, Integer.parseInt(tempTableDate[2]));
          		
          		for (int k = 0; k < 7; k ++){
          			topDates[k] = tempTableDateFormat.format(tableCal.getTime());
          			tableCal.add(Calendar.DATE , 1);
          		}
          	%>
          	<li>		
          		<!-- 수정 화면 상단 날짜 이동 영역 -->
          	<div class = "time_table_top" style = "margin : 10px; text-align : center;">						
          		<button type = "button" class = "total_table_left"  onclick = "slideTable(<%=slideMax %>, 0)" >◀</button>
          		<h2 style = "display : inline;">
          		  <span class = "tableStartDate"><%= tableListStart[index] %></span> -  <span class = "tableEndDate"><%= tableListLast[index] %></span>
          		</h2>	
          		<button type = "button" class = "total_table_right" onclick = "slideTable(<%=slideMax %>, 1)">▶</button>
     			<hr style = "width : 50%; height : 5px; background-color : #F25287; border: 0;">	
          	</div>
          			
          	<br><br><br>
          			
          	<table class = "timeTable" border = "1"  bordercolor="#DDDDDD"  width = "100%" height = "100%" cellspacing = "0">
          		
              <thead>
          			<tr align = "center"  style="height: 54px; font-weight: bold;">
          			  <td style="width: 12.5%;">&nbsp;</td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[0] %></span><br>
								    <span style = "font-size : 20px">일</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[1] %></span><br>
								    <span style = "font-size : 20px">월</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[2] %></span><br>
								    <span style = "font-size : 20px">화</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[3] %></span><br>
								    <span style = "font-size : 20px">수</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[4] %></span><br>
								    <span style = "font-size : 20px">목</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[5] %></span><br>
								    <span style = "font-size : 20px">금</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[6] %></span><br>
								    <span style = "font-size : 20px">토</span></td>						
          				</tr>
   	       			</thead>

   	       		  <tbody>        			
          				<% 
          					for (int i = 0; i < 42; i++){
          						int count = 5;
          						count = count + i/2;
          						String spanT = " style = 'color : #F25287'";
          						String tbId = ""+ i+ index;
          					%>         			
          					<tr align = "center"  style=" font-weight: bold;">	
          					  <%if ((i%2 == 0)){ %>
          						<td rowspan = "2">
          						  <span<%if (count == 12 || count == 24){%><%=spanT %><%} %>>
          						  <%= count%>:00</span>
                      </td>
          					  <%} %>
          								<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol0<%=tbId%>"  
          								data-color = "0" data-count = <%=SundayList2[index][i] %>></div></td>
								      	<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol1<%=tbId %>" 
								      	data-color = "0" data-count =  <%=MondayList2[index][i] %>></div></td>
								      	<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol2<%=tbId %>" 
								      	data-color = "0" data-count =  <%=TuesdayList2[index][i] %>></div></td>
								      	<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol3<%=tbId %>"  
          								data-color = "0" data-count =  <%=WednesdayList2[index][i] %>></div></td>
								      	<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol4<%=tbId %>" 
								      	data-color = "0" data-count =  <%=ThusdayList2[index][i] %>></div></td>
								      	<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol5<%=tbId %>" 
								      	data-color = "0" data-count =  <%=FridayList2[index][i] %>></div></td>
							      		<td style="width: 12.5%;"><div  class = "tdCol" id = "tbCol6<%=tbId %>" 
							      		data-color = "0" data-count =  <%=SaturdayList2[index][i] %>></div></td>
          					</tr>
          				<%} %>
          			</tbody>          			
          		</table>
          		</li>	
          	<%} %>
          	</ul>
          	</div>
          	
            <br>    				
          	<form class = "tableForm" action = "/schedule/${groupId}/updateUserTable" method = "GET">
          		<!-- 42 * 7개의 데이터를 slideMax개수 만큼 저장 -->
          		<input type = "text" style = "display : None" value = ""  name = "code" id = "tableFormResult">
          		<input type = "text" style = "display : None" value = ""  name = "code" id = "tableFormResult">
          		<button type = "submit" class = "btns" id = "ScheduleSaveBtn"  onclick = "ScheduleSaveBtnClick(<%= slideMax%>)">저장</button>
          		<br>
          	</form>
          </div>
          
          <!-- 전체 회원 테이블  -->	
          <div id = "total_table">     	
          	<div id = "tableSlide" style = "width :100%">
                
          	<ul>         	
          	<%
          	tableListStart = (String[])request.getAttribute("tableListStart");
          	tableListLast = (String[])request.getAttribute("tableListLast");
          	
          	int[][] SundayList = (int[][])request.getAttribute("SundayList");
  			int[][] MondayList = (int[][])request.getAttribute("MondayList");
  			int[][] TuesdayList = (int[][])request.getAttribute("TuesdayList");
  			int[][] WednesdayList = (int[][])request.getAttribute("WednesdayList");
  			int[][] ThusdayList = (int[][])request.getAttribute("ThusdayList");
  			int[][] FridayList = (int[][])request.getAttribute("FridayList");
  			int[][] SaturdayList = (int[][])request.getAttribute("SaturdayList");
          	
          	for (int index = 0; index < slideMax; index++){ 
          		String[] tempTableDate = tableListStart[index].split("/");
          		tableCal.set(Integer.parseInt(tempTableDate[0]), Integer.parseInt(tempTableDate[1])-1, Integer.parseInt(tempTableDate[2]));
          		for (int k = 0; k < 7; k ++){
          			topDates[k] = tempTableDateFormat.format(tableCal.getTime());
          			tableCal.add(Calendar.DATE , 1);
          		}
          	%>
          	<li>		
          		<!-- 수정 화면 상단 날짜 이동 영역 -->
          	<div class = "total_table_top" style = "margin : 10px; text-align : center;">						
          		<button type = "button" class = "total_table_left"  onclick = "slideTable(<%=slideMax %>, 0)" >◀</button>
          		<h2 style = "display : inline;">
          		  <span class = "tableStartDate"><%= tableListStart[index] %></span> -  <span class = "tableEndDate"><%= tableListLast[index] %></span>
          		</h2>	
          		<button type = "button" class = "total_table_right" onclick = "slideTable(<%=slideMax %>, 1)">▶</button>
     			<hr style = "width : 50%; height : 5px; background-color : #F25287; border: 0;">	
          	</div>
          			
          	<br><br><br>
          	<table class = "totalTable" border = "1"  bordercolor="#DDDDDD"  width = "100%" height = "100%" cellspacing = "0">          		
              <thead>
          			<tr align = "center"  style="height: 54px; font-weight: bold;">
          				<td style="width: 12.5%;">&nbsp;</td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[0] %></span><br>
								    <span style = "font-size : 20px">일</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[1] %></span><br>
								    <span style = "font-size : 20px">월</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[2] %></span><br>
								    <span style = "font-size : 20px">화</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[3] %></span><br>
								    <span style = "font-size : 20px">수</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[4] %></span><br>
								    <span style = "font-size : 20px">목</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[5] %></span><br>
								    <span style = "font-size : 20px">금</span></td>
							    <td style="width: 12.5%;"><span style = "color : #F25287;"><%=topDates[6] %></span><br>
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
								  <td style="width: 12.5%;" class= "totalCol" data-count = <%=SundayList[index][i] %>>&nbsp;</td>
								  <td style="width: 12.5%;" class= "totalCol" data-count = <%=MondayList[index][i] %>>&nbsp;</td>
								  <td style="width: 12.5%;" class= "totalCol" data-count = <%=TuesdayList[index][i] %>>&nbsp;</td>
								  <td style="width: 12.5%;" class= "totalCol" data-count = <%=WednesdayList[index][i] %>>&nbsp;</td>
								  <td style="width: 12.5%;" class= "totalCol" data-count = <%=ThusdayList[index][i] %>>&nbsp;</td>
								  <td style="width: 12.5%;" class= "totalCol" data-count = <%=FridayList[index][i] %>>&nbsp;</td>
								  <td style="width: 12.5%;" class= "totalCol" data-count = <%=SaturdayList[index][i] %>>&nbsp;</td>
          		  </tr>
          		  <%} %>
          	  </tbody>   			
          	</table>
          	</li>	
			<%} %>
          	</ul>
          	</div>
          	
            <br>
            <button type = "button" class = "btns" id = "ScheduleEditBtn">수정</button>
            
            <br>

          </div>
        </div>
        
        <!-- 디데이 입력  -->
        <div id="Dday_area" >
        	<div id="Dday" style = "display : None" >
          		<a><img class = "editDate" style = "display : None" src = "/img/방장용_수정_버튼.svg" /></a>
            	<span>D-day</span>
            	<span>${finalScheduleList[3]}</span>
           	 	<span>${finalScheduleList[0]}</span>
            	<span>${finalScheduleList[1]} - ${finalScheduleList[2]}</span>
          </div>
          <div id="DdayInit" >
          	<a><img class = "editDate" style = "display : None" src = "/img/방장용_수정_버튼.svg" /></a>
            <span>D-day가<br>아직 등록되지 않았습니다.</span>
          </div>
          		
          <div id = "Dday_edit" style = "display : None;">
          	<img class = "etc" src = "/img/수정중.svg">
          	<img ID = "endEditDate" src = "/img/엑스.svg">
          	<!-- 이 부분은 최종 결정 난 날짜와 시각을 방장 or 부방장이 수동으로 입력 -->
          	<!-- 편집 표시 자체를 방장들만 볼 수 있게 -->
          	<!-- 이미지버튼으로 캘린더 띄우기 참고 : https://velog.io/@rkio/CSS-input-type-date-캘린더-아이콘-커스텀하기 -->
          	<form action = "/schedule/${groupId}/updateDday#second_section" method = "POST" id = "Dday_frm" onsubmit = "return DdayError()">
          		<br><br>
          		<span><a id = "DdayEditDate">날짜 : 0000-00-00</a>
          			<input type = "date" name = "date" class = "spanImg" id = "finalDate" placeholder = "" onchange = "changeDate()"/>
          		</span>          	
          		<br><br>
          		<span><a id = "DdayEditTime1">시작 시각 : 00:00</a>
          			<input type = "time" name = "start" class = "spanImg" id = "finalStartTime" placeholder = "" onchange = "changeTime1()"/>
          		</span>       
            	<br><br>
            	<span><a id = "DdayEditTime2">종료 시각 : 00:00</a>
          			<input type = "time" name = "end" class = "spanImg" id = "finalEndTime" placeholder = "" onchange = "changeTime2()"/>
            	<br>
            	<input type = "submit" value = "저장" class = "submitBtn"/>            
          	</form>
          </div>
          <%
          
           Calendar cal = Calendar.getInstance();
          	SimpleDateFormat formatToday = new SimpleDateFormat("yyyy/MM/dd (E)");
			
        	Date dateToday = new Date();
        	String today = formatToday.format(dateToday);
        	
        	Date datePlusWeek = dateToday;
        	cal.setTime(datePlusWeek);
        	cal.add(Calendar.DATE, 6);
        	datePlusWeek = cal.getTime();
        	String todayPlusWeek = formatToday.format(datePlusWeek);
        	
        	if (request.getAttribute("startDate") != null){
              	String startDatestr = (String)request.getAttribute("startDate");
              	String endDatestr = (String)request.getAttribute("endDate");

              	SimpleDateFormat formatStr = new SimpleDateFormat("yyyy-MM-dd");
              	
              	today = formatToday.format(formatStr.parse(startDatestr));	
              	todayPlusWeek = formatToday.format(formatStr.parse(endDatestr));
              }
        	
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
				
					<form action = "/schedule/${groupId}/tableUpdate" method = "post" id = "updateWeekForm" onsubmit = "return changeWeek('<%= today %>');" >
						<span>기간 시작일 : <input type = "date" name = "start" id = "firstDate" ></span>
						<span>기간 종료일 : <input type = "date"  name = "end" id = "EndDate" /></span>
						<input type = "text" style = "display : None" name = "data" id = "updateTableData" value = ""/>
						<input type = "submit" value = "저장"  class = "submitBtn"/>
					</form>
					
				</div>		
  			</div>
            		
            <div id="join_area">
              <p>참여한 사람|</p>
              <div id="join_member">
              <%
              String [] groupSetScheduleUsersName = (String[])request.getAttribute("groupSetScheduleUsersName");
              int ssuCnt = groupSetScheduleUsersName.length;
              
              for (int i = 0; i < ssuCnt; i++){
              %>
                <li><p><%=groupSetScheduleUsersName[i] %></p></li>
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
				  <button id = "ganttCreateBtn" style = "display : None"><h1><img src = "/img/plusIcon.svg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;새로운 차트</h1></button>
			  	<h1 style = "position : relative; text-align : center; top : 300px; font-size : 50px"><span style = "color : #f25287">아</span>직 차트가 등록되지 않았습니다.</h1>
			  </div>	

			  <div id = "ganttFirstEdit" style = "display : None;">
			  	<div id = "leftGanttFirstEdit">
			  		<div id = "GFEDoIt" >
			  			<h2 style = "margin : 0px; text-align : center">할 일 목록</h2>
			  			<hr style = "border : 3px solid #f25287">
			  			<div id = "DoItContainer">
			  				<div id = "ajaxContainer">
			  				<ul style = "list-style:none; margin : 0px; padding : 0">
			  					<%
			  					
								int DoItCnt = 0;
			  					if (request.getAttribute("DoItCnt") != null){
			  						DoItCnt = (int)request.getAttribute("DoItCnt");
			  					}
			  					
			  					List<String> DoIt = new ArrayList<String>();
			  					if(request.getAttribute("DoIt") != null){
			  						DoIt = (List<String>)request.getAttribute("DoIt");
			  					}
			  					
			  					List<String>[] DoItDetail = new ArrayList[DoIt.size()];
			  					if(request.getAttribute("DoItDetail") != null){
			  						DoItDetail = (List<String>[])request.getAttribute("DoItDetail");
			  					}
			  					
			  					List<Integer>[] checkListOne = new ArrayList[DoIt.size()];
			  					if(request.getAttribute("checkListOne") != null){
			  						checkListOne = (List<Integer>[])request.getAttribute("checkListOne");
			  					}
			  					
			  					int count = 0;
			  					for (int i = 0; i < DoIt.size(); i++){
			  						for (int j = 0; j < DoItDetail[i].size(); j++){
			  							count++;
			  						}
			  					}

			  					for (int i = 0; i < DoItCnt; i++){
			  					%>
			  					
			  						<li>
			  							<div class = "DoItList" >
			  								<input type = "checkbox" class = "DoItCheck" id = "DoItCheck<%=i%>" alt = "0" onclick = "openDoItList('<%=i%>')">
			  								<label for = "DoItCheck<%=i%>"></label>&nbsp;<%= DoIt.get(i) %>
			  								<img src = "/img/방장용_수정_버튼.svg" class ="DoItListEditBtn" onclick = "DpopOpen(<%= i %>,'<%=DoIt.get(i) %>', '<%=DoItDetail[i]%>')"/>
			  								<button type = "button" class = "deleteBtn" onclick="deleteBtn('<%=i%>', '<%=DoItCnt%>', '${groupId }')">✕</button>
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
			  			</div>	  		
			  			<div id = "GanttEditValueBox" style = "display : flex; margin-top : 20px;">
			  				<input type = "text" placeholder = "  새 작업 추가하기" class = "newValue"/>
			  				<button class = "newValueBtn">+</button>
			  			</div>
			  		</div>
			  	</div>
			  	<div id = "rightGanttFirstEdit">
			  		<div id = "chart_div1_container">
			  		<br>
			  		<h2 style = "text-align : center">차트 미리보기</h2>
			  			<!-- <button id = "RefreshBtn" >새로고침</button>  -->
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
			   
			    <div style = "display : flex; height : 100%;">
			    	<div id = "GRleft">
			    		<div id = "GRDoIt" >
			  				<h2 style = "margin : 0px; text-align : center">할 일 목록</h2>
			  				<hr style = "border : 3px solid #f25287">
			  				<div id = "GRDoItContainer">
			  					<div id = "GRAjax">
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
			  												<input type = "checkbox"  class = "DoItCheck3" id = "DoItCheck3<%=i%><%=j%>" data-check = "<%=checkListOne[i].get(j) %>" onclick = "GRchecked('<%=i%>','<%=j%>', <%=count%>)">
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
				  		<div id = "GRubmitBtn" >
				  			<button id = "ganttInitBtn"  style = "display : None">초기화</button>
				  			<button id = "ganttResultEditBtn" style = "display : None">수정</button>
				  		</div>
				  	</div>
				  </div>
			  </div>			
		  </div>			
	  </div>
	  	
	 <script>
	 var cnt = 0;
	//간트 결과 체크박스 이벤트
	function GRchecked(element1, element2, count){
		var element = element1 + element2;
		var temp1 = "#DoItCheck3"+element;
		var item = $(temp1).parent();
		var text = item.children('.DoItListItem');
		
		if($(temp1).attr("data-check") == "0"){
			text.css({
				"color": "#D9D9D9",
				"text-decoration" : "line-through"
			});
			cnt++;
			$.ajax({
				url : "/schedule/${groupId}/check",
				type : "get",
				data : ({
					big_todo : element1,
					small_todo : element2
				})
			})
			$(temp1).attr("data-check" , "1");
		}else{
			text.css({
				"color": "black",
				"text-decoration" : "None"
			});
			cnt--;
			$.ajax({
				url : "/schedule/${groupId}/check2",
				type : "get",
				data : ({
					big_todo : element1,
					small_todo : element2
				})
			})
			$(temp1).attr("data-check",  "0");
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

	<%
	Date[] DoItStartDate = new Date[DoItCnt];
	Date[] DoItEndDate = new Date[DoItCnt];
	Calendar[] doItCal = new Calendar[DoItCnt];
	Calendar[] doItCal2 = new Calendar[DoItCnt];

	for (int i = 0; i < DoItCnt; i++){
		DoItStartDate[i] = new Date();
		DoItEndDate[i] = new Date();
		doItCal[i] = Calendar.getInstance();
		doItCal2[i] = Calendar.getInstance();
		doItCal[i].setTime(DoItStartDate[i]);
		doItCal2[i].setTime(DoItEndDate[i]);
		doItCal2[i].add(Calendar.DATE, 7);
		doItCal[i].add(Calendar.MONTH, 1);
		doItCal2[i].add(Calendar.MONTH, 1);
		
		System.out.println(doItCal[i].getTime());
		System.out.println(doItCal2[i].getTime());
	}
	
	if ((Date[])request.getAttribute("DoItStartDate") != null 
			&& (Date[])request.getAttribute("DoItEndDate") != null ){
		DoItStartDate = (Date[])request.getAttribute("DoItStartDate") ;
		DoItEndDate = (Date[])request.getAttribute("DoItEndDate");
		for (int i = 0; i < DoItCnt; i++){
			doItCal[i].setTime(DoItStartDate[i]);
			doItCal2[i].setTime(DoItEndDate[i]);
		}
	}
	%>

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
	int[] checkList = new int [DoItCnt];
	if (request.getAttribute("checkList")!=null)
		checkList = (int[])request.getAttribute("checkList");

  	for (int t = 0; t < DoItCnt; t++){
  	%>
  		valueName.push('<%=DoIt.get(t)%>');

	    valueSDate.push(new Date(<%=doItCal[t].get(Calendar.YEAR) %>,<%=doItCal[t].get(Calendar.MONTH) %>, <%=doItCal[t].get(Calendar.DATE) %>));
	    valueEDate.push(new Date(<%=doItCal2[t].get(Calendar.YEAR) %>,<%=doItCal2[t].get(Calendar.MONTH) %>, <%=doItCal2[t].get(Calendar.DATE) %>));
	    
	    valueDur.push(null);
	    valuePC.push(<%=checkList[t]%>);
	<%}
	%>
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
				defaultStartDate: '<%=DoItStartDate%>',
				defaultEndDate: '<%=DoItEndDate%>',
				
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

	<% int DoItMax = (int)request.getAttribute("DoItMax");%>
	var max = <%= DoItMax%>;
	<% 
	 int [] smallDoItMax = (int[])request.getAttribute("smallDoItMax");
	 //System.out.println(smallDoItMax[0]);
	 %>
		var smallMax = [];
		<% for (int i = 0; i < smallDoItMax.length; i++){ %>
			smallMax[<%=i%>] = <%=smallDoItMax[i]%>;
		<%}%>
	
	var IndexInt = 0;
	var Element;
	//할일 팝업을 열기
	function DpopOpen(indexint, element, childs){
		var list = $("#DoItListChild");
		IndexInt = indexint;
		Element = element;
		//temp의 child
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
	
	$(document).ready(function () {
		
		//방장인가 부방장인가?				
		<% if ( HostId[0].equals(userId)) { %>
			IamHost('${groupId}');
		<% }
		
		//부방장
		else{			
			for (int i = 0; i < SubHostId.length; i++){
				if (SubHostId[i].equals(userId)){
			%> 
			IamSubHost();
			<% break;
				}
			}		
		} %>
		
		//로드
		$(".loader").css("display", "None");

		
		//ajax
		 $("#ganttCreateBtn").on("click", function(){
			$.ajax({
				url : "/schedule/<%= groupId%>/CreateGantt",
				type : "get",
				complete : function(){
					location.reload();	//새고해야 제대로 떠서 일단 새고시킴...
				}
			})
		})	

	$("#GanttEditValueBox .newValueBtn").on("click", function(){
		 if ($("#GanttEditValueBox .newValue").val() == ""){
			 alert("값을 입력하세요");
		 }
		 else{

			 $.ajax({
					url : "/schedule/<%= groupId%>/InsertGantt",
					type : "get",
					data : {
						group_id : "<%= 	groupId%>",
						big_todo : ++max,
						small_todo : 0,
						big_todo_content : $("#GanttEditValueBox .newValue").val(),
						small_todo_content : "하위 메뉴",
						check_do : 0
					},
					success : function(data){
						$('#ajaxContainer').load(window.location.href + " #ajaxContainer",function(){	
							drawChart();	//갱신 안 됨...
						});
					},
					error : function(){
						alert("입력 중 에러가 발생했습니다.");
						location.reload();
						$("#meeting_date").hide();
						$("#gantt_chart").show();
					},
					complete : function(){
						$("#GanttEditValueBox .newValue").val(null);
					}
				})  
			 } 
		})	
			
		//모달 창 입력 ajax
		$("#DoItChildDate .newValueBtn").click(function(){
			var list = $("#DoItListChild");
		 if ($("#DoItChildDate .newValue").val() == ""){
			 alert("값을 입력하세요");
		 }
		 else{
				
			 console.log(smallMax[IndexInt]);
			 $.ajax({
					url : "/schedule/<%= groupId%>/InsertGantt2",
					type : "get",
					data : {
						group_id : "<%= 	groupId%>",
						big_todo : IndexInt,
						small_todo : ++smallMax[IndexInt],
						big_todo_content : Element,
						small_todo_content : $("#DoItChildDate .newValue").val()
					},
					success : function(data){
						list.append('<li><div class = "DoItListItem" style = "width : 98%; " >&nbsp;'+$("#DoItChildDate .newValue").val()+'</div></li>');
						$("#DoItListChild").children().eq(smallMax[IndexInt]).children().append('<button type = "button" class = "deleteBtn" onclick="deleteBtn2('+smallMax[IndexInt]+')">✕</button>');
					},
					error : function(){
						alert("입력 중 에러가 발생했습니다.");
						//location.reload();
					},
					complete : function(){
						$("#DoItChildDate .newValue").val(null);
						$('#ajaxContainer').load(window.location.href + " #ajaxContainer");
						$('#GRAjax').load(window.location.href + " #GRAjax");
					}
				})  
			 } 
		})
		//저장 버튼
		$("#updateDoItForm .submitBtn").click(function(){
			changeGantt('${groupId}', IndexInt);
			<% for (int i = 0; i < smallDoItMax.length; i++){ %>
				smallMax[<%=i%>] = <%=smallDoItMax[i]%>;
			<%}%>
		});
		
		//체크박스 초기화
		cnt = 0;
		<%
		 for (int i = 0; i < DoIt.size(); i++){
				for (int j = 0; j < DoItDetail[i].size(); j++){
					%>
					var temp1 = "#DoItCheck3<%=i%><%=j%>";
					var item = $(temp1).parent();
					var text = item.children('.DoItListItem');
					
					if($("#DoItCheck3<%=i%><%=j%>").attr("data-check") == "0"){
						text.css({
							"color": "black",
							"text-decoration" : "None"
						});
						$("#DoItCheck3<%=i%><%=j%>").attr("checked", false);
					}else{
						$(text).css({
							"color": "#D9D9D9",
							"text-decoration" : "line-through"
						});
						cnt++;
						$("#DoItCheck3<%=i%><%=j%>").attr("checked", true);
					}
					
					var result = (cnt/<%=count%>)*100;
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
					<%
				}
			}
		%>
		//Dday 초기화 화면 숨기기
		if (<%=(int)request.getAttribute("DdayTrue")%> == 1){
			$("#Dday").show();
			$("#DdayInit").hide();			
		}
			
		//일정표 색 결과 보여주기
		var people = <%=ssuCnt%>; //참여 인원 수
		var k = 1/people;	//1인당 투명도
		for (var i = 0; i < <%=slideMax*42*7%>; i++){
			if($(".totalCol").eq(i).attr("data-count") == -1){
				$(".totalCol").eq(i).css("background", "#E9E9E9");

			}else{
				var resultColor = k*$(".totalCol").eq(i).attr("data-count");
				$(".totalCol").eq(i).css("background", "rgba(242, 82, 135, "+ resultColor +")");		
			}
		}
		//수정 페이지
		for (var i = 0; i < <%=slideMax*42*7%>; i++){
			if($('.tdCol').eq(i).attr("data-count") == -1){
				$(".tdCol").eq(i).css("background", "#E9E9E9");
				$(".tdCol").eq(i).attr("data-color", "-1");
			}
			else if($('.tdCol').eq(i).attr("data-count") == 1){
				$(".tdCol").eq(i).css("background", "rgba(242,82,135,1)");
				$(".tdCol").eq(i).attr("data-color", "1");
			}
		}
		
		$("#gantt_chart_btn").on('click', function(){
			//간트차트 있을 때 바로 결과창
			if ( <%=DoItCnt%> >0){
				drawChart();
				$("#ganttCreate").hide();
				$("#ganttFirstEdit").hide();
				$("#ganttResult").show();
			}
		})
		
		//일정 버튼 초기 색
		if(<%=slideMax%> == 1){
				$(".total_table_left").css("color", "#C9C9C9");
				$(".total_table_right").css("color", "#C9C9C9");
			}else{
				$(".total_table_right").css("color", "#F25287");
			}
		
	 	/* 간트 차트 */	

	  	$("#ganttFirstEditCancelBtn").click(function(){
	  		drawChart();
	  		if ( <%=DoItCnt%> >0){
	  			drawChart();
				$("#ganttCreate").hide();
				$("#ganttFirstEdit").hide();
				$("#ganttResult").show();
			}else{
				$("#ganttCreate").show();
				$("#ganttFirstEdit").hide();	
			}
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
		$("#ganttInitBtn").on("click", function(){
			var result = confirm("정말 초기화하시겠습니까? 모든 데이터가 영구적으로 삭제됩니다.");
			
			if(result){
				$.ajax({
					url : "/schedule/<%= groupId%>/InitGantt",
					type : "get",
					complete : function(){
						location.reload();
					}
				})
			}
			else{
				
			}
		})
		
	 });
	
	//리스트 삭제하기
	function deleteBtn(element, cnt, groupId){
		 console.log(cnt);
		var result = confirm("하위 항목이 모두 사라집니다. 정말로 삭제하시겠습니까?");
		if(result){
			if(cnt <=1){
				alert("항목이 하나 이상 존재해야 합니다.");
				return false;
			}else{
				$.ajax({
					url : "/schedule/" + groupId + "/deleteGanttDoIt",
					type : "get",
					data : {big_todo : element},
					success : function(){
						$('#ajaxContainer').load(window.location.href + " #ajaxContainer",function(){	
						drawChart();	//갱신 안 됨...
						max--;
					});
					}
				})
			}
		}else{
			return false;
		}	
	}
	
	</script>
	  <div id = "group_detail" style = "display : none;">
		  <div class="group_info">
			<div class = "group_information" style = "display : flex; margin : auto; background : white; width : 95%; height : 90%">
				<div style= " display : flex;  margin : auto; width : 90%; height : 80%">
					<div id = "group_detail_left" >
						<h1>${groupName}</h1>
						<h3><span>일반맴버</span> : ${thisUserName}</h3>
						<h3></h3>
						
						<img src = "${thisUserImg }" onerror = "/img/user_logo.png" style = "width : 100px; height : 100px; border-radius : 50%;">
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
						<div id = "updateDoItForm">
							<div style = "display : flex;">
								<div id = "DoItChildDate" style = "margin : 10px">
			  						<h2 style = "display : inline"> Task 시작일 : <br><input type = "date" class = "startDate"/><br><br>
			  							Task 종료일 : <br><input type = "date" class = "endDate"/></h2> <br>
			  						<input type = "text" placeholder = "  새 작업 추가하기" class = "newValue"/>
			  						<button class = "newValueBtn" style = "width : 40px; height : 40px; font-size : 25px;">+</button>
			  					</div>
			  					<div id = "DoItChildList">
			  						<div id = "DoItChildListAjax">
			  							<div class = "DoItListChild" >
			  								<ul id = "DoItListChild">
			  								
			  								</ul>
			  							</div>
			  						</div>
			  					</div>
			  				</div>
							<input type = "button" value = "저장"  class = "submitBtn"  style = "left : 42%; margin-top : 10px;"/>
						</div>
					</div>		
  				</div>
			  </div>
  </div>	
  
  
	<!-- footer -->
	
	<div>
		<%@ include file="../footer.jsp" %>
	</div>
</div>
</c:otherwise>
</c:choose>
</body>
</html>