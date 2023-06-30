$(document).ready(function() {
    // 우편번호 검색 버튼 클릭 시 동작
    $("#btnSearchAddress").click(function() {
        daum.postcode.load(function() {
            new daum.Postcode({
                oncomplete: function(data) {
                    $("#address").val(data.zonecode + " " + data.address);
                }
            }).open();
        });
    });

    // 네이버 CAPTCHA API 호출
    $.ajax({
        url: "https://openapi.naver.com/v1/captcha/nkey?code=CODE_FROM_DEVELOPER_PORTAL",
        headers: {
            "X-Naver-Client-Id": "YOUR_CLIENT_ID",
            "X-Naver-Client-Secret": "YOUR_CLIENT_SECRET"
        },
        type: "GET",
        success: function(data) {
            var key = data.key;
            // 네이버 CAPTCHA 이미지 생성
            $.ajax({
                url: "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + key,
                headers: {
                    "X-Naver-Client-Id": "YOUR_CLIENT_ID",
                    "X-Naver-Client-Secret": "YOUR_CLIENT_SECRET"
                },
                type: "GET",
                dataType: "text",
                success: function(data) {
                    $("#captcha").html("<img src='data:image/jpeg;base64," + data + "'/>");
                    $("#captcha").append("<input type='hidden' name='key' value='" + key + "'>");
                }
            });
        }
    });

    // 회원가입 폼 제출 시 동작
    $("form").submit(function(event) {
        event.preventDefault();
        var formData = $(this).serialize();
        // TODO: 서버로 회원가입 데이터 전송 및 처리
        console.log(formData);
    });
});
