<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="js/jquery-3.6.4.min.js"></script>
<style>
.profile_img{
	position: relative;
    padding: 7.5px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    object-fit: cover;
    object-position: cover;
    float:left;
}
.member_name{
	position: relative;
    top: -45px;
}
#chatarea{
	display:flex;
	flex-direction:column;
	overflow:hidden;
	height:100%;
}
#display{
	flex:12;
	overflow-y:scroll;
}
#input_wrap{
	flex:2;
	background:white;
	display:flex;
	justify-content:stretch;
	align-items:stretch;
}
#display::-webkit-scrollbar{
	width : 10px;
}
#display::-webkit-scrollbar-thumb {
    background-color: #F25287;
}
#display::-webkit-scrollbar-track {
    background-color: #D9D9D9;
}
#chatform{	
	display: flex;
	justify-content:flex-start;
	align-items:center;
	width:100%;
	padding:0.3rem;
}
#chatinput{
	font-size:16px;
	height:100%;
	flex:8;
	border:none;
	resize:none;
}
#chatinput:focus-visible{
	outline:none;
}
#chatsend{
	flex:0.8;
	background:#F25287;
	border:none;
	height:100%;
	border-radius:5px;
	cursor:pointer;
	color:white;
	
	
}
.chatting-list{
	padding:0;
}
.receive{
	width:70%;
	padding:0.3rem;
	display:flex;
	justify-content:flex-start;
	align-items:flex-end;
	margin-top:0.1rem;		
}
.message{
	border-radius:5px;
	padding:0.5rem;	
}
.time{
	margin:0 5px;
}
.sent{
	flex-direction:row-reverse;
	float:right;
	width:65%;
	padding:0.3rem;
	display:flex;
	justify-content:flex-start;
	align-items:flex-end;
	margin-top:0.1rem;
}
.sent .message{
	color:white;
	background:#F25287;
	position:relative;
	margin: 0 10px 0 5px;
}
.receive .message{
	background:white;
	position:relative;
	margin: 0 5px 0 10px;
}
.user_name{
    position: relative;
	width:60px;
	left:5px;
}
.receive .chatcontent{
    position:relative;
    top:5px;
}
.receive .chat_time{
	display: inline-flex;
    align-items: flex-end
}
.chat_time{
	flex: 0 0 auto;
}
.chatcontent, .chat_wrap{
	width: auto;
    word-wrap: break-word;
    max-width: 100%;
    overflow:hidden;
}
.rowone{
	width:fit-content;
}
.receive,.sent{
	margin:5px 10px;
}
.receive{
	display: flex;
	align-items: stretch;
}
.chat_wrap{
float:left;}

.sent .message:before {
  	content: '';
	position: absolute;
	right: 8px;
	top: 50%;
	width: 0;
	height: 0;
	border: 20px solid transparent;
	border-left-color: #F25287;
	border-right: 0;
	border-top: 0;
	margin-top: -10px;
	margin-right: -20px;
}
.receive .message:after{
	content: '';
	position: absolute;
	left: 8px;
	top: 20px;
	width: 0;
	height: 0;
	border: 20px solid transparent;
	border-right-color: #ffffff;
	border-left: 0;
	border-top: 0;
	margin-top: -10px;
	margin-left: -20px;
}
</style>

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
$(document).ready(function(){
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

	var websocket = new WebSocket("ws://localhost:8065/chatws");
	websocket.onopen = function(){
		var t = setInterval(function(){
	        if (ws.readyState != 1) {
	            clearInterval(t);
	            return;
	        }
	        ws.send('{type:"ping"}');
	    }, 55000);
		console.log("웹소켓 연결 성공");
	}

	websocket.onmessage = function(server){
		$('.chatting-list').append(server.data);
	}	

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
	      websocket.send($('#chatinput').val().replaceAll("\n","<br>") + ":" + now); 
	      setTimeout(function() {
	    	  $("#display").scrollTop(($('#display')[0].scrollHeight));
	    	  $("#chatinput").val(""); 
	    	}, 1); 
	      
	    }
	  });
	const chatcontents = document.querySelectorAll('.receive .chatcontent');
	
	chatcontents.forEach((chatcontent) => {
		  if (chatcontent.offsetHeight < 45) {
			  chatcontent.classList.add('rowone');
			  }
			});
	
	$("#chatinput").on('keydown', function(e) {
		if (e.ctrlKey && e.keyCode == 13) {
		      var content = $(this).val();
		      var caret = $(this).get(0).selectionStart;
		      
		      $(this).val(content.substring(0, caret) + "\n" + content.substring(caret, content.length));
		      
		      $(this).get(0).selectionStart = $(this).get(0).selectionEnd = caret + 1;

		      e.preventDefault();
		}else if( e.keyCode == 13){ 
			$("#chatinput").submit();
			
		}
	});
})

</script>
