<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width"/>
    <title></title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">

    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link href="${base}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
    <style type="text/css">
        .comments {
            width: 100%; /*自动适应父布局宽度*/
            overflow: auto;
            word-break: break-all;
            /*在ie中解决断行问题(防止自动变为在一行显示，主要解决ie兼容问题，ie8中当设宽度为100%时，文本域类容超过一行时，
            当我们双击文本内容就会自动变为一行显示，所以只能用ie的专有断行属性“word-break或word-wrap”控制其断行)*/
        }
    </style>

</head>
<body>


<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="examineForm">
        <input hidden="hidden" name="id" value="${assetExamine.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px;display: none;">
                <label class="col-sm-2 control-label" for="no">点检NO</label>

                <div class="col-sm-5">
                    <input type="text" name="no" disabled class="form-control" id="no"
                           value="${assetExamine.no}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="examineName">点检名称</label>

                <div class="col-sm-5">
                    <input type="text" name="examineName" class="form-control" id="examineName" placeholder="请输入点检名称"
                           value="${assetExamine.name}">
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label for="examineBeginDate" class="col-sm-2 control-label">点检开始日</label>
                <div class="col-sm-5">
                    <div id="examineBeginDate" name="examineBeginDate" class="input-group date form_date" data-date=""
                         data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" readonly type="text"
                               value="<#if assetExamine.examineBeginDate??>${assetExamine.examineBeginDate?string('yyyy-MM-dd')}</#if>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="examineEndDate">点检终了日</label>
                <div class="col-sm-5">
                    <div id="examineEndDate" name="examineEndDate" class="input-group date form_date" data-date=""
                         data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" readonly type="text"
                               value="<#if assetExamine.examineEndDate??>${assetExamine.examineEndDate?string('yyyy-MM-dd')}</#if>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <#--<div class="form-group" style="height: 55px">-->
            <#--<label class="col-sm-2 control-label" for="examineCreateDate">点检创建日</label>-->
            <#--<div class="col-sm-5">-->
            <#--<div id="examineCreateDate" class="input-group date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">-->
            <#--<input class="form-control" size="16" readonly type="text" value="<#if assetExamine.examineCreateDate??>${assetExamine.examineCreateDate?string('yyyy-MM-dd')}</#if>" >-->
            <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
            <#--<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="moreInfo">补充说明</label>
                <div class="col-sm-5">
                    <textarea class="form-control" id="moreInfo" rows="3" name=moreInfo
                              style="min-width: 70%">${assetExamine.moreInfo}</textarea>
                </div>
            </div>
            <div class="form-group" style="min-height: 150px">
                <label class="col-sm-2 control-label" for="myTab">点检对象选择方式</label>
                <div class="col-sm-8">
                    <ul id="myTab" class="nav nav-tabs" role="tablist">
                        <li class="active"><a href="#normal" role="tab" data-toggle="tab">一般</a></li>
                        <li><a href="#user" role="tab" data-toggle="tab">用户</a></li>
                        <li><a href="#organization" role="tab" data-toggle="tab">部门</a></li>
                        <li><a href="#location" role="tab" data-toggle="tab">地点</a></li>
                    </ul>
                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane active" id="normal">
                            <br>
                            <#if assetExamine.id??>
                                <input type="radio" name="radio" value="2" checked>沿用修改前点检对象<br>
                            </#if>
                            <input type="radio" name="radio" value="0" <#if !assetExamine.id??>checked</#if>>全部点检对象<br>
                            <input type="radio" name="radio" value="1">领用中点检对象
                        </div>
                        <div class="tab-pane" id="user">
                            <div class="col-sm-5">
                                <ul id="userOrganTree" class="ztree">
                                </ul>
                            </div>
                            <input type="hidden" id="searchOrganId">
                            <div class="col-sm-7">
                                <table class="table table-condensed" id="userTable"></table>
                            </div>
                        </div>
                        <div class="tab-pane" id="organization">
                            <ul id="organizationTree" class="ztree">
                            </ul>
                        </div>
                        <div class="tab-pane" id="location">
                            <ul id="locationTree" class="ztree">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none;"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
        <!-- /.box-footer -->
    </form>

</div>
<!--资产查询-->

