<html>
<head>
    <title>模型编辑</title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
</head>

<body>
<div class="box box-info" style="margin-bottom:0px;" id="role_edit_table">
    <form id="roleForm" class="form-horizontal" >
        <input type="hidden" name="id" value="${role.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">模型分类:</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" id="category" name="category" value="${modelForm.category}"/>
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">模型名称:</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" id="name" name="name" value="${modelForm.name}"/>
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">模型标识:</label>
                <div class="col-md-7">
                    <input type="text" class="form-control" id="key" name="key" value="${modelForm.key}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">模型描述:</label>
                <div class="col-md-7">
                    <textarea name="desc" class="form-control" id="desc" value="${modelForm.desc}" rows="4"></textarea>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none" >保存</button>
    </form>
</div>
<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script type="text/javascript">
    $(function(){
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化表单
        formValidator();
    });
    //初始化表单
    function formValidator(){

        $('#roleForm').bootstrapValidator({
            message: '输入值不合法',
            fields: {
                category: {
                    validators: {
                        notEmpty: {
                            message: '模型分类不能为空'
                        }
                    }
                },
                name: {
                    validators: {
                        notEmpty: {
                            message: '模型名称不能为空'
                        }
                    }
                },
                key: {
                    validators: {
                        notEmpty: {
                            message: '模型标识不能为空'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            debugger;
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {

                var formdata={
                    "category": $("#category").val(),
                    "name": $("#name").val(),
                    "key": $("#key").val(),
                    "desc": $("#desc").val()
                };

                console.log(formdata);

                //发送ajax请求
                $.ajax({
                    url: '${base}/activityView/insert',
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
                            $('button[name="refresh"]', window.parent.document).click();
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.$("#handle").attr("value",1);
                            parent.layer.close(index);
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