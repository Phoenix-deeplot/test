<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码--${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <!-- 页面描述 -->
    <meta name="description" content="${site.description}"/>
    <!-- 页面关键词 -->
    <meta name="keywords" content="${site.keywords}"/>
    <!-- 网页作者 -->
    <meta name="author" content="${site.author}"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
</head>
<body class="childrenBody">
<form class="form-horizontal changePwd" id="passwordForm">

    <div class="box-body">
        <!--tab页内容区分-------------------------------------->
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane active">
                <div class="form-group" style="height: 55px;align-self: center;" align="center">
                    <label class="col-sm-3 control-label" for="nickName">用户名</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" name="nickName"
                               value="<#if currentUser.nickName!''>${currentUser.nickName}<#else>${currentUser.loginName}</#if>"
                               disabled>
                    </div>
                </div>
                <div class="form-group" style="height: 55px;">
                    <label class="col-sm-3 control-label" for="oldPwd">旧密码</label>
                    <div class="col-sm-5">
                        <input type="password" name="oldPwd" id="oldPwd" placeholder="请输入旧密码" class="form-control">
                    </div>
                </div>
                <div class="form-group" style="height: 55px;">
                    <label class="col-sm-3 control-label" for="newPwd">新密码</label>
                    <div class="col-sm-5">
                        <input type="password" name="newPwd" id="newPwd" placeholder="请输入新密码" class="form-control">
                    </div>
                </div>
                <div class="form-group" style="height: 55px;">
                    <label class="col-sm-3 control-label" for="confirmPwd">确认密码</label>
                    <div class="col-sm-5">
                        <input type="password" name="confirmPwd" id="confirmPwd" placeholder="请确认密码"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group" style="height: 55px;">
                    <div class="col-sm-5 col-sm-offset-4">
                        <button class="btn btn-primary">立即修改</button>
                        <button type="reset" class="btn btn-default">重置</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>
<script>
    $(function () {
        toastr.options.positionClass = 'toast-center-center';

        $("#passwordForm").bootstrapValidator({
            message: '输入值不合法',
            excluded: [":disabled"],
            fields: {
                oldPwd: {
                    message: '原密码不合法',
                    validators: {
                        notEmpty: {
                            message: '原密码不能为空'
                        }
                    }
                },
                newPwd: {
                    message: '新密码不合法',
                    validators: {
                        notEmpty: {
                            message: '新密码不能为空'
                        },
                        identical: {
                            field: 'confirmPwd',
                            message: '两次输入的密码不相符'
                        }
                    }
                },
                confirmPwd: {
                    message: '确认密码不合法',
                    validators: {
                        notEmpty: {
                            message: '确认密码不能为空'
                        },
                        identical: {
                            field: 'newPwd',
                            message: '两次输入的密码不相符'
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                $.ajax({
                    url:'${base}/sys/user/changePassword',
                    type:'post',
                    data:{'oldPwd':$("#oldPwd").val(),'newPwd':$("#newPwd").val(),'confirmPwd':$("#confirmPwd").val()},
                    success:function (res) {
                        if(res.success){
                            layer.msg("密码修改成功,请重新登录",{"time":1000},function(){
                                sessionStorage.clear();
                                localStorage.clear();
                                parent.location.href = "${base}/systemLogout";
                            })
                        }else{
                            toastr.error(res.message);
                        }
                    }
                })
            }
        });
    });
</script>
</body>
</html>