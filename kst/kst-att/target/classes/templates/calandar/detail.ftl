<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>问题管理</title>
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
        <input hidden="hidden" id="id" name="id" value="${calandar.id}"/>
        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="calFlg">数据区分</label>
                <div class="col-sm-6" >
                    <input type="text" id="calFlg" name="calFlg" class="form-control" placeholder="数据区分" value="${calandar.calFlg}">
                </div>
            </div>
            <div class="form-group" style="margin-right:15px">
                <label class="col-sm-2 control-label" for="calDate">日期</label>
                <div class="col-sm-6">
                    <div id="calDate" name="calDate" class="input-group date form_date" data-date=""
                         data-date-format="yyyy-MM-dd" data-link-field="dtp_input2" data-link-format="yyyy-MM-dd">
                        <input id="calDates" class="form-control" size="16" type="text"
                               value="<#if calandar.calDate??>${calandar.calDate?string('yyyy-MM-dd')}</#if>" readonly/>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>

            <div id="calWorkflg" class="form-group" style="margin-left: 130px;width: 300px">
                日期区分&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <#if ('${calandar.calWorkflg}'=='0')>
                    <input type="radio" name="calWorkflg"  value="0" checked><label for="calContentX">休息</label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="calWorkflg"  value="1"><label for="calContentC">出勤</label>
                </#if>
                <#if ('${calandar.calWorkflg}'=='1')>
                    <input type="radio" name="calWorkflg"  value="0"><label for="calContentX">休息</label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="calWorkflg"  value="1" checked><label for="calContentC">出勤</label>
                </#if>
                <#if ('${calandar.calWorkflg}'=='')>
                    <input type="radio" name="calWorkflg"  value="0" checked><label for="calContentX">休息</label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="calWorkflg"  value="1"><label for="calContentC">出勤</label>
                </#if>
            </div>

            <div id="da" class="form-group" style="height:100px;">
                <label class="col-sm-2 control-label"  for="qusRequestdetail">日期说明</label>
                <div class="col-sm-6">
                    <textarea  id="calContent" name="calContent" class="form-control" rows="4"
                               placeholder="日期说明" >${calandar.calContent}</textarea>
                </div>
            </div>
        </div>

        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>取消
        </button>
        <!-- /.box-footer -->
    </form>
</div>


<script type="text/javascript">
    $(function () {
        formValidator();
    });

    $('.form_date').datetimepicker({
        format: 'yyyy-mm-dd',
        language: '<@spring.message "sys.message.local" />',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

    /*
    表单验证
    */
    function formValidator() {

        var id = $('[name="id"]').val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $("#form").bootstrapValidator({
            message: "<@spring.message "sys.user.validate.illegal" />",
            fields: {
                calFlg: {
                    validators: {
                        notEmpty: {
                            message: '数据区分不能为空'
                        }
                    }
                },calDates:{
                    validators: {
                        notEmpty: {
                            message: '日期不能为空'
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
                var formdata={
                    "id":$('[name="id"]').val(),
                    "calFlg":$("#calFlg").val(),
                    "calDate":$("#calDate").find("input").val(),

                    "calWorkflg":$('input[name="calWorkflg"]:checked').val(),

                    "calContent":$("#calContent").val(),
                };

                var url = "";
                if(1 == mode){
                    url = "/att/calandar/add";
                }else{
                    url = "/att/calandar/edit";
                }

                //发送ajax请求
                $.ajax({
                    url: url,
                    type: 'POST',
                    dataType:"json",
                    contentType:"application/json",
                    data: JSON.stringify(formdata),
                    complete: function (question) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        if(result.success){
                            //刷新父页面
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.$("#handle").val(mode);
                            parent.$("#CalandarTable").bootstrapTable("refresh");
                        }else{
                            toastr.error(result.message);
                        }
                    },error:function () {
                    }
                });
            }
        });
    }

</script>
</body>
</html>