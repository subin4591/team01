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
</div>
</body>
</html>