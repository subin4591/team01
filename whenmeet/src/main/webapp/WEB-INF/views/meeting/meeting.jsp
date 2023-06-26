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
	<link href="/css/meeting/meeting_default.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			/// Function
			function tryLogin() {
        		alert("로그인이 필요합니다.");
    		};
			
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
			
			
			/// page active event
			$(".sort_a[data-target='${ sort }']").addClass("page_active");
			$(".page_a:contains('${ page }')").addClass("page_active");
			
			
			/// contents btns event
			$("#mycon_btn").on("click", function() {
				if (${ session_id == null }) {
					tryLogin();
				}
				else {
					window.location.href = "";
				}
			});
			
			$("#write_btn").on("click", function() {
				if (${ session_id == null }) {
					tryLogin();
				}
				else {
					window.location.href = "meeting/write";
				}
			});

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
			<p>총 ${ total_cnt }개</p>
			<div id="contents_sort">
				<a href="meeting?sort=time&page=1" class="sort_a" data-target="time">최신순</a>
				<a href="meeting?sort=appl&page=1" class="sort_a" data-target="appl">신청순</a>
				<a href="meeting?sort=hits&page=1" class="sort_a" data-target="hits">조회순</a>		
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
			
			<c:forEach items="${ meeting_list }" var="m">
				<tr>
					<td>${ m.seq }</td>
					<td>${ m.category }</td>
					<td><a href="meeting/detailed?seq=${ m.seq }">${ m.title }</a></td>
					<td>${ m.writer }</td>
					<td>${ m.writing_time }</td>
					<td>${ m.applicant_cnt }</td>
					<td>${ m.hits }</td>
				</tr>
			</c:forEach>
			
		</table>
		<div id="page_nums">
		<%
			String sort = (String)request.getAttribute("sort");
			int totalCnt = (Integer)request.getAttribute("total_cnt");
			int divNum = (Integer)request.getAttribute("div_num");
			int totalPage = totalCnt / divNum;
			
			if (totalCnt % divNum != 0)
        		totalPage++;
			
			for (int p = 1; p <= totalPage; p++)
        		out.println("&nbsp;<a class='page_a'"
        			+ " href=\"meeting?sort=" + sort + "&page=" + p + "\">"
        			+ p + "</a>&nbsp;");
		%>
		</div>
		<div id="contents_btns">
			<input id="mycon_btn" type="button" value="내글보기">
			<input id="write_btn" type="button" value="글쓰기">
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>