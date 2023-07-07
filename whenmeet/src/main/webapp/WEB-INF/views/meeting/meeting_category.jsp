<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	
	<c:choose>
		<c:when test="${ category == 'all' }">
			<title>전체모임 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'exercise' }">
			<title>운동모임 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'hobby' }">
			<title>취미모임 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'study' }">
			<title>공부모임 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'etc' }">
			<title>기타모임 | 언제만나</title>	
		</c:when>
	</c:choose>
	
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_category.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/js/meeting.js"></script>
	<script>
		$(document).ready(function() {
			/// category active event
			categoryActive("${ category }");
			
			/// 기본 page active event
			$("#page_nums").html(makePage(${ total_cnt }, ${ div_num }));
			pageActive("time", 1);
			
			/// contents btns event
			$("#mycon_btn").on("click", function() {
				if (${ session_id == null }) {
					tryLogin();
				}
				else {
					window.location.href = "/meeting/my";
				}
			});
			$("#myapp_btn").on("click", function() {
				if (${ session_id == null }) {
					tryLogin();
				}
				else {
					window.location.href = "/meeting/myapp";
				}
			});
			$("#write_btn").on("click", function() {
				if (${ session_id == null }) {
					tryLogin();
				}
				else {
					window.location.href = "/meeting/write";
				}
			});
			
			/// sort ajax
			$(".sort_a").on("click", function(event) {
				event.preventDefault();
				let sort = $(this).data("target");
				
				let category = "";
				if (${ param.category == null }) {
					category = "all";
				}
				else {
					category = "${ param.category }"
				}
				
				$.ajax({
					url: "/meeting/meetingSort",
					data: {category: category, sort: sort},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						pageActive(sort, 1);
						
						// 게시글 목록
						let ct = $("#contents_table");
						ct.html(setConTableTh());
						
						for (let c = 0; c < data.length; c++) {
							let mc = new MeetingCon(
										data[c].seq,
										data[c].category,
										data[c].title,
										data[c].writer,
										data[c].writing_time,
										data[c].applicant_cnt,
										data[c].hits
									);
							ct.append(mc.printTd());
						}
					}
				});
			});
			
			/// page event
			$(document).on("click", ".page_a", function(event) {
				event.preventDefault();
				let page = $(this).data("target");
				let sort = $(".sort_a.page_active").data("target");
				let category = "";
				if (${ param.category == null }) {
					category = "all";
				}
				else {
					category = "${ param.category }"
				}
				
				$.ajax({
					url: "/meeting/meetingPage",
					data: {category: category, sort: sort, page: page},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						pageActive(sort, page);
						
						// 게시글 목록
						let ct = $("#contents_table");
						ct.html(setConTableTh());
						
						for (let c = 0; c < data.length; c++) {
							let mc = new MeetingCon(
										data[c].seq,
										data[c].category,
										data[c].title,
										data[c].writer,
										data[c].writing_time,
										data[c].applicant_cnt,
										data[c].hits
									);
							ct.append(mc.printTd());
						}
					}
				});
			});
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- banner -->
	<%@ include file="meeting_banner.jsp" %>
	
	<!-- category -->
	<div id="category_list">
		<ul id="category_ul">
			<li class="category_li" data-target="all"><a class="category_a" href="/meeting">전체</a></li>
			<li class="category_li" data-target="exercise"><a class="category_a" href="/meeting?category=exercise">운동</a></li>
			<li class="category_li" data-target="hobby"><a class="category_a" href="/meeting?category=hobby">취미</a></li>
			<li class="category_li" data-target="study"><a class="category_a" href="/meeting?category=study">공부</a></li>
			<li class="category_li" data-target="etc"><a class="category_a" href="/meeting?category=etc">기타</a></li>
		</ul>
	</div>
	
	<!-- contents -->
	<div id="contents_list">
		<div id="contents_table_caption">
			<p>총 ${ total_cnt }개</p>
			<div id="contents_sort">
				<a href="" class="sort_a" data-target="time">최신순</a>
				<a href="" class="sort_a" data-target="appl">신청순</a>
				<a href="" class="sort_a" data-target="hits">조회순</a>		
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
					<td><a href="/meeting/detailed?seq=${ m.seq }">${ m.title }</a></td>
					<td>${ m.writer }</td>
					<td>${ m.writing_time }</td>
					<td>${ m.applicant_cnt }</td>
					<td>${ m.hits }</td>
				</tr>
			</c:forEach>
			
		</table>
		<div id="page_nums"></div>
		<div id="contents_btns">
			<div id="my_contents_btns">
				<input id="mycon_btn" type="button" value="내 모집">
				<input id="myapp_btn" type="button" value="내 신청">
			</div>
			<input id="write_btn" type="button" value="글쓰기">
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>