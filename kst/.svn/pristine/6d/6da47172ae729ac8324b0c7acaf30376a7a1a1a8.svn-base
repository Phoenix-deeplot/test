<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base }/static/plugins/dropzone/css/dropzone.css">

    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
</head>
<body>
    <div class="panel panel-default">
        <div class="panel-body">
                <span id="onsetDate">${onsetDate}</span>
                <span id="days" style=" margin-left: 100px"></span>
            ${strDate}
                <span style=" margin-left: 800px">姓名：${nickName}</span>
        </div>
    </div>
    <div class="panel-body" style="padding-bottom:0px;">
        <table id="attTable"></table>
    </div><!-- /.panel-body -->

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
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
        var y = $("#onsetDate").html().substr(0,4);
        var m = $("#onsetDate").html().substr(5,2);
        $("#onsetDate").html(y+"年"+m+"月度");
        var d = ${day};
        $("#days").html("("+m+"/"+d+"~"+Number(Number(m)+Number(1))+"/"+Number(Number(d)-Number(1))+")");
    });

    //初始化Table
    function initBootstrapTable() {
        $('#attTable').bootstrapTable({
            url: '${base}/att/modulePara/gateCardlist?onsetDate='+"'${onsetDate}'"+"&userId="+ "'${id}'",         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
           //传递参数（*）
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 50,                       //每页的记录行数（*）
            pageList: [50, 100],                //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            cardView: false,                    //是否显示详细视图
            rowStyle:  rowStyle,
            detailView: false,                   //是否显示父子表
            columns: [{
                field: 'attSigntime',
                title: '日期',
                formatter: dateymFormatter
            },{
                field: 'weekDay',
                title: '星期'
            }, {
                field: 'attLocname',
                title: '打卡地点'
            }, {
                field: 'beginWork',
                title: '第一次打卡'
            },{
                field: 'endWork',
                title: '最后一次打卡'
            },{
                field: 'turnTime',
                title: '出勤时间'
            },{
                field: 'workTime',
                title: '工作时间'
            },{
                field: 'outTime',
                title: '休息时间'
            },{
                field: '',
                title: '说明'
            },{
                field: 'dateExplain',
                title: '日期说明'
            },
            ]
        });
    };

    function rowStyle(row, index) {
        if(row.weekDay == '六'){
            var style = "";
            style='success';
            return { classes: style }
        }
        if(row.weekDay == '日'){
            var style = "";
            style='info';
            return { classes: style }
        }
        if(row.dateExplain != null){
            var style = "";
            style='danger';
            return { classes: style }

        }
        return {};
    }

    function dateymFormatter(value, row, index) {
        var oDate = new Date(value),
            oYear = oDate.getFullYear(),
            oMonth = oDate.getMonth()+1,
            oDay = oDate.getDate(),
            oTime = oDay+"日";//最后拼接时间
        return oTime;
    }

    /**
     * 重新加载表
     */
    function re_load() {
        $('#attTable').bootstrapTable('refresh');
    }


</script>
</body>
</html>