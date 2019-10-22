<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>组织管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">

    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">

    <style>
        #role_edit_table .control-label {
            margin-left: -60px;
        }

        .ztree li span.button.add {
            margin-right: 2px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle
        }

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
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>

<div class="col-sm-3" style="margin-top: 20px;">
    <ul id="groupTree" class="ztree">
    </ul>
</div>
<div class="panel-body col-md-9" style="padding-bottom:0px;">
    <div id="toolbar" class="btn-group" style="padding-bottom:5px;">
        <button type="button" id="addRootBtn" onclick="insertGroup('parent');" class="btn btn-group-sm btn-primary"
                role="dialog">
            <span class="glyphicon glyphicon-plus"></span>新增根节点
        </button>
        <button type="button" id="addChildBtn" onclick="insertGroup('child');" class="btn btn-group-sm btn-primary"
                role="dialog">
            <span class="glyphicon glyphicon-plus"></span>新增子节点
        </button>
        <button type="button" id="updateBtn" onclick="updateGroup();" class="btn btn-group-sm btn-warning"
                role="dialog">
            <span class="glyphicon glyphicon-plus"></span>修改节点
        </button>
        <button type="button" id="deleteBtn" onclick="deleteGroup();" class="btn btn-group-sm btn-danger" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>删除节点
        </button>
    </div>

    <div class="panel panel-default" id="inputPanel">
        <div class="panel-body">
            <form id="form">
                <input type="hidden" id="submitType">
                <input type="hidden" id="parentId">
                <input type="hidden" id="id">
                <div class="form-group">
                    <label class="col-md-2 control-label">所属组织</label>
                    <div class="col-md-9">
                        <input type="text" id="parent" class="form-control" readonly="readonly">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">组织名</label>
                    <div class="col-md-9">
                        <input type="text" id="name" name="name" class="form-control" readonly="readonly">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">排序</label>
                    <div class="col-md-3">
                        <div class="input-icon right">
                            <input type="text" id="sort" name="sort" class="form-control" readonly="readonly">
                        </div>
                    </div>
                    <div class="col-md-7" style="display: none;height: 40px;"></div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">备注</label>
                    <div class="col-md-9">
                        <textarea id="remarks" name="remarks" class="form-control" rows="2" readonly="readonly"></textarea>
                    </div>
                </div>
                <div class="col-md-6 col-md-offset-6">
                    <button class="btn btn-sm btn-info" disabled="disabled" id="submit">保存</button>
                    <button class="btn btn-sm btn-default" disabled="disabled" id="cancel" onclick="fresh()">取消</button>
                </div>
            </form>
        </div>
    </div>


</div>


