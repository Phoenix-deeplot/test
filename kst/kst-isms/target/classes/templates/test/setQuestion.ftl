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
                <div class="form-group" style="margin-right:20px;">

                </div>
            </form>

        </div>
    </div>
    <table id="testTable"></table>
</div>
<div id="toolbar" class="btn-group">
    <div class="col-sm-offset-1" style="width: 100%;" id="degree">

    </div>
</div>
<table id="questionTable"></table>
<input type="button" id="btn" onclick="submit()" style="display: none;">
</div>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table-treegrid.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>

<script>
    $(function () {
        selectFileType('isms_question_type');
        selectFileType('isms_question_category');
        loadQuestion();
        toastr.options.positionClass = 'toast-center-center';
        degree();
    })

    //加载完成度
    function degree() {
        var types = "${testParams.topic.questionTypes}".split(",");
        var counts = "${testParams.topic.questionCounts}".split(",");
        var amounts = "${testParams.topic.questionAmounts}".split(",")
        var re = "";
        <#list testParams.types as type>
        for (var j = 0; j < types.length; j++) {
            if ("${type.value}" == types[j]) {
                re += "          <label>" + "${type.label}" + ":";
                if (counts[j] == amounts[j]) {
                    re += "<span style='color:#449d44'>" + counts[j] + "/" + amounts[j];
                } else {
                    re += "<span style='color:red'>" + counts[j] + "/" + amounts[j];
                }
                re += "</span></label>&nbsp;&nbsp;"
            }
        }
        </#list>
        $("#degree").html(re);
    }


    function loadQuestion() {
        $('#questionTable').bootstrapTable({
            url: '${base}/isms/test/questionList',         //请求后台的URL（*）
            method: 'post',
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var types = "${testParams.topic.questionTypes}".split(",");

                var searchParams = {};
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                var select = $("#searchType").val();
                if (select != null && select != "") {
                    searchParams["type"] = select;
                }
                searchParams["topicId"] = "${testParams.topic.id}";
                searchParams["ids"] = "${testParams.topic.questionTypes}";
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
            pageSize: 15,                       //每页的记录行数（*）
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
            onClickRow: function (row, $element) {

            },
            columns: [{
                checkbox: true
            }, {
                title: '序号',
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
            }, {
                field: 'name', title: '考题名称'
            }, {
                field: 'categoryLabel', title: '考题分类',
            }, {
                field: 'typeLabel', title: '类型', align: "center",
            }, {
                field: 'answer', title: '答案'
            }]
        });
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

    //提交设置考题
    function submit() {
        var rows = $("#questionTable").bootstrapTable("getSelections");

        var counts = "${testParams.topic.questionCounts}".split(",").map(Number);//原已选题目数量
        var amounts = "${testParams.topic.questionAmounts}".split(",").map(Number);//总数
        <#list testParams.topic.questionTypes?split(",") as type>
        rows.forEach(function (o) {
            if (${type}==o.type){
                var num = counts[${type_index}] + 1;
                counts[${type_index}] = num;
            }
        });
        </#list>
        var re = true;
        for (var i = 0; i < amounts.length; i++) {
            if (amounts[i] < counts[i]) {
                re = false;
            }
        }

        var topic={
            'id':"${testParams.topic.id}",
            'questionCounts':counts.join(",")
        }

        if(re){
            $.ajax({
                url:'${base}/isms/test/setQuestion',
                type:'post',
                data: {'rows': JSON.stringify(rows),'topic':JSON.stringify(topic)},
                success: function (data) {
                    toastr.error("添加成功");
                    parent.toastr.success("添加试题成功");
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                    parent.$("#testTable").bootstrapTable("refresh");
                },
                error:function () {
                    parent.toastr.error("添加试题失败");
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }
            })
        }else{
            toastr.error("选中的题目超过上限");
        }
    }


</script>
</body>
</html>