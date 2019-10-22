<!DOCTYPE html>

<html>

<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>项目进度登记</title>
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
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">


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
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>


<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">
        <input hidden="hidden" id="id" name="id" value="${schDetail.id}"/>
        <input hidden="hidden" id="pjId" name="pjId" value="${schDetail.pjId}"/>
        <input hidden="hidden" id="workGroup" name="workGroup" value="${schDetail.workGroup}"/>

        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workNo">作业编号</label>
                <div class="col-sm-5">
                    <input type="text" id="workNo" name="workNo" class="form-control"
                           placeholder="请输入作业编号" value="${schDetail.workNo}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workName">作业名称</label>
                <div class="col-sm-5">
                    <input type="text" id="workName" name="workName" class="form-control" rows="2"
                           placeholder="请输入作业名称" value="${schDetail.workName}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workName">作业类型</label>
                <div class="col-sm-5">
                    <input type="checkbox" id="workType" name="workType"
                           <#if schDetail.workType==2 >checked</#if>
                           class="flat-red"/>
                    <#--<select id="workType" name="workType" class="selectpicker" title="请选择">-->
                    <#--<option <#if schDetail.workType==1 >selected="selected"</#if> value="1">项目工作</option>-->
                    <#--<option <#if schDetail.workType==2 >selected="selected"</#if> value="2">相关工作</option>-->
                    <#--</select>-->
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-1 col-sm-offset-1 control-label" for="workBKindId">大分类</label>
                <div class="col-sm-2" style="height: 30px">
                    <select name="workBKindId" id="workBKindId" class="selectpicker" title="请选择"
                            data-width="150px">
                        <option value="">请选择</option>
                        <#list workKind as kind>
                            <#if kind.kindFlg=='B' >
                                <option <#if schDetail.workBKindId==kind.kindId >selected="selected"</#if>
                                        value="${kind.kindId}">${kind.kindName}</option>
                            </#if>
                        </#list>
                    </select>
                </div>
                <label class="col-sm-1 control-label" for="workMKindId">中分类</label>
                <div class="col-sm-2" style="height: 30px">
                    <select name="workMKindId" id="workMKindId" class="selectpicker" title="请选择"
                            data-width="150px">
                        <option value="">请选择</option>
                        <#list workKind as kind>
                            <#if kind.kindFlg=='M' >
                                <option <#if schDetail.workMKindId==kind.kindId >selected="selected"</#if>
                                        value="${kind.kindId}">${kind.kindName}</option>
                            </#if>
                        </#list>
                    </select>
                </div>
                <label class="col-sm-1 control-label" for="workSKindId">小分类</label>
                <div class="col-sm-2" style="height: 30px">
                    <select name="workSKindId" id="workSKindId" class="selectpicker" title="请选择"
                            data-width="150px">
                        <option value="">请选择</option>
                        <#list workKind as kind>
                            <#if kind.kindFlg=='S' >
                                <option <#if schDetail.workSKindId==kind.kindId >selected="selected"</#if>
                                        value="${kind.kindId}">${kind.kindName}</option>
                            </#if>
                        </#list>
                    </select>
                </div>
            </div>
            <#--<div class="form-group">-->
            <#---->
            <#--</div>-->
            <#--<div class="form-group">-->
            <#---->
            <#--</div>-->
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workPlanFrom">预定开始日</label>
                <div class="col-sm-8">
                    <div id="workPlanFrom" name="workPlanFrom" class="input-group date form_date col-md-6" data-date=""
                         data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                         data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text" readonly
                               value="<#if schDetail.workPlanFrom??>${schDetail.workPlanFrom?string('yyyy-MM-dd')}</#if>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workPlanTo">预定结束日</label>
                <div class="col-sm-8">
                    <div id="workPlanTo" name="workPlanTo" class="input-group date form_date col-md-6" data-date=""
                         data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                         data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text" readonly
                               value="<#if schDetail.workPlanTo??>${schDetail.workPlanTo?string('yyyy-MM-dd')}</#if>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workPlanNickName">预定担当者</label>
                <div class="col-sm-4">
                    <input type="text" id="workPlanUserName" name="workPlanUserName" class="form-control"
                           value="${schDetail.workPlanUserName}" readonly/>
                    <input type="text" id="workPlanUser" name="workPlanUser" value="${schDetail.workPlanUser}" hidden/>
                </div>
                <input type="button" onclick="openModel('Plan')" class="btn btn-primary" value="选择">
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workPlanTimes">预定工时总数</label>
                <div class="col-sm-5">
                    <input type="text" id="workPlanTimes" name="workPlanTimes" class="form-control"
                           placeholder="请输入预定工时总数" value="${schDetail.workPlanTimes}"
                           oninput="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workFactFrom">实际开始日</label>
                <div class="col-sm-8">
                    <div id="workFactFrom" name="workFactFrom" class="input-group date form_date col-md-6" data-date=""
                         data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                         data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text" readonly
                               value="<#if schDetail.workFactFrom??>${schDetail.workFactFrom?string('yyyy-MM-dd')}</#if>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workFactTo">实际结束日</label>
                <div class="col-sm-8">
                    <div id="workFactTo" name="workFactTo" class="input-group date form_date col-md-6" data-date=""
                         data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                         data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text" readonly
                               value="<#if schDetail.workFactTo??>${schDetail.workFactTo?string('yyyy-MM-dd')}</#if>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workFactUserName">实际担当者</label>
                <div class="col-sm-4">
                    <input type="text" id="workFactUserName" name="workFactUserName" class="form-control"
                           value="${schDetail.workFactUserName}" readonly/>
                    <input type="text" id="workFactUser" name="workFactUser" value="${schDetail.workFactUser}" hidden/>
                </div>
                <input type="button" onclick="openModel('Fact')" class="btn btn-primary" value="选择">
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workFactTimes">实际工时总数</label>
                <div class="col-sm-2">
                    <input type="text" id="workFactTimes" name="workFactTimes" class="form-control"
                           placeholder="请输入实际工时总数" oninput="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"
                           value="${schDetail.workFactTimes}">
                </div>
                <label class="control-label">小时</label>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workFinishPer">实际完成比例</label>
                <div class="col-sm-2">
                    <input type="text" id="workFinishPer" name="workFinishPer" class="form-control"
                           value="${schDetail.workFinishPer}" placeholder="请输入实际完成比例"
                           oninput="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')">
                </div>
                <label class="control-label">%</label>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="workMemo">补充说明</label>
                <div class="col-sm-6">
                    <textarea id="workMemo" name="workMemo" class="form-control"
                              rows="3">${schDetail.workMemo}</textarea>
                </div>
            </div>
            <div class="form-group" id="userDiv">
                <div id="userTool">
                    <input type="button" onclick="openModel2()" class="btn btn-info" value="添加"/>
                    <input type="button" onclick="removeUserTable()" class="btn btn-danger" value="删除"/>
                </div>
                <div class="col-sm-6 col-sm-offset-2">
                    <table id="usersTable" class="table table-condensed"></table>
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
<div class="modal inmodal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">选择用户</h4>
            </div>
            <div class="modal-body">
                <table id="choiceUsers" class="table table-condensed"></table>
            </div>
            <div class="modal-footer">
                <button id="closeBtn" type="button" class="btn btn-primary">确认</button>
                <button id="resetBtn" type="button" class="btn btn-default">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal inmodal fade" id="myModal2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">选择用户</h4>
            </div>
            <div class="modal-body">
                <table id="choiceUsers2" class="table table-condensed"></table>
            </div>
            <div class="modal-footer">
                <button id="closeBtn2" type="button" class="btn btn-primary">确认</button>
                <button id="resetBtn2" type="button" class="btn btn-default">取消</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        initBootstrapSwitch();
        formValidator();
        InitUsersTable();
        if (!$("#workType")[0].checked) {
            $("#userDiv").hide();
        }
        var id = $("#id").val();
        // if (undefined !== id && null != id && '' != id) {
        //     //修改
        //     $('#form').data("bootstrapValidator").enableFieldValidators("workNo", false, "remote");
        // }

    });

    $('.form_date').datetimepicker({
        language: 'zh-CN',
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
        var id = $("#id").val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $("#form").bootstrapValidator({
            message: "输入不合法",
            fields: {
                workNo: {
                    validators: {
                        notEmpty: {
                            message: '作业编号不能为空'
                        },
                        remote: {
                        url: '${base}/pjs/schDetail/checkInteriorNoIsExist',//验证地址
                        message: '该分类的作业编号已存在',//提示消息
                        delay: 1000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                        type: 'POST',//请求方式
                        data: {
                            workNo :function (){return $("#workNo").val()},
                            workBKindId:function (){return $("#workBKindId").val()},
                            workMKindId:function (){return $("#workMKindId").val()},
                            workSKindId:function (){return $("#workSKindId").val()},
                            pjId: function (){return $("#pjId").val()},
                            mode:mode,
                            id: function (){return $("#id").val()}
                        }
                        }
                    }
                },
                workName: {
                    validators: {
                        notEmpty: {
                            message: '作业名不能为空'
                        }
                    }
                },
                workPlanFrom: {
                    trigger: 'change',
                    message: '预定开始时间不合法',
                    validators: {
                        callback: {
                            message: '预定开始时间不能在预定结束时间之后',
                            callback: function (value, validator) {
                                var planFrom = $("#workPlanFrom").find("input").val() != "" ? $("#workPlanFrom").data("datetimepicker").getDate() : null;
                                var planTo = $("#workPlanTo").find("input").val() != "" ? $("#workPlanTo").data("datetimepicker").getDate() : null;
                                if (planFrom == null) {
                                    $('#form').bootstrapValidator('updateMessage', 'workPlanFrom', 'callback', '预定结束时间不能为空');
                                    return false;
                                } else {
                                    $('#form').bootstrapValidator('updateMessage', 'workPlanFrom', 'callback', '预定开始时间不能在预定结束时间之后');
                                    if ((planFrom != null && planTo == null) || (planFrom == null && planTo != null)) {
                                        return false;
                                    } else if (planFrom != null && planTo != null) {
                                        return planFrom.getTime() <= planTo.getTime();
                                    }
                                }
                                return true;
                            }
                        }
                    }
                },
                workPlanTo: {
                    trigger: 'change',
                    message: '预定结束时间不合法',
                    validators: {
                        callback: {
                            message: '预定结束时间不能在预定开始时间之前',
                            callback: function (value, validator) {
                                var planFrom = $("#workPlanFrom").find("input").val() != "" ? $("#workPlanFrom").data("datetimepicker").getDate() : null;
                                var planTo = $("#workPlanTo").find("input").val() != "" ? $("#workPlanTo").data("datetimepicker").getDate() : null;
                                if (planTo == null) {
                                    $('#form').bootstrapValidator('updateMessage', 'workPlanTo', 'callback', '预定结束时间不能为空');
                                    return false;
                                } else {
                                    $('#form').bootstrapValidator('updateMessage', 'workPlanTo', 'callback', '预定结束时间不能在预定开始时间之前');
                                    if ((planFrom != null && planTo == null) || (planFrom == null && planTo != null)) {
                                        return false;
                                    } else if (planFrom != null && planTo != null) {
                                        return planFrom.getTime() <= planTo.getTime();
                                    }
                                }
                                return true;
                            }
                        }
                    }
                },
                workPlanTimes: {
                    validators: {
                        lessThan: {
                            value: 1000000,
                            message: '超出范围'
                        },
                        regexp: {
                            regexp: /^(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,
                            message: '请输入合法的参数'
                        },
                    }
                },
                workFactFrom: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '实际开始时间不能在实际结束时间之后',
                            callback: function (value, validator) {
                                var factFrom = $("#workFactFrom").find("input").val() != "" ? $("#workFactFrom").data("datetimepicker").getDate() : null;
                                var factTo = $("#workFactTo").find("input").val() != "" ? $("#workFactTo").data("datetimepicker").getDate() : null;
                                if (factFrom != null && factTo != null) {
                                    return factFrom.getTime() <= factTo.getTime();
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                workFactTo: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '实际结束时间不能在实际开始时间之前',
                            callback: function (value, validator) {
                                var factFrom = $("#workFactFrom").find("input").val() != "" ? $("#workFactFrom").data("datetimepicker").getDate() : null;
                                var factTo = $("#workFactTo").find("input").val() != "" ? $("#workFactTo").data("datetimepicker").getDate() : null;
                                if (factFrom != null && factTo != null) {
                                    return factFrom.getTime() <= factTo.getTime();
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                workFactTimes: {
                    validators: {
                        lessThan: {
                            value: 1000000,
                            message: '超出范围'
                        },
                        regexp: {
                            regexp: /^(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,
                            message: '请输入合法的参数'
                        },
                    }
                },
                workFinishPer: {
                    validators: {
                        lessThan: {
                            value: 100,
                            message: '超出范围'
                        },
                        regexp: {
                            regexp: /^(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,
                            message: '请输入合法的参数'
                        },
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

                var url = "";
                var check=true;
                if (1 == mode) {
                    url = "${base}/pjs/schDetail/add";
                    var interiorNo=$("#workNo").val()+$("#workBKindId").val()+$("#workMKindId").val()+$("#workSKindId").val();
                    $.ajax({
                        url: '${base}/pjs/schDetail/checkInteriorNoIsExist',//验证地址
                        type: 'POST',//请求方式
                        data: {'interiorNo':interiorNo},
                        async:false,
                        success:function (ret) {
                            if(!ret.valid){
                                toastr.warning("该分类的作业编号已存在");
                                check=false;
                            }
                        }
                    })
                } else {
                    url = "${base}/pjs/schDetail/edit";
                }
                //如果编号判断失败，则跳过接下来的代码
                if(!check){
                    return;
                }

                var workType = 1;
                if ($("#workType")[0].checked) {
                    workType = 2
                }


                var formData = {
                    'id': $("#id").val(),
                    'pjId': $("#pjId").val(),
                    'interiorNo':interiorNo,
                    'workNo': $("#workNo").val(),
                    'workName': $("#workName").val(),
                    'workType': workType,
                    'workBKindId': $('#workBKindId').val(),
                    'workMKindId': $("#workMKindId").val(),
                    'workSKindId': $("#workSKindId").val(),
                    'workPlanFrom': $("#workPlanFrom").find("input").val() != "" ? timeStampExchange($("#workPlanFrom").data("datetimepicker").getDate()) : null,
                    'workPlanTo': $("#workPlanTo").find("input").val() != "" ? timeStampExchange($("#workPlanTo").data("datetimepicker").getDate()) : null,
                    'workPlanUser': $("#workPlanUser").val(),
                    'workPlanTimes': $("#workPlanTimes").val(),
                    'workFactFrom': $("#workFactFrom").find("input").val() != "" ? timeStampExchange($("#workFactFrom").data("datetimepicker").getDate()) : null,
                    'workFactTo': $("#workFactTo").find("input").val() != "" ? timeStampExchange($("#workFactTo").data("datetimepicker").getDate()) : null,
                    'workFactUser': $("#workFactUser").val(),
                    'workFactTimes': $("#workFactTimes").val(),
                    'workFinishPer': $("#workFinishPer").val(),
                    'workMemo': $("#workMemo").val()
                }
                var rows = $("#usersTable").bootstrapTable("getData");

                if (($("#workGroup").val() == null || $("#workGroup").val() == "") && rows.length > 0 && $("#workType")[0].checked) {
                    var users = [];
                    rows.forEach(function (r) {
                        users.push(r.id);
                    })
                    formData.users = users.join(",");
                }

                $.ajax({
                    url: url,
                    type: 'POST',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(formData),
                    success: function () {
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.$("#handle").attr("value", mode);
                        parent.layer.close(index);
                        parent.$("#schDetailTable").bootstrapTable("refresh");
                    }, error: function () {
                        alert("错误")
                    }
                });
            }
        });
    }

    function loadChoiceUsers() {
        $("#choiceUsers").bootstrapTable({
            url: '${base}/pjs/projectGroup/selectProjectUser',         //请求后台的URL（*）ams:apply:list
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                var searchParams = {};
                searchParams["pjId"]=$("#pjId").val();
                searchParams["startNo"]=(params.pageNumber - 1) * params.pageSize;
                var sorts = {};
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            singleSelect: true,
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#choiceUsers').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#choiceUsers').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'loginName',
                title: '用户名'
            }, {
                field: 'nickName',
                title: '昵称'
            },
            ]
        });
    }

    function loadChoiceUsers2() {
        $("#choiceUsers2").bootstrapTable({
            url: '${base}/pjs/projectGroup/selectProjectUser',         //请求后台的URL（*）ams:apply:list
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                var searchParams = {};
                var sorts = {};
                searchParams["pjId"]=$("#pjId").val();
                searchParams["startNo"]=(params.pageNumber - 1) * params.pageSize;
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#choiceUsers2').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#choiceUsers2').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'loginName',
                title: '用户名'
            }, {
                field: 'nickName',
                title: '昵称'
            },
            ]
        });
    }

    var userType = "";

    function openModel(type) {
        $('#myModal').modal('show');
        userType = type;
        loadChoiceUsers();
    }

    $("#closeBtn").click(function () {
        var rows = $("#choiceUsers").bootstrapTable("getSelections");

        if (rows.length > 0) {
            $("#work" + userType + "User").val(rows[0].loginName);
            $("#work" + userType + "UserName").val(rows[0].nickName).change();
        }
        $('#myModal').modal('hide');
    });

    $("#resetBtn").click(function () {
        $("#work" + userType + "User").val(null);
        $("#work" + userType + "UserName").val(null).change();
        $('#myModal').modal('hide');
    });

    function openModel2(type) {
        $('#myModal2').modal('show');
        loadChoiceUsers2();
    }

    $("#closeBtn2").click(function () {
        var rows = $("#choiceUsers2").bootstrapTable("getSelections");

        var users = [];
        var workGroup = $("#workGroup").val();
        rows.forEach(function (r) {
            var rs = $("#usersTable").bootstrapTable("getData");
            var check = true;
            rs.forEach(function (r2) {
                if (r.id == r2.id) {
                    check = false;
                }
            });
            if (check) {
                if (workGroup != null && workGroup != "") {
                    users.push({'organizationId': workGroup, 'id': r.id})
                } else {
                    $('#usersTable').bootstrapTable('insertRow', {
                        index: rs.length, row: {
                            'id': r.id,
                            'loginName': r.loginName,
                            'nickName': r.nickName
                        }
                    });
                }
            }
        });

        if (workGroup != null && workGroup != "") {
            $.ajax({
                url: '${base}/pjs/userGroup/addUserToUserGroup',
                type: 'post',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(users),
                success: function () {
                    $("#usersTable").bootstrapTable('refresh');
                }
            });
        }
        $('#myModal2').modal('hide');
    });

    $("#resetBtn2").click(function () {
        $('#myModal2').modal('hide');
    });

    //移除用户
    function removeUserTable() {
        var workGroup = $("#workGroup").val();
        var rows = $("#usersTable").bootstrapTable("getSelections");
        if (workGroup != null && workGroup != "") {
            if (rows.length > 0) {
                var users = []
                for (var i = 0; i < rows.length; i++) {
                    users[i] = {'userId': rows[i].id, 'userGroupId': workGroup}
                }

                $.ajax({
                    url: '${base}/pjs/userGroup/deleteSomeUser',
                    type: 'post',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(users),
                    success: function (ret) {
                        $("#usersTable").bootstrapTable("refresh");
                    }
                });
            }
        } else {
            rows.forEach(function (r, index) {
                $("#usersTable").bootstrapTable('remove', {
                    field: 'id',
                    values: rows[index].id
                })
            });
        }
    }

    $("#workPlanTo").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('workPlanFrom',
            'NOT_VALIDATED', null).validateField('workPlanFrom');
    });

    $("#workPlanFrom").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('workPlanTo',
            'NOT_VALIDATED', null).validateField('workPlanTo');
    });

    $("#workFactTo").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('workFactFrom',
            'NOT_VALIDATED', null).validateField('workFactFrom');
    });

    $("#workFactFrom").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('workFactTo',
            'NOT_VALIDATED', null).validateField('workFactTo');
    });

    $("#workBKindId,#workMKindId,#workSKindId").on("change",function () {
        $('#form').data('bootstrapValidator').updateStatus('workNo',
            'NOT_VALIDATED', null).validateField('workNo');
    })

    //加载用户
    function InitUsersTable() {
        $("#usersTable").bootstrapTable({
            url: '${base}/pjs/userGroup/loadUser',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            queryParams: function (params) {
                var searchParams = {};
                var workGroup = $("#workGroup").val();
                if (workGroup != null && workGroup != "") {
                    searchParams["id"] = workGroup;
                } else {
                    searchParams["id"] = 0;
                }
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            toolbar: '#userTool',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            formatNoMatches: function () {
                return "请选择相关用户";
            },
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#usersTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#usersTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'loginName',
                title: '用户名'
            }, {
                field: 'nickName',
                title: '昵称'
            },
            ]
        });
    }

    function initBootstrapSwitch() {
        //有则销毁（Destroy）
        $('input[name="workType"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="workType"]').bootstrapSwitch({
            onText: "其他工作",      // 设置ON文本
            offText: "项目工作",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "50"//设置控件宽度
        });

        $('input[name="workType"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                console.log('其他工作');
                $("#userDiv").show();
                $(this).val(false);
            } else {
                console.log('项目工作');
                $("#userDiv").hide();
                $(this).val(true);

            }
        });
    }

    //日期格式转换
    function timeStampExchange(time) {
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0"
            + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
            : datetime.getDate();
        var hour = datetime.getHours() < 10 ? "0" + datetime.getHours()
            : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes()
            : datetime.getMinutes();
        var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds()
            : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute
            + ":" + second;
    }

</script>
</body>
</html>