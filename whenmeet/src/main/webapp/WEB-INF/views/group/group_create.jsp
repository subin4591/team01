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
			// 글자수 제한
			$("#group_name").on("keyup", function() {
				let text_len = $(this).val().length;
	            let text_max = 100;
	            if (text_max - text_len <= 0) {
	            	alert(text_max + "자 까지 입력할 수 있습니다.");
	                $(this).val($(this).val().slice(0, text_max-10));
	            }
			});
			$("#group_description").on("keyup", function() {
				let text_len = $(this).val().length;
	            let text_max = 500;
	            if (text_max - text_len <= 0) {
	            	alert(text_max + "자 까지 입력할 수 있습니다.");
	                $(this).val($(this).val().slice(0, text_max-10));
	            }
			});
			
			// submit event
			$("#group_submit").on("click", function() {
				let in_txt = "";
				let gn_len = $("#group_name").val().length;
				let tx_len = $("#info_form_right textarea").val().length;
				let alert_TF = false;
				
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
					alert(in_txt);
				}
				else {
					$("#create_forms").submit();
				}
			});	// submit event end
			
			// 개설일
			let today = new Date();
			let year = today.getFullYear();
			let month = String(today.getMonth() + 1).padStart(2, '0');
			let day = String(today.getDate()).padStart(2, '0');
			today = year + "-" + month + "-" + day;
			
			$("#ifrt_left p").text(today);
		});	// document end
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- group create form -->
	<div id="group_create">
		<div id="host_info">
			<div class="profile_img">
				<img alt="profile_img" src="${ host_info.profile_url }">
			</div>
			<h1><span>${ host_info.name }</span><span>님의 그룹생성</span></h1>
		</div>
		<form id="create_forms" action="/group/create/result" method="post">
			<input type="hidden" name="host_id" value="${ host_info.user_id }">
			<div id="group_user_form">
				<div id="user_form_title">
					<h2>부방장</h2>
				</div>
				<div id="user_from_ul">
					<ul>
						<c:forEach items="${ user_info }" var="user">
							<li>
								<div class="profile_img">
									<img alt="profile_img" src="${ user.profile_url }">
								</div>
								<div class="sub_chk_list">
									<input id="chk_${ user.user_id }" class="sub_checkboxs" type="checkbox" name="sub_host_id" value="${ user.user_id }">
									<label for="chk_${ user.user_id }"><h2>${ user.name }</h2><span></span></label>
								</div>
								<input type="hidden" name="user_list[]" value="${ user.user_id }">
							</li>
						</c:forEach>
					</ul>
				</div>
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
							<img id="info_frame" src="/img/액자.png">
							<div id="host_profile_img">
								<img src="${ host_info.profile_url }">							
							</div>
						</div>
					</div>
					<div id="info_form_right">
						<div id="info_form_right_top">
							<div id="ifrt_left">
								<h2>개설일<span>|</span></h2>
								<p>2023</p>
							</div>
							<div id="ifrt_right">
								<h2>종료일<span>|</span></h2>
								<input type="date" name="project_end_time">
							</div>
						</div>
						<div id="info_form_right_bottom">
							<h2>그룹 설명<span>|</span></h2>
							<textarea name="group_description" rows="4" cols="20" placeholder="그룹 설명을 입력하세요."></textarea>
						</div>
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