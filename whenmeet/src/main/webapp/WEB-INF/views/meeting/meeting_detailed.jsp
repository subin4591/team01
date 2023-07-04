<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	<title>모집글 | 언제만나</title>
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_detailed.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/js/meeting.js"></script>
	<script>
		$(document).ready(function() {
			/// 게시글
			// 비공개 게시글 event
			if ("${ dto.hidden }" == "비공개" && "${ session_id }" != "${ dto.user_id }") {
				$("#meeting_detailed_all").hide();
				$("#hidden_popup").show();
				
				$("#popup_confirm").on("click", function() {
					if ($("#popup_password").val() == "${ dto.contents_password }") {
						$("#meeting_detailed_all").show();
						$("#hidden_popup").hide();
					}
					else {
						alert("비밀번호가 틀렸습니다.");
					}
				});
			};
			
			// 완료 모집글 event
			if (${ dto.end == '완료'}) {
				$("#meeting_detailed_all").prepend("<div id='end_text'><h1>완료된 모집</h1></div>");
				$("#applicant_form").hide();
			}
			
			// 링크복사 event
			$("#copy_link_btn").on("click", function() {
				let temp = $("<textarea>");
				let title = "[" + "${ dto.title }" + "]\n"
				let link = "URL : " + location.href + "\n";
				let password = "PW : " + "${ dto.contents_password }";
				
				$("body").append(temp);
				
				if (${ dto.contents_password == null } || ${ dto.contents_password == "" }) {
					password = "PW : 없음";
				}
				
				temp.val(title + link + password).select();
				document.execCommand("copy");
				temp.remove();
				alert("복사되었습니다.");
			});
			
			// 삭제 event
			$("#contents_delete_btn").on("click", function() {
				let reallyDelete = confirm("정말 삭제하시겠습니까?");
				if (reallyDelete) {
					let seq = ${ dto.seq };
					
					// form 태그 생성 및 submit
					let deleteForm = $("<form></form>");
					deleteForm.attr("action", "/meeting/delete");
					deleteForm.attr("method", "post");
					deleteForm.append($("<input>", {type: "hidden", name: "seq", value: seq}));
					
					$("body").append(deleteForm);
					
					deleteForm.submit();
				}
			})
			
			
			/// 신청 댓글
			// 기본 page active event
			if ("${ session_id }" != "${ dto.user_id }") {
				$("#applicant_page_nums").html(makePage(${ total_cnt }, ${ div_num }));
				pageActive("time", 1);				
			}
			else {
				if (${ dto.end != '완료'}) {
					$("#management_page_nums").html(makePage(${ total_cnt_wt }, ${ div_num }));
					pageActive("yet", 1);
					
					$("#meeting_applicant").hide();
					$("#writer_mode").show();
				}
				else {
					$("#applicant_page_nums").html(makePage(${ total_cnt }, ${ div_num }));
					pageActive("time", 1);	
				}
			}
			
			// 신청 댓글 글자수 제한 event
			$("#app_contents").on("keyup", function() {
				let text_len = $(this).val().length;
	            let text_max = 500;
	            if (500 - text_len > 0) {
	                $("#app_th").text(text_len + "/" + text_max);
	            }
	            else {
	                alert(text_max + "자 까지 입력할 수 있습니다.");
	                $(this).val($(this).val().slice(0, 450));
	                text_len = $(this).val().length;
	                $("#app_th").text(text_len + "/" + text_max);
	            }
			});
			$(document).on("keyup", "#my_app_contents", function() {
				let text_len = $(this).val().length;
	            let text_max = 500;
	            if (500 - text_len > 0) {
	                $("#my_app_th").text(text_len + "/" + text_max);
	            }
	            else {
	                alert(text_max + "자 까지 입력할 수 있습니다.");
	                $(this).val($(this).val().slice(0, 450));
	                text_len = $(this).val().length;
	                $("#my_app_th").text(text_len + "/" + text_max);
	            }
			});
			
			// 신청 댓글 submit
			$("#app_submit").on("click", function() {
				// 로그인 여부 확인
				if (${ session_id != null }) {
					// 중복 여부 확인
					if (${ user_app_cnt } > 0) {
						alert("신청은 한 번만 할 수 있습니다.");
					}
					else {
						// 댓글 공백 여부 확인
						if ($("#app_contents").val() == "") {
							alert("신청 댓글을 입력하세요.");
						}
						else {
							let formData = $("#applicant_form").serialize();
							$.ajax({
								url: "/meeting/applicantInsert",
								data: formData,
								type: "post",
								dataType: "json",
								success: function(data) {
									// page active event
									$("#applicant_page_nums").show();
									$("#applicant_page_nums").html(makePage(data.total_cnt, data.div_num));
									pageActive("time", 1);
									
									// 모임신청 총 개수
									$("#applicant_ul_caption h2").text("모임신청 총 " + data.total_cnt + "개");
									
									// 신청 댓글 목록
									let au = $("#applicant_ul");
									au.html("");
									
									for (let a = 0; a < data.app_list.length; a++) {
										let a_user = data.app_list[a].user_id;
										let ma = new MeetingApp(
												data.app_list[a].profile_url,
												data.app_list[a].name,
												data.app_list[a].applicant_time,
												data.app_list[a].approval,
												data.app_list[a].contents
											);
										// 본인 댓글이면
										if ("${ session_id }" == a_user) {
											au.append(ma.printLiMy());
										}	// if end
										// 본인 댓글이 아니면
										else {
											au.append(ma.printLi());
										}	// else end
									}	// for end
								}	// success end
							});	// ajax end
						}
					}
				}
				else {
					alert("로그인 후에 작성할 수 있습니다.");
				}
			});
			
			/// sort ajax event
			$(".sort_a[data-target='time']").on("click", function(event) {
				event.preventDefault();
				let seq = ${ dto.seq };
				
				$.ajax({
					url: "/meeting/applicantSort",
					data: {seq: seq},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						pageActive("time", 1);
						$("#applicant_page_nums").show();
						
						// 신청 댓글 목록
						let au = $("#applicant_ul");
						au.html("");
						
						for (let a = 0; a < data.length; a++) {
							let a_user = data[a].user_id;
							let ma = new MeetingApp(
									data[a].profile_url,
									data[a].name,
									data[a].applicant_time,
									data[a].approval,
									data[a].contents
								);
							// 본인 댓글이면
							if ("${ session_id }" == a_user) {
								au.append(ma.printLiMy());
							}	// if end
							// 본인 댓글이 아니면
							else {
								au.append(ma.printLi());
							}	// else end
						}	// for end
					}	// success end
				});	// ajax end
			});	// sort ajax event end
			
			/// page event
			$(document).on("click", ".page_a", function(event) {
				event.preventDefault();
				let seq = ${ dto.seq };
				let page = $(this).data("target");
				
				$.ajax({
					url: "/meeting/applicantPage",
					data: {seq: seq, page: page},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						pageActive("time", page);
						
						// 신청 댓글 목록
						let au = $("#applicant_ul");
						au.html("");
						
						for (let a = 0; a < data.length; a++) {
							let a_user = data[a].user_id;
							let ma = new MeetingApp(
									data[a].profile_url,
									data[a].name,
									data[a].applicant_time,
									data[a].approval,
									data[a].contents
								);
							// 본인 댓글이면
							if ("${ session_id }" == a_user) {
								au.append(ma.printLiMy());
							}	// if end
							// 본인 댓글이 아니면
							else {
								au.append(ma.printLi());
							}	// else end
						}	// for end
					}	// success end
				});	// ajax end
			});	// page event end
			
			// my event
			$(".sort_a[data-target='my']").on("click", function(event) {
				event.preventDefault();
				let seq = ${ dto.seq };
				let user_id = "${ session_id }";
				
				$.ajax({
					url: "/meeting/applicantMy",
					data: {seq: seq, user_id: user_id},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						pageActive("my", 1);
						$("#applicant_page_nums").hide();
						
						// 신청 댓글 목록
						let au = $("#applicant_ul");
						au.html("");
						
						if (data.user_id != "none") {
							let ma = new MeetingApp(
									data.profile_url,
									data.name,
									data.applicant_time,
									data.approval,
									data.contents
								);
							au.html(ma.printLiMy());
						}
					}	// success end
				});	// ajax end
			});	// my event end
			
			// 신청 댓글 수정 event
			$(document).on("click", "#app_list_change", function() {
				let myAppHtml = $("#my_app").html();
				let appCon = $("#my_app .app_list_contents p").text();
				let appLen = appCon.length;
				$("#my_app").html(`<form id="my_app_form">
								<input type="hidden" name="seq" value="${ dto.seq }">
								<input type="hidden" name="user_id" value="${ session_id }">
								<div id="my_app_caption">
									<label>신청자</label>
									<input id="my_app_user_name" name="name" type="text" value="${ user_dto.name }" readonly>
								</div>
								<textarea id="my_app_contents" name="contents" rows="4" cols="80" placeholder="신청 댓글을 입력하세요.">\${ appCon }</textarea>
								<div id="my_app_bottom">
									<p id="my_app_th">\${ appLen }/500</p>
									<div>
										<input id="my_app_cancel" type="button" value="취소">
										<input id="my_app_submit" type="button" value="수정">
									</div>
								</div>
							</form>`);
				$("#my_app_cancel").on("click", function() {
					$("#my_app").html(myAppHtml);
				});	// cancel end
				$("#my_app_submit").on("click", function() {
					let formData = $("#my_app_form").serialize();
					$.ajax({
						url: "/meeting/applicantChange",
						data: formData,
						type: "post",
						dataType: "json",
						success: function(data) {
							// page active event
							pageActive("my", 1);
							$("#applicant_page_nums").hide();
							
							// 신청 댓글 목록
							let au = $("#applicant_ul");
							let ma = new MeetingApp(
									data.profile_url,
									data.name,
									data.applicant_time,
									data.approval,
									data.contents
								);
							au.html(ma.printLiMy());
						}
					});	// ajax end
				});	// submit end
			});	// 신청 댓글 수정 event end
			
			// 신청 댓글 삭제 event end
			$(document).on("click", "#app_list_cancel", function() {
				let reallyDelete = confirm("정말 삭제하시겠습니까?");
				if (reallyDelete) {
					let seq = ${ dto.seq };
					let user_id = "${ session_id }";
					
					$.ajax({
						url: "/meeting/applicantDelete",
						data: {seq: seq, user_id: user_id},
						type: "post",
						dataType: "json",
						success: function(data) {
							// page active event
							$("#applicant_page_nums").show();
							$("#applicant_page_nums").html(makePage(data.total_cnt, data.div_num));
							pageActive("time", 1);
							
							// 모임신청 총 개수
							$("#applicant_ul_caption h2").text("모임신청 총 " + data.total_cnt + "개");
							
							// 신청 댓글 목록
							let au = $("#applicant_ul");
							au.html("");
							
							for (let a = 0; a < data.app_list.length; a++) {
								let ma = new MeetingApp(
										data.app_list[a].profile_url,
										data.app_list[a].name,
										data.app_list[a].applicant_time,
										data.app_list[a].approval,
										data.app_list[a].contents
									);
								au.append(ma.printLi());
							}	// for end
						}	// success end
					});	// ajax end
				}	// if end
			});	// 신청 댓글 삭제 event end
			
			// writer mode 전체 선택 event
			$("#select_all").on("click", function() {
				if($(this).is(":checked")) {
					$("#management_ul").find("input[type='checkbox']").prop("checked", true);
				}
				else {
					$("#management_ul").find("input[type='checkbox']").prop("checked", false);
				}
			});	// writer mode 전체 선택 event end
			
			// writer mode 결정 event
			$("#man_ok_btn").on("click", function() {
				let formData = $("#writer_mode_form").serialize();
				let total_cnt = ${ total_cnt };
				$.ajax({
					url: "/meeting/writerMode",
					data: formData,
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						$("#management_page_nums").html(makePage(data.total_cnt, data.div_num));
						pageActive("yet", 1);
						
						// 모임신청 총 개수
						$("#management_ul_caption h2").text("모임신청 총 (" + data.total_cnt + "/" + total_cnt + ")개");
						
						// 신청 댓글 목록
						let au = $("#management_ul");
						au.html("");
						
						for (let a = 0; a < data.app_list.length; a++) {
							let ma = new MeetingApp(
									data.app_list[a].profile_url,
									data.app_list[a].name,
									data.app_list[a].applicant_time,
									data.app_list[a].approval,
									data.app_list[a].contents,
									data.app_list[a].user_id
								);
							au.append(ma.printLiWt());
						}	// for end
					}	// success end
				});	// ajax end
			});	// writer mode 결정 event end
			
			// writer mode sort event
			$("#management_sort a").on("click", function(event) {
				event.preventDefault();
				let seq = ${ dto.seq };
				let sort = $(this).data("target");
				
				$.ajax({
					url: "/meeting/writerModeSort",
					data: {seq: seq, sort: sort},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						$("#management_page_nums").html(makePage(data.total_cnt, data.div_num));
						pageActive(sort, 1);
						
						// 총 개수
						$("#management_ul_caption h2").text("모임신청 총 (" + data.total_cnt + "/" + ${ total_cnt } + ")개");
						
						// 신청 댓글 목록
						let au = $("#management_ul");
						au.html("");
						
						for (let a = 0; a < data.app_list.length; a++) {
							let ma = new MeetingApp(
									data.app_list[a].profile_url,
									data.app_list[a].name,
									data.app_list[a].applicant_time,
									data.app_list[a].approval,
									data.app_list[a].contents,
									data.app_list[a].user_id
								);
							au.append(ma.printLiWt());
						}	// for end
					}
				});
			});
		});	// document ready end
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<div id="meeting_detailed_all">
		<div id="meeting_detailed">
			<div id="contents_caption">
				<p id="contents_category">${ dto.category }</p>
				<p>${ dto.hidden }</p>
			</div>
			
			<h1 id="contents_title">${ dto.title }</h1>
			
			<div id="contents_info">
				<div id="contents_writer_info">
					<img id="writer_profile" alt="writer_profile" src="${ dto.profile_url }">
					<p id="writer_name">${ dto.writer }</p>
				</div>
				<div id="contents_info_text">
					<p>신청자 ${ dto.applicant_cnt }</p>
					<p>조회 ${ dto.hits }</p>
					<p>${ dto.writing_time }</p>
				</div>
			</div>
			
			<div id="copy_link">			
				<input id="copy_link_btn" type="button" value="링크복사">
			</div>
			
			<div id="contents">
				${ dto.contents }
			</div>
			
			<div id="contents_btn">
				<div id="contents_btn_left">
					<input id="contents_list_btn" type="button" value="목록" onclick="location.href='/meeting'">
				</div>
				
				<c:choose>
					<c:when test="${ session_id == dto.user_id }">
						<div id="contents_btn_right">
						
						<c:choose>
							<c:when test="${ dto.end == '완료' }">
								<input id="contents_delete_btn" type="button" value="삭제">						
							</c:when>
							<c:otherwise>
								<input id="contents_change_btn" type="button" value="수정" onclick="location.href='/meeting/change?seq=${ dto.seq }'">
								<input id="contents_delete_btn" type="button" value="삭제">											
							</c:otherwise>					
						</c:choose>
						
						</div>				
					</c:when>
				</c:choose>
			</div>
		</div>
		
		<div id="meeting_applicant">
			<!-- not writer mode -->
			<form id="applicant_form">
				<input type="hidden" name="seq" value="${ dto.seq }">
				<input type="hidden" name="user_id" value="${ session_id }">
				<input type="hidden" name="approval" value="대기">
				<input type="hidden" name="profile_url" value="${ user_dto.profile_url }">
				<div id="app_cation">				
					<label>신청자</label>
					<input id="app_user_name" name="name" type="text" value="${ user_dto.name }" readonly>
				</div>
				
				<c:choose>
	            	<c:when test="${ session_id != null }">
	            		<textarea id="app_contents" name="contents" rows="4" cols="80" placeholder="신청 댓글을 입력하세요."></textarea>
	            	</c:when>
	            	<c:otherwise>
	            		<textarea id="app_contents" name="contents" rows="4" cols="80" placeholder="로그인 후에 작성할 수 있습니다." readonly></textarea>
	            	</c:otherwise>
            	</c:choose>
            	
            	<div id="app_bottom">
                	<p id="app_th">0/500</p>
                	<input id="app_submit" type="button" value="등록">
            	</div>
			</form>
			
			<div id="applicant_ul_caption">
				<h2>모임신청 총 ${ total_cnt }개</h2>
				<div id="applicant_sort">
					<a href="" class="sort_a" data-target="time">최신순</a>
					<a href="" class="sort_a" data-target="my">내신청</a>
				</div>
			</div>
			
			<ul id="applicant_ul">
				<c:forEach items="${ app_list }" var="a">
					<c:choose>
						<c:when test="${ session_id == a.user_id }">
							<li id="my_app">
								<div class="app_list_caption">
									<img class="app_list_profile" alt="app_list_profile" src="${ a.profile_url }">
									<div class="app_list_info">
										<label class="app_list_name">${ a.name }</label>
										<label class="app_list_time">${ a.applicant_time }</label>
									</div>
									<label class="app_list_approval">${ a.approval }</label>						
								</div>
								
								<div class="app_list_contents">
									<p>${ a.contents }</p>
								</div>
								
								<div class="app_list_btn">
									<input id="app_list_change" type="button" value="수정">
									<input id="app_list_cancel" type="button" value="삭제">
								</div>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<div class="app_list_caption">
									<img class="app_list_profile" alt="app_list_profile" src="${ a.profile_url }">
									<div class="app_list_info">
										<label class="app_list_name">${ a.name }</label>
										<label class="app_list_time">${ a.applicant_time }</label>
									</div>
									<label class="app_list_approval">${ a.approval }</label>						
								</div>
								
								<div class="app_list_contents">
									<p>${ a.contents }</p>
								</div>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			
			<div id="applicant_page_nums"></div>
		</div>
		
		<!-- writer mode -->
		<div id="writer_mode">
			<div id="management_ul_caption">
				<h2>모임신청 총 (${ total_cnt_wt }/${ total_cnt })개</h2>
				<div id="management_sort">
					<a href="" class="sort_a" data-target="yet">대기</a>
					<a href="" class="sort_a" data-target="ready">완료</a>
				</div>
			</div>
			
			<form id="writer_mode_form">
				<input type="hidden" name="seq" value="${ dto.seq }">
				<div id="management_caption">
					<div id="man_select_all">
						<label>전체선택</label>
						<input id="select_all" class="man_checkboxs" type="checkbox">
						<label for="select_all"></label>					
					</div>
					<div id="man_right">
						<select id="man_select" name="approval">
							<option value="승인" selected>승인</option>
							<option value="거절">거절</option>
						</select>
						<input id="man_ok_btn" type="button" value="결정">
					</div>
				</div>
				
				<ul id="management_ul">
					<c:forEach items="${ app_list_wt }" var="a">
						<li>
							<div class="man_chk_list">
								<input id="ch_${ a.user_id }" class="man_checkboxs" type="checkbox" name="user_id" value="${ a.user_id }">
								<label for="ch_${ a.user_id }"></label>
							</div>
							<div class="man_list_caption">
								<img class="man_list_profile" alt="man_list_profile" src="${ a.profile_url }">
								<div class="man_list_info">
									<label class="man_list_name">${ a.name }</label>
									<label class="man_list_time">${ a.applicant_time }</label>
								</div>
								<label class="man_list_approval">${ a.approval }</label>						
							</div>
							
							<div class="man_list_contents">
								<p>${ a.contents }</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</form>
			
			<div id="management_page_nums"></div>
		</div>
	</div>
	
	<!-- hidden popup -->
	<div id="hidden_popup" style="display: none;">
		<div id="hidden_popup_p">
			<p>비공개 모집글입니다.</p>
			<p>비밀번호를 입력하세요.</p>		
		</div>
		<input id="popup_password" type="password">
		<div id="popup_btn">
			<input id="popup_cancel" type="button" value="취소" onclick="location.href='/meeting'">
			<input id="popup_confirm" type="button" value="확인">		
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>