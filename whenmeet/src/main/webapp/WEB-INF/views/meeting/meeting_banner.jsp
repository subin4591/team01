<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/css/meeting/meeting_banner.css" rel=stylesheet>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
	$(document).ready(function() {
		/// banner event
		// banner text
		let banner_tit_list = [`${ all_banner.title }`, 
			`${ exercise_banner.title }`, 
			`${ hobby_banner.title }`, 
			`${ study_banner.title }`,
			`${ etc_banner.title }`];
		let banner_con_list = [`${ all_banner.contents }`, 
			`${ exercise_banner.contents }`, 
			`${ hobby_banner.contents }`, 
			`${ study_banner.contents }`,
			`${ etc_banner.contents }`];
		
		for (let i = 0; i < banner_con_list.length; i++) {
			let t = banner_tit_list[i];
			let c = banner_con_list[i];
			
			console.log(t.length);
			
			// 모집글 내용 html 태그 제거
			c = $("<div>").html(c).text();
			
			// 글자수 제한
			if (t.length > 20)
				t = t.substring(0, 20) + "...";
			if (c.length > 50)
				c = c.substring(0, 50) + "...";
			
			banner_tit_list[i] = t;
			banner_con_list[i] = c;
		}
		$("#all_title").text(banner_tit_list[0]);
		$("#exercise_title").text(banner_tit_list[1]);
		$("#hobby_title").text(banner_tit_list[2]);
		$("#study_title").text(banner_tit_list[3]);
		$("#etc_title").text(banner_tit_list[4]);
		
		$("#all_contents").text(banner_con_list[0]);
		$("#exercise_contents").text(banner_con_list[1]);
		$("#hobby_contents").text(banner_con_list[2]);
		$("#study_contents").text(banner_con_list[3]);
		$("#etc_contents").text(banner_con_list[4]);
		
		// banner size
		let banner = $("#banner").find("ul");
		let bannerWidth = banner.children().outerWidth();
		let bannerHeight = banner.children().outerHeight();
		let imgLen = banner.children().length;
		
		// banner function
		function rollingRight() {
			banner.css({
				"width": bannerWidth * imgLen + "px",
				"height": bannerHeight + "px"
			});
			
			banner.animate({
					left: -bannerWidth + "px"
				}, 1500, function() {
					$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
					$(this).find("li:first").remove();
					$(this).css("left", 0);
				}
			);
		};
		
		// banner defalut event
		let rollingId = setInterval(rollingRight, 10000);
	});
</script>
	
<div id="banner_background">
	<div id="banner">
		<ul>
			<li>
				<img src="/img/meeting/default_banner.jpg">
				<div class="banner_text">
					<h1>
						<span class="banner_category">[전체]</span>
						<a id="all_title" href="/meeting/detailed?seq=${ all_banner.seq }"></a>
					</h1>
					<p id="all_contents"></p>				
				</div>
			</li>
			<li>
				<img src="/img/meeting/exercise_banner.jpg">
				<div class="banner_text">
					<h1>
						<span class="banner_category">[운동]</span>
						<a id="exercise_title" href="/meeting/detailed?seq=${ exercise_banner.seq }"></a>
					</h1>
					<p id="exercise_contents"></p>
				</div>
			</li>
			<li>
				<img src="/img/meeting/hobby_banner.jpg">
				<div class="banner_text">
					<h1>
						<span class="banner_category">[취미]</span>
						<a id="hobby_title" href="/meeting/detailed?seq=${ hobby_banner.seq }"></a>
					</h1>
					<p id="hobby_contents"></p>
				</div>				
			</li>
			<li>
				<img src="/img/meeting/study_banner.jpg">
				<div class="banner_text">
					<h1>
						<span class="banner_category">[공부]</span>
						<a id="study_title" href="/meeting/detailed?seq=${ study_banner.seq }"></a>
					</h1>
					<p id="study_contents"></p>
				</div>
			</li>
			<li>
				<img src="/img/meeting/etc_banner.jpg">
				<div class="banner_text">
					<h1>
						<span class="banner_category">[기타]</span>
						<a id="etc_title" href="/meeting/detailed?seq=${ etc_banner.seq }"></a>
					</h1>
					<p id="etc_contents"></p>
				</div>
			</li>
		</ul>
	</div>
</div>