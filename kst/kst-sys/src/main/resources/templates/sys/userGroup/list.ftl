<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>用户组管理</title>
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
<div class="col-sm-3" style="margin-top: 20px;">
    <button type="button" id="addRootBtn" onclick="addRootNode();" class="btn btn-group-sm btn-primary"
            role="dialog">
        <span class="glyphicon glyphicon-plus"></span><@spring.message "sys.userGroup.addRoot" />
    </button>
    <ul id="userGroupTree" class="ztree">
    </ul>
</div>
<div class="panel-body col-md-9" style="padding-bottom:0px;">
    <div id="toolbar" class="btn-group" style="padding-bottom:5px;">
        <button type="button" id="addChildBtn" onclick="addUserToOrgnization()" class="btn btn-group-sm btn-primary"
                role="dialog">
            <span class="glyphicon glyphicon-plus"></span><@spring.message "sys.user.addUser" />
        </button>
        <button type="button" id="updateBtn" onclick="removeSome()" class="btn btn-group-sm btn-danger"
                role="dialog">
            <span class="glyphicon glyphicon-remove"></span><@spring.message "common.button.deleteInBatches" />
        </button>
    </div>
    <input type="hidden" id="searchUserGroupId">
    <table id="userGroupTable" >

    </table>

</div>


