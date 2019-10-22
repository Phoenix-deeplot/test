<!DOCTYPE html>

<html>

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>组织管理</title>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
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
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/layer/layer.js"></script>


<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">

        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="loginName">选项</label>
                <div class="col-sm-6">
                    <input type="text" name="value" class="form-control" placeholder="如:A B C等">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="loginName">选项内容</label>
                <div class="col-sm-6">
                    <input type="text" name="name" class="form-control" >
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="email">排序</label>
                <div class="col-sm-3">
                    <input type="text" name="sort" name="sort" class="form-control">
                </div>
            </div>
        </div>
        <input type="hidden" id="hidItem">

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

<script type="text/javascript">
    $(function () {

        if("${handleItemType}"==2){
            var row=parent.$("#answerList").bootstrapTable("getRowByUniqueId","${editId}");
            $("[name='name']").val(row.name);
            $("[name='value']").val(row.value);
            $("[name='sort']").val(row.sort);
        }

        formValidator();
    });

    var re;

    function formValidator() {

        $("#form").bootstrapValidator({
            message: "输入不合法",
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: '题目不能为空'
                        },
                        stringLength: {
                            max: 36,
                            message: '长度不能超过36位'
                        },
                        callback:{
                            message:'不可出现重复选项名',
                            callback:function (value, validator) {
                                var flag=true;
                                var rows=parent.$("#answerList").bootstrapTable('getData');
                                rows.forEach(function (r) {
                                    if (r.name==value && r.id!="${editId}"){
                                        flag=false;
                                    }
                                })
                                return flag;
                            }
                        },
                    }
                },
                value: {
                    validators: {
                        notEmpty: {
                            message: '请输入选项'
                        },
                        stringLength: {
                            max: 10,
                            message: '长度不能超过10位'
                        },
                        callback:{
                            message:'不可出现重复选项',
                            callback:function (value, validator) {
                                var flag=true;
                                var rows=parent.$("#answerList").bootstrapTable('getData');
                                rows.forEach(function (r) {
                                    if (r.value==value && r.id!="${editId}"){
                                        flag=false;
                                    }
                                })
                                return flag;
                            }
                        },
                    }
                },
                sort: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.menu.sort"/><@spring.message "sys.user.validate.notEmpty"/>'
                        },
                        digits: {
                            message: '请输入数字'
                        },
                        stringLength: {
                            min: 1,
                            max: 3,
                            message: '长度不能超过3位'
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
                var id = parent.$("#answerList").bootstrapTable('getData').length + 1;
                var type = "${handleItemType}";
                if (type == 1) {
                    var data = {
                        'id': 'new' + new Date().getTime(),
                        'name': $("[name='name']").val(),
                        'value': $("[name='value']").val(),
                        'sort': $("[name='sort']").val()
                    }
                } else {
                    var data = {
                        'id': "${editId}",
                        'name': $("[name='name']").val(),
                        'value': $("[name='value']").val(),
                        'sort': $("[name='sort']").val()
                    }
                }
                re = data;
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            }
        });
    }

    //父页面调用这个方法获取表单数据
    function getItem() {
        return re;
    }


</script>
</body>
</html>