<!DOCTYPE html>
<html>
<head>
    <title>资产移动</title>
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
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">资产编号</label>
                    <input type="text" class="form-control _search" id="search_like_no" name="no">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">资产存放类型</label>
                    <select name="location_type" class="selectpicker _search" title="请选择"
                            data-width="150px">
                        <option value="">请选择</option>
                        <option value="1">存放中</option>
                        <option value="2">历史存放</option>
                    </select>
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_name">资产存放地点</label>
                    <input type="text" class="form-control" id="locationName" onchange="locationChange()" readonly>
                    <input type="text" name="location_id" id="locationId" class="_search" hidden>
                </div>
                <button type="button" class="btn btn-small" id="locationChoiceBtn" onclick="openLocationChoiceDig()">
                    地点选择
                </button>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">查询</button>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="addAssetMove();" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>资产移动
        </button>
        <#--<button type="button" id="delBtn" onclick="batchRemove();"class="btn btn-danger">-->
        <#--<span class="glyphicon glyphicon-remove" ></span>资产转移记录删除-->
        <#--</button>-->
    </div>
    <table id="assetLocationTbl"></table>
    <input id="handle" name="handle" value="" hidden="hidden">

    <div class="modal inmodal fade" id="myModal3" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">选择存放地点</h4>
                </div>
                <div class="col-sm-3" style="margin-top: 20px;">
                    <ul id="locationTree" class="ztree">
                    </ul>
                </div>
                <div class="modal-footer">
                    <button id="closeBtn3" type="button" class="btn btn-primary">确认</button>
                    <button id="resetBtn3" type="button" class="btn btn-default">清除</button>
                </div>
            </div>
        </div>
    </div>
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
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>
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
        debugger;
        $('#assetLocationTbl').bootstrapTable({
            url: '${base}/ams/assetLocation/list',         //请求后台的URL（*）ams:apply:list
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
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                $("#searchForm ._search").each(function () {
                    if ("" != $(this).val()) {
                        searchParams[$(this).attr('name')] = $(this).val();
                    }
                });
                debugger;
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
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#assetLocationTbl').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#assetLocationTbl').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'no',
                title: '资产编号'
            }, {
                field: 'name',
                title: '资产名称'
            }, {
                field: 'locationId',
                title: '存放地点',
                formatter: function (value, row, index) {
                    var re = "";
                    <#list testType as types>
                    if ("${types.id}" == value) {
                        re = "${types.name}";
                    }
                    </#list>
                    return re;
                }
            }, {
                field: 'storageDate',
                title: '存放日'
            }, {
                field: 'removeDate',
                title: '移除日'
            }, {
                field: 'moreInfo',
                title: '备注'
            }
                // ,{
                //     field: 'operate',
                //     title: '操作',
                //     align:"center",
                //     formatter: operateFormatter //自定义方法，添加操作按钮
                //     },
            ]
        });
    };

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="dt_update(\'' + row.id + '&' + row.locationId + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span>编辑</a>  '
            // '<a href="javascript:void(0)" onclick="dt_remove(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  '
        ].join('');
    }

    function changeDateFormat(cellval) {
        if (cellval != null) {
            var date = new Date(parseInt(cellval.replace("/Date(", "").replace(")/", ""), 10));
            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
            var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
            return date.getFullYear() + "-" + month + "-" + currentDate;
        }
    }

    /**
     * 打开新增框
     */
    function addAssetMove() {
        $("#handle").attr("value", 0);
        // iframe层
        layer.open({
            type: 2,
            title: '资产转移',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/ams/assetLocation/add',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                debugger;
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
                    toastr.success('资产移动成功!');
                }
            }
        });
    }

    /**
     * 打开编辑框
     * @param id
     */
    function dt_update(id) {
        debugger;
        $("#handle").attr("value", 0);
        // iframe层
        layer.open({
            type: 2,
            title: '资产转移编辑',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            //area: '80%',
            content: '${base}/ams/assetLocation/edit/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                debugger;
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
                if (handle == 2) {
                    toastr.success('移动信息编辑成功!');
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
                url: '${base}/ams/assetLocation/delete',
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
        var rows = $('#assetLocationTbl').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据!");
            return;
        }
        //var ids = '';
        //遍历所有选择的行数据，取每条数据对应的ID
        /*$.each(rows, function (i, row) {
            if(row['id'] === 1){
                layer.msg("不能删除超级管理员");
                return false;
            }
        });*/

        layer.confirm("确认要删除选中的数据吗?", {icon: 3, title: '提示'}, function (index) {
            var deleteindex = layer.msg('删除中，请稍候...', {icon: 16, time: false, shade: 0.8});
            $.ajax({
                url: '${base}/ams/assetLocation/deleteSome',
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

    function openLocationChoiceDig() {
        $('#myModal3').modal('show');
        initLocationBootstrapTable();
    }

    function initLocationBootstrapTable() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            callback: {
                beforeDrag: function () {
                    return false;
                }
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'pId',
                    rootPid: null
                }
            }
        };
        $.ajax({
            url: '${base}/ams/location/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#locationTree"), setting, data);
            }
        });
    }

    function onZtreeClick(event, treeId, treeNode) {
        selectedLocation = treeNode.id;
    }

    $("#closeBtn3").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("locationTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#locationId").val(nodes[0].id);
            $("#locationName").val(nodes[0].name).change();
        } else {
            $("#locationId").val(null);
            $("#locationName").val(null);
        }
        $('#myModal3').modal('hide');
    });

    $("#resetBtn3").click(function () {
        $("#locationId").val(null);
        $("#locationName").val(null);
        $('#myModal3').modal('hide');
    });


    function locationChange() {
        if ($("#locationName").val() == "" || $("#locationName").val() == null) {
            $("#locationId").val(null);
        }
    }


    /**
     * 重新加载表
     */
    function re_load() {
        $('#assetLocationTbl').bootstrapTable('refresh');
    }
</script>
</body>
</html>