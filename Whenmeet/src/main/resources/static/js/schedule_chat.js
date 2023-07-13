
$(document).ready(function(){
	
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
