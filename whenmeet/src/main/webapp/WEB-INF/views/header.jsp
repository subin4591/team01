<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.4.js"></script>
    <script src="resources/js/header.js"></script>
    <link rel="stylesheet" href="resources/css/header.css" />
        <div id="header">
      <div id="user_logo">
        <a href="#"><img src="resources/images/user_logo.svg" alt="user_logo" /></a>
      </div>
      <div id="logo">
        <a href=""><img src="resources/images/logo.svg" alt="logo" /></a>
      </div>
      <div id="header_btn">
        <a href="#"
          ><img src="resources/images/search.svg" alt="search" id="search_btn"
        /></a>
        <a href="#"><img src="resources/images/logout.svg" alt="logout" /></a>
      </div>
    </div>

    <div id="pop_search">
      <form action="#" name="#">
        <input type="text" name="text" placeholder="검색어를 입력해주세요." />
        <input type="image" name="submit" src="resources/images/search.svg" />
      </form>
    </div>