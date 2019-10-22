<!DOCTYPE html>
<html>
<head>
    <title>项目模块管理</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <input type="hidden" id="handle">
    <#--<div class="panel panel-default">-->
    <#--<div class="panel-body">-->

    <#--</div>-->
    <#--</div>-->
    <div id="toolbar" class="btn-group">
    </div>
    <table id="moduleTable" class="table table-condensed"></table>
</div>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>

<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {

        $('#moduleTable').bootstrapTable({
            url: '${base}/sys/module/list',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            // queryParams: function (params) {
            //     var searchParams = {};
            //     var sorts = {};
            //     sorts.createDate = "desc";
            //     var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            //         "pageSize": params.pageSize,
            //         "pageNumber": params.pageNumber,
            //         "searchParams": searchParams,
            //         "sorts": sorts
            //     };
            //     return temp;
            // },//传递参数（*）
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
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#moduleTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#moduleTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'moduleNo',
                title: '模块编号',
                align:"center"
            }, {
                field: 'moduleName',
                title: '模块名称',
                align:"center"
            }, {
                field: 'useFlag',
                title: '是否可用',
                align: 'center',
                formatter: function (value, row, index) {
                    var btn = '<input class="switch" type="checkbox" name="useFlag" id="' + row.moduleNo + '"';
                    if (value) {
                        btn += 'checked';
                    }
                    btn += '/>'
                    return btn;
                }
            }],
            onLoadSuccess: function () {
                initBootstrapSwitch();
            }
        });
    };

    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="getFlag(\'' + row.moduleNo + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span>查看</a>  '
        ].join('');
    }


    //开关控件初始化
    function initBootstrapSwitch() {
        //!* bootstrap开关控件，初始化 *!/
        $('input[name="useFlag"]').bootstrapSwitch({
            onText: "可用",      // 设置ON文本
            offText: "不可用",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "50",//设置控件宽度
        });

        $('input[name="useFlag"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            var moduleNo = $(this).attr("id");
            var flag = "";
            if (state == true) {
                console.log('可用');
                $(this).val(false);
                flag = true;
            } else {
                console.log('不可用');
                $(this).val(true);
                flag = false;
            }
            updateUseFlag(moduleNo, flag);
        });
    }

    //修改使用状态
    function updateUseFlag(moduleNo, flag) {
        $.ajax({
            url: '${base}/sys/module/editModule',
            type: 'post',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({'moduleNo': moduleNo, 'useFlag': flag}),
            success: function (re) {
                if (!re.success) {
                    toastr.error("修改失败")
                }
            }
        })
    }

    function getFlag(moduleNo) {
        $.ajax({
            url: '${base}/sys/module/getModuleUseFlag',
            type: 'post',
            data: {'moduleNo': moduleNo},
            success: function (re) {
                if (re) {
                    toastr.success("可用");
                } else {
                    toastr.error("不可用");
                }
            }
        })
    }
</script>
</body>
</html>