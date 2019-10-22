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
    <form class="form-horizontal" id="supplierForm">
        <input hidden="hidden" name="id" value="${supplier.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="name">供应商名称</label>
                <div class="col-sm-5">
                    <input type="text" name="name" class="form-control" id="name" placeholder="请输入供应商名称"
                           value="${supplier.name}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="address">地址</label>
                <div class="col-sm-4" style="height: 30px">
                    <input type="text" name="address" class="form-control" id="address" placeholder="请输入地址"
                           value="${supplier.address}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="tel">电话</label>
                <div class="col-sm-5">
                    <input type="text" name="tel" class="form-control" id="tel" placeholder="请输入座机号码"
                           value="${supplier.tel}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="contact">联系人</label>
                <div class="col-sm-3">
                    <input type="text" name="contact" class="form-control" id="contact" placeholder="请输入联系人"
                           value="${supplier.contact}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="mail">邮箱</label>
                <div class="col-sm-3">
                    <input type="text" name="mail" class="form-control" id="mail" placeholder="请输入邮箱地址"
                           value="${supplier.mail}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="phone">手机</label>
                <div class="col-sm-3">
                    <input type="text" name="phone" class="form-control" id="phone" placeholder="请输入手机"
                           value="${supplier.phone}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="phone">备注</label>
                <div class="col-sm-5">
                    <textarea type="text" id="remarks" name="remarks" class="form-control" rows="3" id="remarks"
                              placeholder="请输入备注" value="">${supplier.remarks}</textarea>
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
<script>

    $(document).ready(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        formValidator();
    });

    $("#btnClose").click(function () {
        debugger;
        //清空验证
        $("#supplierForm").data('bootstrapValidator').destroy();
        $('#supplierForm').data('bootstrapValidator', null);
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

        $('#supplierForm').bootstrapValidator({
            message: '输入值不合法',
            /*feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },*/
            fields: {
                name: {
                    message: '供应商名称不合法',
                    validators: {
                        notEmpty: {
                            message: '供应商名称不能为空'
                        },
                        stringLength: {/*长度提示*/
                            min: 3,
                            max: 30,
                            message: '供应商名称长度必须在3到30之间'
                        },
                        threshold: 3,//有6字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/ams/supplier/checkNameExist/' + mode,//验证地址
                            message: '供应商名称已存在',//提示消息
                            delay: 1000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置1秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {
                                loginName: $('[name="name"]').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                },
                tel: {
                    validators: {
                        threshold: 8,
                        remote: {
                            url: '${base}/ams/supplier/checkTelExist/' + mode,
                            message: '该电话号码已被绑定',
                            delay: 1000,
                            type: 'POST',
                            data: {
                                tel: $('[name="tel"]').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                }, mail: {
                    validators: {
                        emailAddress: {
                            message: '请输入正确的邮件地址如：123@koshida.com'
                        },
                        threshold: 6,
                        remote: {
                            url: '${base}/ams/supplier/checkMailExist/' + mode,
                            message: '该邮箱已被使用',
                            delay: 2000,
                            type: 'POST',
                            data: {
                                email: $('[name="mail"]').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                },
                phone: {
                    validators: {
                        regexp: {
                            regexp: "^([0-9]{11})?$",
                            message: '手机号码格式错误'
                        },
                        threshold: 11,
                        remote: {
                            url: '${base}/ams/supplier/checkPhoneExist/' + mode,
                            message: '该手机号已被绑定',
                            delay: 2000,
                            type: 'POST',
                            data: {
                                tel: $('[name="phone"]').val(),
                                id: $('[name="id"]').val()
                            }
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

                var formdata = {
                    "id": $('[name="id"]').val(),
                    "name": $("#name").val(),
                    "address": $("#address").val(),
                    "tel": $("#tel").val(),
                    "contact": $("#contact").val(),
                    "mail": $("#mail").val(),
                    "phone": $("#phone").val(),
                    "remarks": $("#remarks").val()
                };
                console.log(formdata);

                var url = "";
                if (1 == mode) {
                    url = "/ams/supplier/add";
                } else {
                    url = "/ams/supplier/edit";
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