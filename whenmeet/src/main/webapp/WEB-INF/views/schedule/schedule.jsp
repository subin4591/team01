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
<script src = "js/schedule_js.js"></script>
</head>
<%
// 사용자 프로필 에러남
String userImgErr = "img/userEmpty.png";
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
	<div class = "group_info" style = "position : relative; left : 25%; margin-top : 10px; margin-left: 1%; width : 74%; height:500px; background : white;">
		
	</div>

	<!-- 하단 상자 -->
	<div class = "meeting_setting">
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</div>
</body>
</html>