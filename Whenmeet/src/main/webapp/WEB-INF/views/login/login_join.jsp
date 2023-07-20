<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="login_join.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    // 중복 체크 버튼 클릭 시 동작
    function checkId() {
      var user_id = $('#user_id').val();
      $.ajax({
        url: './idCheck',
        type: 'post',
        data: { user_id: user_id },
        success: function(cnt) {
          if (cnt == 0) {
            $('.id_ok').css("display", "inline-block");
            $('.id_already').css("display", "none");
          } else {
            $('.id_already').css("display", "inline-block");
            $('.id_ok').css("display", "none");
            alert("아이디를 다시 입력해주세요");
            $('#user_id').val('');
          }
        },
        error: function() {
          alert("에러입니다");
        }
      });
    }
  </script>
  <script>
  // 중복 체크 버튼 클릭 시 동작
  function checkEmail() {
    var email = $('#email').val();
    $.ajax({
      url: './emailCheck',
      type: 'post',
      data: { email: email },
      success: function(cnt) {
        if (cnt == 0) {
          $('.email_ok').css("display", "inline-block");
          $('.email_already').css("display", "none");
        } else {
          $('.email_already').css("display", "inline-block");
          $('.email_ok').css("display", "none");
          alert("이미 사용 중인 이메일입니다.");
          $('#email').val('');
        }
      },
      error: function() {
        alert("에러입니다");
      }
    });
  }

  $(document).ready(function() {
    // email 입력란에서 입력이 발생하면 checkEmail() 함수가 호출됩니다.
    $('#email').on('input', checkEmail);
  });
</script>
<script src="login_join.js"></script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="container">
  <h2>회원가입</h2>
  <form action="/signup" method="POST">
    <div>
      <label for="id">아이디 :</label>
		<input type="text" id="user_id" name="user_id" >
      <!-- id ajax 중복체크 -->
	<span class="id_ok">사용 가능한 아이디입니다.</span>
	<span class="id_already">누군가 이 아이디를 사용하고 있어요.</span>
      
    </div>
    <div>
      <label for="password">비밀번호 :</label>
      <input type="password" id="password" name="pw" required>
    </div>
    <div>
      <label for="name">이름 :</label>
      <input type="text" id="name" name="name" required>
    </div>
    <div>
      <label for="address">주소 :</label>
      <input type="text" id="address" name="address" required>
      <button type="button" id="btnSearchAddress">우편번호 검색</button>
    </div>
    <div>
      <label for="phone">핸드폰 :</label>
      <input type="tel" id="phone" name="phone" required>
    </div>
    <div>
  		<label for="email">이메일 :</label>
  		<input type="email" id="email" name="email" oninput="checkEmail()" required>
  		<span class="email_ok">사용 가능한 이메일입니다.</span>
  		<span class="email_already">이미 사용 중인 이메일입니다.</span>
	</div>
    <div>
      <label for="profile">프로필 사진 :</label>
      <input type="file" id="profile" name="profile_url" accept=".jpg" required>
    </div>
    <div id="captcha"></div>
  <input type="submit" value="가입하기">
  </form>
</div>
<%@ include file="footer.jsp" %>
<script>
  $(document).ready(function() {
    // user_id 입력란에서 입력이 발생하면 checkId() 함수가 호출됩니다.
    $('#user_id').on('input', checkId);
  });
</script>
</body>
</html>
