<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/footlogo.svg">
	<title>모집글 | 언제만나</title>
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_detailed.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			// 비공개 게시글 event
			if ("${ dto.hidden }" == "비공개") {
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
			
			// 링크복사 event
			$("#copy_link_btn").on("click", function() {
				let temp = $("<input>");
				let link = location.href;
				
				$("body").append(temp);
				temp.val(link).select();
				document.execCommand("copy");
				temp.remove();
				alert("복사되었습니다.");
			});
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<div id="meeting_detailed_all">
		<c:choose>
			<c:when test="${ dto.end == '완료' }">
				<div id="end_text">			
					<h1>완료된 모집</h1>
				</div>
			</c:when>
		</c:choose>
		
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