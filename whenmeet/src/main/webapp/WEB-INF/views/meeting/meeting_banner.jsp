<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/css/meeting/meeting_banner.css" rel=stylesheet>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
	$(document).ready(function() {
		/// banner event
		// banner text
		let banner_text_list = ["${ all_banner.contents }", 
			"${ exercise_banner.contents }", 
			"${ hobby_banner.contents }", 
			"${ study_banner.contents }",
			"${ etc_banner.contents }"];
		
		for (let i = 0; i < banner_text_list.length; i++) {
			let b = banner_text_list[i];
			
			// 태그 제거
			b = $("<div>").html(b).text();
			
			// 글자수 제한
			if (b.length >= 50)
				b = b.substring(0, 45) + "...";
			
			banner_text_list[i] = b;
		}
		
		$("#all_contents").text(banner_text_list[0]);
		$("#exercise_contents").text(banner_text_list[1]);
		$("#hobby_contents").text(banner_text_list[2]);
		$("#study_contents").text(banner_text_list[3]);
		$("#etc_contents").text(banner_text_list[4]);
		
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
					<h1><a href="/meeting/detailed?seq=${ all_banner.seq }">${ all_banner.title }</a></h1>
					<p id="all_contents"></p>				
				</div>
			</li>
			<li>
				<img src="/img/meeting/exercise_banner.jpg">
				<div class="banner_text">
					<h1><a href="/meeting/detailed?seq=${ exercise_banner.seq }">${ exercise_banner.title }</a></h1>
					<p id="exercise_contents"></p>
				</div>
			</li>
			<li>
				<img src="/img/meeting/hobby_banner.jpg">
				<div class="banner_text">
					<h1><a href="/meeting/detailed?seq=${ hobby_banner.seq }">${ hobby_banner.title }</a></h1>
					<p id="hobby_contents"></p>
				</div>				
			</li>
			<li>
				<img src="/img/meeting/study_banner.jpg">
				<div class="banner_text">
					<h1><a href="/meeting/detailed?seq=${ study_banner.seq }">${ study_banner.title }</a></h1>
					<p id="study_contents"></p>
				</div>
			</li>
			<li>
				<img src="/img/meeting/etc_banner.jpg">
				<div class="banner_text">
					<h1><a href="/meeting/detailed?seq=${ etc_banner.seq }">${ etc_banner.title }</a></h1>
					<p id="etc_contents"></p>
				</div>
			</li>
		</ul>
	</div>
</div>