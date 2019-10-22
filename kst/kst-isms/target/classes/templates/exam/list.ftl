<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>评估测试</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <input type="hidden" id="editType"/><!--添加：1 修改：2-->
                <div class="form-group" style="margin-right:20px">
                    <label for="s_login_Name">考试名称</label>
                    <input type="text" class="form-control _search" name="search_like_name" id="search_like_name">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_email">考试类型</label>
                    <select name="search_eq_type" id="search_eq_type" class="selectpicker" title="请选择"
                            data-width="150px">
                        <option value="">请选择</option>
                        <#list examParams.testTypeList as types >
                            <option value="${types.value}">${types.label}</option>
                        </#list>
                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load()"
                        class="btn btn-primary">查询
                </button>
            </form>
        </div>
    </div>

    <table id="examTable"></table>
</div>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table-treegrid.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>

<script>
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        loadTest();
    });

    function loadTest() {
        $('#examTable').bootstrapTable({
            url: '${base}/isms/exam/list',         //请求后台的URL（*）
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
                //var select = $("#searchType").val();
                searchParams["id"]="${currentUser.id}";
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                searchParams["name"]=$("#search_like_name").val();
                searchParams["type"]=$("#search_eq_type").val();
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
            //clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#examTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#examTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'automationFlag',
                title: '自动生成',
                visible: false
            }, {
                field: 'name', title: '标题'
            }, {
                field: 'type', title: '考试类型', formatter: function (value, row, index) {
                    var re = "";
                    <#list examParams.testTypeList as types >
                    if ("${types.value}" == value) {
                        re = "${types.label}";
                    }
                    </#list>
                    return re;
                }
            }, {
                field:'firstFlag',
                title:'完成状态',
                formatter:function (value,row,index) {
                    var scores=row.questionScores.split(",");
                    var amounts=row.questionAmounts.split(",");
                    var sum=0;
                    for (var i=0;i<scores.length;i++){
                        sum+=scores[i]*amounts[i]
                    }
                    var r="";
                    if(value){
                        r="<label style='color:black'>未作答</label>"
                    }else{
                        if(row.lastScore<row.qualifiedScore){
                            r="<label style='color:red'>未及格（"+row.lastScore+"/"+sum+"）</label>"
                        }else if (row.lastScore==sum) {
                            r="<label style='color:blue'>满分（"+row.lastScore+"/"+sum+"）</label>"
                        }else{
                            r="<label style='color:green'>及格（"+row.lastScore+"/"+sum+"）</label>"
                        }
                    }
                    return r;
                }
            },{
                field: 'operate', title: '操作', align: "center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            }]
        });
    }


    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        var scores=row.questionScores.split(",");
        var amounts=row.questionAmounts.split(",");
        var sum=0;
        for (var i=0;i<scores.length;i++){
            sum+=scores[i]*amounts[i]
        }
        var text="考试";
        if(row.lastScore==sum){
            text="查看"
        }
        return [
            '<a href="javascript:void(0)" onclick="doExam(\'' + row.id + '\')" class="btn btn-info"><span class="glyphicon glyphicon-pencil" ></span>'+text+'</a>  '
        ].join('');
    }

    //刷新
    function re_load() {
        $("#examTable").bootstrapTable('refresh');
    }

    //开始测试
    function doExam(id){
        layer.open({
            type: 2,
            title: '测试',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/isms/exam/doExam/'+id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var child = window[layero.find('iframe')[0]['name']];
                child.submit();
                //var formSubmit = layer.getChildFrame('$()', index);
            }, end: function () {

            }
        });
    }

</script>
</body>
</html>