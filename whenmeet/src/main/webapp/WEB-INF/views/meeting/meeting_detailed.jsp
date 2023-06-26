<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/footlogo.svg">
	<title>모임 | 언제만나</title>
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_detailed.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
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
						<input id="contents_change_btn" type="button" value="수정" onclick="location.href='/meeting/change?seq=${ dto.seq }'">
						<input id="contents_delete_btn" type="button" value="삭제">						
					</div>				
				</c:when>
			</c:choose>
		</div>
	</div>
	
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>