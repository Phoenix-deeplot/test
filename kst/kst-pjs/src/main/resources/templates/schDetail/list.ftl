<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>项目工作</title>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">

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

        <div id="toolbar">
            <input type="button" onclick="addSchDetail()" class="btn btn-info" value="添加"/>
            <input type="button" onclick="deleteSome()" class="btn btn-danger" value="删除"/>
            <input type="button" onclick="exportExcel()" class="btn btn-primary" value="导出Excel模板"/>
            <input type="file" id="file" name="file" onchange="uploadFile()" style="display: none;">
            <input type="button" onclick="$('#file').click()" class="btn btn-success" value="上传"/>
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
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true,
                width: '3%',
            }, {
                title: '序号',
                align: 'center',
                width: '5%',
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
                field: 'workNo',
                title: '作业编号',
                width: '10%',
            }, {
                field: 'workName',
                title: '作业名称',
                width: '15%',
            }, {
                field: 'workBKindName',
                title: '工作分类',
                width: '20%',
                formatter: function (value, row, index) {
                    var kind = "";
                    if (row.workBKindName != null && row.workBKindName != "") {
                        kind += row.workBKindName
                    }
                    if (row.workMKindName != null && row.workMKindName != "") {
                        kind += "/" + row.workMKindName
                    }
                    if (row.workSKindName != null && row.workSKindName != "") {
                        kind += "/" + row.workSKindName;
                    }
                    return kind;
                }
            }, {
                field: 'workPlanUserName',
                title: '预定担当者',
                align: "center",
                width: '5%',
            }, {
                field: 'workPlanTimes',
                title: '预定工时',
                align: "center",
                width: '5%',
            }, {
                field: 'workFactUserName',
                title: '实际担当者',
                align: "center",
                width: '5%',
            }, {
                field: 'workFactTimes',
                title: '实际工时',
                align: "center",
                width: '5%',
            }, {
                field: 'workFinishPer',
                title: '实际完成比例',
                align: "center",
                width: '10%',
            }, {
                title: '操作',
                width: '20%',
                align: "center",
                formatter: operateFormatter
            }
            ]
        });
    }

    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="editSchDetail(\'' + row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span>编辑</a>  ',
            '<a href="javascript:void(0)" onclick="deleteOne(\'' + row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  '
        ].join('');
    }

    //添加
    function addSchDetail() {
        layer.open({
            type: 2,
            title: '添加作业内容',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/pjs/schDetail/add/' + $("#pjId").val(),
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('#form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 1) {
                    toastr.success('添加成功!');
                }
            }
        });
    }

    //编辑
    function editSchDetail(id) {
        layer.open({
            type: 2,
            title: '修改作业内容',
            maxmin: true,
            shadeClose: false,
            area: ['100%', '100%'],
            content: '${base}/pjs/schDetail/edit/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('#form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 1) {
                    toastr.success('添加成功!');
                }
            }
        });
    }

    //刪除一条数据
    function deleteOne(id) {
        layer.confirm('是否要删除该节点', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url: '${base}/pjs/schDetail/delete',
                type: 'post',
                data: {"id": id},
                success: function (ret) {
                    if (ret.success) {
                        toastr.success("删除成功")
                    } else {
                        toastr.error(ret.message)
                    }
                    refresh();
                }
            });
            layer.close(index)
        });
    }

    //删除多条数据
    function deleteSome() {
        var rows = $("#schDetailTable").bootstrapTable("getSelections");

        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据");
            return;
        }

        rows.forEach(function (r) {
            r.pjId = "${pjId}"
        })

        layer.confirm('是否要删除选中的数据？', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url: '${base}/pjs/schDetail/deleteSome',
                type: 'post',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(rows),
                success: function (result) {
                    layer.close(index);
                    if (result.success) {
                        toastr.success('删除成功!');
                    } else {
                        toastr.error(result.message);
                    }
                    refresh();
                }
            })
        });
    }


    //导出数据
    function exportExcel() {
        window.location = '${base}/pjs/schDetail/exportExcel?pjId=' + $("#pjId").val();
    }

    //导入文件
    function uploadFile() {
        var myform = new FormData();
        myform.append('file', $("[name='file']")[0].files[0]);
        $.ajax({
            url: '${base}/pjs/schDetail/uploadExcel/' + $("#pjId").val(),
            type: 'POST',
            data: myform,
            async: false,
            contentType: false,
            processData: false,
            success: function (result) {
                if (result.success) {
                    toastr.success("上传成功");
                    refresh();
                } else {
                    var arr = result.message.split(":");
                    if (arr[0] == "1") {
                        var errType = "数据有误";
                        if (arr[3] == "type") {
                            errType = "数据类型错误";
                        } else if (arr[3] == "null") {
                            errType = "不存在";
                        }
                        toastr.error("EXCEL表的第" + arr[1] + "行第" + arr[2] + "列" + errType+"!")
                    }else{
                        toastr.error("错误的excel文件!")
                    }

                }
            }
        });
        $("[name='file']").val("")
    }

    function refresh() {
        $("#schDetailTable").bootstrapTable("refresh");
    }

</script>
</body>
</html>