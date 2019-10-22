<!DOCTYPE html>
<html>
<head>
    <title>申请单</title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
</head>
<body>

<div class="box box-info" id="role_edit_table">
    <div class="panel-body" style="padding-bottom:0px;">
    </div>
    <form id="roleForm">
        <input hidden="hidden" name="id" value="${workFlow.id}"/>
        <div class="box-body">
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">申请人:</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" id="applyer" name="applyer" value="${workFlow.applyer}"/>
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">申请资产:</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" id="name" name="name" value="${workFlow.name}"/>
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">审核状态:</label>
                <div class="col-md-5">
                    <input type="text" disabled class="form-control" id="applyStatus" name="applyStatus" value="${workFlow.applyStatus}"/>
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">申请人:</label>
                <div class="col-md-5">
                    <label>${applyerName}</label>
                </div>
            </div>
            <div class="form-group" style="height: 55px;">
                <label class="col-md-2 control-label">资产价格:</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" id="assetPrice" name="assetPrice" value="${workFlow.assetPrice}"/>
                </div>
            </div>
        </div>
        <div class="panel-body" style="padding-bottom:0px;">
            <div id="toolbar" class="btn-group">
                <button  type="button" class="btn btn-info" onclick="dt_apply()">
                    <i class="fa fa-plus-square" aria-hidden="true"></i>申请
                </button>
            </div>
        </div>
        <#--<!-- /.box-body &ndash;&gt;-->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="display: none" >保存</button>
    </form>
