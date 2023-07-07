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
		<c:when test="${ category == 'result' }">
			<title>신청결과 | 언제만나</title>	
		</c:when>
	</c:choose>
	
	<link href="/css/meeting/meeting.css" rel=stylesheet>
	<link href="/css/meeting/meeting_category.css" rel=stylesheet>
	<link href="/css/meeting/meeting_my.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/js/meeting.js"></script>
	<script>
		$(document).ready(function() {
			/// category active event
			categoryActive("${ category }");
			
			/// 기본 page active event
			$("#page_nums").html(makePage(${ total_cnt }, ${ div_num }));
			if ("${ category }" == "result") {
				pageActive("yes", 1);
			}
			else {
				pageActive("time", 1);
			}
			
			/// sort event
			$(".sort_a").on("click", function(event) {
				event.preventDefault();
				let sort = $(this).data("target");
				let user_id = "${ session_id }";
				
				// category
				let category = "";
				if (${ param.category == null }) {
					category = "all";
				}
				else {
					category = "${ param.category }"
				}
				
				// url
				let url = "";
				if (category == "result") {
					url = "/meeting/meetingMyAppResultSort";
				}
				else {
					url = "/meeting/meetingMyAppSort"
				}
				
				// ajax
				$.ajax({
					url: url,
					data: {category: category, sort: sort, user_id: user_id},
					type: "post",
					dataType: "json",
					success: function(data) {
						// 게시글 목록 th
						let ct = $("#contents_table");
						ct.html(setConTableTh());
						
						// page active event
						if (category == "result") {
							$("#page_nums").html(makePage(data.total_cnt, data.div_num));
							pageActive(sort, 1);
							
							// 게시글 개수
							$("#contents_table_caption p").text("총 " + data.total_cnt + "개");
							
							// 게시글 목록
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
							}	// for end
						}	// if end
						else {
							pageActive(sort, 1);
							
							// 게시글 목록
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
							}	// for end
						}	// else end
					}	// success end
				});	// ajax end
			});	// sort event end
			
			/// page event
			$(document).on("click", ".page_a", function(event) {
				event.preventDefault();
				let page = $(this).data("target");
				let sort = $(".sort_a.page_active").data("target");
				let user_id = "${ session_id }";
				
				// category
				let category = "";
				if (${ param.category == null }) {
					category = "all";
				}
				else {
					category = "${ param.category }"
				}
				
				// ajax
				$.ajax({
					url: "/meeting/meetingMyAppPage",
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
						}	// for end
					}	// success end
				});	// ajax end
			});	// page event end
		});	// document event end
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<div id="my_title">
		<h1>${ user_dto.name }님의 모임신청</h1>	
	</div>
	
	<!-- category -->
	<div id="category_list">
		<ul id="category_ul">
			<li class="category_li" data-target="all"><a class="category_a" href="/meeting/myapp">전체</a></li>
			<li class="category_li" data-target="exercise"><a class="category_a" href="/meeting/myapp?category=exercise">운동</a></li>
			<li class="category_li" data-target="hobby"><a class="category_a" href="/meeting/myapp?category=hobby">취미</a></li>
			<li class="category_li" data-target="study"><a class="category_a" href="/meeting/myapp?category=study">공부</a></li>
			<li class="category_li" data-target="etc"><a class="category_a" href="/meeting/myapp?category=etc">기타</a></li>
			<li class="category_li" data-target="result"><a class="category_a" href="/meeting/myapp?category=result">결과</a></li>
		</ul>
	</div>
	
	<!-- contents -->
	<div id="contents_list">
		<div id="contents_table_caption">
			<p>총 ${ total_cnt }개</p>
			<div id="contents_sort">
				<c:choose>
					<c:when test="${ category == 'result' }">
						<a href="" class="sort_a" data-target="yes">승인</a>
						<a href="" class="sort_a" data-target="yet">대기</a>	
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