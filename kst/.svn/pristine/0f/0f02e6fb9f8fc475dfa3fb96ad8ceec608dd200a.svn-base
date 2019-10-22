<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <title>考勤打卡</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
</head>
<body>


<div class="panel-body" style="padding-bottom:0px;align-items: center;">
    <div class="col-md-8 col-md-offset-4">
        <select id="location"  class="selectpicker">
            <#list locations as location >
                <option value="${location.id}" <#if location.id==3>selected</#if>>${location.locName}</option>
            </#list>
        </select>
        <button onclick="clockingIn('出勤')" class="btn btn-success">出勤</button>
        <button onclick="clockingIn('退勤')" class="btn btn-primary">退勤</button>
    </div>
</div>
<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
    });

    //打卡
    function clockingIn(type) {
        $.ajax({
            url:'${base}/att/attendance/clockIn',
            type:'post',
            data:{'id':$("#location").val()},
            success:function (ret) {
                if(ret.success){
                    toastr.success(type+"打卡成功")
                }else{
                    toastr.warning(type+"打卡失败")
                }
            },error:function () {
                toastr.warning(type+"打卡失败")
            }
        })
    }

</script>
</body>
</html>