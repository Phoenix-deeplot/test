$(function () {
	var url="/admin/system/user/getUserMenu";

	$.get(url,function(data){
		debugger;
		//显示左侧菜单
		debugger;
		$(".sidebar-menu").html(navBar(data));

	})
})

function changepath(path,title,titleParent){
	debugger;
	$('#tileName').html(title);
	$('#tileNameParent').html(titleParent);
	$('iframe').attr('src',path);
}

