<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width"/>
    <title></title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
</head>
<body>
<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="addUserForm">
        <input hidden="hidden" name="id" value="${localuser.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="loginName">登录名</label>
                <div class="col-sm-5">
                    <input type="text" name="loginName" class="form-control" id="loginName" placeholder="请输入登录名"
                           value="${localuser.loginName}">
                </div>
                <div class="col-sm-4" style="height: 200px;float: right;">
                    <#--<img id="showImage" class="layui-circle img-responsive" src="${base}/attach/headPortrait/155840835801111474.jpg"-->
                    <#--style="height: 150px;width: 150px;">-->
               <img id="showImage" class="layui-circle img-responsive" <#if (localuser.icon??)>src="${base}${localuser.icon}" <#else> src="${base}/attach/headPortrait/default.jpg " </#if>
                         style="height: 150px;width: 150px;">
                    <div style=" height:0px; overflow:hidden; position:absolute;">
                        <input name="icon" type="file"  val="${localuser.icon}" id="picFile" accept="image/*"/>
                    </div>
                    <input type="button" value="选择头像" class="btn btn-info"
                           onclick="document.getElementById('picFile').click();"/>
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="nickName">昵称</label>
                <div class="col-sm-4" style="height: 30px">
                    <input type="text" name="nickName" class="form-control" id="nickName" placeholder="请输入昵称"
                           value="${localuser.nickName}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="email">邮箱</label>
                <div class="col-sm-5">
                    <input type="text" name="email" class="form-control" id="email" placeholder="请输入邮箱"
                           value="${localuser.email}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="phone">手机</label>
                <div class="col-sm-3">
                    <input type="text" name="tel" class="form-control" id="tel" placeholder="请输入手机"
                           value="${localuser.tel}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="phone">备注</label>
                <div class="col-sm-5">
                    <textarea type="text" id="remarks" name="remarks" class="form-control" rows="3" id="remarks"
                              placeholder="请输入备注" value="">${localuser.remarks}</textarea>
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="roles[]">用户角色</label>
                <div class="col-sm-10">
                    <#if roleList??>
                        <#if (roleList?size > 0)>
                            <#list roleList as role>
                                <label>
                                    <input type="checkbox" name="roles[]" class="flat-red" value="${role.id}"
                                           <#list roleIds as roleId><#if (roleId == role.id)>checked</#if></#list>/>
                                    ${role.name}
                                </label>
                            </#list>
                        </#if>
                    </#if>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="disableFlag">是否启用</label>
                <div class="col-sm-3">
                    <div class="switch">
                        <#if (localuser??)>
                            <input type="checkbox" name="disableFlag" id="disableFlag"
                                   <#if (localuser.disableFlag == false)>checked</#if> />
                        <#else>
                            <input type="checkbox" name="disableFlag" id="disableFlag" checked/>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
        <!-- /.box-footer -->
    </form>
</div>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>

