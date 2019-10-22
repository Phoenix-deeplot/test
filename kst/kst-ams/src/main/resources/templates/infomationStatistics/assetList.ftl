<!DOCTYPE html>
<html>
<head>
    <title>资产清单</title>
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
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">名称</label>
                    <input type="text" class="form-control _search" id="name"
                           name="name">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="search_eq_classify_id">状态</label>
                    <select name="statusProperty" id="statusProperty" class="selectpicker" title="请选择"
                            data-width="150px">
                        <option value="">请选择</option>
                        <#list assetStatus as test>
                            <option value="${test.value}">${test.label}</option>
                        </#list>
                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">查询</button>
                <br><br>
                <div class="form-group" style="margin-right:20px">
                    <label for="search_eq_classify_id">资产分类</label>
                    <#list assetType as test>
                        <label for="classifyId${test_index}" style="width: 100px;"><input type="checkbox" name="classifyId" id="classifyId${test_index}" value="${test.value}" checked>${test.label}</label>
                    </#list>
                    &nbsp;
                    <input type="checkbox" name="checkAll" id="checkAll" checked><label for="checkAll">全选</label>
                </div>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="excelBtn" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>导出excel
        </button>
        <button type="button" id="excelDetailBtn" class="btn btn-info" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>导出详细excel
        </button>
    </div>
    <table id="assetListTable"></table>

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
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>


<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        $("#divideDate").datetimepicker("setDate", new Date());

        $("#search_eq_classify_id").selectpicker('refresh');
        $("#search_eq_classify_id").selectpicker('render');

        //初始化Table
        initBootstrapTable();
    });

    //初始化资产信息Table
    function initBootstrapTable() {
        $('#assetListTable').bootstrapTable({
            url: '${base}/ams/infomationStatistics/assetList',         //请求后台的URL（*）ams:apply:list
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var classifyIds =[];
                $('input[name="classifyId"]:checked').each(function () {
                    classifyIds.push($(this).val());
                });

                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "name": $("#name").val(),
                    "classifyId": classifyIds,
                    "statusProperty": $("#statusProperty").val(),
                };
                return temp;
            },//传递参数（*）
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#assetListTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#assetListTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            },{
                field: 'assetInputNo',
                align: 'center',
                title: '资产编号'
            }, {
                field: 'name',
                title: '资产名称',
                align: 'center'
            },{
                field: 'classifyName',
                align: 'center',
                title: '资产类型'
            }, {
                field: 'amount',
                align: 'center',
                title: '购买数量',
            },{
                field: 'useAmount',
                align: 'center',
                title: '使用数量'
            },{
                field: 'useRatio',
                align: 'center',
                title: '使用比例'
            },{
                field: 'price',
                title: '原值',
                align: 'center'
            },{
                field: 'supplierName',
                align: 'center',
                title: '供应商'
            },{
                field: 'useLife',
                title: '年限',
                align: 'center'
            }, {
                field: 'buyDate',
                align: 'center',
                title: '购买日'
            }, {
                field: 'reserveScrapDate',
                title: '报废预定日',
                align: 'center'
            }, {
                field: 'actualScrapDate',
                title: '报废实际日',
                align: 'center'
            },{
                field: 'applyUserName',
                title: '领用者',
                align: 'center'
            }, {
                field: 'locationName',
                title: '保管场所',
                align: 'center'
            },{
                field: 'takeOutUserName',
                title: '带出者',
                align: 'center'
            },{
                field: 'examineTarget',
                title: '点检对象',
                align: 'center'
            },{
                field: 'remarks',
                title: '备注',
                align: 'center'
            }]
        });
    };

    //重新加载
    function re_load() {
        $("#assetListTable").bootstrapTable("refresh");
    }

    //导出excel
    $("#excelBtn").click(function () {
        var classifyIds =[];
        $('input[name="classifyId"]:checked').each(function () {
            classifyIds.push($(this).val());
        });
        window.location='${base}/ams/infomationStatistics/assetListExcel?name='+$("#name").val()+"&classifyId="+classifyIds+"&statusProperty="+$("#statusProperty").val();
    });

    //导出详细excel
    $("#excelDetailBtn").click(function () {
        var classifyIds =[];
        $('input[name="classifyId"]:checked').each(function () {
            classifyIds.push($(this).val());
        });
        window.location='${base}/ams/infomationStatistics/assetListDetailExcel?name='+$("#name").val()+"&classifyId="+classifyIds+"&statusProperty="+$("#statusProperty").val();
    });

    //checkbox属性
    $('input[name="classifyId"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    }).on('ifChanged', function (event) {
        if($("[name='classifyId']:checked").length==$("[name='classifyId']").length){
            $('input[name="checkAll"]').iCheck('check');
        }else{
            $('input[name="checkAll"]').iCheck('uncheck');
        }
    });

    $('input[name="checkAll"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    }).on('ifClicked', function (event) {
        if(!$('input[name="checkAll"]')[0].checked){
            $('input[name="classifyId"]').each(function () {
                $(this).iCheck('check');
            });

        }else{
            $('input[name="classifyId"]').each(function () {
                $(this).iCheck('uncheck');
            });
        }
    });

</script>
</body>
</html>