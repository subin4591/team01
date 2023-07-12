<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	<title>검색결과 | 언제만나</title>
	<link href="/css/search/search.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/js/meeting.js"></script>
	<script>
		$(document).ready(function() {
			// 기본 page active event
			$("#page_nums").html(makePage(${ total_cnt }, ${ div_num }));
			pageActive("time", 1);
			
			// selected event
			let cateS = $("#category_select option");
			cateS.each(function() {
				if ($(this).val() == "${ dto.category }") {
					$(this).prop("selected", true);
				}
			})
			
			let typeS = $("#type_select option");
			typeS.each(function() {
				if ($(this).val() == "${ dto.type }") {
					$(this).prop("selected", true);
				}
			})
			
			// 모집글 내용의 html 태그 제거 및 길이 제한 함수
			function setContents() {
				$(".td_contents").each(function() {
					// 텍스트만 가져오기
					let text = $(this).text();
					
					// 길이 제한
					if (text.length >= 70)
						text = text.substring(0, 65) + "...";
					
					// 적용
					$(this).html(text);
				});	// 내용 가공 end
			};	// setContents end
			setContents();
			
			// 테이블 안의 검색어가 있을 경우 색상 변경
			function setColor(type) {
				let target = ".td_tc";
				if (type == "title_contents") {
					setColor("title");
					setColor("contents");
				}
				else if (type == "title") {
					target = ".td_title";
				}
				else if (type == "contents") {
					target = ".td_contents";
				}
				else if (type == "writer") {
					target = ".td_writer";
				}
				$(target).each(function() {
					let si = "${ dto.search_input }";
					let text = $(this).html();
					
					if (text.includes(si)) {
						$(this).html(text.replace(si, "<span class='set_color'>" + si + "</span>"));
					}
				});
			};
			setColor("${ dto.type }");
			
			// 세부 검색
			$("#search_detailed_submit_btn").on("click", function() {
				if ($("#search_detailed_input").val().length == 0) {
					alert("검색어를 입력하세요.");
				}
				else {
					$("#search_detailed_form").submit();
				}
			});	// 세부 검색 end
			
			// sort ajax
			$(".sort_a").on("click", function(event) {
				event.preventDefault();
				let category = "${ dto.category }";
				let type = "${ dto.type }";
				let search_input = "${ dto.search_input }";
				let sort = $(this).data("target");
				
				$.ajax({
					url: "/search/sort",
					data: {category: category, type: type, search_input: search_input, sort: sort},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						pageActive(sort, 1);
						
						// 검색결과 목록
						let st = $("#search_table");
						st.html(setConTableTh());
						
						for (let c = 0; c < data.length; c++) {
							let mc = new MeetingCon(
										data[c].seq,
										data[c].category,
										data[c].title,
										data[c].writer,
										data[c].writing_time,
										data[c].applicant_cnt,
										data[c].hits,
										data[c].contents
									);
							st.append(mc.printSearch());
						}
						
						// 내용 가공
						setContents();
						setColor(type);
					}	// success end
				});	// ajax end
			});	// sort ajax end
			
			/// page event
			$(document).on("click", ".page_a", function(event) {
				event.preventDefault();
				let category = "${ dto.category }";
				let type = "${ dto.type }";
				let search_input = "${ dto.search_input }";
				let sort = $(".sort_a.page_active").data("target");
				let page = $(this).data("target");
				
				$.ajax({
					url: "/search/page",
					data: {category: category, type: type, search_input: search_input, sort: sort, page: page},
					type: "post",
					dataType: "json",
					success: function(data) {
						// page active event
						pageActive(sort, page);
						
						// 검색결과 목록
						let st = $("#search_table");
						st.html(setConTableTh());
						
						for (let c = 0; c < data.length; c++) {
							let mc = new MeetingCon(
										data[c].seq,
										data[c].category,
										data[c].title,
										data[c].writer,
										data[c].writing_time,
										data[c].applicant_cnt,
										data[c].hits,
										data[c].contents
									);
							st.append(mc.printSearch());
						}
						
						// 내용 가공
						setContents();
						setColor(type);
					}	// success end
				});	// ajax end
			});	// page event end
		});	// document end
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- search contents -->
	<div id="search_contents">
		<div id="search_table_caption">
			<p id="search_title">
				<span>'${ dto.search_input }'</span>
				<c:choose>
					<c:when test="${ dto.type == 'title_contents' }">
						<span>(제목+내용)</span>
					</c:when>
					<c:when test="${ dto.type == 'title' }">
						<span>(제목)</span>
					</c:when>
					<c:when test="${ dto.type == 'contents' }">
						<span>(내용)</span>
					</c:when>
					<c:when test="${ dto.type == 'writer' }">
						<span>(작성자)</span>
					</c:when>
				</c:choose>
				<span>검색결과</span>
				<span>(총 ${ total_cnt }건)</span>
			</p>
			
			<form id="search_detailed_form" action="/search">
				<select id="category_select" name="category">
					<option value="전체">전체</option>
					<option value="운동">운동</option>
					<option value="취미">취미</option>
					<option value="공부">공부</option>
					<option value="기타">기타</option>
				</select>
				<select id="type_select" name="type">
					<option value="title_contents">제목+내용</option>
					<option value="title">제목</option>
					<option value="contents">내용</option>
					<option value="writer">작성자</option>
				</select>
				<div id="search_box">
					<input type="text" id="search_detailed_input" name="search_input" placeholder="검색어를 입력하세요." value="${ dto.search_input }">
					<img id="search_detailed_submit_btn" src="/img/search.svg" alt="search_submit_btn">
				</div>
			</form>
		</div>
		
		<div id="search_list">
			<div id="search_sort">
				<a href="" class="sort_a" data-target="time">최신순</a>
				<a href="" class="sort_a" data-target="appl">신청순</a>
				<a href="" class="sort_a" data-target="hits">조회순</a>		
			</div>
			<table id="search_table">
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
						<td rowspan="2" class="td_seq">${ m.seq }</td>
						<td rowspan="2" class="td_category">${ m.category }</td>
						<td class="td_title td_tc"><a href="/meeting/detailed?seq=${ m.seq }">${ m.title }</a></td>
						<td class="td_writer">${ m.writer }</td>
						<td class="td_writing_time">${ m.writing_time }</td>
						<td class="td_applicant_cnt">${ m.applicant_cnt }</td>
						<td class="td_hits">${ m.hits }</td>
					</tr>
					<tr>
						<td colspan="4" class="td_contents td_tc">${ m.contents }</td>
					</tr>
				</c:forEach>
			</table>
			<div id="page_nums"></div>
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>