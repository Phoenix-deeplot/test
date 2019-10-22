<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
    <meta charset="utf-8">
    <title>个人资料--${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel = "shortcut icon" href="${site.logo}">
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
</head>
<body>
<form class="form-horizontal" id="userInfoForm">
    <div class="box-body">
        <div class="form-group" style="height: 55px;align-self: center;" align="center">
            <input type="hidden" name="id" value="${userinfo.id}"/>
            <label class="col-sm-3 control-label" for="loginName"><@spring.message "sys.user.loginName"/></label>
            <div class="col-sm-5">
                <input type="text" value="${userinfo.loginName}" id="loginName" name="loginName"  class="form-control" disabled>
            </div>
            <div class="col-sm-4" style="height: 200px;float: right;">
                <img id="showImage" class="layui-circle img-responsive" <#if (userinfo.icon??)>src="${base}${userinfo.icon}" <#else> src="${base}/attach/headPortrait/default.jpg " </#if>
                     style="height: 150px;width: 150px;">
                <div style=" height:0px; overflow:hidden; position:absolute;">
                    <input name="icon" type="file"  val="${userinfo.icon}" id="picFile" accept="image/*"/>
                </div>
                <input type="button" value="<@spring.message "common.button.selectHeadPortrait"/>" class="btn btn-info"
                       onclick="document.getElementById('picFile').click();"/>
            </div>
        </div>
        <div class="form-group" style="height: 55px;align-self: center;" align="center">
            <label class="col-sm-3 control-label" for="nickName"><@spring.message "sys.user.nickName"/></label>
            <div class="col-sm-5">
                <input type="text" value="${userinfo.nickName}" id="nickName" name="nickName" class="form-control">
            </div>
        </div>
        <div class="form-group" style="height: 55px;align-self: center;" align="center">
            <label class="col-sm-3 control-label" for="tel"><@spring.message "sys.user.tel"/></label>
            <div class="col-sm-5">
                <input type="text" value="${userinfo.tel}" id="tel" name="tel" placeholder="<@spring.message "sys.pleaseEnter"/><@spring.message "sys.user.tel"/>" class="form-control" >
            </div>
        </div>
        <div class="form-group" style="height: 55px;align-self: center;" align="center">
            <label class="col-sm-3 control-label" for="email"><@spring.message "sys.user.email"/></label>
            <div class="col-sm-5">
                <input type="text" value="${userinfo.email}" id="email" name="email" placeholder="<@spring.message "sys.pleaseEnter"/><@spring.message "sys.user.email"/>" class="form-control" >
            </div>
        </div>
        <div class="form-group" style="height: 55px;align-self: center;" align="center">
            <label class="col-sm-3 control-label" for="remarks"><@spring.message "sys.user.remarks"/></label>
            <div class="col-sm-5">
                <textarea  class="form-control" id="remarks" name="remarks">${userinfo.remarks}</textarea>
            </div>
        </div>
        <div class="form-group" style="height: 55px;">
            <div class="col-sm-5 col-sm-offset-4">
                <button class="btn btn-primary"><@spring.message "common.button.editNow"/></button>
                <button type="reset" class="btn btn-default"><@spring.message "common.button.reset"/></button>
            </div>
        </div>
    </div>
</form>

<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local" />.js"></script>
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<script src="${base}/static/AdminLTE/js/app_iframe.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script>

    $("#picFile").change(function () {
        $("#showImage").attr("src", URL.createObjectURL($(this)[0].files[0]));
    });

    $(function () {

        toastr.options.positionClass = 'toast-center-center';
        var mode=2;

        $("#userInfoForm").bootstrapValidator({
            message: '输入值不合法',
            excluded: [":disabled"],
            fields: {
                email: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.user.email"/><@spring.message "sys.user.validate.notEmpty"/>'
                        },
                        emailAddress: {
                            message: '<@spring.message "sys.user.validate.emailCheck"/>'
                        },
                        threshold: 6,
                        remote: {
                            url: '${base}/sys/user/checkMailExist/' + mode,
                            message: '<@spring.message "sys.user.validate.emailHasUsed"/>',
                            delay: 2000,
                            type: 'POST',
                            data: {
                                email: $('[name="mail"]').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                }, tel: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.user.tel"/><@spring.message "sys.user.validate.notEmpty"/>'
                        },
                        regexp: {
                            regexp: "^([0-9]{11})?$",
                            message: '<@spring.message "sys.user.validate.telCheck"/>'
                        },
                        threshold: 11,
                        remote: {
                            url: '${base}/sys/user/checkTelExist/' + mode,
                            message: '<@spring.message "sys.user.validate.telLocked"/>',
                            delay: 2000,
                            type: 'POST',
                            data: {
                                tel: $('[name="tel"]').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                },
                remarks:{
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 255,
                            message: '长度要在255个字符以内'
                        },
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

                var formdata = {
                    "id": $('[name="id"]').val(),
                    "loginName": $("#loginName").val().toUpperCase(),
                    "nickName": $("#nickName").val(),
                    "email": $("#email").val(),
                    "tel": $("#tel").val(),
                    "remarks": $("#remarks").val(),
                    "icon":'${userinfo.icon}'
                };

                var myform = new FormData();
                myform.append('file', $("[name='icon']")[0].files[0]);
                if($("[name='icon']")[0].files.length>0){
                    $.ajax({
                        url: "${base}/sys/user/uploadHeadPortrait",
                        type: 'POST',
                        data: myform,
                        async: false,
                        contentType: false,
                        processData: false,
                        success: function (result) {
                            formdata.icon=result;
                        }
                    });
                }

                $.ajax({
                    url: '/sys/user/saveUserinfo',
                    type: 'POST',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(formdata),
                    complete: function (msg) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        if (result.success) {
                            parent.toastr.success("<@spring.message "sys.user.message.editSuccess"/>");
                            window.parent.closeCurrentTab();
                        } else {
                            toastr.error(result.message);
                        }
                    },error:function () {
                        toastr.error("修改失败");
                    }
                });
            }
        });
    })
</script>
</body>
</html>