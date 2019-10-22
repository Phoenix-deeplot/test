<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>场所管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">

    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">

    <style>
        #role_edit_table .control-label {
            margin-left: -60px;
        }

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

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!--bootstrap-table-->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>

<div id="handle" type="text" hidden="hidden"></div>
<input type="hidden" id="qrcodeList">
<input type="hidden" id="showTextList">
<div class="col-sm-5" style="margin-top: 20px;">
    <button type="button" id="addRootBtn" onclick="addRootNode();" class="btn btn-group-sm btn-primary"
            role="dialog">
        <span class="glyphicon glyphicon-plus"></span>新增场所
    </button>
    <button type="button" id="printQRCode" onclick="printQRCode();" class="btn btn-group-sm btn-info"
            role="dialog">
        <span class="glyphicon glyphicon-print"></span>打印场所二维码
    </button>
    <button type="button" id="printQRCode" onclick="downloadCSVFile();" class="btn btn-group-sm btn-default"
            role="dialog">
        <span class="glyphicon glyphicon-download"></span>导出数据(Excel)
    </button>
    <ul id="locationTree" class="ztree">
    </ul>
</div>


<script type="text/javascript">
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        ztree();
    });

    /*
    树形菜单的点击事件
     */
    function onZtreeClick(event, treeId, treeNode) {

    }


    /*
    加载树形菜单
     */
    function ztree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
            },
            check: {
                enable: true,   //true / false 分别表示 显示 / 不显示 复选框或单选框
                //autoCheckTrigger: true,   //true / false 分别表示 触发 / 不触发 事件回调函数
                chkStyle: "checkbox",   //勾选框类型(checkbox 或 radio）
                chkboxType: {"Y" : "", "N" : ""}   //勾选 checkbox 对于父子节点的关联关系
            },
            edit:{
                enable: true,
                editNameSelectAll:true,
                removeTitle:'删除场所',
                renameTitle:'修改场所'
            },
            callback: {
                onClick: onZtreeClick,
                beforeRemove:beforeRemove,
                beforeEditName:beforeEditName,
                beforeDrag:function () {
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
    添加基础场所
     */
    function addRootNode(){
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '新增场所',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/ams/location/addRoot',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit=layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 1){
                    toastr.success('场所添加成功!');
                }
            }
        });
    }

    /*
    自定义添加按钮
     */
    function addHoverDom(treeId,treeNode){
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='添加场所' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var id=treeNode.id;
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) btn.bind("click", function(){
            $("#handle").val(0);
            layer.open({
                type: 2,
                title: '新增场所',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '90%'],
                content: '${base}/ams/location/add/'+id,
                btn: ['确定', '取消'],
                yes: function (index, layero) {

                    // 获取弹出层中的form表单元素
                    var formSubmit=layer.getChildFrame('form', index);
                    // 获取表单中的提交按钮
                    var submited = formSubmit.find('#btnConfirm');
                    // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                    submited.click();
                    //layer.close(index);//这块是点击确定关闭这个弹出层
                },
                end: function(){
                    var handle = $("#handle").val();
                    if( handle == 1){
                        toastr.success('场所添加成功!');
                    }
                }
            });
        });

    }
    /*
    移除自定义按钮
     */
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_"+treeNode.tId).unbind().remove();
    };

    /*
    删除事件
     */
    function beforeRemove(treeId, treeNode){
        var re=false;
        layer.confirm('确定要删除选中的场所？这将会使得其下的所有场所都删除？', {icon: 3, title: '提示'}, function (index) {
            var data = {
                'id': treeNode.id,
                'level':treeNode.level+1
            }
            $.ajax({
                url: '${base}/ams/location/delete',
                type: 'post',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function (data) {
                    layer.closeAll('dialog');
                    ztree()
                },
            });
        });
        return re;
    }

    /*
    修改事件
     */
    function beforeEditName(treeId, treeNode){
        id=treeNode.id;
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '修改场所',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/ams/location/edit/'+id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {

                // 获取弹出层中的form表单元素
                var formSubmit=layer.getChildFrame('form', index);
                // 获取表单中的提交按钮
                var submited = formSubmit.find('#btnConfirm');
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                submited.click();
                //layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 2){
                    toastr.success('场所修改成功!');
                }
            }
        });
        return false;
    }

    //打开打印二维码
    function printQRCode(){
        var treeObj=$.fn.zTree.getZTreeObj("locationTree");
        var nodes=treeObj.getCheckedNodes(true);
        if(nodes.length==0){
            toastr.warning("请选择要打印二维码的数据!");
            return;
        }
        var data=[];
        var text=[];
        nodes.forEach(function (r,index) {
            data.push(r.id);
            text.push(r.name)
        });
        $("#qrcodeList").val(JSON.stringify(data));
        $("#showTextList").val(JSON.stringify(text))
        layer.confirm("确认要打印选中的数据的二维码吗?", {icon: 3, title: '提示'}, function (index) {
            layer.close(index);
            layer.open({
                type: 2,
                title: '打印预览',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['80%', '100%'],
                content: '${base}/qrcode/previewQRcode',
                btn: ['打印', '取消'],
                yes: function (index, layero) {
                    var formSubmit = layer.getChildFrame('form', index);
                    var submited = formSubmit.find('#btnSubmit');
                    submited.click();
                    layer.close(index);//这块是点击确定关闭这个弹出层
                },
                end: function () {

                }
            });
        });
    }

    function downloadCSVFile() {
        var treeObj=$.fn.zTree.getZTreeObj("locationTree");
        var nodes=treeObj.getCheckedNodes(true);
        if(nodes.length==0){
            toastr.warning("请选择要导出的数据!");
            return;
        }

        var ids=[];
        nodes.forEach(function (r) {
            ids.push(r.id)
        })
        window.location='${base}/ams/location/downloadLocationCSVFile?ids='+ids;
    }


</script>
</body>
</html>