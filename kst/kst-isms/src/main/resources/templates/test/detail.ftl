<!DOCTYPE html>

<html>

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>考卷设置</title>
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
            height: 60px;
        }

        table tr td {
            padding: 0px 10px 0px 10px;
            width: 120px;
        }
    </style>
</head>
<body>

<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">

        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label">考试名称</label>
                <div class="col-sm-6">
                    <input type="text" id="name" name="name" class="form-control" value="${testParams.topic.name}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">考试类型</label>
                <div class="col-sm-6" style="height: 30px">
                    <select name="isms_test_type" id="isms_test_type" class="selectpicker" title="请选择"
                            data-width="150px">
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">考试题型</label>
                <#if testParams.topic==null>
                    <#list testParams.types as type >
                        <div class="col-sm-2">
                            <input type="checkbox" name="questionType[]" value="${type.value}"
                                   checked> ${type.label}
                        </div>
                    </#list>
                <#else>
                    <#list testParams.types as type >
                        <div class="col-sm-2">
                            <input type="checkbox" name="questionType[]" value="${type.value}"
                                    <#list testParams.topic.questionTypes?split(",") as t>
                                        <#if t==type.value >checked</#if>
                                    </#list>
                            > ${type.label}
                        </div>
                    </#list>
                </#if>
            </div>
            <div id="formCount" class="form-group">
                <label class="col-sm-2 control-label" for="email">考题数量</label>
                <#list testParams.types as type >
                    <div class="col-sm-2">
                        <input type="test" id="num${type.value}" name="num${type.value}" class="form-control"
                               oninput="value=value.replace(/^(0+)|[^\d]+/g,'')">
                    </div>
                </#list>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="email">考题分数</label>
                <#list testParams.types as type >
                    <div class="col-sm-2">
                        <input type="text" id="score${type.value}" name="score${type.value}" class="form-control"
                               oninput="value=value.replace(/^(0+)|[^\d]+/g,'')">
                    </div>
                </#list>
            </div>
            <div class="form-group ">
                <label class="col-sm-2 control-label" for="email">合格分</label>
                <div class="col-sm-3" id="trueAnswerList">
                    <input type="text" id="qualifiedScore" name="qualifiedScore"
                           value="${testParams.topic.qualifiedScore}" oninput="value=value.replace(/[^\d]/g,'')"
                           class="form-control ">
                </div>
            </div>
        </div>

        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none;"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
    </form>
