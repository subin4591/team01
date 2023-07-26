<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	$("#UserUpdateButton").on('click',function(){
		$.ajax({
			url:'updateuser',
			data: {
				'userid':"${loginUser.user_id}",
				'pw':$("#pw").val(),
				'phone':$("#phone").val(),
				'email':$("#email").val()
			},
			type:'post',
			success:function(res){
				alert("회원정보 수정이 완료되었습니다.");
				location.href = "/myinfo"
			},
			error:function(request,status,e){
				alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
			}
		}); //ajax
	});
});
</script>
<body>
<%@ include file="header.jsp" %>

<article>
		<form name="signUpForm">
		<h2>내정보</h2>
			<div class='formindiv'>
				<p>아이디(수정불가)</p>
				<div id=id_div>
					<input type="text" name="user_id" id="user_id" value="${loginUser.user_id}" maxlength="16" readonly>
				</div>
			</div>

			<div class='formindiv'>
				<p>비밀번호</p>
				<label><input type="password" name="pw" id="pw" value="${loginUser.pw}" maxlength="16"></label>
			</div>

			<div class='formindiv'>
				<p>이름(수정불가)</p>
				<input type="text" name="name" id="name" value="${loginUser.name}" readonly>
			</div>
			
			<div class='formindiv'>
				<p>주소</p>
				<label><input type="" name="address" id="address" value="${loginUser.address}"></label>
			</div>

			<div class='formindiv'>
				<p>휴대폰번호</p>
				<input type="tel" name="phone" id="phone" value="${loginUser.phone}">
			</div>

			<div class='formindiv'>
				<p>이메일</p>
				<input type="tel" name="email" id="email" value="${loginUser.email}">
			</div>

			<div class='formindiv'>
				<button type="button" id="UserUpdateButton">수정완료</button>
			</div>

		</form>
	</article>

<%@ include file="footer.jsp" %>
</body>
</html>