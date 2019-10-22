<!DOCTYPE html>

<html>

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>答题页面</title>
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
        <div class="col-md-12" style="text-align: center;">
            <label style="align-items: center;font-size: 25px">${examParams.topic.name}</label>
        </div>
        <div id="questions" class="box-body">
            <#list examParams.questionTypeList as typeList >
                <#list examParams.topic.questionTypes?split(",") as type >
                    <#if typeList.value==type >
                        <table class='table table-striped'>
                            <thead>
                            <tr>
                                <th>
                                    <label style='font-size:18px;'>
                                        <#if type_index==0 >
                                            一、
                                        <#elseif type_index==1 >
                                            二、
                                        <#elseif type_index==2 >
                                            三、
                                        </#if>${typeList.label}
                                    </label>
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list examParams.questions as question>
                                <#if question.type==type>
                                    <tr>
                                        <td><label style='font-size:15px;'>${question_index+1}.${question.name}</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <#list question.questionItems as items>
                                                <#if question.type==1>
                                                    <input type='radio' name='${question.id}'
                                                           value='${items.value}'>&nbsp;${items.value}、${items.name}
                                                    <br/>
                                                <#elseif question.type==2>
                                                    <input type='checkbox' name='${question.id}'
                                                           value='${items.value}'>&nbsp;${items.value}、${items.name}
                                                    <br/>
                                                </#if>
                                            </#list>
                                            <#if question.type==3>
                                                <input type='radio' name='${question.id}' value='对'>&nbsp;对<br/><input
                                                    type='radio' name='${question.id}' value='错'>&nbsp;错
                                            </#if>
                                        </td>
                                    </tr>
                                </#if>
                            </#list>
                        </table><br>
                    </#if>
                </#list>
            </#list>
        </div>

        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
    </form>
</div>


<script type="text/javascript">
</script>
</body>
</html>