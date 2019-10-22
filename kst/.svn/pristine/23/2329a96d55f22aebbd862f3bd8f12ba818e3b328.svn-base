<!DOCTYPE html>
<html>
<head>
    <title>固定资产折旧</title>
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
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="divideDate">折旧年月</label>
                    <div id="divideDate" onchange="re_load()" class="input-group date form_date col-md-9" data-date=""
                         data-date-format="yyyymm" data-link-field="dtp_input2" data-link-format="yyyymm">
                        <input class="form-control" size="16" type="text" readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">查询</button>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="excelBtn" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>导出excel
        </button>
        <#--<button type="button" id="pdfBtn" class="btn btn-danger">-->
            <#--<span class="glyphicon glyphicon-remove"></span>导出pdf-->
        <#--</button>-->
        <#--<button type="button" id="pdfBtn2" class="btn btn-danger">-->
            <#--<span class="glyphicon glyphicon-remove"></span>导出pdf2-->
        <#--</button>-->
    </div>
    <table id="assetDepreciationTable">

    </table>
</div><!-- /.panel-body -->

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>

<script src="${base}/static/plugins/table-export/libs/FileSaver/FileSaver.min.js"></script>
<script src="${base}/static/plugins/table-export/libs/js-xlsx/xlsx.core.min.js"></script>
<script src="${base}/static/plugins/table-export/libs/jsPDF/jspdf.min.js"></script>
<script src="${base}/static/plugins/table-export/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
<script src="${base}/static/plugins/table-export/tableExport.min.js"></script>

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
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>


<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        $("#divideDate").datetimepicker("setDate", new Date());

        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {
        $('#assetDepreciationTable').bootstrapTable({
            url: '${base}/ams/infomationStatistics/depreciation',         //请求后台的URL（*）ams:apply:list
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
                var date = $("#divideDate").datetimepicker("getDate");

                var yymm = date.getFullYear().toString() + ((date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : '' + (date.getMonth() + 1)).toString();

                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "yymm": yymm
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
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            formatNoMatches: function () {
                return "本月没有计提信息";
            },
            columns: [{
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#assetDepreciationTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#assetDepreciationTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'buyDate',
                align: 'center',
                title: '购买日'
            }, {
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
                title: '数量',
                align: 'center'
            },{
                field: 'price',
                title: '原值',
                align: 'center',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            },{
                field: 'netWorth',
                title: '净值',
                align: 'center',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            }, {
                field: 'residualPrice',
                title: '残值',
                align: 'center',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            },{
                field: 'useLife',
                title: '年限',
                align: 'center',
            }, {
                field: 'monthProvision',
                title: '每月计提',
                align: 'center',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            },{
                field: 'provisionValue',
                title: '本月计提',
                align: 'center',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            }, {
                field: 'provisionAllValue',
                title: '已提折旧',
                align: 'center',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            }, {
                field: 'balanceValue',
                title: '账面余额',
                align: 'center',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            },{
                field: 'reservescrapDate',
                title: '备注',
                align: 'center',
                formatter:function (value) {
                    if(value!=null){
                        return "["+value+"]结束";
                    }else{
                        return "";
                    }
                }
            }]
        });
    };

    function changeDateFormat(cellval) {
        if (cellval != null) {
            var date = new Date(parseInt(cellval.replace("/Date(", "").replace(")/", ""), 10));
            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
            var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
            return date.getFullYear() + "-" + month + "-" + currentDate;
        }
    }

    $('.form_date').datetimepicker({
        format: 'yyyymm',
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 3,
        minView: 3,
        forceParse: 0
    });

    $("#datetimeStart").datetimepicker("setDate", new Date());

    function re_load() {
        $("#assetDepreciationTable").bootstrapTable("refresh");
    }

    //导出excel
    $("#excelBtn").click(function () {
        // $("#assetDepreciationTable").tableExport({
        //     type: "xlsx",
        //     escape: "false",
        // });
        var date = $("#divideDate").datetimepicker("getDate");
        var yymm = date.getFullYear().toString() + ((date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : '' + (date.getMonth() + 1)).toString();

        window.location='${base}/ams/infomationStatistics/depreciationExcel/'+yymm;
    });

    //导出pdf
    $("#pdfBtn").click(function () {
        var date = $("#divideDate").datetimepicker("getDate");
        var yymm = date.getFullYear().toString() + ((date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : '' + (date.getMonth() + 1)).toString();

        window.location='${base}/ams/infomationStatistics/depreciationPdf/'+yymm;
    })

    $("#pdfBtn2").click(function () {
        $("#assetDepreciationTable").tableExport({
            type: "pdf",
            escape: "false"
        });
    })

</script>
</body>
</html>