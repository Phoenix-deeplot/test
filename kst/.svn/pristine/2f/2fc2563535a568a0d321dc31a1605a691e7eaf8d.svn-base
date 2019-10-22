<!DOCTYPE html>

<html>

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>文件修改</title>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">


    <style>
        .form-group {
            height: 55px;
        }
    </style>
</head>
<body>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>


<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">
        <input hidden="hidden" id="id" name="id" value="${question.id}"/>
        <input hidden="hidden" id="delIds" name="delIds"/>

        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="loginName"><@spring.message "sys.resource.name"/></label>
                <div class="col-sm-6">
                    <input type="text" id="name" name="name" class="form-control" value="${resource.name}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="nickName"><@spring.message "sys.resource.fileType"/></label>
                <div class="col-sm-6" style="height: 30px">
                    <select name="category" id="category" class="selectpicker" title="<@spring.message "sys.message.choice"/>"
                            data-width="150px">
                        <#list resourceCategory as category>
                            <#if category.value==resource.typeId>
                                <option value="${category.value}" selected="selected">${category.label}</option>
                            <#else>
                                <option value="${category.value}">${category.label}</option>
                            </#if>
                        </#list>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="email"><@spring.message "sys.role.remarks"/></label>
                <div class="col-sm-6">
                    <textarea name="remarks" id="remarks" type="text" class="form-control" rows="4"
                              placeholder="<@spring.message "sys.pleaseEnter"/><@spring.message "sys.role.remarks"/>">${resource.remarks}</textarea>
                </div>
            </div>
        </div>

        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span><@spring.message "common.button.save"/>
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span><@spring.message "common.button.close"/>
        </button>
        <!-- /.box-footer -->
    </form>
</div>

<script type="text/javascript">

    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        $("#category").selectpicker('refresh');
        $("#category").selectpicker('render');

        formValidator();
    });


    function formValidator() {
        $("#form").bootstrapValidator({
            message: "<@spring.message "sys.user.validate.message1"/>",
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.resource.name"/><@spring.message "sys.user.validate.notEmpty"/>'
                        },
                        stringLength: {
                            max: 50,
                            message: '<@spring.message "sys.resource.validate.nameLength"/>'
                        }
                    }
                },
                remarks: {
                    validators: {
                        stringLength: {
                            max: 255,
                            message: '<@spring.message "sys.user.validate.remarksLength"/>'
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
                var upData = {
                    'id': "${resource.id}",
                    'name': $("#name").val(),
                    'typeId': $("#category").val(),
                    'remarks': $("#remarks").val()
                }
                $.ajax({
                    url: '${base}/sys/resource/editResource',
                    type: 'post',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(upData),
                    success: function (re) {
                        if(re.success){
                            //刷新父页面
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.toastr.success("<@spring.message "sys.message.editSuccess"/>")
                            parent.$("#resourceTable").bootstrapTable('refresh');
                        }else{
                            parent.toastr.error(result.message);
                        }
                    }, error: function () {
                        toastr.error("<@spring.message "sys.message.editFailed"/>")
                    }
                })
            }
        });
    }
</script>
</body>
</html>