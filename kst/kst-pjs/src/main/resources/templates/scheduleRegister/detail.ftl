<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>项目工作</title>
    <meta name="viewport" content="width=device-width" />
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">

    <style>
        .form-group {
            height: 55px;
        }
    </style>
</head>
<body>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>


<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">
        <input hidden="hidden" id="pjId" name="pjId" value="${pjId}"/>
        <input hidden="hidden" id="mode" name="mode" value="${mode}"/>

        <div id="toolbar">
            <input type="button" onclick="uploadData()" style="margin-left: 20px;" class="btn btn-info" value="保存"/>
            <#--<input type="button" onclick="removeSoftToTable()" class="btn btn-danger" value="删除"/>-->
        </div>
        <table id="schDetailTable" class="table table-condensed"></table>
    </form>
</div>


<script type="text/javascript">
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        loadChoiceUsers();
    });


    function loadChoiceUsers() {

        $("#schDetailTable").bootstrapTable({
            url: '${base}/pjs/schDetail/list',         //请求后台的URL（*）ams:apply:list
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                var searchParams = {};
                searchParams["pjId"] = $("#pjId").val();
                searchParams['mode'] =$("#mode").val();
                searchParams['loginName']='${currentUser.loginName}';
                searchParams['userId']='${currentUser.id}';
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;

                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            queryParamsType : "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [2,10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            singleSelect:true,
            columns: [{
                field:'index',
                title: '序号',
                align: 'center',
                width:'5%',
                formatter: function (value, row, index) {
                    var pageSize = $('#schDetailTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#schDetailTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'interiorNo',
                title: '内部编号',
                visible:false
            },{
                field: 'workNo',
                title: '作业编号',
                width:'10%',
            },{
                field: 'pjName',
                title: '项目名称',
                width:'10%',
            },{
                field: 'workName',
                title: '作业名称',
                width:'15%',
            },{
                field: 'workBKindName',
                title: '工作分类',
                width:'15%',
                formatter:function (value, row, index) {
                    var kind="";
                    if(row.workBKindName!=null && row.workBKindName!=""){
                        kind+=row.workBKindName
                    }
                    if(row.workMKindName!=null && row.workMKindName!=""){
                        kind+="/"+row.workMKindName
                    }
                    if(row.workSKindName!=null && row.workSKindName!=""){
                        kind+="/"+row.workSKindName;
                    }
                    return kind;
                }
            },{
                field: 'workPlanUserName',
                title: '预定担当者',
                align:"center",
                width:'8%',
            },{
                field: 'workFinishPer',
                title: '实际完成比例',
                width:'10%',
                align:"center",
                formatter:function (value, row, index) {
                    return ['<div class="col-sm-10"><input type="text" class=" form-control " onkeyup="clearNoNum(this)" name="workFinishPer' + index + '" oninput="if(value>100)value=100;if(value<0)value=0"  value="' + (value == null ? "" : value) + '" /></div><label class="control-label">%</label>'];
                }
            },{
                field: 'todayTime',
                title: '今日工时',
                align:"center",
                width:'5%'
            },{
                title: '本次工时',
                align:"center",
                width:'5%',
                formatter:function (value, row, index) {
                    return ['<input type="text" class="form-control" onkeyup="clearNoNum(this)"  name="workFactTimes' + index + '" oninput="if(value>100)value=100;if(value<0)value=0" />'];
                }
            },{
                title: '补充说明',
                align:"center",
                width:'20%',
                formatter:function (value, row, index) {
                    return ['<input type="text" class="form-control" name="memo' + index + '"/>'];
                }
            }
            ]
        });
    }

    //提交数据
    function uploadData() {
        var rows=$("#schDetailTable").bootstrapTable("getData");
        var upData=[];
        for(var i=0;i<rows.length;i++){
            var row=rows[i];
            var workFactTimes=$("[name='workFactTimes"+i+"']").val();
            var workFinishPer=$("[name='workFinishPer"+i+"']").val();
            if(workFactTimes!="" && workFactTimes!=null && workFinishPer!="" && workFinishPer!=null){

                var schHistory={
                    'workInteriorNo':row.interiorNo,
                    'workFactUser':'${currentUser.loginName}',//进度记录者
                    'workFactTimes':workFactTimes,
                    'workFinishPer':workFinishPer,
                    'workMemo':$("[name='memo"+i+"']").val()
                }
                upData.push(schHistory)
            }
        }

        $.ajax({
            url: '${base}/pjs/scheduleRegister/scheduleResgiter',
            type: 'POST',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(upData),
            success: function () {
                $("#schDetailTable").bootstrapTable("refresh");
            }, error: function () {
                toastr.error("提交失败")
            }
        });
    }

    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");

    }

</script>
</body>
</html>