<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
    <title>用户管理</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <input id="qrcodeList" type="hidden">
    <input id="showTextList" type="hidden" >
    <div class="panel panel-default">
        <div class="panel-heading"><@spring.message "sys.home.queryCondition"/></div>
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_login_Name"><@spring.message "sys.user.loginName"/></label>
                    <input type="text" class="form-control _search" name="search_like_login_Name" >
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_email"><@spring.message "sys.user.email"/></label>
                    <input type="text" class="form-control _search" name="search_like_email">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_tel"><@spring.message "sys.user.tel"/></label>
                    <input type="text" class="form-control _search" name="search_like_tel">
                </div>
                <div class="form-group" style="margin-right:20px;">
                    <label for="s_disable_Flag"><@spring.message "sys.user.status"/></label>
                    <select id="s_disable_Flag" name="search_eq_disable_Flag" class="selectpicker _search" title="<@spring.message "sys.message.choice"/>" data-width="100px">
                        <option value=""><@spring.message "sys.message.choice"/></option>
                        <option value="1"><@spring.message "sys.blockUp"/></option>
                        <option value="0"><@spring.message "sys.message.normal"/></option>
                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary"><@spring.message "common.button.search"/></button>
            </form>
        </div>
    </div>

    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="addUser();" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus" ></span><@spring.message "common.button.addUser"/>
        </button>
        <button type="button" id="delBtn" onclick="batchRemove();"class="btn btn-danger">
            <span class="glyphicon glyphicon-remove" ></span><@spring.message "common.button.deleteInBatches"/>
        </button>
        <button type="button" id="printBtn" onclick="printQRCode();"class="btn btn-info">
            <span class="glyphicon glyphicon-print" ></span><@spring.message "common.button.printUser"/>
        </button>
        <button type="button" id="downloadBtn" onclick="downloadUserCSVData()" class="btn btn-default">
            <span class="glyphicon glyphicon-download" ></span><@spring.message "common.button.exportData"/>
        </button>
        <button type="button" id="rfid" onclick="choiceRfid()" class="btn btn-success">
            <span class="glyphicon glyphicon-tag" ></span>选择标签
        </button>
        <button type="button" id="rfid" onclick="initializeUserPassword()" class="btn btn-primary">
            <span class="glyphicon glyphicon-tag" ></span>初始化密码
        </button>
    </div>

    <table id="userTable"></table>
    <input id="handle" name="handle" value="" hidden="hidden">
