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
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
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
    <form class="form-horizontal" id="applyForm">
        <input hidden="hidden" name="id" value="${apply.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="no">资产名称</label>

                <div class="col-sm-5">
                    <input type="text" id="assetName" name="assetName" value="${assetInfo.name}" class="form-control"
                           placeholder="请选择资产" readonly>
                    <input type="text" name="no" hidden id="no"
                           value="${apply.no}">
                </div>
                <button type="button" class="btn btn-small" id="assetChoiceBtn" <#if apply.id??>disabled</#if>
                        onclick="openAssetChoiceDig()">
                    资产选择
                </button>
            </div>
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="applyId">领用者</label>
                <div class="col-sm-5">
                    <input type="text" id="applyName" name="applyName" value="${userName}" class="form-control"
                           placeholder="请选择领用者" readonly>
                    <input type="text" name="applyId" hidden id="applyId"
                           value="${apply.applyId}">
                </div>
                <button type="button" class="btn btn-small" id="applyChoiceBtn" <#if apply.id??>disabled</#if>
                        onclick="openApplyChoiceDig()">
                    领用者选择
                </button>
            </div>
            <#if assetInfo.locationId?? || apply.id<0 >
                <div class="form-group" style="height: 55px">
                    <label class="col-sm-2 control-label" for="locationId">存放地点</label>
                    <div class="col-sm-5">
                        <input type="text" id="locationName" name="locationName" value="${locationName}"
                               class="form-control"
                               placeholder="请选择存放地点" readonly>
                        <input type="text" name="locationId" id="locationId"
                               value="${locationId}" hidden>
                    </div>
                    <button type="button" class="btn btn-small" id="locationChoiceBtn" <#if apply.id??>disabled</#if>
                            onclick="openLocationChoiceDig()">
                        存放地点选择
                    </button>
                </div>
            </#if>

            <div class="form-group" style="height: 55px">
                <label for="applyDate" class="col-sm-2 control-label">领用日</label>
                <#if apply.id?? >
                    <div class="col-sm-5">
                        <input type="text" class="form-control"
                               value="<#if apply.id??>${apply.applyDate?string('yyyy-MM-dd')}</#if>" readonly>
                    </div>
                </#if>
                <div class="col-sm-5">
                    <div class="col-sm-10" <#if apply.id?? >hidden</#if>>
                        <div id="applyDate" class="input-group date form_date" data-date=""
                             data-date-format="yyyy MM dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                            <input class="form-control" size="16" type="text"
                                   value="<#if apply.applyDate??>${apply.applyDate?string('yyyy-MM-dd')}</#if>">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>
                </div>
            </div>
            <#--<div class="form-group" style="height: 55px">-->
            <#--<label class="col-sm-2 control-label" for="returnDate">归还日</label>-->
            <#--<div id="returnDate" class="input-group date form_date col-md-5" data-date="" data-date-format="yyyy MM dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">-->
            <#--<input class="form-control" size="16" type="text" value="<#if apply.returnDate??>${apply.returnDate?string('yyyy-MM-dd')}</#if>" >-->
            <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
            <#--<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>-->
            <#--</div>-->
            <#--</div>-->
            <div class="form-group" style="height: 55px">
                <label class="col-sm-2 control-label" for="moreInfo">补充说明</label>
                <div class="col-sm-5">
                    <textarea class="form-control" id="moreInfo" rows="3" name=moreInfo
                              style="min-width: 70%">${apply.moreInfo}</textarea>
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
<!--资产查询-->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width:80%;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">选择要领用的资产</h4>
            </div>
            <div class="panel-body">
                <form class="form-inline" id="searchForm">
                    <div class="form-group" style="margin-right:20px">
                        <label for="search_eq_asset_input_no">资产编号</label>
                        <input type="text" class="form-control _search" id="search_eq_asset_input_no"
                               name="search_eq_asset_input_no">
                    </div>
                    <div class="form-group" style="margin-right:20px">
                        <label for="search_like_name">资产名称</label>
                        <input type="text" class="form-control _search" id="search_like_name" name="search_like_name">
                    </div>
                    <div class="form-group" style="margin-right:20px">
                        <label for="login">资产分类</label>
                        <select id="classify_id" name="classify_id" class="selectpicker _search" title="请选择"
                                data-width="150px">
                            <option value="">请选择</option>
                            <#list assetType as type >
                                <option value="${type.value}">${type.label}</option>
                            </#list>
                        </select>
                    </div>
                    <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">查询
                    </button>
                </form>
            </div>
            <div class="modal-body">
                <table id="assetTable" class="table table-condensed"></table>
            </div>
            <div class="modal-footer">
                <button id="closeBtn1" type="button" class="btn btn-primary">确认</button>
                <button id="resetBtn1" type="button" class="btn btn-default">清除</button>
            </div>
        </div>
    </div>
