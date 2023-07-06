<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	<title>그룹생성 | 언제만나</title>
	<link href="/css/group/group_create.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#group_submit").on("click", function() {
				let ra_txt = "";
				let in_txt = "";
				let gn_len = $("#group_name").val().length;
				let tx_len = $("#info_form_right textarea").val().length;
				let alert_TF = false;
				
				if (!$("#create_forms input[name='sub_host_id']:checked").val()) {
					ra_txt = "부방장을 선택하세요.\n";
					alert_TF = true;
				}
				if (gn_len == 0 && tx_len == 0) {
					in_txt = "그룹 이름, 그룹 설명을 입력하세요.";
					alert_TF = true;
				}
				else if (gn_len == 0) {
					in_txt = "그룹 이름을 입력하세요.";
					alert_TF = true;
				}
				else if (tx_len == 0) {
					in_txt = "그룹 설명을 입력하세요.";
					alert_TF = true;
				}
				
				if (alert_TF) {
					alert(ra_txt + in_txt);
				}
				else {
					$("#create_forms").submit();
				}
			});
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- group create form -->
	<div id="group_create">
		<div id="host_info">
			<img class="profile_img" alt="profile_img" src="${ host_info.profile_url }">
			<h1><span>${ host_info.name }</span><span>님의 그룹생성</span></h1>
		</div>
		<form id="create_forms" action="/group/create/result" method="post">
			<input type="hidden" name="host_id" value="${ host_info.user_id }">
			<div id="group_user_form">
				<div id="user_form_title">
					<h2>부방장</h2>
				</div>
				<ul>
					<c:forEach items="${ user_info }" var="user">
						<li>
							<img class="profile_img" alt="profile_img" src="${ user.profile_url }">
							<label for="ra_${ user.user_id }"><h2>${ user.name }</h2></label>
							<input id="ra_${ user.user_id }" class="sub_host_radio" type="radio" name="sub_host_id" value="${ user.user_id }">
							<input type="hidden" name="user_list[]" value="${ user.user_id }">
						</li>
					</c:forEach>
				</ul>
			</div>
			<div id="group_info_form">
				<div id="info_form_title">
					<h2>그룹 정보</h2>
				</div>
				<div id="info_form">
					<div id="info_form_left">
						<input id="group_name" type="text" name="group_name" placeholder="그룹 이름">
						<h3>개설자 : ${ host_info.name }</h3>
						<div id="info_imgs">
							<img src="/img/액자.png">
							<img src="${ host_info.profile_url }">
						</div>
					</div>
					<div id="info_form_right">
						<h2>그룹 설명<span>|</span></h2>
						<textarea name="group_description" rows="4" cols="20" placeholder="그룹 설명을 입력하세요."></textarea>
					</div>
				</div>
			</div>
		</form>
		<input id="group_submit" type="button" value="그룹 만들기">
	</div>
	
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>