<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户组详情</title>
    <meta name="viewport" content="width=device-width" />
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
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
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>

<ul class="nav nav-tabs" id="myTab" role="tablist" <#if projectGroup.id?? >hidden</#if> >
    <li class="active"><a href="#single" role="tab" data-toggle="tab">单个成员</a></li>
    <li><a href="#multi" role="tab" data-toggle="tab">多选成员</a></li>
</ul>
<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal"  id="form">

        <input hidden="hidden" id="id" name="id" value="${projectGroup.id}"/>
        <input hidden="hidden" id="parentId" name="parentId" value="${projectGroup.parentId}"/>
        <input hidden="hidden" id="parentIds" name="parentIds" value="${projectGroup.parentIds}">

        <div class="box-body">
            <div id="myTabContent" class="tab-content">
                <div id="single" class="tab-pane active">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="userTable">用户名</label>
                        <div class="col-sm-6" style="height: 30px">
                            <input type="text" id="nickName" name="nickName"  class="form-control" value="${projectGroup.nickName}" readonly />
                            <input type="text" id="userId" name="userId"   value="${projectGroup.userId}" hidden/>
                        </div>
                        <input type="button" onclick="openModel()" class="btn btn-primary" value="添加">
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-2 control-label" for="email">职位</label>
                        <div class="col-sm-3">
                            <input type="text" id="position" name="position" class="form-control" value="${projectGroup.position}">
                        </div>
                    </div>
                    <#--<div class="form-group">-->
                        <#--<label class="col-sm-2 control-label" for="email">排序</label>-->
                        <#--<div class="col-sm-3">-->
                            <#--<input type="text" id="sort" name="sort" class="form-control" value="${projectGroup.sort}">-->
                        <#--</div>-->
                    <#--</div>-->
                    <div class="form-group" hidden>
                        <label class="col-sm-2 control-label" for="email">等级</label>
                        <div class="col-sm-3">
                            <input type="text" id="level" name="level" readonly="readonly" class="form-control" value="${projectGroup.level}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="phone">备注</label>
                        <div class="col-sm-8">
                            <textarea id="remarks" name="remarks" class="form-control" rows="4">${projectGroup.remarks}</textarea>
                        </div>
                    </div>
                </div>
                <div id="multi" class="tab-pane">
                    <ul>
                        <ul id="organizationTree" class="ztree">
                        </ul>
                    </ul>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span class="glyphicon glyphicon-floppy-disk"></span>保存</button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span class="glyphicon glyphicon-remove"></span>取消</button>
        <!-- /.box-footer -->
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

<script type="text/javascript">
    $(function () {
        formValidator();
        loadChoiceUsers();
        ztree();
    });

    /*
    表单验证
    */
    var userId;
    function formValidator() {

        var id = $('[name="id"]').val();
        var mode = 1;
        if(undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $("#form").bootstrapValidator({
            message: "参数不合法",
            fields: {
                nickName:{
                    trigger: 'change',
                    message: '用户不合法',
                    validators: {
                        notEmpty: {
                            message: '请选择用户'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                //单个添加
                var tabId=$("[class='tab-pane active']").attr("id");

                var pjId=parent.$("#id").val()
                if (pjId==null || pjId==""){
                    pjId=parent.tempId;
                }

                if(tabId=="single"){
                    userId=$("#userId").val();
                    var formdata={
                        "id":$('[name="id"]').val(),
                        'pjId':pjId,
                        "userId":$("#userId").val(),
                        "position":$("#position").val(),
                        "parentId":$("#parentId").val(),
                        "remarks":$("#remarks").val(),
                        "level":$("#level").val(),
                        "parentIds":$("#parentIds").val()
                    };

                    var url = "";
                    if(1 == mode){
                        url = "${base}/pjs/projectGroup/addNode";
                    }else{
                        url = "${base}/pjs/projectGroup/editNode";
                    }

                    //发送ajax请求
                    $.ajax({
                        url: url,
                        type: 'POST',
                        dataType:"json",
                        contentType:"application/json",
                        data: JSON.stringify(formdata),
                        complete: function (msg) {
                            console.log('完成了');
                        },
                        success: function (result) {
                            if(result.success){
                                //刷新父页面
                                parent.loadGroupTree();
                                var index=parent.layer.getFrameIndex(window.name);
                                parent.layer.close(index);
                                parent.$("#handle").val(mode);
                            }else{
                                toastr.error(result.message);
                            }
                        },error:function () {
                            alert("失败")
                        }
                    });
                }else{
                    var treeObj = $.fn.zTree.getZTreeObj("organizationTree");
                    var nodes = treeObj.getSelectedNodes();
                    var nodeIds=[];
                    nodes.forEach(function (e) {
                        getchildren(nodeIds,e)
                    })

                    $.ajax({
                        url:'${base}/pjs/projectGroup/addMultiNode',
                        type:'post',
                        data:{'nodeIds':nodeIds.join(","),'pjId':pjId,'level':$("#level").val(),'parentId':$("#parentId").val(),'parentIds':$("#parentIds").val()},
                        success:function (result){
                            if(result.success){
                                //刷新父页面
                                parent.loadGroupTree();
                                var index=parent.layer.getFrameIndex(window.name);
                                parent.layer.close(index);
                                parent.$("#handle").val(mode);
                            }else{
                                toastr.error(result.message);
                            }
                        },error:function () {
                            alert("失败")
                        }
                    });

                    // var index=parent.layer.getFrameIndex(window.name);
                    // parent.layer.close(index);
                }
            }
        });
    }
    //获取节点的子节点
    function getchildren(nodeIds,node){
        if(nodeIds.indexOf(node.id)==-1){
            nodeIds.push(node.id)
        }
        var children=node.children;
        if(children!=null && children!="" && children!=undefined){
            children.forEach(function (e) {
                getchildren(nodeIds,e)
            });
        }
    }

    //标签页切换时打开/关闭单个用户添加时的用户名验证
    $("a[data-toggle='tab']").on("show.bs.tab",function (e) {
        var target=e.target;
        var tabId=target.toString().substring(target.toString().indexOf("#")+1);
        if(tabId=="single"){
            $("#form").data("bootstrapValidator").enableFieldValidators("nickName", true, "notEmpty");
        }else{
            $("#form").data("bootstrapValidator").enableFieldValidators("nickName", false, "notEmpty");
        }
    })

    function loadChoiceUsers() {
        var pjId=parent.$("#id").val()
        if (pjId==null || pjId==""){
            pjId=parent.tempId;
        }
        $("#choiceUsers").bootstrapTable({
            url: '${base}/pjs/projectGroup/loadUsersNotInProject',         //请求后台的URL（*）ams:apply:list
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
                searchParams["del_flag"] =false;
                searchParams["pjId"] =pjId;
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
            queryParamsType : "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
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
            singleSelect:true,
            columns: [{
                checkbox: true
            },{
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

    function openModel(){
        $('#myModal').modal('show');
        loadChoiceUsers();
    }

    $("#closeBtn").click(function(){
        var rows=$("#choiceUsers").bootstrapTable("getSelections");
        if(rows.length>0){
            $("#nickName").val(rows[0].nickName).change()
            $("#userId").val(rows[0].id)
        }
        $('#myModal').modal('hide');
    });


    $("#resetBtn").click(function(){
        $("#nickName").val(null).change()
        $("#userId").val(null)
        $('#myModal').modal('hide');
    });

    function ztree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: true,
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