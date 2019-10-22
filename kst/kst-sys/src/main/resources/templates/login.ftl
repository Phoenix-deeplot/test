<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${projectName}</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/square/blue.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.css"/>
    <style>
        html, body {
            width: 100%;
            height: 100%
        }

        body {
            font-family: "华文细黑";


        }
    </style>
</head>
<body class="hold-transition login-page"
      style="background:url('../static/image/xia.jpg') no-repeat;background-size: 100%;">
<div class="login-box">
    <div class="login-logo">
        <a href="../../index2.html"><b>${adminText}</b>${projectName}</a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg"><@spring.message "sys.login.login" /></p>

        <form id="loginForm" action="${base}/login/main" method="post">
            <div class="form-group" style="height: 55px;">
                <div class="input-group" style="text-align: left">
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-user"></span>
                    </span>
                    <input type="text" name="username" class="form-control"
                           placeholder="<@spring.message "sys.login.loginName" />" required="">
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <div class="input-group" style="text-align: left">
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-lock"></span>
                    </span>
                    <input type="password" name="password" class="form-control"
                           placeholder='<@spring.message "sys.login.password" />' required="">
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group" style="height: 55px;">
                        <div class="input-group" style="text-align: left">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-th"></span>
                        </span>
                            <input type="text" class="form-control" name="code"
                                   placeholder="<@spring.message "sys.login.verificationCode" />">
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <img onclick="this.src='${base}/genCaptcha?r'+Date.now()" src="${base}/genCaptcha" width="116px"
                         height="36px" id="mycode">
                </div>
            </div>
            <br>
            <div class="form-group">
                <div class="col-sm-6">
                    <#--<input type="checkbox" name="rememberMe" value="false"><@spring.message "sys.login.rememberMe" />-->
                </div>
                <div class="col-sm-6"><a href="/login?l=zh_CN">中文</a>|<a href="/login?l=en_US">English</a></div>
            </div>
            <button type="submit" name="submit" class="btn btn-primary btn-block"
                    id="submit"><@spring.message "sys.login.login" /></button>
        </form>

        <!-- /.social-auth-links -->
        <a href="javascript:void(0)"><@spring.message "sys.login.forgetThePassword" /></a><br>

    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.3 -->
<script src="${base}/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${base}/static/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>

<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<script src="${base}/static/js/login.js"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' /* optional */
        });

        $('#loginForm').bootstrapValidator({
            /* message: 'This value is not valid',
             feedbackIcons: {
                 valid: 'glyphicon glyphicon-ok',
                 invalid: 'glyphicon glyphicon-remove',
                 validating: 'glyphicon glyphicon-refresh'
             },*/
            fields: {
                username: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.login.loginNameNotEmpty" />'
                        }
                        //有待验证，备注以备下次使用。
                        //bootstrap的remote验证器需要的返回结果一定是json格式的数据 :
                        //{"valid":false} //表示不合法，验证不通过
                        //{"valid":true} //表示合法，验证通过
                        /*remote: {//发起Ajax请求。
                            url: '/login/user/name',//验证地址
                            data:{userName:$('input[name="userName"]').val() }
                            message: '用户已存在',//提示消息
                            delay :  2000,//设置2秒发起名字验证
                            type: 'POST' //请求方式
                        }*/
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.login.passwordNotEmpty" />'
                        }
                    }
                },
                code: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.login.CodeNotEmpty" />'
                        }
                    }
                }
            }
        })
            .on('success.form.bv', function (e) {//点击提交之后
                //取消submit默认提交效果
                e.preventDefault();

                /*$("#loginForm")[0].reset();//重置表单，此处用jquery获取Dom节点时一定要加[0]
                $("#loginForm").data('bootstrapValidator').resetForm();//清除当前验证的关键之处*/

                var $form = $(e.target);
                var bv = $form.data('bootstrapValidator');
                var bol = bv.isValid();
                debugger;
                // Use Ajax to submit form data 提交至form标签中的action，result自定义
                $.post($form.attr('action'), $form.serialize(), function (res) {
                    debugger;
                    //恢复submit按钮disable状态。
                    $('#loginForm').bootstrapValidator('disableSubmitButtons', false);
                    //do something...
                    if (res.success) {
                        location.href = "${base}/" + res.data.url;
                    } else {
                        var mes="";
                        if(res.message=="passWrong"){
                            mes="登录密码错误.";
                        }else if(res.message=="failureMore"){
                            mes="登录失败次数过多";
                        }else if(res.message=="locked"){
                            mes="用户已被锁定.";
                        }else if(res.message=="forbidden"){
                            mes="用户已被禁用. ";
                        }else if(res.message=="pastDue"){
                            mes="用户已过期.";
                        }else if(res.message=="noUser"){
                            mes="用户不存在";
                        }else if(res.message=="noPermission"){
                            mes="您没有得到相应的授权!";
                        }else if(res.message=="sessionOver"){
                            mes="session超时";
                        }else if(res.message=="codeOver"){
                            mes="验证码超时";
                        }else if(res.message=="codeErr"){
                            mes="验证码错误";
                        }

                        new LoginValidator({
                            errorCode: res.errorCode,
                            message: mes,
                            username: 'username',
                            password: 'password',
                            code: 'code'
                        });
                        //若错误为用户名或密码错误，则重新加载验证码
                        if (res.errorCode != 4) {
                            $("#mycode").click()
                        }
                    }
                });
            });
    });


</script>
</body>
</html>
