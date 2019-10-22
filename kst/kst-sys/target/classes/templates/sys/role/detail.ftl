<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>角色修改--layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
    <#--<style>-->
        <#--#role_edit_table .control-label {-->
            <#--margin-left: -60px;-->
        <#--}-->

    <#--</style>-->
</head>
<body>
<div class="box box-info" style="margin-bottom:0px;" id="role_edit_table">
    <form id="roleForm" class="form-horizontal" >
        <input type="hidden" name="id" value="${role.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">角色名称</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" name="name" id="name" value="${role.name}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">描述</label>
                <div class="col-md-7">
                    <textarea name="remarks" id="remarks" type="text" class="form-control" rows="4"
                              placeholder="请输入角色描述">${role.remarks}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">权限树</label>
                <div class="col-md-7">
                    <ul id="menuTree" class="ztree" ></ul>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none" >保存</button>
    </form>
</div>

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


<script>
    $(function(){
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化表单
        formValidator();

        ztree();
    });


    //初始化表单
    function formValidator(){
        var id = $('[name="id"]').val();
        var mode = 1;
        if(undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $('#roleForm').bootstrapValidator({
            message: '输入值不合法',
            /*feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },*/
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: '角色名称不能为空'
                        },
                        threshold :  3 ,//有2字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '/sys/role/checkRoleNameExist/'+ mode,//验证地址
                            message: '角色名称已存在',//提示消息
                            delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {name: $('#name').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            debugger;
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {

                var treeObj=$.fn.zTree.getZTreeObj("menuTree");
                var nodes=treeObj.getCheckedNodes(true);
                var menuSet=[];//存放json数组
                for(var i=0;i<nodes.length;i++){
                    var menu={};
                    menu.id = nodes[i].id;
                    menuSet.push(menu);
                }

                var formdata={
                    "id": '${role.id}',
                    "name": $("#name").val(),
                    "remarks": $("#remarks").val(),
                    "menuSet": menuSet
                };

                console.log(formdata);

                var url = "";
                if(1 == mode){  //新增
                    url = "/sys/role/add";
                }else if(2 == mode){    //编辑
                    url = "/sys/role/edit";
                }

                //发送ajax请求
                $.ajax({
                    url: url,
                    type: 'POST',
                    dataType:"json",
                    contentType:"application/json",
                    data: JSON.stringify(formdata),
                    complete: function (msg) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        if(result.success){
                            //刷新父页面
                            $('button[name="refresh"]', window.parent.document).click();
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.$("#handle").attr("value",mode);
                            parent.layer.close(index);
                        }else{
                            toastr.error(result.message);
                        }
                    }
                });

            }

        });
    }

    function ztree(){
        var setting = {
            view: {
                dblClickExpand: false,//双击节点时，是否自动展开父节点的标识
                showLine: true,//是否显示节点之间的连线
                selectedMulti: true //设置是否允许同时选中多个节点
            },
            check: {
                enable: true,   //true / false 分别表示 显示 / 不显示 复选框或单选框
                //autoCheckTrigger: true,   //true / false 分别表示 触发 / 不触发 事件回调函数
                chkStyle: "checkbox",   //勾选框类型(checkbox 或 radio）
                chkboxType: {"Y" : "p", "N" : "ps"}   //勾选 checkbox 对于父子节点的关联关系
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pid",
                    rootPId: null
                }
            }
        };

        $.fn.zTree.init($("#menuTree"), setting, ${menuList});

        // 获取树对象
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        /** 获取所有树节点 */
        var nodes = treeObj.transformToArray(treeObj.getNodes());
        var menuIds = ${menuIds};
        // 遍历树节点设置树节点为选中
        for (var i = 0; i < menuIds.length; i++) {
            for (var j = 0; j < nodes.length; j++) {
                if (menuIds[i] == nodes[j].id) {
                    nodes[j].checked = true;
                    treeObj.updateNode(nodes[j],true);
                    break;
                }
            }
        }
    }

</script>
</body>
</html>