<script type="text/javascript">
    $(function () {
        formValidator();
        ztree();
    });

    /*
    表单验证
    */
    function formValidator() {
        if ($("#form").data('bootstrapValidator') != null) {
            $("#form").data('bootstrapValidator').destroy();
            $('#form').data('bootstrapValidator', null);
        }
        $("#form").bootstrapValidator({
            message: "输入不合法",
            fields: {
                sort: {
                    validators: {
                        notEmpty: {
                            message: '排序不能为空'
                        },
                        digits: {
                            message: '请输入数字'
                        },
                        stringLength: {
                            min: 1,
                            max: 3,
                            message: '长度不能超过3位'
                        }
                    }
                },
                name: {
                    validators: {
                        notEmpty: {
                            message: '组织不能为空'
                        },
                        stringLength:{
                            max:40,
                            message:'长度不能超过40位'
                        },
                        threshold :  3 ,//有2字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/sys/group/checkGroupName',//验证地址
                            message: '该组织已存在',//提示消息
                            delay :  500,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {name: $('#name').val(),
                                parentId: $('#parentId').val(),
                                sub:$('#submitType').val(),
                                id:$('#id').val()
                            }
                        }
                    }
                },
                remarks:{
                    validators: {
                        stringLength:{
                            max:255,
                            message:'长度不能超过255位'
                        }
                    }
                }
            }
        });
    }

    /*
    设定输入框，按钮为可用
     */
    function canUse() {
        $("#name").attr("readOnly", false);
        $("#sort").attr("readOnly", false);
        $("#remarks").attr("readOnly", false);
        $("#submit").attr("disabled",false);
        $("#cancel").attr("disabled",false);
    }

    /*
    设定输入框为只读，按钮不可用
    */
    function readOnly() {
        $("#name").attr("readOnly", true);
        $("#sort").attr("readOnly", true);
        $("#remarks").attr("readOnly", true);
        $("#submit").attr("disabled",true);
        $("#cancel").attr("disabled",true);
    }

    /*
    刷新树形菜单
    */
    function fresh() {
        $("#form").data('bootstrapValidator').destroy();
        $('#form').data('bootstrapValidator', null);
        selectNode = null;
        ztree();
    }
    /*
    清除输入框和隐藏域的值
     */
    function clearInput() {
        $("#name").val("");
        $("#sort").val("");
        $("#remarks").val("");
        $("#parent").val("");
    }
    /*
    加载树形菜单
     */
    function ztree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false
            },
            callback: {
                onClick: onZtreeClick,
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
            url: '${base}/sys/group/list',
            type: 'post',
            success: function (data) {
                readOnly();
                clearInput();
                $.fn.zTree.init($("#groupTree"), setting, data);
            }
        });
    }

    var selectNode;

    /*
    树形菜单的点击事件
     */
    function onZtreeClick(event, treeId, treeNode) {
        $.ajax({
            url: '${base}/sys/group/selectById',
            type: 'post',
            data: {'id': treeNode.id},
            success: function (data) {
                clearInput();
                readOnly()
                formValidator();
                console.log(data)
                selectNode = data;
                $("#name").val(data.name);
                $("#remarks").val(data.remarks);
                $("#sort").val(data.sort);
                $("#parent").val(data.parentName);
                $("#parentId").val(data.parentId);
                $("#id").val(data.id);
            }
        });
    }

    /**
     * 删除节点
     */
    function deleteGroup() {
        if (selectNode == null || selectNode == "") {
            layer.alert("请选择要删除的节点", {icon: 7, title: '警告'})
        } else {
            layer.confirm('确定要删除选中的节点？这将会使得其下的所有子节点都删除？', {icon: 3, title: '提示'}, function (index) {
                var data = {
                    'id': $("#id").val(),
                    'level':selectNode.level
                }
                $.ajax({
                    url: '${base}/sys/group/delete',
                    type: 'post',
                    data: {'group': JSON.stringify(data)},
                    success: function (data) {
                        fresh();
                        layer.closeAll('dialog');
                    }
                })
            });
        }
    }

    /*
        添加节点
    */
    function insertGroup(type) {
        if (type == 'parent') {
            $("#submitType").val(1);
            canUse();
            clearInput();
            $("#parentId").val(null);
            $("#id").val(null);
            formValidator();
        } else {
            if (selectNode == null || selectNode == "") {
                layer.alert("请选择要添加的父节点", {icon: 7, title: '警告'})
            } else {
                $("#submitType").val(2);
                canUse();
                clearInput();
                $("#parentId").val(selectNode.id);
                $("#id").val("");
                $("#parent").val(selectNode.name);
                formValidator();
            }
        }
    }

    /*
        进入修改
    */
    function updateGroup() {
        if (selectNode == null || selectNode == "") {
            layer.alert("请选择要修改的节点", {icon: 7, title: '警告'})
        } else {
            $("#submitType").val(3);
            canUse();
            clearInput();
            $("#parent").val(selectNode.parentName);
            $("#name").val(selectNode.name);
            $("#sort").val(selectNode.sort);
            $("#remarks").val(selectNode.remarks);
            $("#parentId").val(selectNode.parentId);
            $("#id").val(selectNode.id);
            formValidator();
        }
    }

    /*
    提交修改/添加
     */
    $("#submit").click(function () {
        var volidator = $("#form").bootstrapValidator('validate');
        var flag = $("#form").data('bootstrapValidator').isValid();
        if (flag) {
            var that = $(this);

            var title = $("#submitType").val();
            if (title == 3) {
                var data = {
                    'id': selectNode.id,
                    'name': $("#name").val(),
                    'sort': $("#sort").val(),
                    'remarks': $("#remarks").val()
                };
                $.ajax({
                    url: '${base}/sys/group/update',
                    type: 'post',
                    data: {'group': JSON.stringify(data)},
                    success: function () {
                        fresh();
                    }
                });
            } else {
                var data = {
                    'name': $("#name").val(),
                    'sort': $("#sort").val(),
                    'remarks': $("#remarks").val()
                };
                if (title == 2) {
                    data.parentId = selectNode.id;
                    data.level = selectNode.level + 1;
                    data.parentIds = selectNode.parentIds;
                } else if(title==1){
                    data.level = 1;
                }
                $.ajax({
                    url: '${base}/sys/group/insert',
                    type: 'post',
                    data: {'group': JSON.stringify(data)},
                    success: function (data) {
                        fresh();
                    },
                    error: function () {
                        alert("失败")
                    }
                });
            }
        }
    });
</script>
</body>
</html>