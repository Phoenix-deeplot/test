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
    <form class="form-horizontal" id="typeForm">
        <input hidden="hidden" name="id" value="${dict.id}"/>
        <input hidden="hidden" name="oldType" value="${dict.type}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="type">TYPE</label>
                <div class="col-sm-5">
                    <input type="text" name="type" class="form-control" id="type" placeholder="请输入TYPE"
                           value="${dict.type}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="description">描述</label>
                <div class="col-sm-5">
                    <textarea id="description" name="description" class="form-control" rows="4">${dict.description}</textarea>
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
        $("#typeForm").data('bootstrapValidator').destroy();
        $('#typeForm').data('bootstrapValidator', null);
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

        $('#typeForm').bootstrapValidator({
            message: '输入值不合法',
            /*feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },*/
            fields: {
                type: {
                    validators: {
                        notEmpty: {
                            message: 'TYPE不能为空'
                        },
                        stringLength: {/*长度提示*/
                            max: 100,
                            message: 'TYPE长度要在100个字符以内'
                        },
                        threshold: 3,//有6字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/sys/dict/checkTypeExist/' + mode,//验证地址
                            message: '用户名已存在',//提示消息
                            delay: 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {
                                type: $('[name="type"]').val(),
                                id: $('[name="id"]').val()
                            }
                        }
                    }
                },description: {
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 100,
                            message: '描述长度要在100个字符以内'
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
                var formdata = {
                    "id": $('[name="id"]').val(),
                    "oldType": $('[name="oldType"]').val(),
                    "type": $("#type").val(),
                    "label": $("#label").val(),
                    "value": $("#value").val(),
                    "description": $("#tel").val()
                };
                console.log(formdata);

                var url = "";
                if (1 == mode) {
                    url = "/sys/dict/addType";
                } else {
                    url = "/sys/dict/editType";
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