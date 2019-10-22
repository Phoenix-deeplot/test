<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>组织管理</title>
    <meta name="viewport" content="width=device-width" />
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
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
        <input hidden="hidden" id="id" name="id" value="${organization.id}"/>
        <input hidden="hidden" id="parentId" name="parentId" value="${organization.parentId}"/>
        <input hidden="hidden" id="parentIds" name="parentIds" value="${organization.parentIds}">
        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="loginName">所属组织</label>
                <div class="col-sm-6" >
                    <input type="text" id="parent" class="form-control" readonly="readonly" value="${organization.parentName}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="nickName">组织名</label>
                <div class="col-sm-6" style="height: 30px">
                    <input type="text" id="name" name="name" class="form-control" value="${organization.name}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="email">排序</label>
                <div class="col-sm-3">
                    <input type="text" id="sort" name="sort" class="form-control" value="${organization.sort}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="email">等级</label>
                <div class="col-sm-3">
                    <input type="text" id="level" name="level" readonly="readonly" class="form-control" value="${organization.level}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="phone">备注</label>
                <div class="col-sm-8">
                    <textarea id="remarks" name="remarks" class="form-control" rows="4">${organization.remarks}</textarea>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span class="glyphicon glyphicon-floppy-disk"></span>保存</button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span class="glyphicon glyphicon-remove"></span>关闭</button>
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

        var id = $('[name="id"]').val();
        var mode = 1;
        if(undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $("#form").bootstrapValidator({
            message: "输入不合法",
            fields: {
                sort: {
                    validators: {
                        notEmpty: {
                            message: '排序不能为空'
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
                },
                name: {
                    validators: {
                        notEmpty: {
                            message: '组织不能为空'
                        },
                        stringLength:{
                            max:40,
                            message:'长度不能超过40位'
                        },
                        threshold :  3 ,//有2字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/sys/organization/checkOrganizationName',//验证地址
                            message: '该组织已存在',//提示消息
                            delay :  500,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {name: $('#name').val(),
                                parentId: $('#parentId').val(),
                                sub:$('#submitType').val(),
                                id:$('#id').val()
                            }
                        }
                    }
                },
                remarks:{
                    validators: {
                        stringLength:{
                            max:255,
                            message:'长度不能超过255位'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                var formdata={
                    "id":$('[name="id"]').val(),
                    "name":$("#name").val(),
                    "parentId":$("#parentId").val(),
                    "sort":$('[name="sort"]').val(),
                    "remarks":$("#remarks").val(),
                    "level":$("#level").val(),
                    "parentIds":$("#parentIds").val()
                };
                console.log(formdata);

                var url = "";
                if(1 == mode){
                    url = "/sys/organization/insert";
                }else{
                    url = "/sys/organization/update";
                }

                //发送ajax请求
                $.ajax({
                    url: url,
                    type: 'POST',
                    dataType:"json",
                    contentType:"application/json",
                    data: JSON.stringify(formdata),
                    complete: function (msg) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        if(result.success){
                            //刷新父页面
                            parent.ztree();
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.$("#handle").val(mode);
                        }else{
                            toastr.error(result.message);
                        }
                    }
                });
            }

        });
    }

</script>
</body>
</html>