<%@page import="main.MainService"%>
<%@page import="main.MainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/css/schedule_location.css">

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
<c:if test="${location == null}">
<div id="null_text""><h1>위치를 설정해주세요.</h1><h2>(방장만 수정 가능합니다)</h2></div>
</c:if>

<button id="confirm_btn">확정하기</button>

<button id="change_btn" style="display:none;">수정하기</button>
</div>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=a860b9470c235ea7b99c9c4e99ca3f14&libraries=services"></script>
<script src="/js/schedule_location.js"></script>

<script>

$(document).ready(function(){
	let isHost = 0;
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
	$.ajax({
	      url: '/whohost', 
	      method: 'POST', 
	      data: {
	        group_id: "${groupId}"
	      },
	      success: function(response) {
	        if(response.host != '${session_id}'){
	        	setTimeout(() => {
	        		$('#change_btn').hide();
	        	}, 600);
	        }
	      },
	      error: function(xhr, status, error) {
	        console.log(error);
	      }
	});
	// 추가	
		if('${location}' != "" && '${location}' != null){
		setTimeout(() => {
			$(".info:first").click();
			$('#menu_wrap').hide();
			$('#confirm_btn').hide();
			$('#change_btn').show();
		}, 500);
		
	}

	$('#change_btn').on('click',function(){
		$('#menu_wrap').show();
		$('#confirm_btn').show();
		$('#change_btn').hide();
	});

	$('#submit_form').on('submit',function(e){
		searchPlaces();
		if($('#keyword').val() == ""){
			e.preventDefault();
			alert("키워드를 입력해주세요!")
		}
		return false;
	});

	var markers = [];

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	// 키워드로 장소를 검색합니다
	searchPlaces();

	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {

	    var keyword = document.getElementById('keyword').value;

	    /* if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    } */

	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);

	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);

	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

	        alert('검색 결과가 존재하지 않습니다.');
	        return;

	    } else if (status === kakao.maps.services.Status.ERROR) {

	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;

	    }
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( let i=0; i<places.length; i++ ) {

	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
				
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);

	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	            kakao.maps.event.addListener(marker, 'click', function() {
	            	$('#null_text').hide();
	            	dist(places[i].y,places[i].x);
	            	$('#result').html("<h1>" + title + "</h1>" +"<h2>" + places[i].address_name + "</h2>");
	            	map.setLevel(3);
	            	map.setCenter(marker.getPosition());
	            	displayInfowindow(marker, title);
					
	            });
	            
	            itemEl.onclick =  function () {
	            	$('#null_text').hide();
	 				dist(places[i].y,places[i].x);
	            	var spanElement = this.querySelector('div > span');
	            	var address = spanElement.innerHTML;
	            	$('#result').html("<h1>" + title + "</h1>" +"<h2>" + address + "</h2>");	
	            	map.setLevel(3);
	            	map.setCenter(marker.getPosition());	
	                displayInfowindow(marker, title);
	            };

	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name,itemEl);

	        fragment.appendChild(itemEl);
	    }

	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;

	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}	

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';

	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 

	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }

	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
			
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
		
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	    
	    
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}	
	$('#meeting_location_btn').on('click',function(){
		/* var mapContainer = document.getElementById('map');
		mapContainer.style.width = '2000px';
	    mapContainer.style.height = '650px';  */
	    setTimeout(function() {
	    	searchPlaces();	
		    map.relayout();
	    }, 0); 
	    
	});
	function calculateDistance(lat1, lon1, lat2, lon2) {	
		  console.log("위치계산함수실행");
		  const earthRadius = 6371; 

		  const lat1Rad = toRadians(lat1);
		  const lon1Rad = toRadians(lon1);
		  const lat2Rad = toRadians(lat2);
		  const lon2Rad = toRadians(lon2);
			
		  const dLat = lat2Rad - lat1Rad;
		  const dLon = lon2Rad - lon1Rad;
		  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		            Math.cos(lat1Rad) * Math.cos(lat2Rad) *
		            Math.sin(dLon / 2) * Math.sin(dLon / 2);
		  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		  const distance = earthRadius * c;

		  return distance;
		}

		function toRadians(degrees) {
		  return degrees * (Math.PI / 180);
		}
		function dist(lat,lon){
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(
				     function(position) {
				      const latitude = position.coords.latitude;
				      const longitude = position.coords.longitude;
				      // Use latitude and longitude coordinates
				      let distance = calculateDistance(lat,lon,latitude,longitude);
				      if(distance > 10){
				    	  distance = distance.toFixed(0) + "km";
				      }else if(distance > 1){
				    	  distance = distance.toFixed(1) + "km";
				      }else{
				    	  distance = (distance*1000).toFixed(0) + "m";
				      }
				      $('#distance').html("<h2> 현재 위치에서 거리 : " + distance + "</h2>");
				    },
				    function(error) {
				      console.log(error.code);
				    }
				  );
				  return distance;
				} else {
				  console.log("위치 정보를 확인할 수 없습니다.");
				}
		}	
});

</script>