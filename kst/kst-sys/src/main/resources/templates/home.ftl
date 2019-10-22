<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>主页</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/font-awesome.min.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/skins/all-skins.min.css">
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <style type="text/css">
        tbody td{
            border:0px;
        }
    </style>
</head>
<body>
<!-- jQuery 2.2.3 -->
<script src="${base}/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local" />.js"></script>
<div align="center">
    <#--<h1>WELCOME</h1>-->
    <#--<h2>欢迎使用本系统</h2>-->
    <br>
</div>
<div class="col-sm-6">
    <div class="panel panel-default " >
        <div class="panel-heading">
            <h3 class="panel-title">
                <@spring.message "sys.home.announcementMessage"/>
            </h3>
        </div>
        <div class="panel-body">
            <div id="annToolbar">
                <ul id="myTab" class="nav nav-tabs" role="tablist">
                    <li class="active"><a href="javascript:void(0)" onclick="changeTab1(1)" data-toggle="tab"><@spring.message "sys.home.unread"/></a></li>
                    <li><a href="javascript:void(0)" onclick="changeTab1(2)" data-toggle="tab"><@spring.message "sys.home.read"/></a></li>
                </ul>
            </div>

            <table id="announcementTable" class="table table-condensed " data-classes="table table-no-border" style="border:0px;"></table>
        </div>
    </div>
</div>
<div class="col-sm-6">
    <div class="panel panel-default " >
        <div class="panel-heading">
            <h3 class="panel-title">
                <@spring.message "sys.home.informMessage"/>
            </h3>
        </div>
        <div class="panel-body">
            <div id="infToolbar">
                <ul id="myTab" class="nav nav-tabs" role="tablist">
                    <li class="active"><a href="javascript:void(0)" onclick="changeTab2(1)" data-toggle="tab"><@spring.message "sys.home.unread"/></a></li>
                    <li><a href="javascript:void(0)" onclick="changeTab2(2)" data-toggle="tab"><@spring.message "sys.home.read"/></a></li>
                </ul>
            </div>
            <table id="informTable" class="table table-condensed" data-classes="table table-no-border" style="border:0px;"></table>
        </div>
    </div>
</div>
<script type="text/javascript">

    var isNew1=1;
    var isNew2=1;
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        initAnnouncementTable();
        initInformTable();
        $(".table>tbody>tr>td ").css("border","0px");
    })

    //查看详情
    function msgDeteil(id,table,msgName) {
        layer.open({
            type: 2,
            title: msgName,
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['70%', '80%'],
            content: '${base}/sys/msg/selectMsgDetail/'+id,
            btn: ['<@spring.message "common.button.confirm"/>'],
            yes: function (index, layero) {
                if(table==1){
                    $("#announcementTable").bootstrapTable("refresh");
                }else{
                    $("#informTable").bootstrapTable("refresh");
                }

                layer.close(index);
            }
        });
    }

    function changeTab1(val) {
        isNew1=val;
        $('#announcementTable').bootstrapTable("refresh")
    }

    function changeTab2(val) {
        isNew2=val;
        $('#informTable').bootstrapTable("refresh")
    }


    function initAnnouncementTable() {
        $('#announcementTable').bootstrapTable({
            url: '${base}/sys/msg/list',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            toolbar: '#annToolbar',                //工具按钮用哪个容器
            striped: false,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                var searchParams = {};
                searchParams["isNew"]=isNew1;
                searchParams["userId"] = "${currentUser.id}";
                searchParams["level"]=1;
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams
                };
                return temp;
            },
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            //rowStyle:rowStyle,
            columns: [{
                align: 'center',
                formatter: function (value, row, index) {
                    return "<span class='glyphicon glyphicon-inbox'></span>";    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                },
                width:'5%'
            },{
                title: '<@spring.message "sys.home.No"/>',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#announcementTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#announcementTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                },
                width:'5%'
            },{
                field: 'id',
                title: 'id',
                visible: false
            },{
                field: 'title',
                title: '<@spring.message "sys.home.messageTitle"/>',
                formatter:function (value, row, index) {
                    return "<a href='javascript:void(0)' onclick='msgDeteil(\""+row.id+"\",1)' >"+value+"</a>"
                },
                width:'50%'
            },{
                field: 'createBy',
                width:'20%'
            },{
                field: 'pushDate',
                title: '<@spring.message "sys.home.messagePushDate"/>',
                width:'20%'
            }]
        });
        $("thead").prop("hidden",true)

    }

    //加载通知信息
    function initInformTable() {
        $('#informTable').bootstrapTable({
            url: '${base}/sys/msg/list',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            toolbar: '#infToolbar',                //工具按钮用哪个容器
            striped: false,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                var searchParams = {};
                searchParams["isNew"]=isNew2;
                searchParams["noLevel"]=1;
                searchParams["userId"] = "${currentUser.id}";
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams
                };
                return temp;
            },
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            //rowStyle:rowStyle,
            columns: [{
                align: 'center',
                formatter: function (value, row, index) {
                    var ret="";
                    if(row.level==2){
                        ret="<span class='glyphicon glyphicon-comment'></span>"
                    }else if(row.level==3){
                        ret="<span class='glyphicon glyphicon-send'></span>"
                    }else if(row.level==4){
                        ret="<span class='glyphicon glyphicon-exclamation-sign'></span>"
                    }
                    return ret;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                },
                width:'5%'
            },{
                title: '<@spring.message "sys.home.No"/>',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#informTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#informTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                },
                width:'5%'
            },{
                field: 'id',
                title: 'id',
                visible: false
            },{
                field: 'title',
                title: '<@spring.message "sys.home.messageTitle"/>',
                formatter:function (value, row, index) {
                    return "<a href='javascript:void(0)' onclick='msgDeteil(\""+row.id+"\",2,\""+value+"\")' >"+value+"</a>"
                },
                width:'45%'
            },{
                field: 'createBy',
                width:'25%'
            },{
                field: 'pushDate',
                title: '<@spring.message "sys.home.messagePushDate"/>',
                width:'20%'
            }]
        });
        $("thead").prop("hidden",true)
    }

    //行样式
    function rowStyle(row, index) {
        if(row.level=='4'){
            return {
                classes: 'danger'
            };
        }else{
            return {
                classes: 'info'
            };
        }
    }


</script>
</body>
</html>