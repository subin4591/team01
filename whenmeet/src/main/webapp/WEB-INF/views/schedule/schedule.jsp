<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정|언제만나</title>
<link rel = "stylesheet" href = "resources/css/schedule_css.css">
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script src = "resources/js/schedule_js.js"></script>
</head>
<%
String userImgErr = "resources/images/userEmpty.png";
%>
<body>
<div class = "schedule_page">
	<!-- 헤더 위치 -->
	<!-- 
	<header class = "schedule_header">
		<div class = "user_icon">
		<a href = "/" >
			<img src = "resources/images/userEmpty.png"  
			onError = "<%=userImgErr %>" 
			alt = "유저 프로필 사진" class = "userIcon"/>
		</a>
		</div>
		<div class = "logo">
		<a href = "/">
			<img src = "resources/images/logo.svg" alt = "메인 로고 이미지" class = "mainLogo"/>
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

			for(int i = 0; i < 10; i++){
				String Img = "resources/images/방장표시.svg";
				boolean host = false;
				boolean subhost = false;
				if (i == 0){ 
					host = true;
				}
				if (i == 1){ 
					subhost = true;
					Img = "resources/images/부방장표시.svg";
				}
			%>
				<li><div class = "member">
					<!-- 유저 프로필 이미지 설정 -->
					<div class = "Uimage">
						<img src = "<%= userImgErr %>" 
							onError = "<%= userImgErr %>" 
							alt = "유저 프로필 이미지" class = "userProfile"/>
					</div>
					<!-- 유저 이름 설정-->
					<div class = "text">
						<h2>방장쓰</h2>
						
					<!-- 방장 및 부방장 설정-->	
						<%if(host || subhost){ %>
						<img src = "<%= Img %>" alt = "방장 표시" 
							class = "hostMark">
						<%}; %>						
					</div>
					
				</div></li>
		<%} %>
		</ul>
		</div>
	</div>
	
	<!-- 그룹 정보 -->
	<div class = "group_info" style = "position : relative; left : 25%; margin-top : 10px; margin-left: 15px; width : 70%; height:500px; background : white;">
		
	</div>
	<%@ include file="../footer.jsp" %>
</div>
</body>
</html>