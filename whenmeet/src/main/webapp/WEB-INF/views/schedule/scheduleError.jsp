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
  <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b4c5e3499f85cf245295753dba018dc"
  ></script>
  </head>
<%@page import = "java.util.*"%>

<body>
	<div class = "schedule_page">
	<!--헤더 -->
	<%@ include file="../header.jsp" %>
	
	<div style = "display : flex; margin : 10%; margin-left : 30%;">
	<img src = "/img/sorry.png" style = "width : 200px; height : 300px">
	<div style = "margin-left : 5%;">
		<br><br><br>
		<h1 style = "color : #f25287; font-size : 50px;">죄송합니다!</h1>
		<h1 style = "">페이지를 찾을 수 없습니다.</h1>
	</div>
	
 	</div>	
   
	<!-- footer -->	
	<div>
		<%@ include file="../footer.jsp" %>
	</div>
</div>
</body>
</html>