</div>
<!--申请者查询-->
<div class="modal inmodal fade" id="myModal2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">选择领用者</h4>
            </div>
            <div class="panel-body">
                <form class="form-inline" id="searchForm1">
                    <div class="form-group" style="margin-right:20px">
                        <label for="s_name">领用者名</label>
                        <input type="text" class="form-control _search1" id="search_like_nick_name"
                               name="search_like_nick_name">
                    </div>
                    <button type="button" style="margin-left:20px" onclick="re_load1();" class="btn btn-primary">查询
                    </button>
                </form>
            </div>
            <div class="modal-body">
                <table id="applyTable1"></table>
            </div>
            <div class="modal-footer">
                <button id="closeBtn2" type="button" class="btn btn-primary">确认</button>
                <button id="resetBtn2" type="button" class="btn btn-default">清除</button>
            </div>
        </div>
    </div>
</div>
<!--存放地点查询-->
<div class="modal inmodal fade" id="myModal3" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">选择存放地点</h4>
            </div>
            <div class="col-sm-3" style="margin-top: 20px;">
                <ul id="locationTree" class="ztree">
                </ul>
            </div>
            <div class="modal-footer">
                <button id="closeBtn3" type="button" class="btn btn-primary">确认</button>
                <button id="closeBtn4" type="button" class="btn btn-default">清除</button>
            </div>
        </div>
    </div>
