<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="/css/footer.css" rel=stylesheet>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
	$(document).ready(function() {
		// 스크롤 위치에 따른 버튼 표시 여부
		$(window).scroll(function() {
			if ($(window).scrollTop() > 300) {
				$("#go_top").show();
			}
			else {
				$("#go_top").hide();
			}
		});
		
		// 페이지 맨 위로 스크롤 이동
		$("#go_top").on("click", function() {
			window.scrollTo({
				top: 0,
				behavior: "smooth"
			});
		});
	});
</script>
<button id="go_top">^<br>TOP</button>
<footer>
	<p id="footer_left">When will I meet you<p>
	<p id="footer_right">
		대표 : 언제만나조<br>
		전화번호 : 010-9876-5432<br>
		주소 : Zoom 소회의실 1
	</p>
</footer>