<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="js/jquery-3.6.4.min.js"></script>
<script src="/js/schedule_chat.js"></script>
<link rel="stylesheet" href="/css/schedule_chat.css">

<div id="chatarea">
	<div id="display">
		<ul class = "chatting-list">
			<li>
				<c:forEach items="${chatlist}" var="chat">
				<c:choose>
				    <c:when test="${username == chat.name}">
				   		<h3 class="sent">
				   			<div class="chatcontent">
					   			<div class="message">${chat.text}</div>
				   			</div>
				   			<span class="chat_time">${chat.writing_time }</span>
				   		</h3>
			   		</c:when>
			   		<c:otherwise>
			   			<h3 class="receive">
			   			<img class = "profile_img" src="${chat.profile_url}"/>
			   				<div class="chat_wrap">
				   				<div class="user_name">${chat.name }</div>
					   			<div class="chatcontent">
						   			<div class="message">${chat.text}</div>
					   			</div>
					   		</div>
					   		<span class="chat_time">${chat.writing_time }</span>
				   		</h3>
			   		</c:otherwise>
			   	</c:choose>
			   	</c:forEach>
		   	</li>
	   	</ul>
	</div>
	<div id="input_wrap">
		<form id = "chatform">
			<textarea name="text" id="chatinput"></textarea>
			<input type="text" name="userId" value="${session_id}" style="display: none;" />
			<button type= submit id="chatsend"><h2>전 송</h2></button>
		</form>
	</div>
</div>

<script>
$("#display").scrollTop(($('#display')[0].scrollHeight))
const currentDate = new Date();

const options = {
  month: 'short',
  day: 'numeric',
  hour: 'numeric',
  minute: 'numeric'
};

const dateFormatter = new Intl.DateTimeFormat('ko-ko', options);
const formattedDate = dateFormatter.format(currentDate);
const now = formattedDate.replace("월 ","/").replace("일","");

var websocket = new WebSocket("ws://118.67.129.223:8080/chatws");
websocket.onopen = function(){
	var t = setInterval(function(){
        if (websocket.readyState != 1) {
            clearInterval(t);
            return;
        }
    }, 55000);
	console.log("웹소켓 연결 성공");
}

websocket.onmessage = function(server){
	var content = "";
	var json = JSON.parse(server.data);
	if(json.id == "${session_id}"){
		content = "<li><h3 class=\"sent\">\r\n"
			+ "		<div class=\"chatcontent\">\r\n"
			+ "			<div class=\"message\">"+ json.text + "</div>\r\n"
			+ "				  </div>\r\n"
			+ "			<span class=\"chat_time\">" + json.date + "</span>\r\n"
			+ "	   </h3>\r\n</li>"
	}
	else{
		content = "<li><h3 class=\"receive\">\r\n"
			+ "			   			<img class = \"profile_img\" src=\"" + json.profileimg + "\"/>\r\n"
			+ "			   				<div class=\"chat_wrap\">\r\n"
			+ "				   				<div class=\"user_name\">" + json.name + "</div>\r\n"
			+ "					   			<div class=\"chatcontent\">\r\n"
			+ "						   			<div class=\"message\">"+ json.text + "</div>\r\n"
			+ "					   			</div>\r\n"
			+ "					   		</div>\r\n"
			+ "					   		<span class=\"chat_time\">" + json.date + "</span>\r\n"
			+ "				   		</h3>\r\n</li>"
	}
	$('.chatting-list').append(content);
	$("#display").scrollTop(($('#display')[0].scrollHeight));
}	

$(document).ready(function(){
	$("#chatform").on("submit", function(e) {
		e.preventDefault();
	    var message = $("#chatinput").val().replaceAll("\n","<br>");
	    if (message !== "") {
	      // Send the message to the server using AJAX
	      $.ajax({
	        url: "/schedule/${groupId}/addchat",
	        method: "POST",
	        data: {
	        	text: message,
	        	userId : "${session_id}"
	        },
	        success: function(response) {

	        },
	        error: function() {
	          alert("에러발생");
	        }
	      });
	      var res = now.split(" ");
		  var re = res[0].split("/");
	      var m = re[0];
	      var d = re[1];
	     
	      if (d.length == 1){
	    	  d = "0" + d;
	      }
		  
	      websocket.send($('#chatinput').val().replaceAll("\n","<br>") + ":" + m + "/" + d + " " + res[1] + " " + res[2] + ";" + "${session_id}"); 

	      setTimeout(function() {
	    	  
	    	  $("#chatinput").val(""); 
	    	}, 1); 
	      
	    }
	  });
});
</script>
