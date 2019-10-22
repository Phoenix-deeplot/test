<!DOCTYPE html>
<html>
<head>
    <title>资产报废信息</title>
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
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
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
                    <label for="s_name">预定/实际</label>
                    <input type="checkbox" name="isReserve" id="isReserve">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">出力对象</label>
                    <input type="checkbox" name="yymm" id="yymm">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">年月</label>
                    <div id="discardDate" onchange="re_load()" class="input-group date form_date col-md-9" data-date=""
                         data-date-format="yyyymm" data-link-field="dtp_input2" data-link-format="yyyymm">
                        <input class="form-control" size="16" type="text" readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="excelBtn" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>导出excel
        </button>
    </div>
    <table id="assetDiscardTable" style="width: 100%">

    </table>
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
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>


<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        $("#discardDate").datetimepicker("setDate", new Date());

        $("#search_eq_classify_id").selectpicker('refresh');
        $("#search_eq_classify_id").selectpicker('render');

        //初始化Table
        initBootstrapTable();
        //初始化switch开关
        initBootstrapSwitch();
    });

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

    //初始化Table
    function initBootstrapTable() {
        $('#assetDiscardTable').bootstrapTable({
            url: '${base}/ams/infomationStatistics/selectDiscard',         //请求后台的URL（*）ams:apply:list
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                var isReserve = $("#isReserve")[0].checked;
                var temp = {};
                if ($("#discardDate").find("input").val() != null) {
                    var date = $("#discardDate").find("input").val();
                    if ($("#yymm")[0].checked) {
                        //年
                        if ($("#isReserve")[0].checked) {
                            //实际
                            temp.actualYy = date.substring(0, 4);
                        } else {
                            //预定
                            temp.reserveYy = date.substring(0, 4);
                        }
                    } else {
                        //年月
                        if ($("#isReserve")[0].checked) {
                            //实际
                            temp.actualYymm = date;
                        } else {
                            //预定
                            temp.reserveYymm = date;
                        }
                    }
                }
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
                    var pageSize = $('#assetDiscardTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#assetDiscardTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'assetInputNo',
                align: 'center',
                title: '资产编号'
            }, {
                field: 'name',
                title: '资产名称',
                align: 'center'
            }, {
                field: 'classifyName',
                align: 'center',
                title: '资产类型'
            }, {
                field: 'amount',
                align: 'center',
                title: '购买数量',
            }, {
                field: 'price',
                align: 'center',
                title: '原价',
                formatter:function (value) {
                    return value.toFixed(2)
                }
            }, {
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
            }, {
                field: 'applyUserName',
                title: '领用者',
                align: 'center'
            }, {
                field: 'locationName',
                title: '保管场所',
                align: 'center'
            }, {
                field: 'takeOutUserName',
                title: '带出者',
                align: 'center'
            }, {
                field: 'examineTarget',
                title: '点检对象',
                align: 'center'
            }, {
                field: 'remarks',
                title: '备注',
                align: 'center'
            }]
        });
    };

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

    function re_load() {
        $("#assetDiscardTable").bootstrapTable("refresh");
    }

    function initBootstrapSwitch() {
        $('input[name="isReserve"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="isReserve"]').bootstrapSwitch({
            onText: "实际",      // 设置ON文本
            offText: "预定",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "info",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="isReserve"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            re_load()
            if (state == true) {
                $(this).val(false);
                $("#assetDiscardTable").bootstrapTable('hideColumn','reserveScrapDate');
            } else {
                $(this).val(true);
                $("#assetDiscardTable").bootstrapTable('showColumn','reserveScrapDate');
            }
        });

        $('input[name="yymm"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="yymm"]').bootstrapSwitch({
            onText: "年度",      // 设置ON文本
            offText: "月度",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "info",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="yymm"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            re_load()
            if (state == true) {
                $(this).val(false);
            } else {
                $(this).val(true);
            }
        });
    }

    //导出excel
    $("#excelBtn").click(function () {
        var yymmFlag=$("#yymm")[0].checked;
        var isReserveFlag=$("#isReserve")[0].checked;
        var date = $("#discardDate").find("input").val();
        window.location = '${base}/ams/infomationStatistics/assetDiscardExcel?date='+date+"&yymmFlag="+yymmFlag+"&isReserveFlag="+isReserveFlag;
    });


</script>
</body>
</html>