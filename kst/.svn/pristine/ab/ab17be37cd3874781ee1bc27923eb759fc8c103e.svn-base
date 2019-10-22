<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>组织管理</title>
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
        <span class="glyphicon glyphicon-plus"></span>新增根节点
    </button>
    <ul id="organizationTree" class="ztree">
    </ul>
</div>
<div class="panel-body col-md-9" style="padding-bottom:0px;">
    <div id="toolbar" class="btn-group" style="padding-bottom:5px;">
        <button type="button" id="addChildBtn" onclick="addUserToOrgnization()" class="btn btn-group-sm btn-primary"
                role="dialog">
            <span class="glyphicon glyphicon-plus"></span>添加用户
        </button>
        <button type="button" id="updateBtn" onclick="removeSome()" class="btn btn-group-sm btn-danger"
                role="dialog">
            <span class="glyphicon glyphicon-remove"></span>批量删除
        </button>
    </div>
    <input type="hidden" id="searchOrganId">
    <table id="organTable" >

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
        $("#searchOrganId").val(treeNode.id);
        $("#organTable").bootstrapTable('refresh');

    }

    /*
    bootstraptable 加载事件
    */
    function initBootstrapTable() {

        $('#organTable').bootstrapTable({
            url: '${base}/sys/organization/loadUser',         //请求后台的URL（*）
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
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#organTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#organTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
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
            }, {
                field: 'email',
                title: '邮箱'
            }, {
                field: 'tel',
                title: '电话'
            }, {
                field: 'operate',
                title: '操作',
                align: "center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            },
            ]
        });
    }

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="#" onclick="dt_remove(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  '
        ].join('');
    }

    /*
        表格内的删除事件
    */
    function dt_remove(id) {
        layer.confirm('确定要删除这条记录？', {icon: 3, title:'提示'}, function (index) {
            $.ajax({
                url: '${base}/sys/organization/deleteOneUser',
                type: "POST",
                data: {
                    'userId': id,
                    'organizationId':$("#searchOrganId").val()
                },
                success: function (result) {
                    if(result.success){
                        $('button[name="refresh"]').click();
                        toastr.success('删除成功!');
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
        var rows = $('#organTable').bootstrapTable('getSelections');
        if(rows.length==0){
            toastr.warning("请选择要删除的数据!");
            return;
        }
        console.log(rows)
        layer.confirm("确认要删除选中的数据吗?", {icon: 3, title:'提示'}, function (index) {
            var organizationId=$("#searchOrganId").val();
            var list=[];
            for (var i=0;i<rows.length;i++){
                list[i]={'userId':rows[i].id,'organizationId':organizationId}
            }
            $.ajax({
                url:'${base}/sys/organization/deleteSomeUser',
                type:'POST',
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(list),
                success:function (result) {
                    toastr.success('删除成功!');
                    layer.close(index);
                    $("#organTable").bootstrapTable('refresh');
                }
            });
        });

    }
    /*
        添加用户
    */
    function addUserToOrgnization(){
        var organId = $("#searchOrganId").val();
        if(organId==null || organId=="" || organId==0){
            layer.alert("请选择组织", {icon: 7, title: '警告'})
        }else{
            layer.open({
                type: 2,
                title: '添加用户',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '90%'],
                content: '${base}/sys/organization/addUserToOrganization/'+organId,
                btn: ['确定', '取消'],
                yes: function (index, layero) {
                    //获取子页面，调用子页面方法获取选中值
                    var child=window[layero.find('iframe')[0]['name']];
                    var rows=child.getRows();
                    $.ajax({
                        url:'${base}/sys/organization/addUserToOrganization',
                        type:'post',
                        dataType:"json",
                        contentType:"application/json",
                        data:JSON.stringify(rows),
                        success:function(){
                            toastr.success('添加成功!');
                            layer.close(index);
                            $("#organTable").bootstrapTable('refresh');
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
                removeTitle:'删除节点',
                renameTitle:'修改节点'
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
            url: '${base}/sys/organization/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#organizationTree"), setting, data);
            }
        });
    }

    /*
    添加根节点
     */
    function addRootNode(){
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '新增根节点',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/sys/organization/addRoot',
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
                    toastr.success('根节点添加成功!');
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
            + "' title='添加子节点' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var id=treeNode.id;
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) btn.bind("click", function(){
            $("#handle").val(0);
            layer.open({
                type: 2,
                title: '新增子节点',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '90%'],
                content: '${base}/sys/organization/add/'+id,
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
                        toastr.success('子节点添加成功!');
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
        layer.confirm('确定要删除选中的节点？这将会使得其下的所有子节点都删除？', {icon: 3, title: '提示'}, function (index) {
            var data = {
                'id': treeNode.id,
                'level':treeNode.level+1,
            }
            $.ajax({
                url: '${base}/sys/organization/delete',
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
            title: '修改节点',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/sys/organization/edit/'+id,
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
                    toastr.success('节点修改成功!');
                }
            }
        });
        return false;
    }



</script>
</body>
</html>