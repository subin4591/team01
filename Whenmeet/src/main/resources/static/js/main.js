$(document).ready(function(){	
	$('#write_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
    }
	});
	$('#apply_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	    }
	});
	$('#group_more').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	    }
	});
	$('#add_btn').on('click',function(e){
	    if ("${session_id}" == "") {
	      e.preventDefault();
	      alert('로그인이 필요합니다.');
	    }
	});
});
