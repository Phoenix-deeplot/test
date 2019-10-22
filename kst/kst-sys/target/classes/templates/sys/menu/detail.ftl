<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改</title>
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
    <!-- Ionicons -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/ionicons.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/font-awesome.css">
    <style>
        #menu_edit_table input, #menu_edit_table select {
            /*margin-left: -45px;*/
        }

       /* #menu_edit_table .row {
            margin-top: 30px !important;
        }*/
        .form-group {
            height: 55px;
        }

    </style>
</head>
<body>
<div class="box box-info" style="margin-bottom:0px;" id="menu_edit_table">
    <form id="menuForm" class="form-horizontal" >
        <input type="hidden" name="id" value="${menu.id}"/>
        <input type="hidden" name="parentId" value="${parentMenu.id}"/>
        <input type="hidden" name="path"/>
        <div class="box-body">
            <div class="form-group" >
                <label class="col-md-2 control-label">权限名称</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" name="name" id="name" value="${menu.name}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">权限标识</label>
                <div class="col-md-4">
                    <input type="text" class="form-control" name="permission" id="permission" value="${menu.permission}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">菜单图标</label>
                <div class="col-md-4">
                    <input type="hidden" name="icon" id="iconValue" value="${menu.icon}" >
                    <i class="<#if (menu.icon)??>${menu.icon}</#if>" id="realIcon" style="<#if (menu.icon == null || menu.icon == '')>display: none;</#if>font-size: 28px"></i>
                    <button id="icon_add" class="btn btn-info" onclick="showIconModul()" type="button"><i class="fa fa-file-picture-o"></i> 请选择一个图标</button>
                </div>

            </div>
            <div class="form-group" >
                <label class="col-md-2 control-label">类型</label>
                <div class="col-md-2">
                    <select id="type" name="type" class="form-control selectpicker" title="请选择" data-width="100px" >
                        <option value="">请选择</option>
                        <#list menuTypes as rt>
                            <option value="${rt}" <#if (menu.type=='${rt}')>selected</#if>>${rt}</option>
                        </#list>
                    </select>
                </div>
            </div>
            <div class="form-group" >
                <label class="col-md-2 control-label">菜单链接</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" name="href" id="href" value="${menu.href}" placeholder="如果是菜单，请输入链接地址"/>
                </div>
            </div>
            <div class="form-group" >
                <label class="col-md-2 control-label">排序</label>
                <div class="col-md-2">
                    <div class="input-icon right">
                        <input type="number" class="form-control" name="sort" id="sort" value="${menu.sort}"/>
                    </div>
                </div>
            </div>
            <div class="form-group" >
                <label class="col-md-2 control-label">是否启用</label>
                <div class="col-md-2">
                    <div class="switch">
                        <input type="checkbox" name="showFlag" id="showFlag"  <#if (menu.showFlag == true)>checked</#if> />
                    </div>
                </div>
            </div>

        </div>
        <!-- /.box-body -->
        <#--<div class="box-footer pull-right">-->
            <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none" >保存</button>
            <button type="button" class="btn btn-default" style="margin-right: 20px;display: none">取消</button>
        <#--</div>-->
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
<script>
    $(function () {
        debugger;
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化表单
        formValidator();

        //启用/停用开关初始化
        initBootstrapSwitch();
    });

    //初始化表单
    function formValidator(){
        var id = $('[name="id"]').val();
        var mode = 1;
        if(undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $('#menuForm').bootstrapValidator({
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
                            message: '权限名称不能为空'
                        },
                        threshold :  2 ,//有2字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/sys/menu/checkPermissionNameExist/'+ mode,//验证地址
                            message: '权限名称已存在',//提示消息
                            delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {name: $('#name').val(),
                                     id: $('[name="id"]').val()
                            }
                        }
                    }
                },
                permission: {
                    validators: {
                        threshold :  3 ,//有2字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/sys/menu/checkPermissionExist/'+ mode,//验证地址
                            message: '权限标识已存在',//提示消息
                            delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {permission: $('#permission').val(),
                                           id: $('[name="id"]').val()
                            }
                        }
                    }
                },
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
                inputName:{
                    validators:{
                        notEmpty: {
                            message: '组织名不能为空'
                        },
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

                var showFlg=$("#showFlag")[0].checked;
                //判断是否启用
                if(undefined == showFlg || null == showFlg || true == showFlg){
                    showFlg = true;
                }else{
                    showFlg = false;
                }

                var formdata={
                    "name": $("#name").val(),
                    "permission": $("#permission").val(),
                    "icon": $("#iconValue").val(),
                    "href": $("#href").val(),
                    "sort": $("#sort").val(),
                    "type": $("#type").val(),
                    "showFlag": showFlg
                };
                console.log(formdata);

                var url = "";
                if(1 == mode){  //子权限新增
                    url = "/sys/menu/add";
                    formdata['parentId'] = '${parentMenu.id}';
                }else if(2 == mode){    //子权限编辑
                    url = "/sys/menu/edit";
                    formdata['id'] = '${menu.id}';
                }else if(3 == mode){    //根权限新增
                    url = "/sys/menu/add";
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

    //启用/停用开关初始化
    function initBootstrapSwitch() {
        //有则销毁（Destroy）
        $('input[name="showFlag"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="showFlag"]').bootstrapSwitch({
            onText : "是",      // 设置ON文本
            offText : "否",    // 设置OFF文本
            onColor : "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor : "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size : "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth:"25"//设置控件宽度
        });

        $('input[name="showFlag"]').bootstrapSwitch("onSwitchChange",function(event,state){
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                console.log('是');
                $(this).val(true);
            } else {
                console.log('否');
                $(this).val(false);
            }
        });
    }

    function showIconModul() {
        var iconShow =layer.open({
            type: 2,
            title: '选择图标',
            shadeClose: true,
            //area: ['800px', '580px'],
            area: ['80%', '80%'],
            content: '${base}/static/page/iconList.html'
        });
        //layer.full(iconShow);
    }

</script>
</body>
</html>