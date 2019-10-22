<!DOCTYPE html>

<html>

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>考卷管理</title>
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
    <link rel="stylesheet" href="${base}/static/plugins/spinner/bootstrap-spinner.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <style>
        label{
            padding-right: 20px;
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

<script src="${base}/static/plugins/spinner/jquery.spinner.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/layer/layer.js"></script>


<div class="box box-info" style="margin-bottom:0px;">

    <div class="box-body">
        <div class="form-group">
            <div class="col-sm-12" style="text-align: center;">
                <label style="font-size: 25px;">${finishDetail.topic.name}</label><br>
                <label>满分：${finishDetail.sum}</label>
                <#list finishDetail.topic.finishDegree?split("/") as degree>
                    <#if degree_index==0>

                        <label>已考人数：${degree}</label>
                    <#elseif degree_index==1>
                        <label>参考人数：${degree}</label>
                    </#if>
                </#list>
            </div>
        </div>
        <table class='table table-striped' style="text-align: center;">
            <tr>
                <td width="5%">NO</td>
                <td width="15%">部门</td>
                <td width="10%">姓名</td>
                <td width="45%">答题记录</td>
            </tr>
            <#list finishDetail.users as user >
                <tr>
                    <td>${user_index+1}</td>
                    <td>${user.organizationName}</td>
                    <td>${user.nickName}</td>
                    <td>
                        <#list finishDetail.userTests as userTest >
                            <#if userTest.userId==user.id>
                                <label>分数：
                                    <#if userTest.score<finishDetail.topic.qualifiedScore >
                                        <label style="color:red;">${userTest.score}</label>
                                    <#else>
                                        <label style="color:#449d44;">${userTest.score}</label>
                                    </#if>
                                </label>
                                &nbsp;&nbsp;&nbsp;
                                <label>
                                    完成时间：${userTest.createDate?string("yyyy-MM-dd hh:mm:ss")}
                                </label><br>
                            </#if>
                        </#list>
                    </td>
                </tr>
            </#list>
        </table>
    </div>
</div>
</body>
</html>