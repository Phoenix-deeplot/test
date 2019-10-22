<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <title>提出问题</title>
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
        <div class="panel-heading"><@spring.message "sys.condition.query" /></div>
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px"><#--search_eq_qus_title-->
                    <label for="s_type"><@spring.message "sys.question.title" /></label>
                    <input type="text" class="form-control _search" name="qusTitle" >
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_label"><@spring.message "sys.question.flag" /></label>
                    <select id="search_level" name="qusFlag" class="form-control selectpicker _search" title="<@spring.message "sys.message.choice" />" data-width="200px">
                        <option value="" ><@spring.message "sys.message.choice" /></option>
                        <#list questionFlag as type>
                            <option value="${type.value}">${type.label}
                            </option>
                        </#list>
                    </select>
                </div>
                <div class="form-group" style="margin-right:10px">
                    <label for="s_name"><@spring.message "sys.question.status" /></label>
                    <select id="search_level" name="qusStatus" class="form-control selectpicker _search" title="<@spring.message "sys.message.choice" />" data-width="200px">
                        <option value="" ><@spring.message "sys.message.choice" /></option>
                        <#list questionStatus as type>
                            <option value="${type.value}" >${type.label}</option>
                        </#list>
                    </select>
                </div>

                <div class="form-group" style="margin-right:20px">
                    <input type="checkbox" name="qusPusher" id="qusPusher" value="${loginName}"><label for="qusPusher"><@spring.message "sys.question.raise" /></label>
                    &nbsp;
                    <input type="checkbox" name="qusRequester" id="qusRequester" value="${loginName}"><label for="qusRequester"><@spring.message "sys.questions.answer" /></label>
                </div>

                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary"><@spring.message "common.button.search" /></button>
            </form>
        </div>
    </div>
    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="addQuestion();" class="btn btn-primary" role="dialog"><@spring.message "common.button.add" /></button>
        <button type="button" id="delBtn" onclick="questionRemove();"class="btn btn-danger"><@spring.message "common.button.deleteInBatches" /></button>
    </div>
    <table id="questionTable"></table>
    <input id="handle" name="handle" value="" hidden="hidden">
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

        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {

        $('#questionTable').bootstrapTable({
            url: '${base}/sys/question/list',         //请求后台的URL（*）
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

                $('input[name="qusPusher"]:checked').each(function () {
                    searchParams['qusPusher']=($(this).val());
                });

                $('input[name="qusRequester"]:checked').each(function () {
                    searchParams['qusRequester']=($(this).val());
                });
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams
                };
                return temp;
            },//传递参数（*）
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
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                title: '<@spring.message "sys.home.No"/>',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#questionTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#questionTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            },{
                field: 'qusPusher',
                title: '<@spring.message "sys.question.requester" />',
                visible: false
            },{
                field: 'qusflag',
                title: '<@spring.message "sys.question.flag" />',

            }, {
                field: 'qusTitle',
                title: '<@spring.message "sys.question.title" />'
            },{
                field: 'qusPushdate',
                title: '<@spring.message "sys.question.pushdate" />',
                align:"center"
            }, {
                field: 'qusPushername',
                title: '<@spring.message "sys.question.pusher" />',
                align:"center"
            },{
                field: 'qusRequestdate',
                title: '<@spring.message "sys.question.requestdate" />',
                align:"center"
            },{
                field: 'qusRequestername',
                title: '<@spring.message "sys.question.requester" />',
                align:"center"
            },{
                field: 'qusstatus',
                title: '<@spring.message "sys.question.status" />',
                align:"center"
            },{
                title: '<@spring.message "sys.operation" />',
                align:"center",
                formatter: operateFormatter //自定义方法，添加操作按钮

            },
            ]

        });
    };
    //操作格式自定义
    function operateFormatter(value, row, index) { //赋予的参数
        if(row.qusStatus==0){
            return [
                '<a href="javascript:void(0)" onclick="dt_updateQuestion(\''+ row.id + '\',0)" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span><@spring.message "sys.quizzer.update" /></a>  ',
                '<a href="javascript:void(0)" onclick="dt_updateQuestion(\''+ row.id + '\',1)" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span><@spring.message "sys.question.answer" /></a>',
                '<a href="javascript:void(0)" onclick="dt_remove(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span><@spring.message "sys.delete" /></a>  '

            ].join('');
        }else{
            return [
                '<a href="javascript:void(0)" onclick="dt_updateQuestion(\''+ row.id + '\',1)" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span><@spring.message "sys.question.answer" /></a> '
            ].join('');
        }

    }

    /**
     * 打开新增框
     */
    function addQuestion() {
        layer.open({
            type: 2,
            title: '<@spring.message "sys.question.add" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/sys/question/add',
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {
                var formSubmit=layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 1){
                    re_load();
                    toastr.success('<@spring.message "sys.message.addSuccess" />');

                }
            }
        });
    }

    /**
     * 打开编辑框
     * @param id
     */
    function dt_updateQuestion(id,da) {
        layer.open({
            type: 2,
            title: '<@spring.message "sys.question.update" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/sys/question/edit?id='+id+'&da='+da,
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {
                // 获取弹出层中的form表单元素
                var formSubmit=layer.getChildFrame('form', index);
                // 获取表单中的提交按钮
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
                toastr.success('<@spring.message "sys.msg.editSuccess" />!');
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 2){
                    re_load();
                }
            }
        });
    }


    /**
     * 删除某条记录
     * @param url
     * @param id
     */
    function dt_remove(id) {
        layer.confirm('<@spring.message "sys.user.message.isDelete" />', {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            $.ajax({
                url: '${base}/sys/question/deleteQus/'+id,
                type: "POST",
                data: {
                    'id': id
                },
                success: function (result) {
                    if(result.success){
                        $('button[name="refresh"]').click();
                        re_load();
                        toastr.success('<@spring.message "sys.message.deleteSuccess" />');
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
    function questionRemove() {
        var rows = $('#questionTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("<@spring.message "sys.message.choiceDelete" />!");
            return;
        }

        layer.confirm("<@spring.message "sys.user.message.isDelete" />?", {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            var deleteindex = layer.msg('<@spring.message "sys.message.inDelete" />',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url: '${base}/sys/question/deleteQusSome',
                type: "POST",
                dataType:"json",
                contentType:"application/json",
                data: JSON.stringify(rows),
                success: function (result) {
                    layer.close(deleteindex);
                    if(result.success){
                        $('button[name="refresh"]').click();
                        re_load();
                        toastr.success('<@spring.message "sys.message.deleteSuccess" />');
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
        $('#questionTable').bootstrapTable('refresh');
    }
    //checkbox属性
    $('input[name="qusPusher"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    });

    $('input[name="qusRequester"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    });
</script>
</body>
</html>