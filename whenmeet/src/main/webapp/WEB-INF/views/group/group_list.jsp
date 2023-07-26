<%@page import="dto.GroupDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/img/icon.svg">
	<title>그룹목록 | 언제만나</title>
	<link href="/css/group/group_list.css" rel=stylesheet>
	<script src="/js/jquery-3.6.4.min.js"></script>
	<script src="/js/meeting.js"></script>
	<script>
		$(document).ready(function() {
		});	// document end
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
	
	<!-- group list -->
	<div id="group_list">
		<div id="user_info">
			<div id="user_info_profile">
				<img alt="profile_img" src="${ user.profile_url }">
			</div>
			<h1><span>${ user.name }</span><span>님의 그룹목록</span></h1>
		</div>
		<div id="group_list_result">
			<div id="gl_caption">
				<label>총 ${ cnt }개</label>
				<div id="gl_sort">
					<a href="" class="sort_a" data-target="all">전체</a>
					<a href="" class="sort_a" data-target="host">방장</a>
					<a href="" class="sort_a" data-target="sub_host">부방장</a>
					<a href="" class="sort_a" data-target="not">일반</a>
				</div>
			</div>
			<div id="gl">
				<div id="gl_top">
					<%
						List<GroupDTO> group = (List<GroupDTO>)request.getAttribute("group");
						int size = group.size();
						int last = size;
						if (size > 5) {
							last = 5;
						}
						
						for (int i = 0; i < last; i++) { 
							GroupDTO dto = group.get(i);
							String name = dto.getGroup_name();
							String des = dto.getGroup_description();
							
							if (name.length() > 9) {
								name = name.substring(0, 8) + "...";
							}
							if (des.length() > 22) {
								des = des.substring(0, 21) + "...";
							}
						%>
							<div class="gl_item">
								<a href="/schedule/<%= dto.getGroup_id() %>"><h2><%= name %></h2></a>
								<h3><%= des %></h3>
								<p>개설일 : <%= dto.getGroup_create_time() %></p>					
							</div>
						<%	
						}
					%>			
				</div>
				<div id="gl_bottom">
					<%
						if (last == 5) {
							for (int i = 5; i < size; i++) {
								GroupDTO dto = group.get(i);
								String name = dto.getGroup_name();
								String des = dto.getGroup_description();
								
								if (name.length() > 9) {
									name = name.substring(0, 8) + "...";
								}
								if (des.length() > 22) {
									des = des.substring(0, 21) + "...";
								}
							%>
								<div class="gl_item">
									<a href="/schedule/<%= dto.getGroup_id() %>"><h2><%= name %></h2></a>
									<h3><%= des %></h3>
									<p>개설일 : <%= dto.getGroup_create_time() %></p>					
								</div>
							<%
							}
						}
					%>
				</div>
			</div>
			<div id="page_nums"></div>
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>