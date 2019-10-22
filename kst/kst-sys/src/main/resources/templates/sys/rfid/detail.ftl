<!DOCTYPE html>

<html>

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
                <label class="col-sm-2 control-label" for="name">名称</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="name" name="name" value="${rfid.name}">
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <input type="hidden" value="${rfid.id}" id="id" name="id">
                <label class="col-sm-2 control-label" for="name">IP</label>
                <div class="col-sm-3">
                    <div class="form-control">
                        <input class="IPInput" name="ip1" id="ip1" type="text" size="3" maxlength="3"
                               onkeydown="keyDownEvent(this)" oninput="value=value.replace(/[^\d]/g,'')"
                               onkeyup="keyUpEvent(ip1,ip1,ip2)" value="${rfid.ip?split(".")[0]}">.
                        <input class="IPInput" name="ip2" id="ip2" type="text" size="3" maxlength="3"
                               onkeydown="keyDownEvent(this)" oninput="value=value.replace(/[^\d]/g,'')"
                               onkeyup="keyUpEvent(ip1,ip2,ip3)" value="${rfid.ip?split(".")[1]}">.
                        <input class="IPInput" name="ip3" id="ip3" type="text" size="3" maxlength="3"
                               onkeydown="keyDownEvent(this)" oninput="value=value.replace(/[^\d]/g,'')"
                               onkeyup="keyUpEvent(ip2,ip3,ip4)" value="${rfid.ip?split(".")[2]}">.
                        <input class="IPInput" name="ip4" id="ip4" type="text" size="3" maxlength="3"
                               onkeydown="keyDownEvent(this)" oninput="value=value.replace(/[^\d]/g,'')"
                               onkeyup="keyUpEventForIp4(ip3,ip4)" value="${rfid.ip?split(".")[3]}">
                    </div>
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-sm-2 control-label" for="com">端口</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="com" name="com" value="${rfid.com}">
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-sm-2 control-label" for="location">场所</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="location" name="location" value="${rfid.location}">
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <div class="col-sm-8">
                    <input type="button" class="btn btn-primary" style="margin-left: 20%" value="测试" onclick="testConnection()">
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
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        formValidator();
    });

    function formValidator() {
        var id = $('[name="id"]').val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }
        //var ip=$("#ip1").val()+"."+$("#ip2").val()+"."+$("#ip3").val()+"."+$("#ip4").val()
        $('#form').bootstrapValidator({
            message: '输入值不合法',
            fields: {
                ip1: {
                    validators: {
                        callback: {
                            message: '请输入正确的ip地址',
                            callback: function (value, validator) {
                                if ($("[name='ip1']").val() != "" && $("[name='ip2']").val() != "" && $("[name='ip3']").val() != "" && $("[name='ip4']").val() != "") {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                        },
                        threshold: 3,
                        remote: {
                            url: '${base}/sys/rfid/checkIpExist/' + mode,
                            message: 'ip地址不能重复',
                            delay: 1000,
                            type: 'POST',
                            data: {
                                ip: function (){return getIp()},
                                id: id,
                            }
                        }
                    }
                },
                com: {
                    validators: {
                        notEmpty: {
                            message: '端口号不能为空'
                        },
                        lessThan: {
                            value: 65535,
                            message: '端口号不合法'
                        }
                    }
                },
                location: {
                    validators: {
                        notEmpty: {
                            message: '场所不能为空'
                        }
                    }
                },
                name: {
                    validators: {
                        notEmpty: {
                            message: '设备名称不能为空'
                        },
                        stringLength: {/*长度提示*/
                            max: 50,
                            message: '设备名称长度必须小于200'
                        },
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
                var formdata = {
                    "id": $('[name="id"]').val(),
                    "ip": getIp(),
                    "com": $("#com").val(),
                    "location": $("#location").val(),
                    "name": $("#name").val(),
                };

                var url = "";
                if (1 == mode) {
                    url = "/sys/rfid/add"
                } else {
                    url = "/sys/rfid/edit";
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
                        if(result.success){
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.$("#handle").attr("value", mode);
                        }else{
                            if (1 == mode) {
                                parent.toastr.error("添加设备信息失败！");
                            } else {
                                parent.toastr.error("修改设备信息失败！")
                            }
                        }
                    }
                });
            }
        });
    };

    //获取四个文本框组合的ip
    function getIp() {
        return parseInt($("#ip1").val(),10) + "." + parseInt($("#ip2").val(),10) + "." + parseInt($("#ip3").val(),10) + "." + parseInt($("#ip4").val(),10);
    }

    function keyDownEvent(obj) {
        code = event.keyCode;
        if (!((code >= 48 && code <= 57) || (code >= 96 && code <= 105) || code == 190 || code == 110 || code == 13 || code == 9 || code == 39 || code == 8 || code == 46 || code == 99 || code == 37))
            event.returnValue = false;
        if (code == 13)
            event.keyCode = 9;
        if (code == 110 || code == 190)
            if (obj.value)
                event.keyCode = 9;
            else
                event.returnValue = false;
    }

    function keyUpEvent(obj0, obj1, obj2) {
        $("#form").data('bootstrapValidator').updateStatus('ip1',
            'NOT_VALIDATED', null).validateField('ip1');
        if (obj1.value > 255) {
            obj1.value = obj1.value.substring(0, obj1.value.length - 1);
            return;
        }
        code = event.keyCode

        if (obj1.value.length >= 3 && code != 37 && code != 39 && code != 16 && code != 9 && code != 13)
            obj2.focus();

        if (code == 32)
            obj2.focus();

        if (code == 8 && obj1.value.length == 0) {
            obj0.focus();
            setCursor(obj0, obj0.value.length);
        }

        if (code == 37 && (getPos(obj1) == 0)) {
            obj0.focus();
            setCursor(obj0, obj0.value.length);
        }
        if (code == 39 && (getPos(obj1) == obj1.value.length)) {
            obj2.focus();
        }
    }

    function keyUpEventForIp4(obj0, obj) {
        $("#form").data('bootstrapValidator').updateStatus('ip1',
            'NOT_VALIDATED', null).validateField('ip1');

        if (obj.value > 255) {
            obj.value = obj.value.substring(0, obj.value.length - 1);
            return;
        }
        if (code == 8 && obj.value.length == 0) {
            obj0.focus();
            setCursor(obj0, obj0.value.length);
        }
        if (code == 37 && (getPos(obj) == 0)) {
            obj0.focus();
            setCursor(obj0, obj0.value.length);
        }
    }

    function getPos(obj) {
        obj.focus();
        var workRange = document.selection.createRange();
        obj.select();
        var allRange = document.selection.createRange();
        workRange.setEndPoint("StartToStart", allRange);
        var len = workRange.text.length;
        workRange.collapse(false);
        workRange.select();
        return len;
    }

    function setCursor(obj, num) {
        range = obj.createTextRange();
        range.collapse(true);
        range.moveStart('character', num);
        range.select();
    }
    
    //测试连接
    function testConnection() {
        var ip=getIp();
        var reg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/
        var com=$("#com").val();
        if (!reg.test(ip)){
            toastr.warning("请输入正确格式的ip地址");
            return;
        }
        if(com=="" || com==null){
            toastr.warning("请输入端口号");
            return;
        }
        var deleteindex = layer.msg('正在测试连接，请稍候...', {icon: 16, time: false, shade: 0.8});
        $.ajax({
            url: '${base}/sys/rfid/testConnection',
            type: 'POST',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({'ip':ip,'com':com}),
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

</script>
</body>
</html>