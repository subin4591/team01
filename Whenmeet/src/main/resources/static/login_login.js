
// 로그인 폼 제출 시 동작
$("form").submit(function(event) {
    event.preventDefault();
    var formData = $(this).serialize();
    // TODO: 로그인 데이터 전송 및 처리
    console.log(formData);
});


