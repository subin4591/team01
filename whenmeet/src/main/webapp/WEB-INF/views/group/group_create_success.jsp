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
			alert("그룹 생성이 완료되었습니다.");
			
			// 개설일
			let today = new Date();
			let year = today.getFullYear();
			let month = String(today.getMonth() + 1).padStart(2, '0');
			let day = String(today.getDate()).padStart(2, '0');
			today = year + "-" + month + "-" + day;
			
			$("#ifrt_left p").text(today);
		});
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
			<h1><span>${ host_info.name }</span><span>님의 그룹</span></h1>
		</div>
		<div id="create_forms">
			<input type="hidden" name="host_id" value="${ host_info.user_id }">
			<div id="group_user_form">
				<div id="user_form_title">
					<h2>멤버 목록</h2>
				</div>
				<div id="user_from_ul">
					<ul>
						<li>
							<div class="profile_img">
								<img alt="profile_img" src="${ host_info.profile_url }">
							</div>
							<label for="ra_${ host_info.user_id }"><h2>${ host_info.name }</h2></label>
							<img class="host_img" src="/img/방장표시.svg">
						</li>
						<li>
							<div class="profile_img">
								<img alt="profile_img" src="${ sub_host_info.profile_url }">
							</div>
							<label for="ra_${ sub_host_info.user_id }"><h2>${ sub_host_info.name }</h2></label>
							<img class="host_img" src="/img/부방장표시.svg">
						</li>
						<c:forEach items="${ user_info }" var="user">
							<li>
								<div class="profile_img">
									<img alt="profile_img" src="${ user.profile_url }">
								</div>
								<label for="ra_${ user.user_id }"><h2>${ user.name }</h2></label>
								<img class="host_img" src="/img/부방장표시.svg" style="opacity: 0;">
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
						<h2 id="group_name">${ group_dto.group_name }</h2>
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
								<p>2023</p>
							</div>
							<div id="ifrt_right">
								<h2>종료일<span>|</span></h2>
								<p>${ group_dto.project_end_time }</p>
							</div>
						</div>
						<div id="info_form_right_bottom">
							<h2>그룹 설명<span>|</span></h2>
							<p id="ifr_p">${ group_dto.group_description }</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="gcs_btns">
			<input id="go_main" type="button" value="메인으로 가기" onclick="location.href = '/'">
			<input id="go_schedule" type="button" value="일정으로 가기" onclick="location.href = '/schedule/${ group_id }'">
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>