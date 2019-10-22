<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width"/>
    <title>资产信息管理详情</title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
    <style type="text/css">

        .ztree li span.button.add {
            margin-right: 2px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle
        }

        .form-group {
            height: 55px;
        }
    </style>

</head>
<body>
<ul id="myTab" class="nav nav-tabs" role="tablist">
    <li class="active"><a href="#main" role="tab" data-toggle="tab">主信息</a></li>
    <li><a href="#pjFactInfo" role="tab" data-toggle="tab">详细信息</a></li>
    <li><a href="#kind" role="tab" data-toggle="tab">分类</a></li>
    <li><a href="#pjUser" role="tab" data-toggle="tab">体制</a></li>
</ul>

<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">
        <input type="hidden" id="id" name="id" value="${main.id}"/>
        <input type="hidden" name="factInfoId" value="${factInfo.id}"/>
        <input type="hidden" id="userGroupId" name="userGroupId" value="${factInfo.userGroupId}"/>
        <div class="box-body">

            <!--tab页内容区分-------------------------------------->
            <div id="myTabContent" class="tab-content">
                <!--tab页内容区分-----------------主要信息--------------------->
                <div class="tab-pane active" id="main">

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="companyNo">公司编号</label>
                        <div class="col-sm-5">
                            <input type="text" id="companyNo" name="companyNo" class="form-control"
                                   placeholder="请输入公司编号" value="${main.companyNo}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="name">项目名称</label>
                        <div class="col-sm-5">
                            <input type="text" id="name" name="name" class="form-control"
                                   placeholder="请输入项目名称" value="${main.name}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="nameS">项目略称</label>
                        <div class="col-sm-5">
                            <input type="text" id="nameS" name="nameS" class="form-control"
                                   placeholder="请输入项目略称" value="${main.nameS}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="planFrom">预定开始日</label>
                        <div class="col-sm-10">
                            <div id="planFrom" name="planFrom" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" readonly
                                       value="<#if main.planFrom??>${main.planFrom?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="planTo">预定结束日</label>
                        <div class="col-sm-10">
                            <div id="planTo" name="planTo" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" readonly
                                       value="<#if main.planTo??>${main.planTo?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="planTimeAll">预定工时总数</label>
                        <div class="col-sm-5">
                            <input type="text" id="planTimeAll" name="planTimeAll" class="form-control"
                                   placeholder="请输入预定工时总数" value="${main.planTimeAll}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="organizatonId">所属部门</label>
                        <div class="col-sm-5">
                            <input type="text" id="organizationName" name="organizationName" class="form-control"
                                   placeholder="请选择项目所属部门" value="${main.organizationName}" readonly>
                            <input type="hidden" id="organizationId" value="${main.organizationId}">
                        </div>
                        <input type="button" onclick="openOrganizationChoiceDig()" class="btn btn-primary" value="选择">
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="memo">补充说明</label>
                        <div class="col-sm-5">
                            <textarea id="memo" name="memo" class="form-control" placeholder="请输入补充说明" maxlength="1000" rows="5">${main.memo}</textarea>
                            <#--<input type="text" id="memo" name="memo" class="form-control"-->
                                   <#--placeholder="请输入补充说明" value="${main.memo}">-->
                        </div>
                    </div>
                </div>
                <!--tab页内容区分-----------------实际信息--------------------->
                <div class="tab-pane" id="pjFactInfo">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="factFrom">实际开始日</label>
                        <div class="col-sm-10">
                            <div id="factFrom" name="factFrom" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" readonly
                                       value="<#if factInfo.factFrom??>${factInfo.factFrom?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="factTo">实际结束日</label>
                        <div class="col-sm-10">
                            <div id="factTo" name="factTo" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" readonly
                                       value="<#if factInfo.factTo??>${factInfo.factTo?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="factTimeAll">实际工时总数</label>
                        <div class="col-sm-5">
                            <input type="text" id="factTimeAll" name="factTimeAll" class="form-control"
                                   placeholder="请输入实际工时总数" value="${factInfo.factTimeAll}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="perMemo">进度记录标准</label>
                        <div class="col-sm-5">
                            <input type="text" id="perMemo" name="perMemo" class="form-control"
                                   placeholder="请输入进度记录标准" value="${factInfo.perMemo}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 90px">
                        <label class="col-sm-2 control-label" for="memo_info">补充说明</label>
                        <div class="col-sm-5">
                            <textarea id="memo_info" name="memo_info" class="form-control" placeholder="请输入补充说明" maxlength="1000" rows="5">${factInfo.memo}</textarea>
                            <#--<input type="text" id="memo_info" name="memo_info" class="form-control"-->
                                   <#--placeholder="请输入补充说明" value="${factInfo.memo}">-->
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="status">状态属性</label>
                        <div class="col-sm-5">
                            <select name="status" id="status" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <#if factInfo.status??>
                                    <#list status as type>
                                        <option value="${type.value}"
                                                <#if type.value==factInfo.status >selected="selected" </#if> >${type.label}</option>
                                    </#list>
                                <#else>
                                    <#list status as type>
                                        <option value="${type.value}"
                                                <#if type_index==0 >selected="selected" </#if> >${type.label}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                </div>
                <!--tab页内容区分-----------------分类--------------------->
                <div class="tab-pane " id="kind">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="kindId">分类编号</label>
                        <div class="col-sm-5">
                            <input type="text" id="kindId" name="kindId" class="form-control"
                                   placeholder="请输入两位数分类编号" maxlength="2" oninput="value=value.replace(/[^\d]/g,'')">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="kindFlg">分类区分</label>
                        <div class="col-sm-5">
                            <select name="kindFlg" id="kindFlg" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <#list kindFlg as type>
                                    <option value="${type.value}">${type.label}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="kindName">分类名称</label>
                        <div class="col-sm-5">
                            <input type="text" id="kindName" name="kindName" class="form-control"
                                   placeholder="请输入分类名称">
                        </div>
                    </div>
                    <div class="form-group" style="height: 60px">
                        <label class="col-sm-2 control-label" for="kindMemo">补充说明</label>
                        <div class="col-sm-5">
                            <textarea id="kindMemo" name="kindMemo" class="form-control" placeholder="请输入补充说明" rows="3" maxlength="1000"></textarea>
                        </div>
                    </div>
                    <div id="kindToolbar">
                        <input id="kindAdd" type="button" class="btn btn-primary" value="添加"/>
                        <input id="kindRemove" type="button" class="btn btn-danger" value="删除"/>
                    </div>
                    <div class="col-sm-10 col-sm-offset-1">
                        <table id="kindTable" class="table"></table>
                    </div>


                </div>
                <!--tab页内容区分-----------------体制（项目组成员）--------------------->
                <div class="tab-pane " id="pjUser">
                    <button type="button" id="addRootBtn" onclick="addRootNode();" class="btn btn-group-sm btn-primary"
                            role="dialog">
                        <span class="glyphicon glyphicon-plus"></span>添加根节点
                    </button>
                    <ul id="projectGroupTree" class="ztree">
                    </ul>
                </div>
            </div>
        </div>

        <div class="modal inmodal fade" id="organizationModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="organizationModal">选择部门</h4>
                    </div>
                    <div class="modal-body">
                        <ul id="organizationTree" class="ztree">
                        </ul>
                    </div>
                    <div class="modal-footer">
                        <button id="closeBtn1" type="button" class="btn btn-primary">确认</button>
                        <button id="resetBtn1" type="button" class="btn btn-default">清除</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
        <!-- /.box-footer -->
    </form>
