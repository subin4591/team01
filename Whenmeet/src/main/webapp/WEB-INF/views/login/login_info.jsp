<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
    <link rel="stylesheet" href="/login_info.css">
</head>
<script src="js/jquery-3.6.4.min.js"></script>
<body>
<%@ include file="../header.jsp" %>
<article>
    <h2>내 정보</h2>
    <form  method="post" >
        <table id='myinfo'>
            <tr>
                <td>아이디</td>
                <td>${dto.user_id}
                <input type="hidden" name="user_id" value="${dto.user_id}">
                </td>
            </tr>
            <tr>
            	<td>비밀번호</td>
            	<td><input type="text" name="pw" value="${dto.pw}">
            	</td>
            <tr>
                <td>이름</td>
                <td><input type="text" name="name" value="${dto.name}"></td>
            </tr>
            <tr>
                <td>주소</td>
                <td><input type="text" name="address" value="${dto.address}"></td>
            </tr>
            <tr>
                <td>휴대폰번호</td>
                <td><input type="text" name="phone" value="${dto.phone}"></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><input type="text" name="email" value="${dto.email}"></td>
            </tr>
            <tr>
                <td>프로필 사진</td>
                <td><input type="file" name="profile" accept="image/jpeg, image/png"></td>
            </tr>
            <tr>
                <td>정보 수정 및 탈퇴</td>
                <td>
                    <button type="button" id="UserUpdateButton">회원정보수정</button>
                    <button id="deleteUser">회원탈퇴</button>
                </td>
            </tr>
        </table>
    </form>
</article>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/login_info.js"></script>
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
    	
    	function showUserUpdateAlert() {
            alert("사용자 정보가 성공적으로 수정되었습니다!");
        }

        $("#UserUpdateButton").click(function() {
            // 파일 업로드
            //alert("UserUpdateButton");
            // action="updateMember"
            $("form").attr("action", "updateMember");
            $("form").submit();
        });

    	 $("#deleteUser").click(function() {
 	    	//파일 업로드 
 	    	alert("deleteUser");
 	    	//action="updateMember"
 	    	$("form").attr("action", "deleteMember");
 	    	$("form").submit();
 	    });
    	 
        // 우편번호 검색 버튼 클릭 시 동작
        $("#btnSearchAddress").click(function() {
            if (typeof daum === 'undefined' || typeof daum.postcode === 'undefined') {
                // API 스크립트가 로드되지 않았을 경우
                console.log('우편번호 API 스크립트 로드 중...');
                var script = document.createElement('script');
                script.src = '//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js';
                script.onload = function() {
                    console.log('우편번호 API 스크립트 로드 완료');
                    new daum.Postcode({
                        oncomplete: function(data) {
                            $("#address").val(data.zonecode + " " + data.address);
                        }
                    }).open();
                };
                document.head.appendChild(script);
            } else {
                // API 스크립트가 이미 로드된 경우
                new daum.Postcode({
                    oncomplete: function(data) {
                        $("#address").val(data.zonecode + " " + data.address);
                    }
                }).open();
            }
        });
        
        // 회원탈퇴 버튼 클릭 시 동작
        $("#deleteUser").click(function() {
            if (confirm("정말로 회원 탈퇴하시겠습니까?")) {
                location.href = "/deleteMember";
            }
        });
    });
</script>
<%@ include file="footer.jsp" %>

</body>
</html>
