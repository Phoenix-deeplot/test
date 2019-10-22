<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/html">

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>rfid编辑页面</title>
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
        th {
            background-color: lightgrey;
        }

        div.IPDiv {
            background: #ffffff;
            width: 120;
            font-size: 9pt;
            text-align: center;
            border: 2 ridge threedshadow;
            border-right: inset threedhighlight;
            border-bottom: inset threedhighlight;
        }

        input.IPInput {
            width: 20%;
            font-size: 9pt;
            text-align: center;
            border-width: 0;
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
            <div class="form-group" style="height: 55px;">
                <label class="col-sm-2 control-label" for="com">读写器</label>
                <div class="col-sm-6">
                    <select id="UHF" name="UHF" class="selectpicker" title="请选择" data-width="300px">
                        <#list rfids as rfid >
                            <option value="${rfid.ip},${rfid.com}">${rfid.name}</option>
                        </#list>
                    </select>
                    <input type="button" onclick="testConnection()" class="btn btn-success"  value="连接">
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-sm-2 control-label" for="location">选择标签</label>
                <div class="col-sm-9">
                    <div class="panel panel-default">
                        <div class="panel-heading"><input type="button" class="btn btn-primary" onclick="selectLabel()" value="刷新"></div>
                        <div class="panel-body">
                            <#list users as user >
                                <div class="row">
                                    <div class="col-sm-6"><input type="text" name="user" class="form-control" id="user${user.id}" value="${user.nickName}" readonly></div>
                                    <div class="col-sm-6"><select id="label${user.id}" name="label" class="selectpicker"  title="请选择标签" data-width="300px"></select></div>
                                </div>
                                </br>
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
    </form>
</div>


<script type="text/javascript">
    var selectArr=[];
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        formValidator();
    });

    function formValidator() {
        //var ip=$("#ip1").val()+"."+$("#ip2").val()+"."+$("#ip3").val()+"."+$("#ip4").val()
        $('#form').bootstrapValidator({
            message: '输入值不合法',
            fields: {
                UHF: {
                    validators: {
                        notEmpty: {
                            message: '请选择设备'
                        }
                    }
                },
            }
        }).on('success.form.bv', function (e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                //发送ajax请求
                var data=[];
                $("[name='user']").each(function () {
                    var userId=$(this).attr("id").substring(4);
                    var epc=$("#label"+userId).val();
                    if(epc!=""){
                        data.push({
                            'word':userId,
                            'epc':epc
                        })
                    }
                })

                var arr=$("#UHF").val().split(",");
                var updata={
                'ip':arr[0],
                'com':arr[1],
                'data':data
                }

                $.ajax({
                    url: "${base}/sys/rfid/saveDataToRfid",
                    type: 'POST',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(updata),
                    complete: function (msg) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        if(result.success){
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.toastr.success("添加数据成功！")
                        }else{
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.toastr.error("添加数据失败！");
                        }
                    }
                });
            }
        });
    }

    function testConnection() {
        if($("#UHF").val()=="" || $("#UHF").val()==null){
            toastr.warning("请选择要连接的读写器设备！");
            return;
        }
        var arr=$("#UHF").val().split(",");

        var deleteindex = layer.msg('正在测试连接，请稍候...', {icon: 16, time: false, shade: 0.8});
        $.ajax({
            url: '${base}/sys/rfid/testConnection',
            type: 'POST',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({'ip':arr[0],'com':arr[1]}),
            complete: function (msg) {
                console.log('完成了');
            },
            success: function (result) {
                if(result.success){
                    toastr.success("测试成功，可用连接")
                }else{
                    toastr.error("测试失败，连接不成功")
                }
                layer.close(deleteindex);
            }
        });
    }

    //查询标签
    function selectLabel() {
        if($("#UHF").val()=="" || $("#UHF").val()==null){
            toastr.warning("请选择要连接的读写器设备！");
            return;
        }
        var arr=$("#UHF").val().split(",");

        $.ajax({
            url: '${base}/sys/rfid/selectRfid',
            type: 'POST',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({'ip':arr[0],'com':arr[1]}),
            complete: function (msg) {
                console.log('完成了');
            },
            success: function (result) {
                $("[name='label']").html("");
                selectArr=result;
                $("[name='label']").append("<option value=''>不选择</option>")
                result.forEach(function (r) {
                    $("[name='label']").append("<option value='"+r+"'>"+r+"</option>")
                    $("[name='label']").selectpicker('refresh');
                    $("[name='label']").selectpicker('render');
                })
            }
        });
    }

    $("[name='label']").change(function () {
        var labelCheck=new Array();
        var id=$(this).attr("id");

        $("[name='label']").each(function () {
            if($(this).val()!=null && $(this).val()!=""){
                labelCheck.push($(this).val())
            }
        })

        $("[name='label']").each(function () {
            $(this).find('option').each(function () {
                if($(this).parent().attr("id")!=id){
                    if(labelCheck.indexOf($(this).val())==-1){
                        $(this).show();
                    }else{
                        $(this).hide();
                    }
                }
            });
        })

        $("[name='label']").selectpicker('refresh');
        $("[name='label']").selectpicker('render');
    });
</script>
</body>
</html>