</div>
<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script type="text/javascript">
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
        //初始化Table
        //initBootstrapTable();
        //初始化表单
        formValidator();
    });
    //初始化表单
    function formValidator(){

        $('#roleForm').bootstrapValidator({
            message: '输入值不合法',
            fields: {
                applyer: {
                    validators: {
                        notEmpty: {
                            message: '模型分类不能为空'
                        }
                    }
                },
                name: {
                    validators: {
                        notEmpty: {
                            message: '模型名称不能为空'
                        }
                    }
                },
            }
        }).on('success.form.bv', function(e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            debugger;
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                var formdata={
                    "id":$("#id").val(),
                    "applyer": $("#applyer").val(),
                    "applyStatus": $("#applyStatus").val(),
                    "name": $("#name").val(),
                    "assetPrice": $("#assetPrice").val()
                };
                console.log(formdata);

                //发送ajax请求
                $.ajax({
                    url: '${base}/myApply/save',
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
                             $('button[name="refresh"]', window.parent.document).click();
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.$("#handle").attr("value",1);
                            //parent.layer.close(index);
                            toastr.success(result.message);
                        }else{
                            debugger;
                            toastr.success(result.message);
                        }
                    }
                });
            }
        });
    }

    /**
     * 打开新增框
     */
    function dt_apply() {
        var submited = $('#btnConfirm');
        submited.click();
    }

    /**
     * 打开编辑框
     * @param id
     */
    <#--function dt_update(id) {-->
        <#--$("#handle").attr("value",0);-->
        <#--// iframe层-->
        <#--layer.open({-->
            <#--type: 2,-->
            <#--title: '编辑用户',-->
            <#--maxmin: true,-->
            <#--shadeClose: false, // 点击遮罩关闭层-->
            <#--area: ['80%', '80%'],-->
            <#--//area: '80%',-->
            <#--content: '${base}/sys/user/edit/'+id,-->
            <#--btn: ['确定', '取消'],-->
            <#--yes: function (index, layero) {-->
                <#--debugger;-->
                <#--// 获取弹出层中的form表单元素-->
                <#--var formSubmit=layer.getChildFrame('form', index);-->
                <#--// 获取表单中的提交按钮-->
                <#--var submited = formSubmit.find('#btnConfirm');-->
                <#--// 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息-->
                <#--submited.click();-->
                <#--//layer.close(index);//这块是点击确定关闭这个弹出层-->
            <#--},-->
            <#--end: function(){-->
                <#--var handle = $("#handle").val();-->
                <#--if( handle == 2){-->
                    <#--toastr.success('用户编辑成功!');-->
                <#--}-->
            <#--}-->
        <#--});-->
    <#--}-->

    /**
     * 删除某条记录
     * @param url
     * @param id
     */
    <#--function dt_remove(id) {-->
        <#--layer.confirm('确定要删除选中的记录？', {icon: 3, title:'提示'}, function (index) {-->
            <#--$.ajax({-->
                <#--url: '${base}/sys/user/delete',-->
                <#--type: "POST",-->
                <#--data: {-->
                    <#--'id': id-->
                <#--},-->
                <#--success: function (result) {-->
                    <#--if(result.success){-->
                        <#--$('button[name="refresh"]').click();-->
                        <#--toastr.success('删除成功!');-->
                        <#--layer.close(index);-->
                    <#--}else{-->
                        <#--toastr.error(result.message);-->
                        <#--layer.close(index);-->
                    <#--}-->
                <#--}-->
            <#--});-->
        <#--})-->
    <#--}-->

    <#--/**-->
     <#--* 批量删除-->
     <#--*/-->
    <#--function batchRemove() {-->
        <#--var rows = $('#userTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组-->
        <#--if (rows.length == 0) {-->
            <#--toastr.warning("请选择要删除的数据!");-->
            <#--return;-->
        <#--}-->
        <#--//var ids = '';-->
        <#--//遍历所有选择的行数据，取每条数据对应的ID-->
        <#--/*$.each(rows, function (i, row) {-->
            <#--if(row['id'] === 1){-->
                <#--layer.msg("不能删除超级管理员");-->
                <#--return false;-->
            <#--}-->
        <#--});*/-->

        <#--layer.confirm("确认要删除选中的数据吗?", {icon: 3, title:'提示'}, function (index) {-->
            <#--var deleteindex = layer.msg('删除中，请稍候...',{icon: 16,time:false,shade:0.8});-->
            <#--$.ajax({-->
                <#--url: '${base}/sys/user/deleteSome',-->
                <#--type: "POST",-->
                <#--dataType:"json",-->
                <#--contentType:"application/json",-->
                <#--data: JSON.stringify(rows),-->
                <#--success: function (result) {-->
                    <#--layer.close(deleteindex);-->
                    <#--if(result.success){-->
                        <#--$('button[name="refresh"]').click();-->
                        <#--toastr.success('删除成功!');-->
                        <#--layer.close(index);-->
                    <#--}else{-->
                        <#--console.log(result.message);-->
                        <#--toastr.error(result.message);-->
                        <#--layer.close(index);-->
                    <#--}-->
                <#--}-->
            <#--});-->
        <#--})-->
    <#--}-->

    function dt_delete_button(row) {
        var deleteO = '<a class="btn btn-warning btn-sm" href="#" title="删除"  mce_href="#" ' +
            'onclick="remove(\'' + row.id + '\')"><i class="fa fa-remove"></i></a> ';

        return deleteO;

    }

    function dt_edit_model_button(row) {
        var uri = url.substring(0, url.length - 1);
        var editO = '<a class="btn btn-primary btn-sm" href="' +'modeler.html?modelId=' + row.id + '" title="编辑"><i class="fa fa-edit"></i></a> ';
        return editO;
    }

    function dt_doploy_button(row) {
        var editO = '<a class="btn btn-primary btn-sm" href="#" mce_href="#" title="部署" onclick="deploy(\''
                + row.id + '\')"><i class="fa fa-cog"></i></a> ';
        return editO;
    }

    function deploy(id) {
        layer.confirm('确定要部署选中的记录？', {
            btn: ['确定', '取消']
        }, function () {
            $.ajax({
                url: url + "deploy",
                type: "POST",
                data: {
                    'id': id
                },
                success: function (r) {
                    dataTable_rep_message(r)
                }
            });
        })
    }

    /**
     * 格式化日期
     * @param now
     * @returns {string}
     */
    function formatDate(now) {
        var year = now.getFullYear();
        var month = now.getMonth()+1;
        var date = now.getDate();
        var hour = now.getHours();
        var minute = now.getMinutes();
        var second = now.getSeconds() > 10 ? now.getSeconds() : '0' + now.getSeconds();
        return year + "-" + month + "-" + date+ " " + hour + ":" + minute + ":" + second;
    }
</script>
</body>
</html>