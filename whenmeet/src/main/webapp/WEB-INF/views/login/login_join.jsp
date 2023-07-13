<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="login_join.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
  <h2>회원가입</h2>
  <form action="registerProcess.jsp" method="POST">
    <div>
      <label for="id">아이디:</label>
      <input type="text" id="id" name="id" required>
      <button type="button" id="btnDuplicateCheck">중복 체크</button>
    </div>
    <div>
      <label for="password">비밀번호:</label>
      <input type="password" id="password" name="password" required>
    </div>
    <div>
      <label for="name">이름:</label>
      <input type="text" id="name" name="name" required>
    </div>
    <div>
      <label for="address">주소:</label>
      <input type="text" id="address" name="address" required>
      <button type="button" id="btnSearchAddress">우편번호 검색</button>
    </div>
    <div>
      <label for="phone">폰번호:</label>
      <input type="tel" id="phone" name="phone" required>
    </div>
    <div>
      <label for="email">이메일:</label>
      <input type="email" id="email" name="email" required>
      <button type="button" id="btnEmailDuplicateCheck">중복 체크</button>
    </div>
    <div id="captcha"></div>
    <input type="submit" value="가입하기">
  </form>
</div>
<%@ include file="footer.jsp" %>

<script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=YOUR_CLIENT_ID"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="login_join.js"></script>
</body>
</html>
