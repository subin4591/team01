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
			<title>전체모집 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'exercise' }">
			<title>운동모집 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'hobby' }">
			<title>취미모집 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'study' }">
			<title>공부모집 | 언제만나</title>	
		</c:when>
		<c:when test="${ category == 'etc' }">
			<title>기타모집 | 언제만나</title>	
		</c:when>
		<c:otherwise>
			<title>모집결과 | 언제만나</title>
		</c:otherwise>
	</c:choose>
	
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_category.css" rel=stylesheet>
	<link href="/css/meeting/meeting_my.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/js/meeting.js"></script>
	<script>
		$(document).ready(function() {
			/// category, page active event
			let ca = "${ category }";
			categoryActive(ca);
			
			$("#page_nums").html(makePage(${ total_cnt }, ${ div_num }));
			
			if (ca == "notfinish" || ca == "yetfinish" || ca == "finish") {
				categoryReActive(ca);
				pageActive("open", 1);
				$("#category_re_ul").show();
			}
			else {
				pageActive("time", 1);
			}
			
			/// 결과 카테고리 event
 			$(".ca_li_re").on("click", function(event) {
 				event.preventDefault();
 				$("#category_re_ul").slideToggle(400);
 			});
			
			/// sort ajax
			$(".sort_a").on("click", function(event) {
				event.preventDefault();
				let sort = $(this).data("target");
				let user_id = "${ session_id }";
				
				let category = "";
				if (${ param.category == null }) {
					category = "all";
				}
				else {
					category = "${ param.category }"
				}
				
				$.ajax({
					url: "/meeting/meetingMySort",
					data: {category: category, sort: sort, user_id: user_id},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						$("#page_nums").html(makePage(data.total_cnt, data.div_num));
						pageActive(sort, 1);
						
						// 게시글 목록
						let ct = $("#contents_table");
						ct.html(setConTableTh());
						
						for (let c = 0; c < data.meeting_list.length; c++) {
							let mc = new MeetingCon(
										data.meeting_list[c].seq,
										data.meeting_list[c].category,
										data.meeting_list[c].title,
										data.meeting_list[c].writer,
										data.meeting_list[c].writing_time,
										data.meeting_list[c].applicant_cnt,
										data.meeting_list[c].hits
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
				let user_id = "${ session_id }";
				let category = "";
				if (${ param.category == null }) {
					category = "all";
				}
				else {
					category = "${ param.category }"
				}
				
				$.ajax({
					url: "/meeting/meetingMyPage",
					data: {category: category, sort: sort, page: page, user_id: user_id},
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
	
	<div id="my_title">
		<h1>${ user_dto.name }님의 그룹모집</h1>	
	</div>
	
	<!-- category -->
	<div id="category_list">
		<ul id="category_ul">
			<li class="category_li" data-target="all"><a class="category_a" href="/meeting/my">전체</a></li>
			<li class="category_li" data-target="exercise"><a class="category_a" href="/meeting/my?category=exercise">운동</a></li>
			<li class="category_li" data-target="hobby"><a class="category_a" href="/meeting/my?category=hobby">취미</a></li>
			<li class="category_li" data-target="study"><a class="category_a" href="/meeting/my?category=study">공부</a></li>
			<li class="category_li" data-target="etc"><a class="category_a" href="/meeting/my?category=etc">기타</a></li>
			<li class="category_li ca_li_re" data-target="${ category }"><a class="category_a" href="">결과</a></li>
		</ul>
		<ul id="category_re_ul" style="display: none;">
			<li><a class="category_re" data-target="notfinish" href="/meeting/my?category=notfinish">진행</a></li>
			<li><a class="category_re" data-target="yetfinish" href="/meeting/my?category=yetfinish">대기</a></li>
			<li><a class="category_re" data-target="finish" href="/meeting/my?category=finish">완료</a></li>
		</ul>
	</div>
	
	
	<!-- contents -->
	<div id="contents_list">
		<div id="contents_table_caption">
			<p>총 ${ total_cnt }개</p>
			<div id="contents_sort">
				<c:choose>
					<c:when test="${ category == 'notfinish' || category == 'yetfinish' || category == 'finish'}">
						<a href="" class="sort_a" data-target="open">공개</a>
						<a href="" class="sort_a" data-target="hidden">비공개</a>
					</c:when>
					<c:otherwise>
						<a href="" class="sort_a" data-target="time">최신순</a>
						<a href="" class="sort_a" data-target="appl">신청순</a>
						<a href="" class="sort_a" data-target="hits">조회순</a>
					</c:otherwise>
				</c:choose>			
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
			<input id="mycon_btn" type="button" value="목록보기" onclick="location.href='/meeting'">
			<input id="write_btn" type="button" value="글쓰기" onclick="location.href='/meeting/write'">
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>