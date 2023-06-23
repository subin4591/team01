<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/footlogo.svg">
	<title>모임 | 언제만나</title>
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			/// banner event
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
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<div id="banner_background">
		<div id="banner">
			<ul>
				<li>
					<img src="/img/meeting/default_banner.jpg">
					<div class="banner_text">
						<h1><a href="">엄청난 모임 구합니다.</a></h1>
						<p>모임을 구합니다. 많은 신청 부탁드립니다.</p>				
					</div>
				</li>
				<li>
					<img src="/img/meeting/exercise_banner.jpg">
					<div class="banner_text">
						<h1><a href="">운동 모임 함께 하실 분</a></h1>
						<p>함께 운동해요~~ 선착순 10명~~ 빨리빨리~~</p>
					</div>
				</li>
				<li>
					<img src="/img/meeting/hobby_banner.jpg">
					<div class="banner_text">
						<h1><a href="">재봉틀로 같이 만들어요</a></h1>
						<p>정기적으로 모여서 같이 만들고 싶어요</p>
					</div>				
				</li>
				<li>
					<img src="/img/meeting/study_banner.jpg">
					<div class="banner_text">
						<h1><a href="">이번 정보처리기사 같이 공부해요</a></h1>
						<p>붙었으면 좋겠어요</p>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<div id="category_list">
		<ul id="category_ul">
			<li class="category_active"><a class="category_a category_active" href="meeting">전체</a></li>
			<li><a class="category_a" href="meeting">운동</a></li>
			<li><a class="category_a" href="meeting">취미</a></li>
			<li><a class="category_a" href="meeting">공부</a></li>
			<li><a class="category_a" href="meeting">기타</a></li>
		</ul>
	</div>
	
	<div id="contents_list">
		<div id="contents_table_caption">
			<p>총 50개</p>
			<div id="contents_sort">
				<a href="">최신순</a>
				<a href="">신청자순</a>		
			</div>		
		</div>
		<table id="contents_table">
			<tr>
				<th>번호</th>
				<th colspan="2">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>신청자수</th>
				<th>조회</th>
			</tr>
			
			<!-- 임시 게시글 -->
			<tr>
				<td>1</td>
				<td>공부</td>
				<td><a href="">제목입니다</a></td>
				<td>작성자입니다</td>
				<td>2023.06.21</td>
				<td>8</td>
				<td>0</td>
			</tr>
			<tr>
				<td>2</td>
				<td>운동</td>
				<td><a href="">제목입니다</a></td>
				<td>작성자입니다</td>
				<td>2023.06.21</td>
				<td>8</td>
				<td>0</td>
			</tr>
			<tr>
				<td>3</td>
				<td>취미</td>
				<td><a href="">제목입니다</a></td>
				<td>작성자입니다</td>
				<td>2023.06.21</td>
				<td>8</td>
				<td>0</td>
			</tr>
			<tr>
				<td>4</td>
				<td>기타</td>
				<td><a href="">제목입니다</a></td>
				<td>작성자입니다</td>
				<td>2023.06.21</td>
				<td>8</td>
				<td>0</td>
			</tr>

		</table>
		<div id="contents_btns">
			<input id="mycon_btn" type="button" value="내글보기">
			<input id="write_btn" type="button" value="글쓰기">
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>