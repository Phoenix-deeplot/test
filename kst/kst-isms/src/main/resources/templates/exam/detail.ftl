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
            <#if examParams.questions?size gt 0>
                <#list examParams.questionTypeList as typeList >
                    <#list examParams.topic.questionTypes?split(",") as type >
                        <#if typeList.value==type >
                            <table class='table table-striped'>
                                <#list examParams.questions as question>
                                    <#if question.type==type  >
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
                                                    <#list examParams.topic.questionScores?split(",") as score >
                                                        <#if score_index==type_index>
                                                            （每题${score}分）
                                                        </#if>
                                                    </#list>
                                                </label>
                                            </th>
                                        </tr>
                                        </thead>
                                        <#break>
                                    </#if>
                                </#list>
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
                                                        <input type='radio' name='${question.id}' id="${question.id}${items_index}"
                                                               value='${items.value}'>&nbsp;<label for="${question.id}${items_index}" >${items.value}、${items.name}</label>
                                                        <br/>
                                                    <#elseif question.type==2>
                                                        <input type='checkbox' name='${question.id}' id="${question.id}${items_index}"
                                                               value='${items.value}'>&nbsp;<label for="${question.id}${items_index}" >${items.value}、${items.name}</label>
                                                        <br/>
                                                    </#if>
                                                </#list>
                                                <#if question.type==3>
                                                    <input type='radio' name='${question.id}' id="${question.id}1" value='对'>&nbsp;<label for="${question.id}1">对</label><br/>
                                                    <input type='radio' name='${question.id}' id="${question.id}2" value='错'>&nbsp;<label for="${question.id}2">错</label>
                                                </#if>
                                            </td>
                                        </tr>
                                    </#if>
                                </#list>
                            </table><br>
                        </#if>
                    </#list>
                </#list>
            <#else>
                <div class="col-md-12" style="text-align: center;">
                    <label style="align-items: center;font-size: 25px">考试已完成所有考题</label>
                </div>
                <div class="col-md-12" >
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
                                                        <#list examParams.topic.questionScores?split(",") as score >
                                                            <#if score_index==type_index>
                                                                （每题${score}分）
                                                            </#if>
                                                        </#list>
                                                    </label>
                                                </th>
                                            </tr>
                                            </thead>
                                    <tbody>
                                    <#list examParams.finishQuestions as question>
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
                                                                   <#if question.answer==items.value>checked</#if>
                                                                   value='${items.value}'>&nbsp;${items.value}、${items.name}
                                                            <br/>
                                                        <#elseif question.type==2>
                                                            <input type='checkbox' name='${question.id}'
                                                                   <#list question.answer?split(",") as an>
                                                                       <#if an==items.value>checked</#if>
                                                                   </#list>
                                                                   value='${items.value}'>&nbsp;${items.value}、${items.name}
                                                            <br/>
                                                        </#if>
                                                    </#list>
                                                    <#if question.type==3>
                                                        <input type='radio' name='${question.id}'<#if question.answer=='对'>checked</#if> value='对'>&nbsp;对<br/><input
                                                            type='radio' name='${question.id}' <#if question.answer=='错'>checked</#if> value='错'>&nbsp;错
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
            </#if>
        </div>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
    </form>
</div>


<script type="text/javascript">
    $(function () {
        <#if examParams.questions?size gt 0>
            if(!"${examParams.topic.firstFlag}"){
                layer.alert("这不是你的第一次考试，题目为上一次考试答错的题目组成！")
            }else{
                layer.alert("这是你的第一次考试，请好好作答！")
            }
        <#else>

        </#if>
    });


    //提交
    function submit() {
        <#if examParams.questions?size gt 0>
            var mess='确定要提交考卷吗？';
            var answers = [];
            var questionScores = "${examParams.topic.questionScores}".split(",");
            var examQuestions=[];
            var userTest = {
                'topicId': "${examParams.topic.id}",
                'userId': "${currentUser.id}",
            }
            var score = 0;
            //循环题目
            <#list examParams.questions as question>
            var answer = "";
            $("[name='${question.id}']:checked").each(function (index, element) {
                if (index == 0) {
                    answer += $(this).val();
                } else {
                    answer += "," + $(this).val();
                }
            });

            var question={
                'id':'${question.id}',
                'name':'${question.name}',
                'category':'${question.name}',
                'type':'${question.type}',
                'answer':'${question.answer}',
            }
            examQuestions.push(question);

            if(answer==""){
                mess="有未完成的考题，确定要提交考卷吗？"
            }
            //保存答案
            answers.push(answer)

            </#list>
            layer.confirm(mess, {icon: 3, title: '提示'}, function (index1) {
                layer.close(index1)

                $.ajax({
                    url:'${base}/isms/exam/submitExam',
                    type:'post',
                    data:{'userTest':JSON.stringify(userTest),'answers':answers.join(":"),'examQuestions':JSON.stringify(examQuestions)},
                    success:function (re) {
                        if(re.success){
                            parent.$("#examTable").bootstrapTable("refresh");
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.toastr.success("提交成功！")
                        }else{
                            toastr.error("提交失败");
                        }
                    },error:function () {

                    }
                })
            });
        <#else>
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        </#if>
    }

</script>
</body>
</html>