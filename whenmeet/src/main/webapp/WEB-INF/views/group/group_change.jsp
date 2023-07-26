<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	<title>그룹수정 | 언제만나</title>
	<link href="/css/group/group_change.css" rel=stylesheet>
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
		});	// document end
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- group change form -->
	<div id="group_change">
		<div id="host_info">
			<div class="profile_img">
				<img alt="profile_img" src="${ host_info.profile_url }">
			</div>
			<h1><span>${ host_info.name }</span><span>님의 그룹수정</span></h1>
		</div>
		<div id="change_forms">
			<div id="group_user_form">
				<form id="host_form">
					<input type="hidden" name="group_id" value="${ group_info.group_id }">
					<div class="user_form_title">
						<h2>방장 위임</h2>
					</div>
					<div class="user_from_ul">
						<ul>
							<c:forEach items="${ sub_info }" var="user">
								<li>
									<div class="profile_img">
										<img alt="profile_img" src="${ user.profile_url }">
									</div>
									<label for="ra_${ user.user_id }"><h2>${ user.name }</h2></label>
									<input id="ra_${ user.user_id }" class="host_radio" type="radio" name="sub_host_id" value="${ user.user_id }">
									<input type="hidden" name="user_list[]" value="${ user.user_id }">
								</li>
							</c:forEach>
							
							<c:forEach items="${ mem_info }" var="user">
								<li>
									<div class="profile_img">
										<img alt="profile_img" src="${ user.profile_url }">
									</div>
									<label for="ra_${ user.user_id }"><h2>${ user.name }</h2></label>
									<input id="ra_${ user.user_id }" class="host_radio" type="radio" name="sub_host_id" value="${ user.user_id }">
									<input type="hidden" name="user_list[]" value="${ user.user_id }">
								</li>
							</c:forEach>
						</ul>
					</div>
					<input id="host_submit" class="chn_btn" type="button" value="방장 위임">
				</form>
				
				<form id="sub_form">
					<input type="hidden" name="group_id" value="${ group_info.group_id }">
					<div class="user_form_title">
						<h2>부방장 설정</h2>
					</div>
					<div class="user_from_ul">
						<ul>
							<c:forEach items="${ sub_info }" var="user">
								<li>
									<div class="profile_img">
										<img alt="profile_img" src="${ user.profile_url }">
									</div>
									<h2>${ user.name }</h2>
									<div class="sub_chk_list">
										<input id="sub_${ user.user_id }" class="sub_checkboxs" type="checkbox" name="sub_host_id" value="${ user.user_id }" checked>
										<label for="sub_${ user.user_id }"></label>
									</div>
									<input type="hidden" name="user_list[]" value="${ user.user_id }">
								</li>
							</c:forEach>
							
							<c:forEach items="${ mem_info }" var="user">
								<li>
									<div class="profile_img">
										<img alt="profile_img" src="${ user.profile_url }">
									</div>
									<h2>${ user.name }</h2>
									<div class="sub_chk_list">
										<input id="sub_${ user.user_id }" class="sub_checkboxs" type="checkbox" name="sub_host_id" value="${ user.user_id }">
										<label for="sub_${ user.user_id }"></label>
									</div>
									<input type="hidden" name="user_list[]" value="${ user.user_id }">
								</li>
							</c:forEach>
						</ul>
					</div>
					<input id="sub_submit" class="chn_btn" type="button" value="부방장 설정">
				</form>
				
				<form id="out_form">
					<input type="hidden" name="group_id" value="${ group_info.group_id }">
					<div class="user_form_title">
						<h2>멤버 탈퇴</h2>
					</div>
					<div class="user_from_ul">
						<ul>
							<c:forEach items="${ sub_info }" var="user">
								<li>
									<div class="profile_img">
										<img alt="profile_img" src="${ user.profile_url }">
									</div>
									<h2>${ user.name }</h2>
									<div class="sub_chk_list">
										<input id="out_${ user.user_id }" class="sub_checkboxs" type="checkbox" name="sub_host_id" value="${ user.user_id }">
										<label for="out_${ user.user_id }"></label>
									</div>
									<input type="hidden" name="user_list[]" value="${ user.user_id }">
								</li>
							</c:forEach>
							
							<c:forEach items="${ mem_info }" var="user">
								<li>
									<div class="profile_img">
										<img alt="profile_img" src="${ user.profile_url }">
									</div>
									<h2>${ user.name }</h2>
									<div class="sub_chk_list">
										<input id="out_${ user.user_id }" class="sub_checkboxs" type="checkbox" name="sub_host_id" value="${ user.user_id }">
										<label for="out_${ user.user_id }"></label>
									</div>
									<input type="hidden" name="user_list[]" value="${ user.user_id }">
								</li>
							</c:forEach>
						</ul>
					</div>
					<input id="out_submit" class="chn_btn" type="button" value="멤버 탈퇴">
				</form>
			</div>
			
			<div id="group_info_form">
				<div id="info_form_title">
					<h2>그룹 정보</h2>
				</div>
				<form id="info_form">
					<div id="info_form_left">
						<input id="group_name" type="text" name="group_name" placeholder="그룹 이름" value="${ group_info.group_name }">
						<h3>개설자 : ${ host_info.name }</h3>
						<div id="info_imgs">
							<img src="/img/액자.png">
							<img src="${ host_info.profile_url }">
						</div>
					</div>
					<div id="info_form_right">
						<div id="info_form_right_top">
							<div id="ifrt_left">
								<h2>개설일<span>|</span></h2>
								<p>${ group_info.group_create_time }</p>
							</div>
							<div id="ifrt_right">
								<h2>종료일<span>|</span></h2>
								<input type="date" name="project_end_time">
							</div>
						</div>
						<div id="info_form_right_bottom">
							<h2>그룹 설명<span>|</span></h2>
							<textarea name="group_description" rows="4" cols="20" placeholder="그룹 설명을 입력하세요.">${ group_info.group_description }</textarea>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>