<!--地点查询-->

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>
<script>

    var overAllIds = new Array();              // 全局保存选中行的对象
    $(function () {
        organizationZtree();
        locationZtree();
        loadUserTable();
        userOrganZtree();

        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
        formValidator();
        //初期化
        $('.form_date').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0,
            format: 'yyyy-mm-dd'
        });
        $('.form_date').each(function () {
            var defaultDate = $(this).val();
            $(this).datetimepicker({
                defaultDate: defaultDate,
                format: 'yyyy-MM-dd'
            });
        })
    });


    function examine(type,datas){            // 操作类型，选中的行
        if(type.indexOf('uncheck')==-1){
            $.each(datas,function(i,v){        // 如果是选中则添加选中行的 id
                overAllIds.push(v.loginName);
            });
        }else{
            $.each(datas,function(i,v){
                overAllIds.splice(overAllIds.indexOf(v.loginName),1);     // 删除取消选中行的 id
            });
        }
    }

    $('#userTable').on('uncheck.bs.table check.bs.table check-all.bs.table uncheck-all.bs.table',function(e,rows){
        var datas = $.isArray(rows) ? rows : [rows];        // 点击时获取选中的行或取消选中的行
        examine(e.type,datas);                                 // 保存到全局 Set() 里
    });

    function formValidator() {
        var id = $('[name="id"]').val();
        var mode = 1;

        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        } else {
            var timestamp = Date.parse(new Date());
            $("#no").val(timestamp);
        }
        $('#examineForm').bootstrapValidator({
            message: '输入值不合法',
            fields: {
                remarks: {
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 255,
                            message: '长度要在255个字符以内'
                        },
                    }
                },
                examineName: {
                    validators: {
                        notEmpty: {
                            message: '点检名称不能为空'
                        },
                        stringLength: {/*长度提示*/
                            max: 50,
                            message: '点检名称长度必须小于50'
                        },
                    }
                },
                no: {
                    validators: {
                        notEmpty: {
                            message: '点检编号不能为空'
                        },
                        stringLength: {/*长度提示*/
                            max: 100,
                            message: '点检编号长度必须小于100'
                        },
                    }
                },
                examineBeginDate: {
                    trigger: 'change',
                    message: '点检开始日不合法',
                    validators: {
                        callback: {
                            message: '点检开始日不能在点检终了日之后',
                            callback: function (value, validator) {
                                var examineBeginDate = $("#examineBeginDate").find("input").val() != "" ? $("#examineBeginDate").data("datetimepicker").getDate() : null;
                                var examineEndDate = $("#examineEndDate").find("input").val() != "" ? $("#examineEndDate").data("datetimepicker").getDate() : null;
                                if (examineBeginDate == null) {
                                    $('#examineForm').bootstrapValidator('updateMessage', 'examineBeginDate', 'callback', '点检终了日不能为空');
                                    return false;
                                } else {
                                    $('#examineForm').bootstrapValidator('updateMessage', 'examineBeginDate', 'callback', '点检开始日不能在点检终了日之后');
                                    if ((examineBeginDate != null && examineEndDate == null) || (examineBeginDate == null && examineEndDate != null)) {
                                        return false;
                                    } else if (examineBeginDate != null && examineEndDate != null) {
                                        return examineBeginDate.getTime() <= examineEndDate.getTime();
                                    }
                                }
                                return true;
                            }
                        }
                    }
                },
                examineEndDate: {
                    trigger: 'change',
                    message: '点检终了日不合法',
                    validators: {
                        callback: {
                            message: '点检终了日不能在点检开始日之前',
                            callback: function (value, validator) {
                                var examineBeginDate = $("#examineBeginDate").find("input").val() != "" ? $("#examineBeginDate").data("datetimepicker").getDate() : null;
                                var examineEndDate = $("#examineEndDate").find("input").val() != "" ? $("#examineEndDate").data("datetimepicker").getDate() : null;
                                if (examineEndDate == null) {
                                    $('#examineForm').bootstrapValidator('updateMessage', 'examineEndDate', 'callback', '点检终了日不能为空');
                                    return false;
                                } else {
                                    $('#examineForm').bootstrapValidator('updateMessage', 'examineEndDate', 'callback', '点检终了日不能在点检开始日之前');
                                    if ((examineBeginDate != null && examineEndDate == null) || (examineBeginDate == null && examineEndDate != null)) {
                                        return false;
                                    } else if (examineBeginDate != null && examineEndDate != null) {
                                        return examineBeginDate.getTime() <= examineEndDate.getTime();
                                    }
                                }
                                return true;
                            }
                        }
                    }
                },
            }
        }).on('success.form.bv', function (e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            var $form = $(e.target);
            //进行表单验证 assetExamine
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                var data={};

                var formdata = {
                    "id": $('[name="id"]').val(),
                    "no": $("#no").val(),
                    "name": $("#examineName").val(),
                    "examineBeginDate":$("#examineBeginDate").find("input").val(),
                    "examineEndDate": $("#examineEndDate").find("input").val(),
                    //"examineCreateDate": timeStampExchange($("#examineCreateDate").data("datetimepicker").getDate()),
                    "moreInfo": $("#moreInfo").val(),
                    "remarks": $("#remarks").val()
                };

                var tabId=$("[class='tab-pane active']").attr("id");
                data.examine=JSON.stringify(formdata);
                data.type=tabId;
                if(tabId=='normal'){
                    //一般
                    data.data=$("[name='radio']:checked").val();
                }else if(tabId=='user'){
                    //用户
                    data.data=overAllIds.join(",");
                }else if(tabId=='organization'){
                    //组织
                    var treeObj = $.fn.zTree.getZTreeObj("organizationTree");
                    var nodes = treeObj.getCheckedNodes();
                    var ids=[];
                    nodes.forEach(function (r) {
                        ids.push(r.id)
                    });
                    data.data=ids.join(",")
                }else if(tabId=='location'){
                    //地点
                    var treeObj = $.fn.zTree.getZTreeObj("locationTree");
                    var nodes = treeObj.getCheckedNodes();
                    var ids=[];
                    nodes.forEach(function (n) {
                        ids.push(n.id)
                    });
                    data.data=ids.join(",");
                };

                var url = "";
                if (1 == mode) {
                    url = "/ams/examine/add";
                } else {
                    url = "/ams/examine/edit";
                    if($("[name='radio']:checked").val()==2 && tabId=='normal'){
                        data.editExamine="1";
                    }else{
                        data.editExamine="0";
                    }
                }


                layer.confirm("确认要提交？", {icon: 3, title: '提示'}, function (index) {
                    $.ajax({
                        url: url,
                        type: 'POST',
                        data: data,
                        complete: function (msg) {
                            console.log('完成了');
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
                        }
                    });
                },function () {
                    $("#btnConfirm").removeAttr("disabled");
                });
            }
        });
    };

    function submitForm(url,data,mode){
        //发送ajax请求

    }

    $("#examineEndDate").change(function () {
        $('#examineForm').data('bootstrapValidator').updateStatus('examineBeginDate',
            'NOT_VALIDATED', null).validateField('examineBeginDate');
    });

    $("#examineBeginDate").change(function () {
        $('#examineForm').data('bootstrapValidator').updateStatus('examineEndDate',
            'NOT_VALIDATED', null).validateField('examineEndDate');
    });

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

    $('input[name="radio"]').iCheck({
        radioClass: 'iradio_square-green'
    })

    //组织树
    function organizationZtree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false
            },
            check: {
                enable: true,   //true / false 分别表示 显示 / 不显示 复选框或单选框
                //autoCheckTrigger: true,   //true / false 分别表示 触发 / 不触发 事件回调函数
                chkStyle: "checkbox",   //勾选框类型(checkbox 或 radio）
                chkboxType: {"Y": "s", "N": "s"}   //勾选 checkbox 对于父子节点的关联关系
            },
            callback:{
                onClick: onClick
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
    
    function onClick(e, treeId, treeNode) {
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        treeObj.checkNode(treeNode, !treeNode.checked,null, true);
        return false;
    }

    //地点树
    function locationZtree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            check: {
                enable: true,   //true / false 分别表示 显示 / 不显示 复选框或单选框
                //autoCheckTrigger: true,   //true / false 分别表示 触发 / 不触发 事件回调函数
                chkStyle: "checkbox",   //勾选框类型(checkbox 或 radio）
                chkboxType: {"Y": "s", "N": "s"}   //勾选 checkbox 对于父子节点的关联关系
            },
            callback:{
                onClick: onClick
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
            url: '${base}/ams/location/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#locationTree"), setting, data);
            }
        });
    }

    function userOrganZtree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            callback: {
                onClick: onZtreeClick,
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
                $.fn.zTree.init($("#userOrganTree"), setting, data);
            }
        });
    }

    function onZtreeClick(event, treeId, treeNode) {
        $("#searchOrganId").val(treeNode.id);
        $("#userTable").bootstrapTable('refresh');

    }

    function loadUserTable() {
        $('#userTable').bootstrapTable({
            url: '${base}/sys/organization/loadUser',        //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var searchParams = {};
                var organId=$("#searchOrganId").val();

                if(organId!=null && organId!=0 && organId!=""){
                    searchParams["id"]=organId;
                }
                searchParams["startNo"]=(params.pageNumber-1)*params.pageSize;
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams
                };
                return temp;
            },
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType : "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10],        //可供选择的每页的行数（*）
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
                checkbox: true,
                formatter: function (i,row) {            // 每次加载 checkbox 时判断当前 row 的 id 是否已经存在全局 Set() 里
                    if(overAllIds.indexOf(row.loginName)!=-1){    // 因为 Set是集合,需要先转换成数组
                        return {
                            checked : true               // 存在则选中
                        }
                    }
                }
            }, {
            //     title: 'no',
            //     align: 'center',
            //     formatter: function (value, row, index) {
            //         var pageSize = $('#userTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
            //         var pageNumber = $('#userTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
            //         return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
            //     }
            // }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'loginName', title: '登录名'
            }, {
                field: 'nickName', title: '昵称'
            }]
        });
    }

</script>
</body>
</html>