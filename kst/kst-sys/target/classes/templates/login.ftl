<!DOCTYPE html>
<html >
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Admin KST</title>
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
    <link rel="stylesheet" href="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.css" />
    <style>
        html,body{
            width:100%;
            height:100%
        }
        body{
            font-family: "华文细黑";


        }
    </style>
</head>
<body class="hold-transition login-page" style="background:url('../static/image/xia.jpg') no-repeat;background-size: 100%;">
<div class="login-box">
    <div class="login-logo">
        <a href="../../index2.html"><b>${adminText}</b>${projectName}</a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">Login</p>

        <form id="loginForm" action="${base}/login/main" method="post">
            <div class="form-group" style="height: 55px;">
                <div class="input-group" style="text-align: left">
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-user"></span>
                    </span>
                    <input type="text" name="username" class="form-control" placeholder="用户名" required="">
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <div class="input-group" style="text-align: left">
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-lock"></span>
                    </span>
                    <input type="password" name="password" class="form-control" placeholder="密码" required="">
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group" style="height: 55px;">
                    <div class="input-group" style="text-align: left">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-th"></span>
                        </span>
                        <input type="text" class="form-control" name="code" placeholder="验证码">
                    </div>
                    </div>
                </div>
                <div class="col-xs-6">
                <img onclick="this.src='${base}/genCaptcha?r'+Date.now()" src="${base}/genCaptcha" width="116px" height="36px" id="mycode">
                </div>
            </div>
            <br>
            <div class="form-group">
            <input type="checkbox" name="rememberMe" value="false"> 记住我
            </div>
            <button type="submit" name="submit" class="btn btn-primary btn-block" id="submit">登 录</button>
        </form>

        <!-- /.social-auth-links -->
        <a href="#">忘记密码</a><br>

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
                            message: '用户名不能为空'
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
                            message: '密码不能为空'
                        }
                    }
                },
                code: {
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        }
                    }
                }
            }
        })
       .on('success.form.bv', function(e) {//点击提交之后
           //取消submit默认提交效果
           e.preventDefault();

           /*$("#loginForm")[0].reset();//重置表单，此处用jquery获取Dom节点时一定要加[0]
           $("#loginForm").data('bootstrapValidator').resetForm();//清除当前验证的关键之处*/

           var $form = $(e.target);
           var bv = $form.data('bootstrapValidator');
           var bol = bv.isValid();
            debugger;
           // Use Ajax to submit form data 提交至form标签中的action，result自定义
           $.post($form.attr('action'), $form.serialize(), function(res) {
               debugger;
               //恢复submit按钮disable状态。
               $('#loginForm').bootstrapValidator('disableSubmitButtons', false);
               //do something...
               if(res.success){
                   location.href="${base}/"+res.data.url;
               }else{
                   new LoginValidator({
                       errorCode:res.errorCode,
                       message:res.message,
                       username:'username',
                       password:'password',
                       code:'code'
                   });
               }
           });
       });
    });


</script>
</body>
</html>
