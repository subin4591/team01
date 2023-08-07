<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/css/header.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function() {
    // 유저 아이콘
    <%-- 세션에 session_id가 null이 아닌 경우 (로그인된 상태) --%>
    <c:if test="${session_id != null}">
        $("#user_profile").show();
        $("#logout_btn").show();
    </c:if>
    <c:if test="${session_id == null}">
        $("#user_profile").hide();
        $("#logout_btn").hide();
    </c:if>
}
</script>
<script>
    $(document).ready(function() {
        
        // 검색창 Toggle
        $("#pop_search").hide();
        $("#search_btn").on("click", function() {
            $("#pop_search").slideToggle(400);
        });
        
        // input event
        let sInput = $("#search_input");
        
        // submit event
        let sSubmit = $("#search_submit_btn");
        sSubmit.on("click", function() {
            if (sInput.val().length == 0) {
                alert("검색어를 입력하세요.");
            } else {
                $("#search_form").submit();
            }
        });

        // 로그아웃 버튼에 클릭 이벤트 추가
        $("#logout_btn").on("click", function() {
            logout();
        });
    });

    // 로그아웃 함수
    function logout() {
        // 서버로 로그아웃 요청 보내기
        $.post("/boardlogout", function(data) {
            // 로그아웃이 성공적으로 처리되었을 때 실행되는 부분
            // 서버에서 성공 여부를 반환하면 여기에서 처리 가능
            alert("로그아웃 되었습니다.");
            location.reload();
        });
    }

    // 사용자 정보 수정 후 알림 메시지 띄우기
    $(document).ready(function() {
        let message = "${message}";
        if (message !== "") {
            alert(message);
        }
    });
</script>
<header>
    <div id="main_header">
        <a href="/"><img id="main_logo" src="/img/logo.svg" alt="main_logo"></a>
        <img id="search_btn" src="/img/search.svg" alt="search_btn">
        <c:choose>
            <c:when test="${session_id != null}">
                <a href="/myinfo">
                	<div id="user_profile">
                		<img src="${session_url}" alt="user_profile" onerror="this.src='/img/user_logo.png';">
                		<span>${session_id} | ${session_url}</span>
                	</div>
                </a>
                <!-- 로그아웃 버튼에 클릭 이벤트 추가 -->
                <button id="logout_btn" class="login_btn">LOGOUT</button>
            </c:when>
            <c:otherwise>
                <button class="login_btn" onclick="location.href='/login'">LOGIN</button>
            </c:otherwise>
        </c:choose>
    </div>
    <div id="pop_search">
        <form id="search_form" action="/search">
            <input type="text" id="search_input" name="search_input" placeholder="검색어를 입력하세요.">
            <img id="search_submit_btn" src="/img/search.svg" alt="search_submit_btn">
        </form>
    </div>
</header>

