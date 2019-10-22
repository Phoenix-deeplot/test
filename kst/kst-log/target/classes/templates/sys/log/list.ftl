<!DOCTYPE html>
<html>
<head>
    <title>日志管理</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/formatJSON/jsonFormater.css" media="all" />
    <style>
        .table.table-bordered > tbody > tr >td {
            white-space:nowrap;
            overflow:hidden
        }
    </style>
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_type">请求类型</label>
                    <select id="s_type" class="selectpicker _search" name="search_eq_type" title="请选择" data-width="100px">
                        <option value="">请选择</option>
                        <option value="普通请求">普通请求</option>
                        <option value="Ajax请求">Ajax请求</option>
                    </select>
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_title">行为</label>
                    <input type="text" class="form-control _search" name="search_like_title">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_username">操作者</label>
                    <input type="text" class="form-control _search" name="search_like_username">
                </div>
                <div class="form-group" style="margin-right:20px;">
                    <label for="s_method">操作方式</label>
                    <select id="s_method" name="search_eq_http_method" class="selectpicker _search" title="请选择" data-width="100px">
                        <option value="">请选择</option>
                        <option value="POST">POST</option>
                        <option value="GET">GET</option>
                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">查询</button>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="delBtn" onclick="batchRemove();"class="btn btn-danger">
            <span class="glyphicon glyphicon-remove" ></span>批量删除
        </button>
    </div>

    <table id="logTable"></table>
    <input id="handle" name="handle" value="" hidden="hidden">
    <button id="btnShowParams" type="button" style="display: none" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
        参数显示
    </button>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div id='jsonContainer' class="Canvas" ></div>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.panel-body -->
<script>
    var baseDir = '${base}';
</script>
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
<script src="${base}/static/plugins/layer/layer.js"></script>
<script type="text/javascript" src="${base}/static/formatJSON/jsonFormater.js?v=3.0"></script>
<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {
        $('#logTable').bootstrapTable({
            url: '${base}/sys/log/list',         //请求后台的URL（*）
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
                debugger;
                console.log(searchParams);
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize" : params.pageSize,
                    "pageNumber" : params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType : "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
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
            showToggle:false,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#logTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#logTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'type',
                title: '请求类型'
            }, {
                field: 'title',
                title: '行为'
            }, {
                field: 'remoteAddr',
                title: '来源',
                visible: false
            }, {
                field: 'username',
                title: '操作者'
            }, {
                field: 'requestUri',
                title: '请求地址'
            }, {
                field: 'httpMethod',
                title: '操作方式',
                align:"center"
            }, {
                field: 'classMethod',
                title: '请求方法'
            }, {
                field: 'id',
                title: '请求参数',
                align:"center",
                formatter: paramsFormatter //自定义方法
            }, {
                field: 'sessionId',
                title: 'sessionId',
                visible: false
            }, {
                field: 'response',
                title: '返回内容',
                visible: false,
                formatter: responseFormatter
            }, {
                field: 'useTime',
                title: '执行时间',
                visible: false
            }, {
                field: 'browser',
                title: '浏览器',
                visible: false
            }, {
                field: 'exception',
                title: '异常信息',
                visible: false
            }, {
                field: 'createDate',
                title: '创建时间',
                align:"center"
            }, {
                field: 'operate',
                title: '操作',
                align:"center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            }
            ]
        });
    };

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="dt_remove(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  '
        ].join('');
    }

   function paramsFormatter(value, row, index) {//赋予的参数
        if(row.params != '' && row.params != '[]' && row.params != null){
            aa = JSON.stringify(row);
            return "<a href='javascript:void(0)' class='btn btn-info' onclick='showModal(" + row.params + ")'><span class='glyphicon glyphicon-search'></span>参数显示</a>";
        }else{
            return '<span></span>';
        }
    }

    function responseFormatter(value, row, index) {//赋予的参数
        if(row.httpMethod == 'GET'){
            return '<span>' + row.response + '</span>';
        }else{
            aa = JSON.stringify(row);
            return "<a href='javascript:void(0)' class='btn btn-info' onclick='showModal(" + row.response + ")'><span class='glyphicon glyphicon-search'></span>内容显示</a>";
        }
    }

    function showModal(data) {
        $("#jsonContainer").empty();
        debugger;
        var options = {dom : document.getElementById('jsonContainer')};
        window.jf = new JsonFormatter(options);
        jf.doFormat(data);
        $("#btnShowParams").click();
    }

    /**
     * 删除某条记录
     * @param url
     * @param id
     */
    function dt_remove(id) {
        layer.confirm('确定要删除选中的记录？', {icon: 3, title:'提示'}, function (index) {
            $.ajax({
                url: '${base}/sys/log/delete',
                type: "POST",
                data: {
                    'ids': [id]
                },
                success: function (result) {
                    if(result.success){
                        $('button[name="refresh"]').click();
                        toastr.success('删除成功!');
                        layer.close(index);
                    }else{
                        toastr.error(result.message);
                        layer.close(index);
                    }
                }
            });
        })
    }

    /**
     * 批量删除
     */
    function batchRemove() {
        var rows = $('#logTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据!");
            return;
        }
        var ids = [];
        for(var i=0;i<rows.length;i++){
            ids.push(rows[i].id);
        }
        //var ids = '';
        //遍历所有选择的行数据，取每条数据对应的ID
        /*$.each(rows, function (i, row) {
            if(row['id'] === 1){
                layer.msg("不能删除超级管理员");
                return false;
            }
        });*/
        debugger;
        layer.confirm("确认要删除选中的数据吗?", {icon: 3, title:'提示'}, function (index) {
            var deleteindex = layer.msg('删除中，请稍候...',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url: '${base}/sys/log/delete',
                type: "POST",
                data: {
                    'ids': ids
                },
                success: function (result) {
                    layer.close(deleteindex);
                    if(result.success){
                        $('button[name="refresh"]').click();
                        toastr.success('删除成功!');
                        layer.close(index);
                    }else{
                        console.log(result.message);
                        toastr.error(result.message);
                        layer.close(index);
                    }
                }
            });
        })
    }

    /**
     * 重新加载表
     */
    function re_load() {
        $('#logTable').bootstrapTable('refresh');
    }


</script>
</body>
</html>