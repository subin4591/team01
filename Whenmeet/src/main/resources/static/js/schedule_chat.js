
$(document).ready(function(){

		
	const chatcontents = document.querySelectorAll('.receive .chatcontent');
	
	chatcontents.forEach((chatcontent) => {
		  if (chatcontent.offsetHeight < 45) {
			  chatcontent.classList.add('rowone');
			  }
			});
	
	$("#chatinput").on('keydown', function(e) {
		setTimeout(function(){
			var input = $("#chatinput").val().trim();
			if(input !== ""){
				$("#chatsend").css("backgroundColor","#F25287");
			}else{
				$("#chatsend").css("backgroundColor","rgb(224, 224, 224)");
			}
		},1);
		
				
		if (e.ctrlKey && e.keyCode == 13) {
			var input = $("#chatinput").val().trim();
			if(input === ""){
				setTimeout(function(){
					$("#chatinput").val("");
					return;
				},0);
			}
		      var content = $(this).val();
		      var caret = $(this).get(0).selectionStart;
		      
		      $(this).val(content.substring(0, caret) + "\n" + content.substring(caret, content.length));
		      
		      $(this).get(0).selectionStart = $(this).get(0).selectionEnd = caret + 1;

		      e.preventDefault();
		}else if( e.keyCode == 13){ 
			var input = $("#chatinput").val().trim();
			if(input === "" | input ==="\n"){
				setTimeout(function(){
					$("#chatinput").val("");
					return;
				},0);
			}
			$("#chatinput").submit();
			
		}
	});
})
