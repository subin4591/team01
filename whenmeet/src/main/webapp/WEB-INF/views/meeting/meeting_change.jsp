<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	<title>모집글 수정 | 언제만나</title>
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_change.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/ckeditor5/build/ckeditor.js"></script>
	<script>
		$(document).ready(function() {
			// editor
			let editor;
			ClassicEditor
			    .create( document.querySelector( '#editor' ) )
			    .then( newEditor => {
			        editor = newEditor;
			        editor.setData("${ dto.contents }");
			    } )
			    .catch( error => {
			        console.error( error );
			    } );
			
			// submit event
			let title = $("#title");
			let cSubmit = $("#change_form_change_btn");
 			cSubmit.on("click", function() {
				let conLen = editor.getData().length;
 				
 				if (title.val() == "" || title.val() == "제목을 입력하세요.") {
					alert("제목을 입력하세요.");
				}
 				else if (conLen == 0) {
 					alert("내용을 입력하세요.");
 				}
 				else if (conLen >= 4000) {
 					alert("4000자 까지 입력할 수 있습니다.");
 				}
				else {
					$("#change_form").submit();
				}
			});
 			
 			// selected, checked event
 			let category = $("#category option");
 			category.each(function() {
 				if ($(this).val() == "${ dto.category }") {
 					$(this).prop("selected", true);
 				}
 			});
 			
 			let hidden_radio = $("#hidden_radio *");
 			hidden_radio.each(function() {
 				if ($(this).val() == "${ dto.hidden }") {
 					$(this).prop("checked", true);
 				}
 			});
 			
 			// password event
 			$("#contents_password").on("keyup", function() {
				let text_len = $(this).val().length;
	            let text_max = 20;
	            if (20 - text_len <= 0) {
	            	alert(text_max + "자 까지 입력할 수 있습니다.");
	                $(this).val("");
	            }
			});
 			
 			if ("${ dto.hidden }" == "공개") {
				$("#change_form_password").hide();
			}
 			
			$("#hidden_radio input").change(function() {
				if ($(this).val() == "공개") {
					$("#contents_password").val("");
				}
				$("#change_form_password").slideToggle(400);
			});
			
			// title event
			$("#title").on("keyup", function() {
				let text_len = $(this).val().length;
	            let text_max = 100;
	            if (100 - text_len <= 0) {
	            	alert(text_max + "자 까지 입력할 수 있습니다.");
	                $(this).val($(this).val().slice(0, 90));
	            }
			});
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- change_form -->
	<form id="change_form" action="/meeting/change/result" method="post">
		<input type="hidden" value="${ dto.seq }" name="seq">
		<div id="change_form_caption">
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
				<input type="radio" name="hidden" value="공개">공개
				<input type="radio" name="hidden" value="비공개">비공개
			</div>		
		</div>
		
		<div id="change_form_password">
			<label>비밀번호</label>		
			<input type="password" name="contents_password" id="contents_password" value="${ dto.contents_password }">
		</div>
				
		<input type="text" value="${ dto.title }" name="title" id="title">
		<textarea name="contents" id="editor"></textarea>
		
		<div id="change_form_btn">
			<input id="change_form_cancel_btn" type="button" value="취소" onclick="location.href='/meeting'">
			<input id="change_form_change_btn" type="button" value="수정">			
		</div>
	</form>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>