<script type="text/javascript">
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        //初始加载table，
        initBootstrapTable();
        ztree();
    });

    /*
    树形菜单的点击事件
     */
    function onZtreeClick(event, treeId, treeNode) {
        $("#searchUserGroupId").val(treeNode.id);
        $("#userGroupTable").bootstrapTable('refresh');

    }

    /*
    bootstraptable 加载事件
    */
    function initBootstrapTable() {

        $('#userGroupTable').bootstrapTable({
            url: '${base}/sys/userGroup/loadUser',         //请求后台的URL（*）
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
                var userGroupId=$("#searchUserGroupId").val();

                if(userGroupId!=null && userGroupId!=0 && userGroupId!=""){
                    searchParams["id"]=userGroupId;
                    searchParams["startNo"]=(params.pageNumber-1)*params.pageSize;
                }
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams
                };
                return temp;
            },
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
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
                title: '<@spring.message "sys.home.No" />',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#userGroupTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#userGroupTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'loginName',
                title: '<@spring.message "sys.user.loginName" />'
            }, {
                field: 'nickName',
                title: '<@spring.message "sys.user.nickName" />'
            }, {
                field: 'email',
                title: '<@spring.message "sys.user.email" />'
            }, {
                field: 'tel',
                title: '<@spring.message "sys.user.tel" />'
            }, {
                field: 'operate',
                title: '<@spring.message "sys.user.operation" />',
                align: "center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            },
            ]
        });
    }

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="dt_remove(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span><@spring.message "common.button.delete" /></a>  '
        ].join('');
    }

    /*
        表格内的删除事件
    */
    function dt_remove(id) {
        layer.confirm('<@spring.message "sys.user.message.isDelete" />', {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            $.ajax({
                url: '${base}/sys/userGroup/deleteOneUser',
                type: "POST",
                data: {
                    'userId': id,
                    'userGroupId':$("#searchUserGroupId").val()
                },
                success: function (result) {
                    if(result.success){
                        $('button[name="refresh"]').click();
                        toastr.success('<@spring.message "sys.message.deleteSuccess" />');
                        layer.close(index);
                    }else{
                        toastr.error(result.message);
                        layer.close(index);
                    }
                }
            });
        })
    }
    /*
    批量删除
    */
    function removeSome(){
        var rows = $('#userGroupTable').bootstrapTable('getSelections');
        if(rows.length==0){
            toastr.warning("<@spring.message "sys.message.choiceDelete" />");
            return;
        }
        console.log(rows)
        layer.confirm("<@spring.message "sys.user.message.isDelete" />", {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            var userGroupId=$("#searchUserGroupId").val();
            var list=[];
            for (var i=0;i<rows.length;i++){
                list[i]={'userId':rows[i].id,'userGroupId':userGroupId}
            }
            $.ajax({
                url:'${base}/sys/userGroup/deleteSomeUser',
                type:'POST',
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(list),
                success:function (result) {
                    toastr.success('<@spring.message "sys.message.deleteSuccess" />');
                    layer.close(index);
                    $("#userGroupTable").bootstrapTable('refresh');
                }
            });
        });

    }
    /*
        添加用户
    */
    function addUserToOrgnization(){
        var userGroupId = $("#searchUserGroupId").val();
        if(userGroupId==null || userGroupId=="" || userGroupId==0){
            layer.alert("<@spring.message  "sys.userGroup.choiceGroup"/>", {icon: 7, title: '<@spring.message "sys.message.warning" />'})
        }else{
            layer.open({
                type: 2,
                title: '<@spring.message  "sys.user.addUser"/>',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '90%'],
                content: '${base}/sys/userGroup/addUserToUserGroup/'+userGroupId,
                btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
                yes: function (index, layero) {
                    //获取子页面，调用子页面方法获取选中值
                    var child=window[layero.find('iframe')[0]['name']];
                    var rows=child.getRows();
                    $.ajax({
                        url:'${base}/sys/userGroup/addUserToUserGroup',
                        type:'post',
                        dataType:"json",
                        contentType:"application/json",
                        data:JSON.stringify(rows),
                        success:function(){
                            toastr.success('<@spring.message "sys.message.addSuccess" />');
                            layer.close(index);
                            $("#userGroupTable").bootstrapTable('refresh');
                        }
                    })

                },
                end: function(){
                    //toastr.success('分配用户成功!');
                }
            });
        }
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
            edit:{
                enable: true,
                editNameSelectAll:true,
                removeTitle:'<@spring.message "sys.userGroup.deleteNode" />',
                renameTitle:'<@spring.message "sys.userGroup.editNode" />'
            },
            callback: {
                onClick: onZtreeClick,
                beforeRemove:beforeRemove,
                beforeEditName:beforeEditName,
                onDrop:function (event, treeId, treeNodes, targetNode, moveType) {
                    var zTree = $.fn.zTree.getZTreeObj("userGroupTree");
                    var node = zTree.getNodeByParam("id",treeNodes[0].id);
                    var parentNode=node.getParentNode();
                    var ret= new Array();
                    var r =getNodesId(treeNodes,ret).join(',');
                    $.ajax({
                        url:'${base}/sys/userGroup/moveNode',
                        type:'post',
                        data:{'parentId':(parentNode!=null?parentNode.id:null),'childNodes':r,'moveNodeId':treeNodes[0].id},
                        success:function () {

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
            url: '${base}/sys/userGroup/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#userGroupTree"), setting, data);
            }
        });
    }

    function getNodesId(nodes,ret) {
        nodes.forEach(function (r) {
            ret.push(r.id);
            if(r.children!=null){
                getNodesId(r.children,ret)
            }
        })
        return ret;
    }

    /*
    添加根节点
     */
    function addRootNode(){
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '<@spring.message "sys.userGroup.addRoot" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/sys/userGroup/addRoot',
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
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
                    toastr.success('<@spring.message "sys.userGroup.addNodeSuccess" />');
                }
            }
        });
    }

    /*
    自定义添加子节点按钮
     */
    function addHoverDom(treeId,treeNode){
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='<@spring.message "sys.menu.addChild" />' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var id=treeNode.id;
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) btn.bind("click", function(){
            $("#handle").val(0);
            layer.open({
                type: 2,
                title: '<@spring.message "sys.menu.addChild" />',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '90%'],
                content: '${base}/sys/userGroup/add/'+id,
                btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
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
                        toastr.success('<@spring.message "sys.userGroup.addNodeSuccess" />');
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
        layer.confirm('[\'<@spring.message "sys.menu.delete" />\', \'<@spring.message "common.button.cancel" />\']', {icon: 3, title: '提示'}, function (index) {
            var data = {
                'id': treeNode.id,
                'level':treeNode.level+1,
            }
            $.ajax({
                url: '${base}/sys/userGroup/delete',
                type: 'post',
                dataType:"json",
                contentType:"application/json",
                data: JSON.stringify(data),
                success: function (data) {
                    layer.closeAll('dialog');
                    ztree()
                }
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
            title: '<@spring.message "sys.userGroup.editNode" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/sys/userGroup/edit/'+id,
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
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
                    toastr.success('<@spring.message "sys.userGroup.editNodeSuccess" />');
                }
            }
        });
        return false;
    }



</script>
</body>
</html>