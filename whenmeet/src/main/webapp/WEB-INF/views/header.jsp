<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/css/header.css" rel=stylesheet>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
		sSubmit.on("click", function(event) {
			event.preventDefault();
			if (sInput.val().length == 0) {
				alert("검색어를 입력하세요.")
			}
			else {
				$("#search_form").submit();
			}
		});
		
	});
</script>
<header>
	<div id="main_header">
		<a href=""><img id="main_logo" src="/img/logo.svg" alt="main_logo"></a>
		<img id="search_btn" src="/img/search.svg" alt="search_btn">
		<c:choose>
			<c:when test="${ session_id != null }">
				<a href=""><img id="user_profile" src="/img/user_logo.png" alt="user_profile"></a>
				<button class="login_btn" onclick="location.href=''">LOGOUT</button>
			</c:when>
			<c:otherwise>
				<button class="login_btn" onclick="location.href=''">LOGIN</button>
			</c:otherwise>
		</c:choose>
	</div>
	<div id="pop_search">
		<form id="search_form" action="">
			<input type="text" id="search_input" name="searchInput" placeholder="검색어를 입력하세요.">
			<img id="search_submit_btn" src="/img/search.svg" alt="search_submit_btn">
		</form>
	</div>
</header>