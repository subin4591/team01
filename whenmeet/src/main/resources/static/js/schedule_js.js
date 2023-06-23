/**
 * 
 */
function popOpen(){
	var modalPop = $('.user_modal');
	var modalBg = $('.user_modal_bg');
	$(modalPop).show();
	$(modalBg).show();
}

function popClose(){
	var modalPop = $('.user_modal');
	var modalBg = $('.user_modal_bg');
	$(modalPop).hide();
	$(modalBg).hide();
}