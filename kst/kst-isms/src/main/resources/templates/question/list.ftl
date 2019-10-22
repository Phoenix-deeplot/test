<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>问题管理</title>
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
    <style>
        .table {table-layout:fixed;word-break:break-all;}
    </style>
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_login_Name">考题名称</label>
                    <input type="text" class="form-control _search" name="searchName" id="searchName">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_email">考题分类</label>
                    <select name="searchCategory" id="searchCategory" class="selectpicker" title="请选择"
                            data-width="150px">
                    </select>
                </div>
                <div class="form-group" style="margin-right:20px;">
                    <label for="s_disableFlag">考题类型</label>
                    <select name="searchType" id="searchType" class="selectpicker" title="请选择" data-width="100px">
                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load()"
                        class="btn btn-primary">查询
                </button>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="addQuestion()" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>新增考题
        </button>
        <button type="button" id="delBtn" onclick="delSomeQuestion()" class="btn btn-danger">
            <span class="glyphicon glyphicon-remove"></span>批量删除
        </button>
    </div>

    <table id="questionTable"></table>
</div>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table-treegrid.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script>
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        loadQuestion();
        selectFileType('isms_question_type');
        selectFileType('isms_question_category');
    });

    function loadQuestion() {
        $('#questionTable').bootstrapTable({
            url: '${base}/isms/question/list',         //请求后台的URL（*）
            method: 'post',
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var searchParams = {};
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                var select = $("#searchType").val();
                if (select != null && select != "") {
                    searchParams["type"] = select;
                }

                searchParams["name"] = $("#searchName").val();
                searchParams["category"] = $("#searchCategory").val();
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
            sortName: 'id',
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            toolbar: '#toolbar',
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                width:'5%',
                formatter: function (value, row, index) {
                    var pageSize = $('#questionTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#questionTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'name', title: '考题名称',width:'45%'
            }, {
                field: 'categoryLabel', title: '考题分类',align: "center",width:'10%'
            }, {
                field: 'typeLabel', title: '类型', align: "center",width:'10%'
            }, {
                field: 'answer', title: '答案',align: "center",width:'10%'
            }, {
                field: 'operate', title: '操作', align: "center",width:'20%',
                formatter: operateFormatter //自定义方法，添加操作按钮
            }]
        });
    }

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="editQuestion(\'' + row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span> 编辑</a>  ',
            '<a href="javascript:void(0)" onclick="delQuestion(\'' + row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span> 删除</a>  '
        ].join('');
    }

    //刷新
    function re_load() {
        $("#questionTable").bootstrapTable('refresh');
    }

    //查询type=isms_question_type
    function selectFileType(type) {
        $.ajax({
            url: '${base}/isms/question/selectFileType',
            type: 'post',
            data: {'type': type},
            success: function (data) {
                var options = "<option value=''>请选择</option>";
                for (var i = 0; i < data.length; i++) {
                    options += "<option value='" + data[i].value + "'>" + data[i].label + "</option>";
                }
                if (type == 'isms_question_type') {
                    $("#searchType").append(options);
                    $("#searchType").selectpicker('refresh');
                    $("#searchType").selectpicker('render');
                } else if (type == 'isms_question_category') {
                    $("#searchCategory").append(options);
                    $("#searchCategory").selectpicker('refresh');
                    $("#searchCategory").selectpicker('render');
                }

            }, error: function () {
                alert("error：" + type)
            }
        });
    }

    //
    function delTest(id) {
        layer.confirm('确定要删除这个考卷吗？', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url: '${base}/isms/test/delete',
                type: 'post',
                data: {'id': id},
                success: function (result) {
                    if (result.success) {
                        re_load();
                        toastr.success('删除成功!');
                        layer.close(index);
                    } else {
                        toastr.error(result.message);
                        layer.close(index);
                    }
                }
            });
        });
    }

    //批量删除
    function delSomeTest() {
        var rows = $('#questionTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据!");
            return;
        }

        layer.confirm("确认要删除选中的考题吗?", {icon: 3, title: '提示'}, function (index) {
            var list = [];
            for (var i = 0; i < rows.length; i++) {
                list[i] = {'id': rows[i].id, 'delFlag': true}
            }
            $.ajax({
                url: '${base}/isms/question/deleteSome',
                type: 'POST',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(list),
                success: function (result) {
                    toastr.success('删除成功!');
                    layer.close(index);
                    $("#questionTable").bootstrapTable('refresh');
                }
            });
        });
    }

    //新增考题
    function addQuestion() {
        layer.open({
            type: 2,
            title: '新增考题',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/isms/question/add',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var child = window[layero.find('iframe')[0]['name']];
                if (child.checkTrueQuestion()) {
                    var formSubmit = layer.getChildFrame('form', index);
                    var submited = formSubmit.find('#btnConfirm');
                    submited.click();
                } else {
                    child.toastr.error("请选择足够数量的正确答案");
                }
            }, end: function () {
                $('#resourceTable').bootstrapTable('refresh');
            }
        });
    }

    //进入修改页面
    function editQuestion(id) {
        layer.open({
            type: 2,
            title: '修改考题',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/isms/question/edit/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {

                var child = window[layero.find('iframe')[0]['name']];
                if (child.checkTrueQuestion()) {
                    var formSubmit = layer.getChildFrame('form', index);
                    var submited = formSubmit.find('#btnConfirm');
                    submited.click();
                } else {
                    child.toastr.error("请选择足够数量的正确答案");
                }

            }, end: function () {
                $('#resourceTable').bootstrapTable('refresh');
            }
        });
    }

    function delQuestion(id) {
        layer.confirm('确定要删除这个考题吗？', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url: '${base}/isms/question/delete',
                type: 'post',
                data: {'id': id},
                success: function (result) {
                    if (result.success) {
                        re_load();
                        toastr.success('删除成功!');
                        layer.close(index);
                    } else {
                        toastr.error(result.message);
                        layer.close(index);
                    }

                }, error: function () {
                    toastr.error("删除失败");
                }
            });
            re_load();
        });

    }

    //批量删除
    function delSomeQuestion() {
        var rows = $('#questionTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据!");
            return;
        }
        layer.confirm("确认要删除选中的考题吗?", {icon: 3, title: '提示'}, function (index) {
            var list = [];
            for (var i = 0; i < rows.length; i++) {
                list[i] = {'id': rows[i].id, 'delFlag': true}
            }
            $.ajax({
                url: '${base}/isms/question/deleteSome',
                type: 'POST',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(list),
                success: function (result) {
                    toastr.success('删除成功!');
                    layer.close(index);
                    $("#questionTable").bootstrapTable('refresh');
                }
            });
            re_load();
        });
    }

</script>
</body>
</html>