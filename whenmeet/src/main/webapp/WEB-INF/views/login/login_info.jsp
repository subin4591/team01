<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
    <link rel="stylesheet" href="/login_info.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h2>회원 정보</h2>
    <form>
        <div>
            <label for="id">아이디:</label>
            <input type="text" id="id" name="id" value="사용자 아이디" disabled>
        </div>
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" value="********" disabled>
        </div>
        <div>
            <label for="name">이름:</label>
            <input type="text" id="name" name="name" value="사용자 이름" disabled>
        </div>
        <div>
            <label for="address">주소:</label>
            <input type="text" id="address" name="address" value="사용자 주소" disabled>
            <button type="button" id="btnSearchAddress">우편번호 검색</button>
        </div>
        <div>
            <label for="phone">폰번호:</label>
            <input type="tel" id="phone" name="phone" value="사용자 폰번호" disabled>
            <button type="button" id="btnCheckPhone">중복 체크</button>
        </div>
        <div>
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" value="사용자 이메일" disabled>
            <button type="button" id="btnCheckEmail">중복 체크</button>
        </div>
        <div class="button-container">
            <input type="button" id="btnEdit" value="정보 수정">
            <input type="submit" id="btnSave" value="저장" disabled>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/login_info.js"></script>
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
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
    });
</script>
<%@ include file="footer.jsp" %>

</body>
</html>
