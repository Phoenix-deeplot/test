<!DOCTYPE html>
<html>
<head>
    <title>资产信息管理</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <input type="hidden" id="qrcodeList">
    <input type="hidden" id="showTextList">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">资产编号</label>
                    <input type="text" class="form-control _search" name="search_like_asset_input_no">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">资产名称</label>
                    <input type="text" class="form-control _search" name="search_like_NAME">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">资产分类</label>
                    <select name="search_eq_classify_id" class="selectpicker _search" title="请选择"
                            data-width="150px">
                        <option value="">请选择</option>
                        <#list testType as test>
                            <option value="${test.value}">${test.label}</option>
                        </#list>
                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">查询</button>
                <div class="form-group" style="margin-right:20px">
                    <label for="search_eq_classify_id">资产分类</label>
                    <#list statusType as test>
                        <label for="classifyId${test_index}" style="width: 100px;"><input type="checkbox" name="classifyId" id="classifyId${test_index}" value="${test.value}" <#if test.value!=3 >checked</#if> >${test.label}</label>
                    </#list>
                    &nbsp;
                    <input type="checkbox" name="checkAll" id="checkAll"><label for="checkAll">全选</label>
                </div>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="addAsset();" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>新增资产
        </button>
        <#--<button type="button" id="delBtn" onclick="batchRemove();" class="btn btn-danger">-->
            <#--<span class="glyphicon glyphicon-remove"></span>资产批量删除-->
        <#--</button>-->
        <button type="button" id="delBtn" onclick="copyAsset();" class="btn btn-success">
            <span class="glyphicon glyphicon-copy"></span>复制资产
        </button>
        <button type="button" id="printBtn" onclick="doPrintPreview();" class="btn btn-info">
            <span class="glyphicon glyphicon-print"></span>打印二维码
        </button>
        <button type="button" onclick="downloadCSVFile();" class="btn btn-default">
            <span class="glyphicon glyphicon-download"></span>导出数据(Excel)
        </button>
        <button type="button" id="printBtn" onclick="divideDetail();" class="btn btn-inverse">
            <span class="glyphicon glyphicon-search"></span>查看折旧详情
        </button>
        <button type="button" id="printBtn" onclick="exportExcelModel()" class="btn btn-primary">
            <span class="glyphicon glyphicon-download"></span>导出Excel模板
        </button>
        <input type="file" id="file" name="file" onchange="uploadFile()" style="display: none;">
        <button type="button" id="printBtn" onclick="$('#file').click()" class="btn btn-success">
            <span class="glyphicon glyphicon-upload"></span>上传资产数据
        </button>
    </div>

    <table id="assetTable" style="width: 100%;"></table>
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
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {
        var supplierList = [];
        $.ajax({
            url: '${base}/ams/supplier/selectSupplierList',
            type: 'post',
            success: function (ret) {
                supplierList = ret;
            }
        })


        $('#assetTable').bootstrapTable({
                url: '${base}/ams/asset/list',         //请求后台的URL（*）
                method: 'post',                      //请求方式（*）
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                dataType: "json",                   // 服务器返回的数据类型
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: true,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
                queryParams: function (params) {
                    var searchParams = {};
                    var classifyIds =[];
                    $('input[name="classifyId"]:checked').each(function () {
                        classifyIds.push($(this).val());
                    });
                    searchParams['search_in_status_property']=classifyIds;

                    $("#searchForm ._search").each(function () {
                        if ("" != $(this).val()) {
                            if ($(this).attr('name') == 'search_like_asset_input_no') {
                                searchParams[$(this).attr('name')] = $(this).val().toUpperCase();
                            } else {
                                searchParams[$(this).attr('name')] = $(this).val();
                            }
                        }
                    });

                    console.log(searchParams);
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
                        var pageSize = $('#assetTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                        var pageNumber = $('#assetTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                        return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                    }
                }, {
                    field: 'id',
                    title: 'id',
                    visible: false
                }, {
                    field: 'assetInputNo',
                    title: '资产编号',
                    formatter:function (value, row, index) {
                        return '<a href="javascript:void(0)" onclick="dt_update(\'' + row.id + '\','+2+')" >'+value+'</a>';
                    }
                }, {
                    field: 'name',
                    title: '资产名称'
                }, {
                    field: 'classify',
                    title: '资产分类',
                    formatter: function (value, row, index) {
                        var re = "";
                        <#list testType as types>
                        if ("${types.value}" == value) {
                            re = "${types.label}";
                        }
                        </#list>
                        return re;
                    }
                }, {
                    field: 'brand',
                    title: '资产品牌'
                }, {
                    field: 'price',
                    title: '单价',
                    formatter:function (value) {
                        var re;
                        if(value!=null){
                            re=value.toFixed(2);
                        }
                        return re;
                    }
                }, {
                    field: 'supplierId',
                    title: '供应商',
                    formatter: function (value, row, index) {
                        var re = "";
                        supplierList.forEach(function (r) {
                            if (value == r.id) {
                                re = r.name;
                            }
                        })
                        return re;
                    }
                }, {
                    field: 'statusProperty',
                    title: '状态',
                    align: "center",
                    formatter:function (value, row, index) {
                        <#list statusType as status >
                            if(value=="${status.value}"){
                                return "${status.label}";
                            }
                        </#list>
                    }
                },  {
                    field: 'registerDate',
                    title: '登记日'
                }, {
                    field: 'buyDate',
                    title: '购买日'
                }, {
                    field: 'operate',
                    title: '操作',
                    align: "center",
                    formatter: operateFormatter //自定义方法，添加操作按钮
                },
                ]
            }
        );
    };

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        if(row.statusProperty==1){
            return [
                '<a href="javascript:void(0)" onclick="dt_update(\'' + row.id + '\','+row.statusProperty+' )" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span>编辑</a>  ',
                '<a href="javascript:void(0)" onclick="dt_remove(\'' + row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  '
            ].join('');
        }else{
            return [
                '<a href="javascript:void(0)" onclick="dt_update(\'' + row.id + '\','+row.statusProperty+')" class="btn btn-success"><span class="glyphicon glyphicon-search" ></span>查看</a>  ',
                '<a href="javascript:void(0)" disabled="disabled"  class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  '
            ].join('');
        }

    }

    /**
     * 打开新增框
     */
    function addAsset() {
        $("#handle").attr("value", 0);
        // iframe层
        layer.open({
            type: 2,
            title: '新增资产',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/ams/asset/add',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                // 获取弹出层中的form表单元素
                var formSubmit = layer.getChildFrame('form', index);
                // 获取表单中的提交按钮
                var submited = formSubmit.find('#btnConfirm');
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                submited.click();
                //layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 1) {
                    toastr.success('资产添加成功!');
                }
            }
        });
    }

    /**
     * 打开编辑框
     * @param id
     */
    function dt_update(id,statusProperty) {
        $("#handle").attr("value", 0);
        // iframe层
        var b;
        if(statusProperty==1){
            b=['确定', '取消'];
        }else{
            b=['关闭'];
        }
        layer.open({
            type: 2,
            title: '编辑资产',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            //area: '80%',
            content: '${base}/ams/asset/edit/' + id,
            btn: b,
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                if(statusProperty==1){
                    submited.click();
                }else{
                    layer.close(index)
                }
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 2) {
                    toastr.success('资产编辑成功!');
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
        layer.confirm('确定要删除选中的记录？', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url: '${base}/ams/asset/delete',
                type: "POST",
                data: {
                    'id': id
                },
                success: function (result) {
                    if (result.success) {
                        $('button[name="refresh"]').click();
                        toastr.success('删除成功!');
                        layer.close(index);
                    } else {
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
    function batchRemove() {
        var rows = $('#assetTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据!");
            return;
        }

        layer.confirm("确认要删除选中的数据吗?", {icon: 3, title: '提示'}, function (index) {
            var deleteindex = layer.msg('删除中，请稍候...', {icon: 16, time: false, shade: 0.8});
            $.ajax({
                url: '${base}/ams/asset/deleteSome',
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(rows),
                success: function (result) {
                    layer.close(deleteindex);
                    if (result.success) {
                        $('button[name="refresh"]').click();
                        toastr.success('删除成功!');
                        layer.close(index);
                    } else {
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
        $('#assetTable').bootstrapTable('refresh');
    }

    //打印二维码
    function printQRCode() {
        var rows = $('#assetTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("请选择要打印的数据!");
            return;
        }

        layer.confirm("确认要打印选中的数据的二维码吗?", {icon: 3, title: '提示'}, function (index) {

            $.ajax({
                url: '${base}/ams/asset/print',
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(rows),
                success: function (result) {
                    layer.close(index);
                }
            });
        })
    }

    //打印二维码
    function doPrintPreview() {
        var rows = $('#assetTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("请选择要打印的数据!");
            return;
        }
        var data = [];
        rows.forEach(function (r, index) {
            data.push(r.assetInputNo);
        })

        $("#qrcodeList").val(JSON.stringify(data));
        $("#showTextList").val(JSON.stringify(data));

        layer.confirm("确认要打印选中的数据的二维码吗?", {icon: 3, title: '提示'}, function (index) {
            layer.close(index);
            layer.open({
                type: 2,
                title: '打印预览',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['80%', '100%'],
                content: '${base}/qrcode/previewQRcode',
                btn: ['打印', '取消'],
                yes: function (index, layero) {
                    var formSubmit = layer.getChildFrame('form', index);
                    var submited = formSubmit.find('#btnSubmit');
                    submited.click();
                    layer.close(index);//这块是点击确定关闭这个弹出层
                },
                end: function () {

                }
            });
        });
    }

    //复制资产
    function copyAsset() {
        var rows = $('#assetTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("请选择要复制的资产");
            return;
        }
        if (rows.length > 1) {
            toastr.warning("只能选择一条资产进行复制")
            return;
        }
        var id = rows[0].id;
        layer.open({
            type: 2,
            title: '复制资产',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/ams/asset/copyAsset/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 1) {
                    toastr.success('资产复制成功!');
                }
            }
        });
    }

    function downloadCSVFile() {
        var rows = $('#assetTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("请选择要下载的数据");
            return;
        }

        var ids=[];
        rows.forEach(function (r) {
            ids.push(r.id)
        })

        window.location='${base}/ams/asset/downloadCSVFile?ids='+ids;
    }


    //查看分摊信息
    function divideDetail() {
        var rows = $('#assetTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("请选择要查看的资产");
            return;
        }
        if (rows.length > 1) {
            toastr.warning("只能选择一条资产进行查看")
            return;
        }
        if (rows[0].divideFlag) {
            var id = rows[0].id;
            layer.open({
                type: 2,
                title: '查看资产',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['100%', '100%'],
                content: '${base}/ams/asset/divideDetail/' + id,
                btn: ['确定'],
                yes: function (index, layero) {
                    layer.close(index)
                }
            });
        } else {
            toastr.warning("非固定资产没有折旧!")
        }
    }

    $('input[name="classifyId"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    }).on('ifChanged', function (event) {
        if($("[name='classifyId']:checked").length==$("[name='classifyId']").length){
            $('input[name="checkAll"]').iCheck('check');
        }else{
            $('input[name="checkAll"]').iCheck('uncheck');
        }
    });

    $('input[name="checkAll"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    }).on('ifClicked', function (event) {
        if(!$('input[name="checkAll"]')[0].checked){
            $('input[name="classifyId"]').each(function () {
                $(this).iCheck('check');
            });

        }else{
            $('input[name="classifyId"]').each(function () {
                $(this).iCheck('uncheck');
            });
        }
    });

    //导出excel模板（用于上传资产数据）
    function exportExcelModel() {
        window.location = '${base}/ams/asset/exportExcelModel';
    }

    //上传资产数据，添加资产信息
    function uploadFile() {
        var myform = new FormData();
        myform.append('file', $("[name='file']")[0].files[0]);
        $.ajax({
            url:'${base}/ams/asset/uploadExcel',
            type: 'POST',
            data: myform,
            async: false,
            contentType: false,
            processData: false,
            success:function (result) {
                if(result.success){
                    toastr.success("上传成功");
                    re_load();
                }else{
                    var arr=result.message.split(":");
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
        $("[name='file']").val("");
    }

</script>
</body>
</html>