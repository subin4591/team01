<%@page import="main.MainService"%>
<%@page import="main.MainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="map_wrap" style="width:60%;">
    <div id="map" style="width:100%;height:700px;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form id="submit_form">
					   키워드 : <input type="text" value="${location }" id="keyword" size="15"> 
                    <button type="submit" id="searchBtn">검색</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
        
		
    </div>
</div>
<div id ="result_wrap">
<div id="result"></div>
<div id="distance"></div>
<button id="confirm_btn">확정하기</button>
<button id="change_btn" style="display:none;">수정하기</button>
</div>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=a860b9470c235ea7b99c9c4e99ca3f14&libraries=services"></script>
<script src="/js/schedule_location.js"></script>
<script>
$(document).ready(function(){
	$('#confirm_btn').on('click',function(e){

		var address = $('#result h1').html();

		if(address == undefined){
			alert("장소를 선택해주세요.");
			return;
		}
		$.ajax({
		      url: '/address', 
		      method: 'POST', 
		      data: {
		        address: address,
		        group_id: "${groupId}"
		      },
		      success: function(response) {
		        console.log(response);
		      },
		      error: function(xhr, status, error) {
		        console.log(error);
		      }
		});
		$('#menu_wrap').hide();
		$('#confirm_btn').hide();
		$('#change_btn').show();
	});
	
});

</script>