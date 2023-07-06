<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="login_login.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h2>로그인</h2>
    <form action="loginProcess.jsp" method="POST">
        <div>
            <label for="id">아이디:</label>
            <input type="text" id="id" name="id" required>
        </div>
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <input type="submit" value="로그인">
    </form>
    <p>아직 회원이 아니신가요? <a href="/join">회원가입</a></p>
</div>
<%@ include file="footer.jsp" %>
<script src="login_login.js"></script>
</body>
</html>