<script src="${base}/static/plugins/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="${base}/static/plugins/bootstrap-fileinput/locale/zh.js"></script>
<script>


    $(document).ready(function () {
        debugger;
        $("#picFile").change(function () {
            $("#showImage").attr("src", URL.createObjectURL($(this)[0].files[0]));
        });
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        formValidator();

        $('input[name="roles[]"].flat-red').iCheck({
            checkboxClass: 'icheckbox_flat-green'
        }).on('ifChanged', function (event) {
            // 解决icheck和validator冲突的问题
            // 在icheck点击事件中添加验证
            var feild = $(this)[0].name;
            $("#addUserForm").bootstrapValidator('revalidateField', feild);
        });

        initBootstrapSwitch();

    });

    //启用/停用开关初始化
    function initBootstrapSwitch() {
        //有则销毁（Destroy）
        $('input[name="disableFlag"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="disableFlag"]').bootstrapSwitch({
            onText: "启用",      // 设置ON文本
            offText: "停用",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="disableFlag"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                console.log('启用');
                $(this).val(false);
            } else {
                console.log('停用');
                $(this).val(true);
            }
        });
    }

    $("#btnClose").click(function () {
        debugger;
        //清空验证
        $("#addUserForm").data('bootstrapValidator').destroy();
        $('#addUserForm').data('bootstrapValidator', null);
        var index = parent.layer.getFrameIndex(window.name);
        parent.$("#handle").attr("value", "");
        parent.layer.close(index);
    });

    function formValidator() {
        var id = $('[name="id"]').val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $('#addUserForm').bootstrapValidator({
            message: '输入值不合法',
            /*feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },*/
            fields: {
                loginName: {
                    message: '用户名不合法',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {/*长度提示*/
                            min: 3,
                            max: 30,
                            message: '用户名长度必须在3到30之间'
                        },
                        threshold: 3,//有6字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/sys/user/checkLoginNameExist/' + mode,//验证地址
                            message: '用户名已存在',//提示消息
                            delay: 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {
                                loginName: $('[name="loginName"]').val(),
                                id: $('[name="id"]').val()
                            }
                        },
                        regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名只能包含大写、小写、数字和下划线'
                        }
                    }

                }, email: {
                    validators: {
                        notEmpty: {
                            message: 'email不能为空'
                        },
                        emailAddress: {
                            message: '请输入正确的邮件地址如：123@qq.com'
                        },
                        threshold: 6,
                        remote: {
                            url: '${base}/sys/user/checkMailExist/' + mode,
                            message: '该邮箱已被使用',
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
                            message: '手机号不能为空'
                        },
                        regexp: {
                            regexp: "^([0-9]{11})?$",
                            message: '手机号码格式错误'
                        },
                        threshold: 11,
                        remote: {
                            url: '${base}/sys/user/checkTelExist/' + mode,
                            message: '该手机号已被绑定',
                            delay: 2000,
                            type: 'POST',
                            data: {
                                tel: $('[name="tel"]').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                },
                'roles[]': {
                    validators: {
                        notEmpty: {
                            message: '至少选择一个用户角色'
                        }
                    }
                },
                remarks: {
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 255,
                            message: '长度要在255个字符以内'
                        },
                    }
                },
                icon: {
                    validators: {
                        file: {
                            extension: 'png,jpg,jpeg',
                            type: 'image/png,image/jpg,image/jpeg,image/gif',
                            message: '请重新选择图片'
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            debugger;
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                //给角色赋值
                var selectRole = [];
                debugger;
                $('input[name="roles[]"]:checked').each(function () {
                    selectRole.push({"id": $(this).val()});
                });

                var checkFlg = $("#disableFlag")[0].checked;
                console.log(checkFlg);
                //判断用户是否启用
                if (undefined == checkFlg || null == checkFlg || true == checkFlg) {
                    checkFlg = true;
                } else {
                    checkFlg = false;
                }

                var formdata = {
                    "id": $('[name="id"]').val(),
                    "loginName": $("#loginName").val().toUpperCase(),
                    "nickName": $("#nickName").val(),
                    "email": $("#email").val(),
                    "tel": $("#tel").val(),
                    "roleLists": selectRole,
                    "disableFlag": !checkFlg,
                    "remarks": $("#remarks").val(),
                    "icon":$("#picFile").val()
                };
                console.log(formdata);

                var url = "";
                if (1 == mode) {
                    url = "/sys/user/add";
                } else {
                    url = "/sys/user/edit";
                }

                //发送ajax请求
                $.ajax({
                    url: url,
                    type: 'POST',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(formdata),
                    complete: function (msg) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        if (result.success) {
                            //刷新父页面
                            $('button[name="refresh"]', window.parent.document).click();
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.$("#handle").attr("value", mode);
                            parent.layer.close(index);
                        } else {
                            toastr.error(result.message);
                        }
                    }
                });
            }

        });
    };

</script>
</body>
</html>