</div><!-- /.panel-body -->

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local" />.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {
        $('#userTable').bootstrapTable({
            url: '${base}/sys/user/list',         //请求后台的URL（*）
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
                $("#searchForm ._search").each(function () {
                    if ("" != $(this).val()) {
                        searchParams[$(this).attr('name')] = $(this).val();
                        if($(this).attr('name')=='search_like_login_Name'){
                            searchParams[$(this).attr('name')] = $(this).val().toUpperCase();
                        }
                    }
                });
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize" : params.pageSize,
                    "pageNumber" : params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType : "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
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
            columns: [{
                checkbox: true
            }, {
                title: '<@spring.message "sys.home.No"/>',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#userTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#userTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'loginName',
                title: '<@spring.message "sys.user.loginName"/>'
            }, {
                field: 'nickName',
                title: '<@spring.message "sys.user.nickName"/>'
            }, {
                field: 'email',
                title: '<@spring.message "sys.user.email"/>'
            }, {
                field: 'tel',
                title: '<@spring.message "sys.user.tel"/>'
            }, {
                field: 'disableFlag',
                title: '<@spring.message "sys.user.status"/>',
                align:"center",
                formatter : function(value, row, index) {
                    var c ="";
                    if(row.disableFlag==true){
                        c = '<span class="label label-default"><@spring.message "sys.blockUp"/></span>';
                    }else if(row.locked==true){
                        c = '<span class="label label-default"><@spring.message "sys.message.lock"/></span>';
                    }else{
                        c = '<span class="label label-success"><@spring.message "sys.message.normal"/></span>';
                    }
                    return c;
                }
            }, {
                field: 'createDate',
                title: '<@spring.message "sys.user.createDate"/>',
                align:"center"
            }, {
                field: 'operate',
                title: '<@spring.message "sys.user.operation"/>',
                align:"center",
                formatter: operateFormatter //自定义方法，添加操作按钮
                },
            ]
            /*responseHandler: function(res) {
                if(res.state == 0){
                    return {
                        "total": res.data.total,//总页数
                        "rows": res.data.rows   //数据
                    };

                }
            }*/
        });
    };

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="dt_update(\''+ row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span><@spring.message "common.button.edit"/></a>  ',
            '<a href="javascript:void(0)" onclick="dt_remove(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span><@spring.message "common.button.delete"/></a>  '
        ].join('');
    }

    /**
     * 打开新增框
     */
    function addUser() {
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '<@spring.message "sys.user.addUser"/>',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            //area: ['80%', '80%'],
            content: '${base}/sys/user/add',
            btn: ['<@spring.message "common.button.confirm"/>', '<@spring.message "common.button.cancel"/>'],
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
                    toastr.success('<@spring.message "sys.user.message.addSuccess" />');
                }
            }
        });
    }

    /**
     * 打开编辑框
     * @param id
     */
    function dt_update(id) {
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '<@spring.message "sys.user.editUser"/>',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            //area: '80%',
            content: '${base}/sys/user/edit/'+id,
            btn: ['<@spring.message "common.button.confirm"/>', '<@spring.message "common.button.cancel"/>'],
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
                    toastr.success('<@spring.message "sys.user.message.editSuccess" />');
                }
            }
        });
    }

    /**
     * 删除某条记录
     * @param url
     * @param id
     */
    function dt_remove(id) {
        layer.confirm('<@spring.message "sys.user.message.isDelete" />', {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            $.ajax({
                url: '${base}/sys/user/delete',
                type: "POST",
                data: {
                    'id': id
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

    /**
     * 批量删除
     */
    function batchRemove() {
        var rows = $('#userTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("<@spring.message "sys.message.choiceDelete" />");
            return;
        }
        //var ids = '';
        //遍历所有选择的行数据，取每条数据对应的ID
        /*$.each(rows, function (i, row) {
            if(row['id'] === 1){
                layer.msg("不能删除超级管理员");
                return false;
            }
        });*/

        layer.confirm("<@spring.message "sys.user.message.isDelete" />", {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            var deleteindex = layer.msg('<@spring.message "sys.message.inDelete" />',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url: '${base}/sys/user/deleteSome',
                type: "POST",
                dataType:"json",
                contentType:"application/json",
                data: JSON.stringify(rows),
                success: function (result) {
                    layer.close(deleteindex);
                    if(result.success){
                        $('button[name="refresh"]').click();
                        toastr.success('<@spring.message "sys.message.deleteSuccess" />');
                        layer.close(index);
                    }else{
                        console.log(result.message);
                        toastr.error(result.message);
                        layer.close(index);
                    }
                }
            });
        })
    }

    /**
     * 重新加载表
     */
    function re_load() {
        $('#userTable').bootstrapTable('refresh');
    }

    //打印二维码
    function printQRCode() {
        var rows = $('#userTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("<@spring.message  "sys.user.choicePrint"/>");
            return;
        }
        var data=[];
        var showText=[];
        rows.forEach(function (r,index) {
            data.push(r.loginName);
            showText.push(r.nickName)
        })

        $("#qrcodeList").val(JSON.stringify(data));
        $("#showTextList").val(JSON.stringify(showText))

        layer.confirm("<@spring.message  "sys.user.surePrint"/>", {icon: 3, title: '<@spring.message  "sys.message.warning"/>'}, function (index) {
            layer.close(index);
            layer.open({
                type: 2,
                title: '<@spring.message "sys.message.printPreview"/>',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['80%', '100%'],
                content: '${base}/qrcode/previewQRcode',
                btn: ['<@spring.message  "common.button.print"/>', '<@spring.message  "common.button.cancel"/>'],
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

    function  downloadUserCSVData() {
        var rows = $('#userTable').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
        if (rows.length == 0) {
            toastr.warning("<@spring.message "sys.user.choiceDownload" />");
            return;
        }
        var ids=[];
        rows.forEach(function (r) {
           ids.push(r.id)
        });

        layer.confirm("确认要导出选中的数据？", {icon: 3, title: '<@spring.message  "sys.message.warning"/>'}, function (index) {
            window.location='${base}/sys/user/downloadUserCSVData?ids='+ids;
            layer.close(index)
        });
    }

    //给用户绑定标签
    function choiceRfid() {
        var rows=$("#userTable").bootstrapTable("getSelections");

        if(rows.length==0){
            toastr.warning("请选择要绑定的用户");
            return;
        }

        var userIds=[];
        rows.forEach(function (r) {
            userIds.push(r.id)
        })

        layer.open({
            type: 2,
            title: '绑定标签',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '100%'],
            content: '${base}/sys/rfid/choiceRfid/'+userIds,
            btn: ['<@spring.message  "common.button.confirm"/>', '<@spring.message  "common.button.cancel"/>'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function () {

            }
        });
    }

    //初始化用户密码
    function initializeUserPassword() {
        var rows=$("#userTable").bootstrapTable("getSelections");

        if(rows.length==0){
            toastr.warning("请选择要初始化密码的用户");
            return;
        }

        layer.confirm("确定要初始化选中用户的密码？", {icon: 3, title:'<@spring.message "sys.message.warning" />'}, function (index) {
            $.ajax({
                url: '${base}/sys/user/initialize',
                type: "POST",
                dataType:"json",
                contentType:"application/json",
                data: JSON.stringify(rows),
                success: function (result) {
                    if(result.success){
                        toastr.success('初始化密码成功');
                    }else{
                        if(result.message=="fail"){
                            toastr.error("初始化密码失败");
                        }else{
                            toastr.error("初始化密码失败，没有权限");
                        }

                    }
                },error:function () {
                    toastr.error("初始化密码失败，没有权限");
                }
            });
            layer.close(index);
        })
    }
    
</script>
</body>
</html>