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
});
