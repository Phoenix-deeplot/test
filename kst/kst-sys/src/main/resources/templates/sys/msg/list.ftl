<!DOCTYPE html>
<html>

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>通知管理</title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
</head>

<body style="margin:10px 10px 0;">
<div class="panel-body" style="padding-bottom:0px;border: 1 black solid;">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:10px">
                    <label for="s_name"><@spring.message "sys.msg.title" /></label>
                    <input type="text" class="form-control _search" id="search_title" name="title" >
                </div>
                <#--<div class="form-group" style="margin-right:10px">-->
                    <#--<label for="showFrom">时间区间</label>-->
                    <#--<div id="showFrom"  class="input-group date form_date" data-date=""-->
                         <#--data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">-->
                        <#--<input class="form-control" size="16" type="text" readonly>-->
                        <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
                        <#--<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>-->
                    <#--</div>-->
                    <#----->
                    <#--<div id="showTo" class="input-group date form_date" data-date=""-->
                         <#--data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">-->
                        <#--<input class="form-control" size="16" type="text" readonly>-->
                        <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
                        <#--<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>-->
                    <#--</div>-->
                <#--</div>-->
                <div class="form-group" style="margin-right:10px">
                    <label for="s_name"><@spring.message "sys.msg.level" /></label>
                    <select id="search_level" name="level" class="form-control selectpicker _search" title="<@spring.message "sys.message.choice" />" data-width="200px">
                        <option value="" ><@spring.message "sys.message.choice" /></option>
                        <#list msgTypes as type>
                            <option value="${type.value}"
                                    <#if (msg.level=='${type.value}')>selected</#if>>${type.label}</option>
                        </#list>
                    </select>
                </div>
                <button type="button" style="margin-left:10px" onclick="re_load()" class="btn btn-primary"><@spring.message "common.button.search" /></button>
            </form>
        </div>
    </div>
    <div id="toolbar">
        <button type="button" id="addBtn" onclick="addMsg()" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span><@spring.message "common.button.add" />
        </button>
        <button type="button" id="returnBtn" onclick="deleteSome()" class="btn btn-danger" role="dialog">
            <span class="glyphicon glyphicon-remove"></span><@spring.message "common.button.deleteInBatches" />
        </button>
    </div>
    <table id="msgTable"></table>
</div>

</body>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table-treegrid.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local" />.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.<@spring.message "sys.message.local" />.js"></script>

<script type="text/javascript">

    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        initBootstrapTable();
    })

    $('.form_date').datetimepicker({
        format: 'yyyy-mm-dd',
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

    function initBootstrapTable() {
        $('#msgTable').bootstrapTable({
            url: '${base}/sys/msg/list',         //请求后台的URL（*）
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
                searchParams["requestType"]='list';
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams
                };
                return temp;
            },
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
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
                title: '<@spring.message "sys.home.No" />',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#msgTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#msgTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            },{
                field: 'title',
                title: '<@spring.message "sys.msg.title" />'
            },{
                field: 'levelLabel',
                title: '<@spring.message "sys.msg.level" />'
            },{
                field: 'showFrom',
                title: '<@spring.message "sys.msg.showFrom" />'
            },{
                field: 'showTo',
                title: '<@spring.message "sys.msg.showTo" />'
            },{
                field: 'pushTypeLabel',
                title: '<@spring.message "common.button.add" />'
            },{
                field: 'pushDate',
                title: '<@spring.message "sys.msg.pushDate" />'
            },{
                field: 'operate',
                title: '<@spring.message "sys.user.operation" />',
                align:"center",
                width:'15%',
                formatter: operateFormatter //自定义方法，添加操作按钮
            },
            ]
        });
    }

    function addMsg() {
        layer.open({
            type: 2,
            title: '<@spring.message "sys.msg.add" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/sys/msg/add',
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {
                var formSubmit=layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 1){
                    toastr.success('<@spring.message "sys.message.addSuccess" />');
                }
            }
        });
    }

    //修改
    function editMsg(id) {
        layer.open({
            type: 2,
            title: '<@spring.message "sys.msg.edit" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/sys/msg/edit?id='+id,
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {
                // 获取弹出层中的form表单元素
                var formSubmit=layer.getChildFrame('form', index);
                // 获取表单中的提交按钮
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 2){
                    toastr.success('<@spring.message "sys.msg.editSuccess" />!');
                }
            }
        });
    }

    function deleteOneMsg(id) {

        layer.confirm('<@spring.message "sys.user.message.isDelete" />', {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            $.ajax({
                url:'${base}/sys/msg/deleteMsg/'+id,
                type:'post',
                success:function (ret) {
                    if(ret.success){
                        re_load();
                        toastr.success('<@spring.message "sys.message.deleteSuccess" />');
                    }else{
                        toastr.error("删除信息失败");
                    }
                    layer.close(index);
                }
            });
        });
    }

    //批量删除
    function deleteSome() {
        var rows=$("#msgTable").bootstrapTable("getSelections");
        if(rows.length==0){
            toastr.warning("<@spring.message "sys.message.choiceDelete" />");
            return;
        }

        layer.confirm('<@spring.message "sys.user.message.isDelete" />', {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            $.ajax({
                url:'${base}/sys/msg/deleteMsgSome',
                type:'post',
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(rows),
                success:function (ret) {
                    if(ret.success){
                        re_load();
                        toastr.success('<@spring.message "sys.message.deleteSuccess" />');
                    }else{
                        toastr.error("删除信息失败");
                    }
                    layer.close(index);
                }
            });
        });
    }

    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="editMsg(\''+ row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span><@spring.message "common.button.edit" /></a>  ',
            '<a href="javascript:void(0)" onclick="deleteOneMsg(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span><@spring.message "common.button.delete" /></a>  '
        ].join('');
    }

    function re_load() {
        $("#msgTable").bootstrapTable("refresh");
    }

</script>

</html>