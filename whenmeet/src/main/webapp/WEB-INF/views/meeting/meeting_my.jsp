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
	<link href="/css/meeting/meeting_my.css" rel=stylesheet>
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
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<div id="my_title">
		<h1>${ user_dto.name }님의 모임모집</h1>	
	</div>
	
	<!-- category -->
	<div id="category_list">
		<ul id="category_ul">
			<li class="category_li" data-target="all"><a class="category_a" href="/meeting/my?category=all">전체</a></li>
			<li class="category_li" data-target="exercise"><a class="category_a" href="/meeting/my?category=exercise">운동</a></li>
			<li class="category_li" data-target="hobby"><a class="category_a" href="/meeting/my?category=hobby">취미</a></li>
			<li class="category_li" data-target="study"><a class="category_a" href="/meeting/my?category=study">공부</a></li>
			<li class="category_li" data-target="etc"><a class="category_a" href="/meeting/my?category=etc">기타</a></li>
		</ul>
	</div>
	
	<!-- contents -->
	<div id="contents_list">
		<div id="contents_table_caption">
			<p>총 ${ total_cnt }개</p>
			<div id="contents_sort">
				<a href="/meeting/my?category=${ category }&sort=time&page=1" class="sort_a" data-target="time">최신순</a>
				<a href="/meeting/my?category=${ category }&sort=appl&page=1" class="sort_a" data-target="appl">신청순</a>
				<a href="/meeting/my?category=${ category }&sort=hits&page=1" class="sort_a" data-target="hits">조회순</a>		
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
			String category = (String)request.getAttribute("category");
			String sort = (String)request.getAttribute("sort");
			int totalCnt = (Integer)request.getAttribute("total_cnt");
			int divNum = (Integer)request.getAttribute("div_num");
			int totalPage = totalCnt / divNum;
			
			if (totalCnt % divNum != 0)
        		totalPage++;
			
			for (int p = 1; p <= totalPage; p++)
        		out.println("&nbsp;<a class='page_a'"
        			+ " href=\"/meeting/my?category=" + category + "&sort=" + sort + "&page=" + p + "\">"
        			+ p + "</a>&nbsp;");
		%>
		</div>
		<div id="contents_btns">
			<input id="mycon_btn" type="button" value="목록보기" onclick="location.href='/meeting'">
			<input id="write_btn" type="button" value="글쓰기" onclick="location.href='/meeting/write'">
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>