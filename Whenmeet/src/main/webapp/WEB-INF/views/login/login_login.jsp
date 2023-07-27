<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="login_login.css">
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="container">
        <h2>로그인</h2>
        <%-- 로그인 실패 시 오류 메시지 출력 --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <form action="loginProcess" method="POST">
            <div>
                <label for="id">아이디:</label>
                <input type="text" id="id" name="user_id" required>
            </div>
            <div>
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="pw" required>
            </div>
            <input type="submit" value="로그인">
        </form>
        <p>아직 회원이 아니신가요? <a href="/join">회원가입</a></p>
    </div>
    <%@ include file="footer.jsp" %>
    <script src="login_login.js"></script>
<script>
    $(document).ready(function() {
        // 유저 아이콘
        if (${not empty sessionScope.session_id}) {
            $("#user_profile").show();
            $("#login_btn").hide();
            $("#logout_btn").show();
        } else {
            $("#user_profile").hide();
            $("#login_btn").show();
            $("#logout_btn").hide();
        }

        // 로그아웃 버튼 클릭 이벤트
        $("#logout_btn").on("click", function() {
            location.href = "/boardlogout"; // 로그아웃 처리를 위해 /boardlogout 경로로 이동
        });
    });
</script>
</body>
</html>
