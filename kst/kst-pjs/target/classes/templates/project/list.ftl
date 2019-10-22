<!DOCTYPE html>
<html>
<head>
    <title>项目信息管理</title>
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
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <input type="hidden" id="qrcodeList">
    <input type="hidden" id="showTextList">
    <div class="panel panel-default">
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                    <div class="form-group" style="margin-right:20px">
                        <label for="pjName">项目名称</label>
                        <input type="text" class="form-control _search" name="pjName">
                    </div>
                    <div class="form-group" style="margin-right:20px">
                        <label for="organizationId">所属部门</label>
                        <input type="text" id="organizationName" name="organizationName" class="form-control" readonly>
                        <input type="hidden" class="_search" id="organizationId" name="organizationId" >
                    </div>
                    <input type="button" onclick="openOrganizationChoiceDig()" class="btn btn-primary" value="选择">
                    <button type="button" style="margin-left:100px" onclick="re_load();" class="btn btn-primary"><span class="glyphicon glyphicon-search">查询</button>
                    <br><br>
                    <div class="form-group" style="margin-right:20px">
                        <label>项目状态</label>
                        <#list status as type>
                            <label for="status${type_index}" style="width: 100px;"><input type="checkbox" name="status" id="status${type_index}" value="${type.value}" <#if type.value!=3 >checked</#if> >${type.label}</label>
                        </#list>
                        &nbsp;
                        <input type="checkbox" name="checkAll" id="checkAll" ><label for="checkAll">全选</label>
                    </div>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="addProject();" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>新增项目
        </button>
        <button type="button" id="detailBtn" onclick="projectSchDetail();" class="btn btn-info" role="dialog">
            <span class="glyphicon glyphicon-list"></span>项目作业内容
        </button>
        <button type="button" id="detailBtn" onclick="projectChart();" class="btn btn-success" role="dialog">
            <span class="glyphicon glyphicon-tasks"></span>信息统计
        </button>
        <button type="button" id="addBtn" onclick="daily();" class="btn btn-success" role="dialog">
            <span class="glyphicon glyphicon-download"></span>日报输出
        </button>
        <button type="button" id="addBtn" onclick="msg();" class="btn btn-info" role="dialog">
            <span class="glyphicon glyphicon-download"></span>日志消息输出
        </button>
    </div>
    <table id="projectTable" style="width: 100%;"></table>
    <input id="handle" name="handle" value="" hidden="hidden">
    <div class="modal inmodal fade" id="organizationModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="organizationModal">选择部门</h4>
                </div>
                <div class="modal-body">
                    <ul id="organizationTree" class="ztree">
                    </ul>
                </div>
                <div class="modal-footer">
                    <button id="closeBtn1" type="button" class="btn btn-primary">确认</button>
                    <button id="resetBtn1" type="button" class="btn btn-default">清除</button>
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
        var supplierList = [];
        $.ajax({
            url: '${base}/ams/supplier/selectSupplierList',
            type: 'post',
            success: function (ret) {
                supplierList = ret;
            }
        })


        $('#projectTable').bootstrapTable({
                url: '${base}/pjs/project/list',         //请求后台的URL（*）
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
                    $("#searchForm ._search").each(function () {
                        if ("" != $(this).val()) {
                            searchParams[$(this).attr('name')] = $(this).val();
                        }
                    });
                    searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                    var status =[];
                    $('input[name="status"]:checked').each(function () {
                        status.push($(this).val());
                    });
                    searchParams['pjStatus']=status;

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
                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                cardView: false,                    //是否显示详细视图
                detailView: false,                   //是否显示父子表
                singleSelect:true,
                columns: [{
                    checkbox: true
                },{
                    title: '序号',
                    align: 'center',
                    formatter: function (value, row, index) {
                        var pageSize = $('#projectTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                        var pageNumber = $('#projectTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                        return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                    }
                },{
                    field: 'id',
                    title: 'id',
                    visible: false
                },{
                    field: 'name',
                    title: '项目名称'
                },{
                    field: 'nameS',
                    title: '项目略称'
                },{
                    field: 'planFrom',
                    title: '预定开始日'
                },{
                    field: 'planTo',
                    title: '预定结束日'
                },{
                    field: 'planTimeAll',
                    title: '预定工时总数'
                },{
                    field: 'factFrom',
                    title: '实际结束日'
                },{
                    field: 'factTo',
                    title: '实际结束日'
                },{
                    field: 'factTimeAll',
                    title: '实际工时总数'
                },{
                    field: 'organizationName',
                    title: '所属部门'
                },{
                    field: 'status',
                    title: '状态',
                    formatter:function (value, row, index) {
                        var ret="";
                        <#list status as type>
                            if(value=="${type.value}")
                                ret="${type.label}";
                        </#list>
                        return ret;
                    }
                },{
                    field: 'operate',
                    title: '操作',
                    align: "center",
                    formatter: operateFormatter //自定义方法，添加操作按钮
                }]
            }
        );
    };

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="dt_update(\'' + row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span>编辑</a>  ',
            '<a href="javascript:void(0)" onclick="dt_remove(\'' + row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  '
        ].join('');
    }

    /**
     * 打开新增框
     */
    function addProject() {
        $("#handle").attr("value", 0);
        // iframe层
        layer.open({
            type: 2,
            title: '新增项目',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/pjs/project/add',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
                //layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 1) {
                    toastr.success('项目添加成功!');
                }
            }
        });
    }

    /**
     * 打开编辑框
     * @param id
     */
    function dt_update(id) {
        $("#handle").attr("value", 0);
        // iframe层
        layer.open({
            type: 2,
            title: '编辑项目',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            //area: '80%',
            content: '${base}/pjs/project/edit/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 2) {
                    toastr.success('项目编辑成功!');
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
                url: '${base}/pjs/project/delete',
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

    //项目进度详细
    function projectSchDetail() {
        var rows=$("#projectTable").bootstrapTable("getSelections");

        if(rows.length==0){
            toastr.warning("请选择一条项目信息!");
            return;
        }

        if(rows.length>1){
            toastr.warning("只能选择一条项目信息!");
            return;
        }


        var project=rows[0];

        parent.addTabs({
            id: project.id,
            title: project.name,
            close: true,
            height:800,
            href: '${base}/pjs/schDetail/list/'+project.id,
            urlType: "relative"
        });
    }

    function re_load() {
        $("#projectTable").bootstrapTable("refresh");
    }

    function daily() {
        $.ajax({
            url:'${base}/pjs/scheduleRegister/register',
            type:'post',
            success:function () {
                alert("成功")
            },error:function () {
                alert("失败")
            }
        })
    }

    function msg() {
        $.ajax({
            url:'${base}/sys/msg/dailyMessage',
            type:'post',
            success:function () {
                alert("成功")
            },error:function () {
                alert("失败")
            }
        })
    }

    //图表统计
    function projectChart(){
        var rows=$("#projectTable").bootstrapTable("getSelections");
        if(rows.length==0){
            toastr.warning("请选择一条项目信息！");
            return;
        }
        var project=rows[0];

        parent.addTabs({
            id: "1026",
            title: "项目图表统计",
            close: true,
            height:800,
            href: '${base}/pjs/project/projectChart/'+project.id,
            urlType: "relative"
        });
    }

    $('input[name="checkAll"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    }).on('ifClicked', function (event) {
        if(!$('input[name="checkAll"]')[0].checked){
            $('input[name="status"]').each(function () {
                $(this).iCheck('check');
            });
        }else{
            $('input[name="status"]').each(function () {
                $(this).iCheck('uncheck');
            });
        }
    });

    $('[name="status"]').iCheck({
        checkboxClass: 'icheckbox_flat-green'
    }).on('ifChanged', function (event) {
        if($("[name='status']:checked").length==$("[name='status']").length){
            $('input[name="checkAll"]').iCheck('check');
        }else{
            $('input[name="checkAll"]').iCheck('uncheck');
        }
    });

    //打开选择部门框
    function openOrganizationChoiceDig() {
        organizationZtree();
        $("#organizationModal").modal('show');
    }

    //organization按钮点击
    $("#closeBtn1").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("organizationTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#organizationId").val(nodes[0].id);
            $("#organizationName").val(nodes[0].name).change();
        } else {
            $("#organizationId").val(null);
            $("#organizationName").val(null).change();
        }
        $('#organizationModal').modal('hide');
    });

    $("#resetBtn1").click(function () {
        $("#organizationId").val(null);
        $("#organizationName").val(null).change();
        $('#organizationModal').modal('hide');
    })

    function organizationZtree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            edit: {
                enable: false,
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
            url: '${base}/sys/organization/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#organizationTree"), setting, data);
            }
        });
    }

</script>
</body>
</html>