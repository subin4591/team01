<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	<c:choose>
		<c:when test="${ isIn != 'notMember' }">
			<title>그룹초대 | 언제만나</title>
		</c:when>
		<c:otherwise>
			<title>그룹신청 | 언제만나</title>
		</c:otherwise>
	</c:choose>
	<title>그룹초대 | 언제만나</title>
	<link href="/css/group/group_schedule_invitation.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			let group_id = "${ group.group_id }";
			
			// 그룹 신청 제목
			if ("${ isIn }" == "notMember") {
				$("#host_info span:nth-child(2)").text(" 그룹 신청");
			}
			
			// 개설일, 종료일 시간 떼기
			$("#ifrt_left p").text($("#ifrt_left p").text().substring(0, 10));
			$("#ifrt_right p").text($("#ifrt_left p").text().substring(0, 10));
			
			// 초대 링크 복사
			$("#linkCopyBtn").on("click", function() {
				let temp = $("<textarea>");
				let title = "[\'" + "${ group.group_name }" + "\' 그룹 초대]\n"
				let link = location.href;
				
				$("body").append(temp);
				
				temp.val(title + link).select();
				document.execCommand("copy");
				temp.remove();
				alert("복사되었습니다.");
			});
			
			// 그룹 신청
			$("#signGroupBtn").on("click", function() {
				let id = "${ session_id }";
				
				$.ajax({
					url: "/group/schedule/invitation/signUp",
					data: {group_id: group_id, id: id},
					type: "post",
					dataType: "json",
					success: function(data) {
						if (data.result == "already") {
							alert("이미 신청한 그룹입니다.");
						}
						else if (data.result == "success") {
							alert("신청이 완료되었습니다.");
						}
						
						window.location.href = "/";
					}	// success end
				})	// ajax end
			});
			
			// 초대 그룹원 ID 검색
			$("#id_search_submit_btn").on("click", function() {
				let id = $("#id_input").val();
				
				if (id == "") {
					alert("ID를 입력하세요.");
				}	// if end
				else {
					$.ajax({
						url: "/group/schedule/invitation/IDSearch",
						data: {group_id: group_id, id: id},
						type: "post",
						dataType: "json",
						success: function(data) {
							if (data.result == "notFind") {
								$("#sr_none").show();
								$("#sr_result").hide();
								
								$("#sr_none h2").text("이미 가입된 멤버입니다.");
								$("#id_input").val("");
							}	// notFind if end
							else if(data.result == "already") {
								$("#sr_none").show();
								$("#sr_result").hide();
								
								$("#sr_none h2").text("이미 신청한 회원입니다.");
								$("#id_input").val("");
							}	// notFind else if end
							else {
								if (data.user == null) {
									$("#sr_none").show();
									$("#sr_result").hide();
									
									$("#sr_none h2").text("ID가 존재하지 않습니다.");
									$("#id_input").val("");
								}	// null if end
								else {
									$("#sr_none").hide();
									$("#sr_result").show();
									
									$("#sr_result").html(`
												<div class="profile_img">
													<img alt="profile_img" src=\${ data.user.profile_url }>
												</div>
												<h2>\${ data.user.name }</h2>
												<input type="hidden" id="result_user_id" value=\${ data.user.user_id }>
												<input type="button" id="id_input_btn" value="추가">	
											`);
									$("#id_input").val("");
								}	// null else end
							}	// notFind else end
						}	// success end
					});	// ajax end
				}	// else end
			});	// 초대 그룹원 ID 검색 end
			
			// 초대 그룹원 추가
			$(document).on("click", "#id_input_btn", function() {
				let id = $("#result_user_id").val();
				
				$.ajax({
					url: "/group/schedule/invitation/signUp",
					data: {group_id: group_id, id: id},
					type: "post",
					dataType: "json",
					success: function(data) {
						window.location.reload();
					}	// success end
				})	// ajax end
			});	// 초대 그룹원 추가 end
			
			// 초대 승인
			$("#yesBtn").on("click", function() {
				if ($(".s_checkbox:checked").length == 0) {
					alert("회원을 선택하십시오.");
				}	// if end
				else {
					let formData = $("#list_form").serialize();			
					$.ajax({
						url: "/group/schedule/invitation/yes",
						data: formData,
						type: "post",
						dataType: "json",
						success: function(data) {
							alert("그룹에 총 " + data.cnt + "명의 멤버를 추가했습니다.");
							window.location.reload();
						}	// success end
					});	// ajax end
				}	// else end
			});	// 초대 승인 end
			
			// 초대 거절
			$("#noBtn").on("click", function() {
				if ($(".s_checkbox:checked").length == 0) {
					alert("회원을 선택하십시오.");
				}	// if end
				else {
					let formData = $("#list_form").serialize();			
					$.ajax({
						url: "/group/schedule/invitation/no",
						data: formData,
						type: "post",
						dataType: "json",
						success: function(data) {
							alert("총 " + data.cnt + "명의 신청을 삭제했습니다.");
							window.location.reload();
						}	// success end
					});	// ajax end
				}	// else end
			});	// 초대 거절 end
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- group invitation form -->
	<div id="group_invitation">
		<div id="host_info">
			<div class="profile_img">
				<img alt="profile_img" src="${ hostInfo.profile_url }">
			</div>
			<h1><span>${ group.group_name }</span><span> 그룹 초대</span></h1>
		</div>
		
		<div id="all_info">
			<div id="group_info">
				<div id="info_form_left">
					<input type="text" id="group_name" value="${ group.group_name }" readonly>
					<h3>개설자 : ${ hostInfo.name }</h3>
					<div id="info_imgs">
						<img id="info_frame" src="/img/액자.png">
						<div id="host_profile_img">
							<img src="${ hostInfo.profile_url }">							
						</div>
					</div>
				</div>
				<div id="info_form_right">
					<div id="info_form_right_top">
						<div id="ifrt_left">
							<h2>개설일<span>|</span></h2>
							<p>${ group.group_create_time }</p>
						</div>
						<div id="ifrt_right">
							<h2>종료일<span>|</span></h2>
							<p>${ group.project_end_time }</p>
						</div>
					</div>
					<div id="info_form_right_bottom">
						<h2>그룹 설명<span>|</span></h2>
						<textarea rows="4" cols="20" readonly>${ group.group_description }</textarea>
					</div>
				</div>
			</div>
			<c:choose>
				<c:when test="${ isIn != 'notMember' }">
					<input class="topBtns" id="linkCopyBtn" type="button" value="초대 링크 복사">
					
					<c:choose>
						<c:when test="${ isIn == 'host' }">
							<div id="host_mode">
								<form id="invitation_form">
									<div id="invitation_form_title">
										<h2>초대 그룹원 ID 검색</h2>
									</div>
									<div id="search_bottom">
										<div id="search_id">
											<input type="text" id="id_input" name="id_input" placeholder="ID를 입력하세요.">
							            	<img id="id_search_submit_btn" src="/img/search.svg" alt="search_submit_btn">
										</div>
										<div id="search_result">
											<div id="sr_none">
												<h2>ID 검색 결과</h2>
											</div>
											<div id="sr_result" style="display: none;"></div>
										</div>			
									</div>
								</form>
								<form id="list_form">
									<input type="hidden" name="group_id" value="${ group.group_id }">
									<div id="list_form_title">
										<h2>그룹 신청 회원 목록 (총 ${ signCnt }명)</h2>
									</div>
									<div id="list_bottom">
										<div id="list_left">
											<table id="list_table">
												<tr>
													<th>신청자</th>
													<th>신청날짜</th>
												<th>
												</tr>
												<c:forEach items="${ sign }" var="s">
													<tr>
														<td>
															<input id="${ s.user_id }" class="s_checkbox" type="checkbox" name="user_list" value=${ s.user_id }>
															<label for="${ s.user_id }" class="s_td">
																<span></span>
																<div class="s_info">
																	<div class="s_profile">
																		<img src="${ s.profile_url }">
																	</div>
																	<h2>${ s.name }</h2>																
																</div>
															</label>
														</td>
														<td><h3>${ s.invitation_time }</h3></td>
													</tr>
												</c:forEach>
											</table>
										</div>
										<div id="list_right">
											<input id="yesBtn" class="ynBtns" type="button" value="승인">
											<input id="noBtn" class="ynBtns" type="button" value="거절">
										</div>
									</div>
								</form>
							</div>
						</c:when>
					</c:choose>
				</c:when>
				<c:otherwise>
					<input class="topBtns" id="signGroupBtn" type="button" value="그룹 신청">
				</c:otherwise>
			</c:choose>		
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>