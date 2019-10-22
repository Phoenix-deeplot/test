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
    <form class="form-horizontal" id="dictForm">
        <input hidden="hidden" name="id" value="${dict.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="type">TYPE</label>
                <div class="col-sm-5">
                    <input type="text" name="type" class="form-control" id="type" placeholder="请输入TYPE"
                           value="${dict.type}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="label">标签</label>
                <div class="col-sm-5" style="height: 30px">
                    <input type="text" name="label" class="form-control" id="label" placeholder="请输入标签"
                           value="${dict.label}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="value">值</label>
                <div class="col-sm-5">
                    <input type="text" name="value" class="form-control" id="value" placeholder="请输入值"
                           value="${dict.value}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="sort">排序</label>
                <div class="col-sm-5">
                    <input type="text" name="sort" class="form-control" id="sort" placeholder="请输入排序值"
                           value="${dict.sort}">
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
        $("#dictForm").data('bootstrapValidator').destroy();
        $('#dictForm').data('bootstrapValidator', null);
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

        $('#dictForm').bootstrapValidator({
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
                        }
                    }
                }, label: {
                    validators: {
                        notEmpty: {
                            message: '标签不能为空'
                        },stringLength: {/*长度提示*/
                            max: 100,
                            message: '标签长度要在100个字符以内'
                        }
                    }
                },value: {
                    validators: {
                        notEmpty: {
                            message: '值不能为空'
                        },stringLength: {/*长度提示*/
                            max: 100,
                            message: '值长度要在100个字符以内'
                        }
                    }
                },sort: {
                    validators: {
                        notEmpty: {
                            message: '排序值不能为空'
                        }digits: {
                            message: '请输入数字'
                        },
                        stringLength: {
                            min: 1,
                            max: 3,
                            message: '长度不能超过3位'
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
                    "type": $("#type").val(),
                    "label": $("#label").val(),
                    "value": $("#value").val(),
                    "sort":$('[name="sort"]').val(),
                    "description": $("#tel").val()
                };
                console.log(formdata);

                var url = "";
                if (1 == mode) {
                    url = "/sys/dict/add";
                } else {
                    url = "/sys/dict/edit";
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