</div>


<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>

<script>


    var delKind = [];
    var tempId="";
    $(document).ready(function () {
        tempId=new Date().getTime();
        formValidator();
        loadKindTable();
        loadKinds();
        loadGroupTree();
        organizationZtree();
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
        //初期化
        var id = $('[name="id"]').val();
        if (undefined !== id && null != id && '' != id) {

        } else {
            //新增
        }
    });

    //表单验证
    function formValidator() {
        var id = $('[name="id"]').val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }
        $('#form').bootstrapValidator({
            message: '输入值不合法',
            excluded: [":disabled"],
            fields: {
                name: {
                    message: '项目名称不合法',
                    validators: {
                        notEmpty: {
                            message: '项目名称不能为空'
                        }
                    }
                },
                nameS: {
                    message: '项目略称不合法',
                    validators: {
                        notEmpty: {
                            message: '项目略称不能为空'
                        }
                    }
                },
                planFrom: {
                    trigger: 'change',
                    message: '预定开始时间不合法',
                    validators: {
                        callback: {
                            message: '预定开始时间不能在预定结束时间之后',
                            callback: function (value, validator) {
                                var planFrom = $("#planFrom").find("input").val() != "" ? $("#planFrom").data("datetimepicker").getDate() : null;
                                var planTo = $("#planTo").find("input").val() != "" ? $("#planTo").data("datetimepicker").getDate() : null;
                                if (planFrom == null) {
                                    $('#form').bootstrapValidator('updateMessage', 'planFrom', 'callback', '预定结束时间不能为空');
                                    return false;
                                } else {
                                    $('#form').bootstrapValidator('updateMessage', 'planFrom', 'callback', '预定开始时间不能在预定结束时间之后');
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
                planTo: {
                    trigger: 'change',
                    message: '预定结束时间不合法',
                    validators: {
                        callback: {
                            message: '预定结束时间不能在预定开始时间之前',
                            callback: function (value, validator) {
                                var planFrom = $("#planFrom").find("input").val() != "" ? $("#planFrom").data("datetimepicker").getDate() : null;
                                var planTo = $("#planTo").find("input").val() != "" ? $("#planTo").data("datetimepicker").getDate() : null;
                                if (planTo == null) {
                                    $('#form').bootstrapValidator('updateMessage', 'planTo', 'callback', '预定结束时间不能为空');
                                    return false;
                                } else {
                                    $('#form').bootstrapValidator('updateMessage', 'planTo', 'callback', '预定结束时间不能在预定开始时间之前');
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
                planTimeAll: {
                    validators: {
                        lessThan: {
                            value: 1000000,
                            message: '超出范围'
                        },
                        regexp: {
                            regexp: /^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,
                            message: '请输入合法的参数'
                        },
                    }
                },
                factFrom: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '实际开始时间不能在实际结束时间之后',
                            callback: function (value, validator) {
                                var factFrom = $("#factFrom").find("input").val() != "" ? $("#factFrom").data("datetimepicker").getDate() : null;
                                var factTo = $("#factTo").find("input").val() != "" ? $("#factTo").data("datetimepicker").getDate() : null;
                                if (factFrom != null && factTo != null) {
                                    return factFrom.getTime() <= factTo.getTime();
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                factTo: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '实际结束时间不能在实际开始时间之前',
                            callback: function (value, validator) {
                                var factFrom = $("#factFrom").find("input").val() != "" ? $("#factFrom").data("datetimepicker").getDate() : null;
                                var factTo = $("#factTo").find("input").val() != "" ? $("#factTo").data("datetimepicker").getDate() : null;
                                if (factFrom != null && factTo != null) {
                                    return factFrom.getTime() <= factTo.getTime();
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                organizationName:{
                    trigger:'change',
                    validators:{
                        notEmpty: {
                            message: '部门不能为空'
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
                if (mode == 1) {

                    submit(mode);
                } else {
                    submit(mode);
                }
            }
            $("#btnConfirm").removeAttr("disabled");
        });
    };

    $("#planTo").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('planFrom',
            'NOT_VALIDATED', null).validateField('planFrom');
    });

    $("#planFrom").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('planTo',
            'NOT_VALIDATED', null).validateField('planTo');
    });

    $("#factTo").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('factFrom',
            'NOT_VALIDATED', null).validateField('factFrom');
    });

    $("#factFrom").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('factTo',
            'NOT_VALIDATED', null).validateField('factTo');
    });

    //提交方法
    function submit(mode) {
        //var tab = e.target.toString();
        var upData = {};//asset主体信息

        var url = "";
        var newNodes=[];
        if (1 == mode) {
            url = "${base}/pjs/project/add";
            var treeObj = $.fn.zTree.getZTreeObj("projectGroupTree");
            var node=treeObj.getNodes();
            var nodes =treeObj.transformToArray(node);
            nodes.forEach(function (r) {
                newNodes.push(r.id);
            })
            upData.nodes=newNodes.join(",")
            upData.tempId=tempId;
        } else {
            url = "${base}/pjs/project/edit";
        }

        //PjMain 信息
        var mainData = {
            'id': $("[name='id']").val(),
            'companyNo': $("#companyNo").val(),
            'name': $("#name").val(),
            'nameS': $("#nameS").val(),
            'planFrom': timeStampExchange($("#planFrom").data("datetimepicker").getDate()),
            'planTo': timeStampExchange($("#planTo").data("datetimepicker").getDate()),
            'planTimeAll': $("#planTimeAll").val(),
            'organizationId':$("#organizationId").val(),
            'memo': $("#memo").val()
        }
        upData.main = JSON.stringify(mainData);

        //pjFactInfo
        var factInfoId = {
            'id': $("[name='factInfoId']").val(),
            'factFrom': timeStampExchange($("#factFrom").data("datetimepicker").getDate()),
            'factTo': timeStampExchange($("#factTo").data("datetimepicker").getDate()),
            'factTimeAll': $("#factTimeAll").val(),
            'perMemo': $("#perMemo").val(),
            'memo': $("#memo_info").val(),
            'status': $("#status").val()
        };
        upData.factInfo = JSON.stringify(factInfoId);

        var kinds = $("#kindTable").bootstrapTable("getData");
        upData.kinds = JSON.stringify(kinds);

        upData.delKind = delKind.join(",");

        $.ajax({
            url: url,
            type: 'post',
            data: upData,
            complete: function (msg) {
            },
            success: function (result) {
                if (result.success) {
                    //刷新父页面
                    $('button[name="refresh"]', window.parent.document).click();
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.$("#handle").attr("value", mode);
                    parent.layer.close(index);
                } else {
                    toastr.error(result.message);
                }
            }, error: function () {
                toastr.error("错误");
            }
        });
    }

    $('.form_date').datetimepicker({
        //format: 'yyyy-mm-dd hh:ii:ss',
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

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


    //加载kindTable
    function loadKindTable() {
        $('#kindTable').bootstrapTable({
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            toolbar: '#kindToolbar',
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "kindId",                     //每一行的唯一标识，一般为主键列
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#kindTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#kindTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'kindId',
                title: '分类编号'
            }, {
                field: 'kindName',
                title: '分类名称'
            }, {
                field: 'kindMemo',
                title: '补充说明'
            }]
        });
    }

    //添加类型
    $("#kindAdd").click(function () {
        var kindId = $("#kindId").val();
        var kindFlg = $("#kindFlg").val();
        var kindName = $("#kindName").val();
        var kindMemo = $("#kindMemo").val();

        if (kindId == "") {
            toastr.warning("分类编号不能为空");
            return;
        }
        if(kindId.length!=2){
            toastr.warning("请输入两位数的分类编号");
            return;
        }
        if (kindFlg == "") {
            toastr.warning("分类区分不能为空");
            return;
        }
        if (kindName == "") {
            toastr.warning("分类名称不能为空");
            return;
        }
        var kind = {
            'kindId': kindFlg + kindId,
            'kindFlg': kindFlg,
            'kindName': kindName,
            'kindMemo': kindMemo
        };

        var rows = $('#kindTable').bootstrapTable("getData");
        var check = true;
        rows.forEach(function (r) {
            if (r.kindId == kind.kindId) {
                toastr.warning("分类编号和区分组合不能重复");
                check = false;
            }
        })

        if (check) {
            $('#kindTable').bootstrapTable('insertRow', {
                index: rows.length, row: kind
            });
            $("#kindId").val("");
            $("#kindName").val("");
            $("#kindMemo").val("");
        }
    });

    //移除类型
    $("#kindRemove").click(function () {
        var rows = $("#kindTable").bootstrapTable("getSelections");
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据");
            return;
        }
        rows.forEach(function (r) {
            $("#kindTable").bootstrapTable("removeByUniqueId", r.kindId);
            if (r.id != null) {
                this.delKind.push(r.id)
            }
        })
    })

    //修改时加载kinds数据
    function loadKinds() {
        var id = $("[name='id']").val();
        if (id != null && id != "") {
            $.ajax({
                url: '${base}/pjs/project/selectKinds',
                type: 'post',
                data: {'id': id},
                success: function (ret) {
                    ret.forEach(function (r) {
                        var c = $("#kindTable").bootstrapTable("getData").length;
                        $("#kindTable").bootstrapTable("insertRow", {
                            index: c, row: r
                        })
                    })
                }
            })
        }
    }

    function loadGroupTree() {
        var id = $("[name='id']").val();
        if(id==null || id==""){
            id=tempId;
        }
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
            },
            edit: {
                enable: true,
                editNameSelectAll: true,
                removeTitle: '删除节点',
                renameTitle: '修改节点'
            },
            callback: {
                beforeRemove: beforeRemove,
                beforeEditName: beforeEditName,
                onDrop: function (event, treeId, treeNodes, targetNode, moveType) {
                    var zTree = $.fn.zTree.getZTreeObj("projectGroupTree");
                    var node = zTree.getNodeByParam("id", treeNodes[0].id);
                    var parentNode = node.getParentNode();
                    var ret = new Array();
                    var r = getNodesId(treeNodes, ret).join(',');
                    $.ajax({
                        url: '${base}/pjs/projectGroup/moveNode',
                        type: 'post',
                        data: {
                            'parentId': (parentNode != null ? parentNode.id : null),
                            'childNodes': r,
                            'moveNodeId': treeNodes[0].id
                        },
                        success: function () {

                        }
                    })
                }
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'pId',
                    rootPid: null
                }
            }
        };
        $.ajax({
            url: '${base}/pjs/projectGroup/ztree',
            type: 'post',
            data: {'id': id},
            success: function (data) {
                $.fn.zTree.init($("#projectGroupTree"), setting, data);
            }
        });
    }

    function getNodesId(nodes, ret) {
        nodes.forEach(function (r) {
            ret.push(r.id);
            if (r.children != null) {
                getNodesId(r.children, ret)
            }
        })
        return ret;
    }

    /*
    添加根节点
     */
    function addRootNode() {
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '添加根节点',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '100%'],
            content: '${base}/pjs/projectGroup/addRootNode',
            btn: ['提交', '取消'],
            yes: function (index, layero) {

                // 获取弹出层中的form表单元素
                var formSubmit = layer.getChildFrame('form', index);
                // 获取表单中的提交按钮
                var submited = formSubmit.find('#btnConfirm');
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                submited.click();
                var child=window[layero.find('iframe')[0]['name']];
                addUserToUserGroup(child.userId);
                //layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 1) {
                    toastr.success('添加节点成功');
                }
            }
        });
    }

    /*
    自定义添加子节点按钮
     */
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='添加成员' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var id = treeNode.id;
        var btn = $("#addBtn_" + treeNode.tId);
        if (btn) btn.bind("click", function () {
            $("#handle").val(0);
            layer.open({
                type: 2,
                title: '添加子节点',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '100%'],
                content: '${base}/pjs/projectGroup/addChildNode/' + id,
                btn: ['确定', '取消'],
                yes: function (index, layero) {
                    var formSubmit = layer.getChildFrame('form', index);
                    var submited = formSubmit.find('#btnConfirm');
                    submited.click();
                    var child=window[layero.find('iframe')[0]['name']];
                    addUserToUserGroup(child.userId);

                },
                end: function () {
                    var handle = $("#handle").val();
                    if (handle == 1) {
                        toastr.success('添加节点成功');
                    }
                }
            });
        });

    }

    //在修改状态添加体制成员时，同时向用户组添加数据
    function addUserToUserGroup(id) {
        if($("#id").val()!=null && $("#id").val()!=""){
            var users=[];
            users.push({
                'organizationId':$("#userGroupId").val(),
                'id':id
            });
            $.ajax({
                url: '${base}/sys/userGroup/addUserToUserGroup',
                type: 'post',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(users),
                success: function () {

                }
            });
        }
    }

    /*
    移除自定义按钮
     */
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_" + treeNode.tId).unbind().remove();
    };

    /*
    删除事件
     */
    function beforeRemove(treeId, treeNode) {
        var re = false;
        layer.confirm('是否要删除该节点', {icon: 3, title: '提示'}, function (index) {
            var data = {
                'id': treeNode.id,
                'userGroupId':$("#userGroupId").val(),
                'pjId':$("#id").val()
            }
            $.ajax({
                url: '${base}/pjs/projectGroup/deleteNode',
                type: 'post',
                data: data,
                success: function (ret) {
                    if(ret.success){
                        toastr.success("删除成功")
                    }else{
                        toastr.error(ret.message);
                    }
                    layer.closeAll('dialog');
                    loadGroupTree()
                }
            });
        });
        return re;
    }

    /*
    修改事件
     */
    function beforeEditName(treeId, treeNode) {
        id = treeNode.id;
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '修改节点',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '100%'],
            content: '${base}/pjs/projectGroup/editNode/' + id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 2) {
                    toastr.success('修改成功');
                }
            }
        });
        return false;
    }

    //打开选择部门框
    function openOrganizationChoiceDig() {
        $("#organizationModal").modal('show');
    }

    //按钮点击
    $("#closeBtn1").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("organizationTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#organizationId").val(nodes[0].id);
            $("#organizationName").val(nodes[0].name).change();
        } else {
            $("#organizationId").val(null);
            $("#organizationName").val(null).change();
        }
        $('#organizationModal').modal('hide');
    });

    $("#resetBtn1").click(function () {
        $("#organizationId").val(null);
        $("#organizationName").val(null).change();
        $('#organizationModal').modal('hide');
    })

    function organizationZtree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            edit: {
                enable: false,
            },
            callback: {
                beforeDrag: function () {
                    return false;
                }
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'pId',
                    rootPid: null
                }
            }
        };
        $.ajax({
            url: '${base}/sys/organization/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#organizationTree"), setting, data);
            }
        });
    }


</script>
</body>
</html>