<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/footlogo.svg">
	
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
	<script>
		$(document).ready(function() {
			/// Function
			function tryLogin() {
				alert("로그인이 필요합니다.");
			};
			
			/// category active event
			let category_li = $(".category_li[data-target='${ category }']");
			category_li.addClass("category_active");
			category_li.find("a").addClass("category_active");
			
			/// page active event
			$(".sort_a[data-target='${ sort }']").addClass("page_active");
			$(".page_a:contains('${ page }')").addClass("page_active");
			
			
			/// contents btns event
			$("#mycon_btn").on("click", function() {
				if (${ session_id == null }) {
					tryLogin();
				}
				else {
					window.location.href = "/meeting/my";
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
					url: "/meetingSort",
					data: {category: category, sort: sort},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						$(".sort_a, .page_a").removeClass("page_active");
						$(".sort_a[data-target='" + sort + "']").addClass("page_active");
						
						// 게시글 목록
						let ct = $("#contents_table");
						ct.html("<tr>"
									+ "<th>번호</th>"
									+ "<th colspan='2'>제목</th>"
									+ "<th>작성자</th>"
									+ "<th>작성일</th>"
									+ "<th>신청자수</th>"
									+ "<th>조회</th>"
								+ "</tr>");
						
						for (let c = 0; c < data.meeting_list.length; c++) {
							ct.append("<tr>"
										+ "<td>" + data.meeting_list[c].seq + "</td>"
										+ "<td>" + data.meeting_list[c].category + "</td>"
										+ "<td><a href='/meeting/detailed?seq=" + data.meeting_list[c].seq + "'>" 
												+ data.meeting_list[c].title 
												+ "</a></td>"
										+ "<td>" + data.meeting_list[c].writer + "</td>"
										+ "<td>" + data.meeting_list[c].writing_time + "</td>"
										+ "<td>" + data.meeting_list[c].applicant_cnt + "</td>"
										+ "<td>" + data.meeting_list[c].hits + "</td>"
									+ "</tr>");
						}
						
						// 페이징
						let totalCnt = data.total_cnt;
						let divNum = data.div_num;
						let totalPage = totalCnt / divNum;
						if (totalCnt % divNum != 0) {
							totalPage++;
						}
						
						$("#page_nums").html("");
						for (let p = 1; p <= totalPage; p++) {
							if (p == 1) {
								$("#page_nums").append("&nbsp;<a class='page_a page_active' href='' data-target='" + p + "'>" + p + "</a>&nbsp;");
							}
							else {								
								$("#page_nums").append("&nbsp;<a class='page_a' href='' data-target='" + p + "'>" + p + "</a>&nbsp;");
							}
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
					url: "/meetingPage",
					data: {category: category, sort: sort, page: page},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						$(".page_a").removeClass("page_active");
						$(".page_a[data-target='" + page + "']").addClass("page_active");
						
						// 게시글 목록
						let ct = $("#contents_table");
						ct.html("<tr>"
									+ "<th>번호</th>"
									+ "<th colspan='2'>제목</th>"
									+ "<th>작성자</th>"
									+ "<th>작성일</th>"
									+ "<th>신청자수</th>"
									+ "<th>조회</th>"
								+ "</tr>");
						
						for (let c = 0; c < data.length; c++) {
							ct.append("<tr>"
										+ "<td>" + data[c].seq + "</td>"
										+ "<td>" + data[c].category + "</td>"
										+ "<td><a href='/meeting/detailed?seq=" + data[c].seq + "'>" 
												+ data[c].title 
												+ "</a></td>"
										+ "<td>" + data[c].writer + "</td>"
										+ "<td>" + data[c].writing_time + "</td>"
										+ "<td>" + data[c].applicant_cnt + "</td>"
										+ "<td>" + data[c].hits + "</td>"
									+ "</tr>");
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
		<div id="page_nums">
		<%	
			int totalCnt = (Integer)request.getAttribute("total_cnt");
			int divNum = (Integer)request.getAttribute("div_num");
			int totalPage = totalCnt / divNum;
			
			if (totalCnt % divNum != 0)
        		totalPage++;
		%>
			<c:forEach begin="1" end="<%= totalPage %>" var="p">
				&nbsp;<a class="page_a" href="" data-target="${ p }">${ p }</a>&nbsp;
			</c:forEach>
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