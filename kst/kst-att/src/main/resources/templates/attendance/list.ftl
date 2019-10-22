<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
    <title>用户管理</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base }/static/plugins/dropzone/css/dropzone.css">

    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <input id="qrcodeList" type="hidden">
    <input id="showTextList" type="hidden">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_login_Name">担当者</label>
                    <input type="text" class="form-control _search" id="nickName" name="nickName">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label class="col-sm-2 control-label" for="showFrom">月报期间</label>
                    <div class="col-sm-7">
                        <div id="showDate" name="showDate" class="input-group date form_date" data-date=""
                             data-date-format="yyyy-mm" data-link-field="dtp_input2" data-link-format="yyyy-mm">
                            <input id="days" class="form-control" size="16" type="text" readonly/>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>
                </div>
                <div class="form-group" style="margin-right:20px">
                    <input type="checkbox" name="delFlag" id="delFlag" value="1"><label for="delFlag">含退职人员</label>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">检索</button>
            </form>
        </div>
    </div>
    <div id="toolbar" class="btn-group">
        <button type="button" id="gateCardDownload" class="btn btn-primary" role="dialog">出勤表下载</button>
        <button type="button" id="monthlyDownload" class="btn btn-danger">月报下载</button>
    </div>
    <table id="attTable"></table>
    <input id="handle" name="handle" value="" hidden="hidden">
</div><!-- /.panel-body -->

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化Table
        initBootstrapTable();
        var d = new Date();
        var time = d.getFullYear() + '-' + Number(Number(d.getMonth())+Number(1));
        $('#days').val(time);
    });

    //初始化Table
    function initBootstrapTable() {
        $('#attTable').bootstrapTable({
            url: '${base}/att/attendance/list',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var searchParams = {};
                $("#searchForm ._search").each(function () {
                    if ("" != $(this).val()) {
                        searchParams[$(this).attr('name')] = $(this).val();
                    }
                });
                $('input[name="delFlag"]:checked').each(function () {
                    searchParams['delFlag'] = ($(this).val());
                });
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;

                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams

                };
                return temp;
            },//传递参数（*）
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                title: '<@spring.message "sys.home.No"/>',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#attTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#attTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            },{
                field: 'loginName',
                title: '登录名',
                visible: false
            }, {
                field: 'nickName',
                title: '担当者'
            }, {
                field: 'organizationName',
                title: '部门'
            }, {
                field: 'operate',
                title: '<@spring.message "sys.user.operation"/>',
                align: "center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            },
            ]
        });
    };
    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="gateCard(\'' + row.id + '\')" class="btn btn-primary">出勤表</a>  ',
            '<a href="javascript:void(0)" onclick="monthlyStatement(\'' + row.id + '\')" class="btn btn-danger">月报表</a>  '
        ].join('');
    }

    //出勤excel
    $("#gateCardDownload").click(function () {
        var onsetDate = $("#showDate").find("input").val();
        var rows = $('#attTable').bootstrapTable('getSelections');
        if(rows.length <=0 ){
            toastr.warning("请选择你要操作的数据");
            return;
        }
        if(onsetDate==""){
            alert("请选择月报期间");
        }else{
            rows.forEach(function (r) {
                $.ajax({
                    url:'${base}/att/modulePara/turnList?onsetDate='+ onsetDate +"&userId="+r.id,
                    type: 'POST',
                    dataType: "json",
                    data: JSON.stringify(rows),
                    success:function(ret) {
                        if(ret==1){
                            toastr.success('下载成功默认C盘');
                        }
                        if(ret==0){
                            toastr.success('没有这位员工的出勤信息');
                        }
                        $('#attTable').bootstrapTable('refresh');
                        $('#days').val("");
                    }
                });
            });
        }
    });

    //月报excel
    $("#monthlyDownload").click(function () {
        var onsetDate = $("#showDate").find("input").val();
        var rows = $('#attTable').bootstrapTable('getSelections');
        if(rows.length <=0 ){
            toastr.warning("请选择你要操作的数据");
            return;
        }
        if(onsetDate==""){
            alert("请选择月报期间");
        }else{
            rows.forEach(function (r) {
                $.ajax({
                    url:'${base}/att/daily/monExcel?onsetDate='+ onsetDate +"&dailyUserid="+ r.id ,
                    type: 'POST',
                    dataType: "json",
                    data: JSON.stringify(rows),
                    success:function(ret) {
                        if(ret==1){
                            toastr.success('下载成功默认C盘');
                        }
                        if(ret==0){
                            toastr.success('没有这位员工的出勤信息');
                        }
                        $('#attTable').bootstrapTable('refresh');
                        $('#days').val("");
                    }
                });
            });
        }
    });

    /**
     * 打开出勤画面
     * @param id
     */
    function gateCard(id) {
        var onsetDate = $("#showDate").find("input").val();
        if(onsetDate==""){
            alert("请选择月报期间");
        }else{
            // iframe层
            layer.open({
                type: 2,
                title: '出勤时间记录表',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['100%', '100%'],
                content: '${base}/att/modulePara/gateCard?onsetDate=' + onsetDate +"&userId=" + id,
                btn: ['<@spring.message "common.button.cancel"/>'],
                yes: function (index, layero) {
                    layer.close(index);//这块是点击确定关闭这个弹出层
                }
            });
        }
    }

    /**
     * 打开月报画面
     * @param id
     */
    function monthlyStatement(id) {
        var onsetDate = $("#showDate").find("input").val();
        if(onsetDate==""){
            alert("请选择月报期间");
        }else{
            // iframe层
            layer.open({
                type: 2,
                title: '工作月报表',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['100%', '100%'],
                content: '${base}/att/daily/list?onsetDate=' + onsetDate +"&dailyUserid="+id,
                btn: ['<@spring.message "common.button.cancel"/>'],
                yes: function (index, layero) {
                    layer.close(index);//这块是点击确定关闭这个弹出层
                }
            });
        }
    }




    $('.form_date').datetimepicker({
        format: 'yyyy-mm',
        language: '<@spring.message "sys.message.local" />',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 3,
        minView: 3,
        forceParse: 0
    });

    /**
     * 重新加载表
     */
    function re_load() {
        $('#attTable').bootstrapTable('refresh');
    }


</script>
</body>
</html>