</div>

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
<script type="text/javascript">
    $(function () {
        if (parent.$("#editType").val() == 2) {
            editLoadForm();
        } else {
            <#list testParams.types as type >
            $("#num${type.value}").val(1)
            $("#score${type.value}").val(1)
            </#list>
        }
        toastr.options.positionClass = 'toast-center-center';
        selectFileType("isms_test_type");

        //循环考题类型，可用或不可用
        $("[name='questionType[]']").each(function () {
            var numName = "num" + $(this).val();
            var scoreName = "score" + $(this).val();
            if ($(this).is(":checked")) {
                $("#" + numName).attr("disabled", false);
                $("#" + scoreName).attr("disabled", false);
            } else {
                $("#" + numName).attr("disabled", true);
                $("#" + scoreName).attr("disabled", true);
            }
        })
        formValidator();
    });

    function selectFileType(type) {
        $.ajax({
            url: '${base}/isms/test/selectFileType',
            type: 'post',
            data: {'type': type},
            success: function (data) {
                var options = "";
                for (var i = 0; i < data.length; i++) {
                    var isSelected = "";
                    if ("${testParams.topic.type}" == data[i].value) {
                        isSelected = "selected"
                    }
                    options += "<option value='" + data[i].value + "'" + isSelected + ">" + data[i].label + "</option>";
                }
                $("[name=" + type + "]").append(options);
                $("[name=" + type + "]").selectpicker('refresh');
                $("[name=" + type + "]").selectpicker('render');

            }, error: function () {
                alert("error：" + type)
            }
        });
    }

    //修改时加载数据
    function editLoadForm() {
        var hasTypes = "${testParams.topic.questionTypes}".split(",");
        ;
        var questionAmounts = "${testParams.topic.questionAmounts}".split(",");
        var qualifiedScore = "${testParams.topic.questionScores}".split(",");

        var array = new Array();
        <#list testParams.types as type >
        <#list testParams.topic.questionTypes?split(",") as ty >
        <#if (type.value==ty)>
        $("#num${type.value}").val(questionAmounts["${ty_index}"])
        $("#score${type.value}").val(qualifiedScore["${ty_index}"])
        </#if>
        </#list>
        </#list>

    }

    //在选择或取消选择考题类型时修改相应输入框的状态
    $("[name='questionType[]']").iCheck({
        checkboxClass: 'icheckbox_flat-green'
    }).on('ifChanged', function (event) {
        var feild = $(this)[0].name;
        $("#form").bootstrapValidator('revalidateField', feild);
        $("[name='questionType[]']").each(function () {
            var numName = "num" + $(this).val();
            var scoreName = "score" + $(this).val();
            if ($(this).is(":checked")) {
                if ($("#" + numName).attr("disabled") == 'disabled') {
                    if ($("#" + numName).val() == null || $("#" + numName).val() == "") {
                        //$("#" + numName).val(1)
                    }
                    if ($("#" + scoreName).val() == null || $("#" + scoreName).val() == "") {
                        //$("#" + scoreName).val(1)
                    }
                }
                $("#" + numName).removeAttr("disabled");
                $("#" + scoreName).removeAttr("disabled");
            } else {
                $("#" + numName).attr("disabled", true);
                $("#" + scoreName).attr("disabled", true);
            }
        })
        $("#form").data('bootstrapValidator').destroy();
        $('#form').data('bootstrapValidator', null);
        formValidator();

    });

    function formValidator() {
        $("#form").bootstrapValidator({
            message: "输入不合法",
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: '标题不能为空'
                        }
                    }
                },
                isms_test_type: {
                    validators: {
                        notEmpty: {
                            message: '考试类型不能为空'
                        }
                    }
                },
                'questionType[]': {
                    validators: {
                        notEmpty: {
                            message: '至少选择一种题目类型'
                        }
                    }
                },
                <#list testParams.types as type >
                'num${type.value}': {
                    validators: {
                        field: 'num${type.value}',
                        notEmpty: {
                            message: '不能为空'
                        },
                        greaterThan: {
                            value: 1,
                            message: '最小输入1'
                        }
                    }
                },
                </#list>
                <#list testParams.types as type >
                'score${type.value}': {
                    validators: {

                        notEmpty: {
                            field: 'score${type.value}',
                            message: '不能为空'
                        },
                        greaterThan: {
                            field: 'score${type.value}',
                            value: 1,
                            message: '最小输入1'
                        }
                    }
                },
                </#list>
                qualifiedScore: {
                    validators: {
                        notEmpty: {
                            message: '合格分不能为空'
                        },
                        digits: {
                            message: '请输入数字'
                        },
                        callback: {
                            message: "及格分不能超出总分",
                            callback: function (value, validator) {
                                var flag = true;
                                var sum = 0;
                                $("[name='questionType[]']").each(function () {
                                    if ($(this).is(":checked")) {
                                        sum += $("#score" + $(this).val()).val() * $("#num" + $(this).val()).val()
                                    }
                                })
                                if (sum < value) {
                                    flag = false;
                                }
                                return flag;
                            }
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
            //alert(bv.isValid())
            if (bv.isValid()) {
                var editType = parent.$("#editType").val();

                var questionAmounts = "";//问题数量
                var questionScores = "";//问题分数
                var questionTypes = "";//题型类型
                var questionCounts = "";//问题已选数量
                $("[name='questionType[]']:checked").each(function (i) {

                    if (i == 0) {
                        questionAmounts += $("#num" + $(this).val()).val();
                        questionScores += $("#score" + $(this).val()).val();
                        questionTypes += $(this).val();
                        questionCounts += "0"
                    } else {
                        questionAmounts += "," + $("#num" + $(this).val()).val();
                        questionScores += "," + $("#score" + $(this).val()).val();
                        questionTypes += "," + $(this).val();
                        questionCounts += ",0"
                    }
                })

                var updata = {
                    'name': $("[name='name']").val(),
                    'type': $("#isms_test_type").val(),
                    'questionTypes': questionTypes,
                    'questionScores': questionScores,
                    'questionAmounts': questionAmounts,
                    'questionCounts': questionCounts,
                    'qualifiedScore': $("#qualifiedScore").val()
                }
                if (editType == 1) {
                    $.ajax({
                        url: '${base}/isms/test/add',
                        type: 'post',
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(updata),
                        success: function (re) {
                            if (re.success) {
                                parent.$("#testTable").bootstrapTable("refresh");
                                parent.toastr.success("添加成功")
                            } else {
                                parent.toastr.error("添加失败")
                            }
                        },
                        error: function () {
                            parent.toastr.error("添加失败")
                        }
                    })
                } else {
                    updata.id = "${testParams.topic.id}"
                    $.ajax({
                        url: '${base}/isms/test/edit',
                        type: 'post',
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(updata),
                        success: function (re) {
                            if (re.success) {
                                parent.toastr.success("修改成功")
                            } else {
                                parent.toastr.error("修改失败")
                            }
                            parent.$("#testTable").bootstrapTable("refresh");
                        },
                        error: function () {
                            parent.toastr.error("修改失败")
                        }
                    })
                }
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            }
        });
    }

    $("[name='num1'],[name='num2'],[name='num3'],[name='score1'],[name='score2'],[name='score3']").on('input', function () {
        $("#form").data('bootstrapValidator').updateStatus('qualifiedScore', 'NOT_VALIDATED', null);
        $("#form").data('bootstrapValidator').validateField('qualifiedScore');
    })
</script>
</body>
</html>