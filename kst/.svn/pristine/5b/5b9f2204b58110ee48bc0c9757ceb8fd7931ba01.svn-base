<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>考卷管理</title>
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
    <style>
        .table {table-layout:fixed;word-break:break-all;}
    </style>
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
                    <select name="search_eq_type" id="isms_test_type" class="selectpicker" title="请选择"
                            data-width="150px">
                    </select>
                </div>
                <div class="form-group" style="margin-right:20px;">
                    <label for="s_disableFlag">考试状态</label>
                    <select name="search_eq_status" id="isms_test_status" class="selectpicker" title="请选择"
                            data-width="100px">
                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load()"
                        class="btn btn-primary">查询
                </button>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="addTest()" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>新增测试
        </button>
        <#--<button type="button" id="delBtn" onclick="delSomeTest()" class="btn btn-danger">-->
            <#--<span class="glyphicon glyphicon-remove"></span>批量删除-->
        <#--</button>-->
        <button type="button" onclick="openTest()" class="btn btn-success">
            <span class="glyphicon glyphicon-plus"></span>公开
        </button>
        <button type="button" onclick="closeTest()" class="btn btn-info">
            <span class="glyphicon glyphicon-minus"></span>关闭
        </button>
    </div>
    <table id="testTable"></table>
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
        selectFileType('isms_test_type');
        selectFileType('isms_test_status');
        loadTest();
        re_load();
    });

    function loadTest() {
        $('#testTable').bootstrapTable({
            url: '${base}/isms/test/list',         //请求后台的URL（*）
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
                var select = $("#searchType").val();

                searchParams["search_like_name"] = $("[name='search_like_name']").val();
                searchParams["search_eq_type"] = $("[name='search_eq_type']").val();
                searchParams["search_eq_status"] = $("[name='search_eq_status']").val();
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
                    var pageSize = $('#testTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#testTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'automationFlag',
                title: 'automationFlag',
                visible: false
            }, {
                field: 'name', title: '标题',width:'10%',
            }, {
                field: 'type', title: '考试类型',align: 'center',width:'7%',formatter: function (value, row, index) {
                    var re = "";
                    <#list testParams.testTypeList as types >
                    if ("${types.value}" == value) {
                        re = "${types.label}";
                    }
                    </#list>
                    return re;
                }
            }, {
                field: 'status', title: '考试状态',width:'7%', formatter: function (value, row, index) {
                    var re = "";
                    <#list testParams.statusList as status >
                    if ("${status.value}" == value) {
                        re = "${status.label}";
                    }
                    </#list>
                    return re;
                }
            },{
                title: '选题',
                width:'10%',
                formatter: function (value, row, index) {
                    var re = "";
                    if (row.automationFlag == 0) {
                        var types = row.questionTypes.split(",");
                        var counts = row.questionCounts.split(",");
                        var amounts = row.questionAmounts.split(",")
                        <#list testParams.questionType as questionType >
                        for (var j = 0; j < types.length; j++) {
                            if ("${questionType.value}" == types[j]) {
                                re += "<label>" + "${questionType.label}" + ":";
                                if (counts[j] == amounts[j]) {
                                    re += "<span style='color:#449d44'>" + counts[j] + "/" + amounts[j];
                                } else {
                                    re += "<span style='color:red'>" + counts[j] + "/" + amounts[j];
                                }
                                re += "</span></label><br>"
                            }
                        }
                        </#list>
                    } else {
                        re += "<label style='color:#449d44'>自动生成</label>"
                    }
                    return re;
                }
            },{
                field:'finishDegree',width:'8%',
                title:'完成度',
                align: 'center',
                formatter:function(value, row, index){
                    return row.finishDegree;
                }
            },{
                field: 'operate', title: '操作', align: "center",width:'40%',
                formatter: operateFormatter //自定义方法，添加操作按钮
            }, {
                title: '自动生成考题', align: "center",width:'15%', formatter: function (value, row, index) {
                    var btn = '<input class="switch" type="checkbox" name="automationFlag" id="automationFlag' + row.id + '"';
                    if (row.automationFlag == 1){
                        btn += ' checked';
                    }
                    if(row.status!=1){
                        btn+=' disabled="disabled"';
                    }
                    btn += '/>';
                    return btn;
                }
            }],
            onLoadSuccess: function () {
                initBootstrapSwitch();
            }
        });
    }

    function initBootstrapSwitch() {
        //有则销毁（Destroy）
        $('input[name="automationFlag"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="automationFlag"]').bootstrapSwitch({
            onText: "自动",      // 设置ON文本
            offText: "手动",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35",//设置控件宽度
        });

        $('input[name="automationFlag"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            var id = $(this).attr("id").substring(14);
            var flag = "";
            if (state == true) {
                console.log('自动');
                $(this).val(false);
                flag = true;
            } else {
                console.log('手动');
                $(this).val(true);
                flag = false;
            }
            updateAutomationFlag(id, flag);
        });
    }


    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        var btn4 = '<a href="javascript:void(0)" onclick="setQuestion(\'' + row.id + '\')" class="btn btn-info"><span class="glyphicon glyphicon-cog" ></span> 设置考题</a>'
        if (row.automationFlag == 1) {
            btn4 = '<a href="javascript:void(0)" disabled="disabled" class="btn btn-default"><span class="glyphicon glyphicon-cog" ></span> 设置考题</a>';
        }
        var btn1='<a href="javascript:void(0)" disabled="disabled" class="btn btn-default"><span class="glyphicon glyphicon-pencil" ></span> 编辑</a> ';
        var btn2='<a href="javascript:void(0)" disabled="disabled" class="btn btn-default"><span class="glyphicon glyphicon-remove" ></span> 删除</a>  ';
        if(row.status==1){
            btn1='<a href="javascript:void(0)" onclick="editTest(\'' + row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span> 编辑</a> ';
            btn2='<a href="javascript:void(0)" onclick="delTest(\'' + row.id +'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span> 删除</a>  ';
        }else{
            btn4 = '<a href="javascript:void(0)" disabled="disabled" class="btn btn-default"><span class="glyphicon glyphicon-cog" ></span> 设置考题</a> ';
        }


        return [
            btn1,btn2,
            '<a href="javascript:void(0)" onclick="preview(\'' + row.id + '\')" class="btn btn-primary"><span class="glyphicon glyphicon-search" ></span> 预览</a>  ',
            '<a href="javascript:void(0)" onclick="finishDetail(\'' + row.id + '\')" class="btn btn-success"><span class="glyphicon glyphicon-signal" ></span> 详情</a>  ',
            btn4
        ].join('');
    }

    //刷新
    function re_load() {
        $("#testTable").bootstrapTable('refresh');
    }

    //查询type=isms_Test_type
    function selectFileType(type) {
        $.ajax({
            url: '${base}/isms/test/selectFileType',
            type: 'post',
            data: {'type': type},
            success: function (data) {
                var options = "<option value=''>请选择</option>";
                for (var i = 0; i < data.length; i++) {
                    options += "<option value='" + data[i].value + "'>" + data[i].label + "</option>";

                }
                $("#" + type).append(options);
                $("#" + type).selectpicker('refresh');
                $("#" + type).selectpicker('render');

            }, error: function () {
                alert("error：" + type)
            }
        });
    }

    //删除考卷
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

                }, error: function () {
                    toastr.error("删除失败");
                }
            });
            re_load();
        });

    }

    //批量删除
    function delSomeTest() {
        var rows = $('#testTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据!");
            return;
        }
        layer.confirm("确认要删除选中的考卷吗?", {icon: 3, title: '提示'}, function (index) {
            var list = [];
            for (var i = 0; i < rows.length; i++) {
                list[i] = {'id': rows[i].id, 'delFlag': true}
            }
            $.ajax({
                url: '${base}/isms/test/deleteSome',
                type: 'POST',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(list),
                success: function (result) {
                    toastr.success('删除成功!');
                    layer.close(index);
                    $("#testTable").bootstrapTable('refresh');
                }
            });
            re_load();
        });
    }

    //新增考卷
    function addTest() {
        $("#editType").val(1);
        layer.open({
            type: 2,
            title: '新增考卷',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '80%'],
            content: '${base}/isms/test/add',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            }, end: function () {
            }
        });
    }

    //进入修改页面
    function editTest(id) {
        $("#editType").val(2);
        layer.open({
            type: 2,
            title: '修改考卷',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '80%'],
            content: '${base}/isms/test/edit/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            }, end: function () {
            }
        });
    }

    //进入分配题目页面
    function setQuestion(id) {
        layer.open({
            type: 2,
            title: '选择考题',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/isms/test/setQuestion/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var btn = layer.getChildFrame('#btn', index);
                btn.click();
                re_load();
            }, end: function () {

            }
        });
    }

    //修改自动生成
    function updateAutomationFlag(id, automationFlag) {
        $.ajax({
            url: '${base}/isms/test/updateAutomationFlag',
            type: 'post',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({'id': id, 'automationFlag': automationFlag}),
            success: function (re) {
                re_load();
            }, error: function () {
            }
        })

    }

    //公开 若表格选中多条考试信息，选第一条.
    function openTest() {
        var rows = $("#testTable").bootstrapTable("getSelections");
        if (rows.length == 0) {
            toastr.warning("请选择要公开的考卷!");
            return;
        }

        layer.confirm("确认要公开选中的考卷吗?", {icon: 3, title: '提示'}, function (ind) {
            var re = true;
            var list = {};
            rows.forEach(function (e) {
                e.status = 2;
                e.releaseDate = new Date();
                if (e.automationFlag == 0) {
                    if (e.questionCounts != e.questionAmounts) {
                        re = false;
                    }
                }
            });

            if(re){
                layer.open({
                    type: 2,
                    title: '选择考卷要考核的对象',
                    maxmin: true,
                    shadeClose: false, // 点击遮罩关闭层
                    area: ['80%', '80%'],
                    content: '${base}/isms/test/choiceUser/' + rows[0].id,
                    btn: ['确定', '取消'],
                    yes: function (index, layero) {
                        var child = window[layero.find('iframe')[0]['name']];
                        var redata = child.submit();
                        //将选中的考卷授权用户
                        rows.forEach(function (e,index) {
                            $.ajax({
                                url: '${base}/isms/test/saveAuthority',
                                type: 'post',
                                data: {'users': JSON.stringify(redata), 'topicId': e.id},
                                success: function () {
                                    if(rows.length==index+1){
                                        re_load()
                                    }
                                }, error: function () {
                                    alert("失败")

                                }
                            })

                        });
                        //公开
                        $.ajax({
                            url: '${base}/isms/test/openTest',
                            type: 'POST',
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(rows),
                            success: function (result) {
                                if (result.success) {
                                    toastr.success('公开成功!');
                                }
                            }
                        });
                        layer.close(index);
                    }, end: function () {

                    }
                });
            }else{
                toastr.warning("不可公开未完成的考卷")
            }

            layer.close(ind);
        });
    }

    //关闭
    function closeTest() {
        var rows = $("#testTable").bootstrapTable("getSelections");
        if (rows.length == 0) {
            toastr.warning("请选择要关闭的考卷!");
            return;
        }

        layer.confirm("确认要关闭选中的考卷吗?", {icon: 3, title: '提示'}, function (index) {
            var re = true;
            rows.forEach(function (e) {
                if (e.status == 1) {
                    re = false;
                }
                e.status = 3;
            });

            if (re) {
                $.ajax({
                    url: '${base}/isms/test/deleteSome',
                    type: 'POST',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(rows),
                    success: function (result) {
                        if (result.success) {
                            toastr.success('关闭成功!');
                        }

                        layer.close(index);
                        $("#testTable").bootstrapTable('refresh');
                    }
                });
            } else {
                toastr.warning("只能关闭公开中的考卷")
            }

            layer.close(index);
        });
    }

    //预览
    function preview(id) {
        layer.open({
            type: 2,
            title: '预览',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/isms/test/preview/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                layer.close(index);
            }, end: function () {

            }
        });
    }

    //查看考卷完成详情
    function finishDetail(id){
        layer.open({
            type: 2,
            title: '考卷完成详情',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '80%'],
            content: '${base}/isms/test/finishDetail/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                layer.close(index);
            }, end: function () {

            }
        });
    }

</script>
</body>
</html>