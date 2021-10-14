//チャットページに遷移後、最新のメッセージまでスクロール
$(function(){
	$(".message").scrollTop($(".message")[0].scrollHeight);
});