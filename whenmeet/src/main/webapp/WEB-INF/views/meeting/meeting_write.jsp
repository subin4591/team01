<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/footlogo.svg">
	<title>모집글 작성 | 언제만나</title>
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_write.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/ckeditor5/build/ckeditor.js"></script>
	<script>
		$(document).ready(function() {
			// password event
			$("#hidden_radio input").change(function() {
				if ($(this).val() == "공개") {
					$("#contents_password").val("");
				}
				$("#write_form_password").slideToggle(400);
			});
			
			// editor
			ClassicEditor.create(document.querySelector( '#editor' ));
			
			// submit event
			let title = $("#title");
			let wSubmit = $("#write_form_write_btn");
 			wSubmit.on("click", function() {
 				if (title.val() == "" || title.val() == "제목을 입력하세요.") {
					alert("제목을 입력하세요.");
				}
				else {
					$("#write_form").submit();
				}
			}); 
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- write_form -->
	<form id="write_form" action="/meeting/write/result" method="post">
		<input type="hidden" value="${ user_dto.user_id }" name="user_id">
		<input type="hidden" value="${ user_dto.name }" name="writer">
		<input type="hidden" value="${ user_dto.profile_url }" name="profile_url">
		
		<div id="write_form_caption">
			<div id="category_select">
				<label>카테고리</label>
				<select id="category" name="category">
					<option value="운동">운동</option>
					<option value="공부">공부</option>
					<option value="취미">취미</option>
					<option value="기타">기타</option>
				</select>			
			</div>
			<div id="hidden_radio">
				<input type="radio" name="hidden" value="공개" checked>공개
				<input type="radio" name="hidden" value="비공개">비공개
			</div>		
		</div>
		
		<div id="write_form_password" style="display: none;">
			<label>비밀번호</label>		
			<input type="password" name="contents_password" id="contents_password">
		</div>
				
		<input type="text" placeholder="제목을 입력하세요." name="title" id="title">
		<textarea name="contents" id="editor"></textarea>
		
		<div id="write_form_btn">
			<input id="write_form_cancel_btn" type="button" value="취소" onclick="location.href='/meeting'">
			<input id="write_form_write_btn" type="button" value="등록">			
		</div>
	</form>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>