</div>
<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
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
    var selectedVal;
    var selectedApply;
    var selectedLocation;
    var selectedAssetId;
    var selecedApplyName;
    var selectedAssetName;
    $(document).ready(function () {

        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

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
                format: 'YYYY-MM-DD'
            });
        })
        $("#classify_id").selectpicker('refresh');
        $("#classify_id").selectpicker('render');
        formValidator();
    });

    /*
       加载树形菜单
        */
    function ztree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            callback: {
                onClick: onZtreeClick,
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
            url: '${base}/ams/location/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#locationTree"), setting, data);
            }
        });
    }

    /*
     树形菜单的点击事件
    */
    function onZtreeClick(event, treeId, treeNode) {
        console.info(treeNode.id);
        selectedLocation = treeNode.id;
    }

    $("#btnClose").click(function () {
        //清空验证
        $("#applyForm").data('bootstrapValidator').destroy();
        $('#applyForm').data('bootstrapValidator', null);
        var index = parent.layer.getFrameIndex(window.name);
        parent.$("#handle").attr("value", "");
        parent.layer.close(index);
    });

    //资产查询对话框打开时触发
    function openAssetChoiceDig() {
        $('#myModal1').modal('show');
        initBootstrapTable();
    }

    //申请者查询对话框打开时触发
    function openApplyChoiceDig() {
        $('#myModal2').modal('show');
        initApplyBootstrapTable();
    }

    //资产存放地点对话框打开时触发
    function openLocationChoiceDig() {
        $('#myModal3').modal('show');
        initLocationBootstrapTable();
    }

    //选择领用资产确定按钮
    $("#closeBtn1").click(function () {
        $("#no").val(selectedVal);
        $("#assetName").val(selectedAssetName).change();
        $('#myModal1').modal('hide');
    });
    //选择领用资产清除按钮
    $("#resetBtn1").click(function () {
        $("#no").val(null);
        $("#assetName").val(null).change();
        $('#myModal1').modal('hide');
    });
    //选择领用者确定按钮
    $("#closeBtn2").click(function () {
        $("#applyId").val(selectedApply);
        $('#applyName').val(selecedApplyName).change();
        $('#myModal2').modal('hide');
    });
    //选择领用者清除事件
    $("#resetBtn2").click(function () {
        $("#applyId").val(null);
        $('#applyName').val(null).change();
        $('#myModal2').modal('hide');
    });
    //选择存放地点确定按钮
    $("#closeBtn3").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("locationTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#locationId").val(nodes[0].id);
            $("#locationName").val(nodes[0].name).change();
            if (nodes[0].id == 'root') {
                $("#locationName").val('仓库');
            }
        } else {
            $("#locationId").val(null);
            $("#locationName").val(null).change();
        }
        $('#myModal3').modal('hide');
    });

    //选择存放地点清除按钮
    $("#closeBtn4").click(function () {
        $("#locationId").val("").change();
        $("#locationName").val(null).change();
        $('#myModal3').modal('hide');
    });

    //加载场所树形
    function initLocationBootstrapTable() {
        ztree();
    }

    //资产列表
    function initBootstrapTable() {
        var searchParams = {};
        searchParams["search_ne_status_property"] = '3';
        searchParams['search_like_name'] = '';
        searchParams['search_like_asset_input_no'] = '';
        searchParams['search_eq_classify_id'] = '';
        ;
        $('#assetTable').bootstrapTable({
            url: '${base}/ams/asset/list',         //请求后台的URL（*）ams:apply:list
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                searchParams['search_eq_amount'] = '1';
                searchParams['search_ne_status_property'] = '3';
                searchParams['search_is_null_apply_userid'] = "1";
                searchParams['search_like_name'] = $("#search_like_name").val().trim();
                searchParams['search_like_asset_input_no'] = $("#search_eq_asset_input_no").val().trim();
                searchParams['search_eq_classify_id'] = $("#classify_id").val();
                console.log(searchParams);
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
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
                    var pageSize = $('#assetTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#assetTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'assetInputNo',
                title: '资产编号'
            }, {
                field: 'name',
                title: '资产名称'
            }
            ]
        });

    };

    //申请者列表
    function initApplyBootstrapTable() {
        ;
        $('#applyTable1').bootstrapTable({
            url: '${base}/sys/user/list',         //请求后台的URL（*）ams:apply:list
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
                $("#searchForm1 ._search1").each(function () {
                    if ("" != $(this).val()) {
                        searchParams[$(this).attr('name')] = $(this).val();
                    }
                });
                console.log(searchParams);
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
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
                    var pageSize = $('#applyTable1').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#applyTable1').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
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
    };
    $('#assetTable').on('click-row.bs.table', function (e, row, element) {
        selectedVal = row.assetInputNo;
        selectedAssetId = row.id;
        selectedAssetName = row.name;
        //toastr.info("选择的资产编号："+selectedVal);
    });
    $('#applyTable1').on('click-row.bs.table', function (e, row, element) {
        selectedApply = row.loginName;
        selecedApplyName = row.nickName;
        //toastr.info("选择的带出人："+selecedApplyName);
    });

    function formValidator() {
        var id = $('[name="id"]').val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }
        $('#applyForm').bootstrapValidator({
            message: '输入值不合法',
            fields: {
                remarks: {
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 255,
                            message: '长度要在255个字符以内'
                        }
                    }
                },
                assetName: {
                    trigger: "change",
                    validators: {
                        notEmpty: {
                            message: '资产名称不能为空'
                        },
                        threshold: 1,
                        stringLength: {/*长度提示*/
                            max: 50,
                            message: '资产名称长度必须小于50'
                        },
                    }
                },
                applyName: {
                    trigger: "change",
                    validators: {
                        notEmpty: {
                            message: '领用人名称不能为空'
                        },
                        threshold: 1,
                        stringLength: {/*长度提示*/
                            max: 50,
                            message: '长度要在50个字符以内'
                        },
                    }
                },
                locationName: {
                    trigger: "change",
                    validators: {
                        notEmpty: {
                            message: '领用地址不能为空'
                        },
                        threshold: 1,
                        stringLength: {
                            max: 50,
                            message: '长度要在50个字符以内'
                        }
                    }
                },
                moreInfo: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: '长度要在50个字符以内'
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
                var formdata = {
                    "id": $('[name="id"]').val(),
                    "no": $("#no").val(),
                    "applyId": $("#applyId").val(),
                    "name": selectedAssetName,
                    "moreInfo": $("#moreInfo").val(),
                    "applyDate": timeStampExchange($("#applyDate").data("datetimepicker").getDate()),
                    //"returnDate": $("#returnDate").data("datetimepicker").getDate(),
                    "remarks": $("#remarks").val()
                };
                console.log(formdata);
                var url = "";
                if (1 == mode) {
                    url = "/ams/apply/add?id=" + selectedAssetId + "&locationId=" + selectedLocation + "&applyId=" + selectedApply;
                } else {
                    url = "/ams/apply/edit?locationId=" + $("#locationId").val();
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
            }

        });
    };

    /**
     * 重新加载表
     */
    function re_load() {
        $('#assetTable').bootstrapTable('refresh');
    }

    function re_load1() {
        $('#applyTable1').bootstrapTable('refresh');
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