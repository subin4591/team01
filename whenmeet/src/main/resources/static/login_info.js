

    $(document).ready(function() {
    $("#btnEdit").click(function() {
        $("input:not(#id)").removeAttr("disabled");
        $("#btnSave").removeAttr("disabled");
        $(this).attr("disabled", "disabled");
    });

    $("#btnSearchAddress").click(function() {
        // TODO: 우편번호 검색 기능 구현
        console.log("우편번호 검색");
    });

    $("#btnCheckPhone").click(function() {
        // TODO: 폰번호 중복 체크 기능 구현
        console.log("폰번호 중복 체크");
    });

    $("#btnCheckEmail").click(function() {
        // TODO: 이메일 중복 체크 기능 구현
        console.log("이메일 중복 체크");
    });

});

