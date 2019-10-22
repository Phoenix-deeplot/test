<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>月报设定</title>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base }/static/plugins/dropzone/css/dropzone.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">

    <style>
        .form-group {
            height: 55px;
        }

        #dropz {
            min-height: 340px;
            width: 80%;
            margin-bottom: 30px;
            background-color: white;
            align-self: center;
        }
        #dropzDa {
            min-height: 340px;
            width: 80%;
            margin-bottom: 30px;
            background-color: white;
            align-self: center;
        }
    </style>
</head>
<body>
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local" />.js"></script>
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.<@spring.message "sys.message.local" />.js"></script>
<script src="${base}/static/plugins/dropzone/js/dropzone.min.js"></script>


<div style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">
        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="end">月报起始日</label>
                <div class="col-sm-6" >
                    <input type="text" id="tian" name="tian" class="form-control" value="${startDay}" placeholder="月报起始日">
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-left: 500px;"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 500px;"><span
                    class="glyphicon glyphicon-remove"></span>取消
        </button>
        <!-- /.box-footer -->
    </form>
</div>

<script type="text/javascript">
    $(function () {
        formValidator();
    });
    /*
    表单验证
    */
    function formValidator() {
        $("#form").bootstrapValidator({
            message: "<@spring.message "sys.user.validate.illegal" />",
            fields: {
                tian: {
                    validators: {
                        notEmpty: {
                            message: '月报起始日不能为空'
                        },regexp: {
                            regexp: /^[0-9]*$/,
                            message: '只能填写数字'
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
                var tian = $("#tian").val();
                var formdata={
                    "paraJson":JSON.stringify({startDay: tian}),
                };
                //发送ajax请求
                $.ajax({
                    url: "/att/daily/add",
                    type: 'POST',
                    dataType:"json",
                    contentType:"application/json",
                    data: JSON.stringify(formdata),
                    complete: function (modulePara) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        window.parent.closeCurrentTab();
                    },error:function () {
                    }
                });
            }
        });
    }
    $("#btnClose").click(function () {
        debugger;
        //清空验证
        $("#form").data('bootstrapValidator').destroy();
        $('#form').data('bootstrapValidator',null);
        window.parent.closeCurrentTab();
    });
</script>
</body>
</html>