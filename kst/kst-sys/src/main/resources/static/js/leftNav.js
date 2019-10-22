function navBar(strData){
	var data;
	if(typeof(strData) === "string"){
		var data = JSON.parse(strData); //部分用户解析出来的是字符串，转换一下
	}else{
		data = strData;
	}
	debugger;
	var ulHtml = '<li class="header">'+'导航菜单'+'</li>';
	for(var i=0;i<data.length;i++){
		if(data[i].spread){
			ulHtml += '<li class="active treeview">';
		}else{
			ulHtml += '<li class="treeview">';
		}
		if(data[i].children !== undefined && data[i].children.length > 0){
			ulHtml += '<a href="#">';
			ulHtml += '<i class="'+data[i].icon+'"></i>';
			ulHtml += '<span>'+data[i].title+'</span>';
			ulHtml += '<span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span>';
			ulHtml += '</a>';
			ulHtml += '<ul class="treeview-menu">';
			for(var j=0;j<data[i].children.length;j++){
				ulHtml += '<li>';
				var path= "'"+data[i].children[j].href+"'";
				var title= "'"+data[i].children[j].title+"'";
				var titleParent= "'"+data[i].title+"'";
				ulHtml += '<a href="javascript:changepath('+path+','+title+','+titleParent+')"><i class="'+data[i].children[j].icon+'"></i>'+ data[i].children[j].title +'</a>';
				ulHtml += '</li>';
			}
			ulHtml += "</ul>";
		}
		/*else{
			if(data[i].target === "_blank"){
				ulHtml += '<a href="javascript:;" data-url="'+data[i].href+'" target="'+data[i].target+'">';
			}else{
				ulHtml += '<a href="javascript:;" data-url="'+data[i].href+'">';
			}
			if(data[i].icon !== undefined && data[i].icon !== ''){
				if(data[i].icon.indexOf("icon-") !== -1){
					ulHtml += '<i class="iconfont '+data[i].icon+'" style="font-size: 20px" data-icon="'+data[i].icon+'"></i>';
				}else{
					ulHtml += '<i class="layui-icon" style="font-size: 20px" data-icon="'+data[i].icon+'">'+data[i].icon+'</i>';
				}
			}
			ulHtml += '<cite>'+data[i].title+'</cite></a>';
		}*/

	}
	return ulHtml;
}
