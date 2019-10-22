<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
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
<body>
<form class="form-horizontal changePwd" id="passwordForm">
    <div class="box-body">
        <!--tab页内容区分-------------------------------------->
        <div class="form-group" style="height: 55px;align-self: center;" align="center">
            <label class="col-sm-3 control-label" for="loginName"></label>
            <div class="col-sm-5">
                <input type="text" class="form-control" name="loginName"
                       value="<#if currentUser.loginName!''>${currentUser.loginName}<#else>${currentUser.loginName}</#if>"
                       disabled>
            </div>
        </div>
        <div class="form-group" style="height: 70px;">
            <label class="col-sm-3 control-label" for="oldPwd"><@spring.message "sys.user.oldPass" /></label>
            <div class="col-sm-5">
                <input type="password" name="oldPwd" id="oldPwd" placeholder="<@spring.message "sys.user.inputOldPass" />" class="form-control">
            </div>
        </div>
        <div class="form-group" style="height: 80px;">
            <label class="col-sm-3 control-label" for="newPwd"><@spring.message "sys.user.newPass" /></label>
            <div class="col-sm-5">
                <input type="password" name="newPwd" id="newPwd" placeholder="<@spring.message "sys.user.inputNewPass" />" class="form-control">
            </div>
        </div>
        <div class="form-group" style="height: 80px;">
            <label class="col-sm-3 control-label" for="confirmPwd"><@spring.message "sys.user.confirmPass" /></label>
            <div class="col-sm-5">
                <input type="password" name="confirmPwd" id="confirmPwd" placeholder="<@spring.message "sys.user.inputConfirmpass" />"
                       class="form-control">
            </div>
        </div>
        <div class="form-group" style="height: 75px;">
            <div class="col-sm-5 col-sm-offset-4">
                <button class="btn btn-primary"><@spring.message "common.button.editNow" /></button>
                <button type="reset" class="btn btn-default"><@spring.message "common.button.reset" /></button>
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
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local" />.js"></script>
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
            message: '<@spring.message "sys.user.validate.message1" />',
            excluded: [":disabled"],
            fields: {
                oldPwd: {
                    message: '<@spring.message "sys.user.oldPass" /><@spring.message "sys.user.validate.illegal" />',
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.user.oldPass" /><@spring.message "sys.user.validate.notEmpty" />'
                        }
                    }
                },
                newPwd: {
                    message: '<@spring.message "sys.user.newPass" /><@spring.message "sys.user.validate.illegal" />',
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.user.newPass" /><@spring.message "sys.user.validate.notEmpty" />'
                        },
                        identical: {
                            field: 'confirmPwd',
                            message: '<@spring.message "sys.user.twoPass" />'
                        },
                        stringLength: {/*长度提示*/
                            min: 6,
                            max: 12,
                            message: '密码长度只能在 6-12位之间'
                        },
                    }
                },
                confirmPwd: {
                    message: '<@spring.message "sys.user.confirmPass" /><@spring.message "sys.user.validate.illegal" />',
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.user.confirmPass" /><@spring.message "sys.user.validate.notEmpty" />'
                        },
                        identical: {
                            field: 'newPwd',
                            message: '<@spring.message "sys.user.twoPass" />'
                        },
                        stringLength: {/*长度提示*/
                            min: 6,
                            max: 12,
                            message: '密码长度只能在 6-12位之间'
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
                    url: '${base}/sys/user/changePassword',
                    type: 'post',
                    data: {
                        'oldPwd': $("#oldPwd").val(),
                        'newPwd': $("#newPwd").val(),
                        'confirmPwd': $("#confirmPwd").val()
                    },
                    success: function (res) {
                        if (res.success) {
                            layer.msg("<@spring.message "sys.user.message.passChangeSuccess" />", {"time": 1000}, function () {
                                sessionStorage.clear();
                                localStorage.clear();
                                parent.location.href = "${base}/systemLogout";
                            })
                        } else {
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