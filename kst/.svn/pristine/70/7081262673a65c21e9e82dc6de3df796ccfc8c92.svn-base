<!DOCTYPE html>
<html>
<head>
    <title>rfid管理</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <input type="hidden" id="handle">
    <#--<div class="panel panel-default">-->
        <#--<div class="panel-body">-->

        <#--</div>-->
    <#--</div>-->
    <div id="toolbar" class="btn-group">
        <button type="button" id="addBtn" onclick="rfid_add()" class="btn btn-primary" role="dialog">
            <span class="glyphicon glyphicon-plus"></span>新增
        </button>
        <button type="button" id="returnBtn" onclick="deleteSome()" class="btn btn-danger" role="dialog">
            <span class="glyphicon glyphicon-remove"></span>批量删除
        </button>
    </div>
    <table id="rfidTable" class="table table-condensed"></table>
</div>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<!-- Bootstrap select -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>

<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {

        $('#rfidTable').bootstrapTable({
                url: '${base}/sys/rfid/list',         //请求后台的URL（*）
                method: 'post',                      //请求方式（*）
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                dataType: "json",                   // 服务器返回的数据类型
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: true,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
                queryParams: function (params) {
                    var searchParams = {};
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
                //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
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
                columns: [{
                    checkbox: true
                },{
                    title: '序号',
                    align: 'center',
                    formatter: function (value, row, index) {
                        var pageSize = $('#rfidTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                        var pageNumber = $('#rfidTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                        return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                    }
                },{
                    field: 'id',
                    title: 'id',
                    visible: false
                },{
                    field: 'name',
                    title: '名称'
                },{
                    field: 'ip',
                    title: 'Ip'
                },{
                    field: 'com',
                    title: '端口',
                    align:'center'
                },{
                    field: 'location',
                    title: '地点'
                },{
                    field: 'canuse',
                    title: '是否可用',
                    align:"center",
                    formatter:function (value, row, index) {
                        var btn='<input class="switch" type="checkbox" name="canuse" id="canuse'+row.id+'"';
                        if (value){
                            btn+='checked';
                        }
                        btn+='/>'
                        return btn;
                    }
                },{
                    field: 'useflg',
                    title: '使用状态状态',
                    align: 'center',
                    formatter:function (value, row, index) {
                        if(value){
                            return "使用中";
                        }else {
                            return "未使用";
                        }
                    }
                },{
                    field: 'operate',
                    title: '操作',
                    align: "center",
                    formatter: operateFormatter //自定义方法，添加操作按钮
                }],
            onLoadSuccess: function () {
                initBootstrapSwitch();
            }
            });
    };

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="rfid_edit(\'' + row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span>编辑</a>  ',
            '<a href="javascript:void(0)" onclick="deleteOne(\'' + row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  ',
        ].join('');
    }

    //开关控件初始化
    function initBootstrapSwitch() {
        //!* bootstrap开关控件，初始化 *!/
        $('input[name="canuse"]').bootstrapSwitch({
            onText: "可用",      // 设置ON文本
            offText: "不可用",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "50",//设置控件宽度
        });

        $('input[name="canuse"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            var id = $(this).attr("id").substring(6);
            var flag = "";
            if (state == true) {
                console.log('可用');
                $(this).val(false);
                flag = true;
            } else {
                console.log('不可用');
                $(this).val(true);
                flag = false;
            }
            updateCanuse(id, flag);
        });
    }

    //修改使用状态
    function updateCanuse(id,flag) {
        $.ajax({
            url: '${base}/sys/rfid/edit',
            type: 'post',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({'id': id, 'canuse': flag}),
            success: function (re) {
            }
        })
    }

    //新增
    function rfid_add() {
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '新增设备',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '80%'],
            content: '${base}/sys/rfid/add',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('#form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end:function () {
                if($("#handle").val()==1){
                    toastr.success("添加设备信息成功！");
                    re_load();
                }
            }
        });
    }

    //修改
    function rfid_edit(id) {
        $("#handle").val(0);
        layer.open({
            type:2,
            title:'修改设备',
            maxmin:'true',
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '90%'],
            content: '${base}/sys/rfid/edit/'+id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('#form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },end:function () {
                if($("#handle").val()==2){
                    toastr.success("修改设备信息成功！")
                    re_load();
                }
            }
        })
    }

    function re_load() {
        $("#rfidTable").bootstrapTable("refresh");
    }

    function deleteOne(id) {
        layer.confirm('是否要删除这个设备', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url:'${base}/sys/rfid/delete',
                type:'post',
                data:{"id":id},
                success:function (ret) {
                    if(ret.success){
                        toastr.success("删除成功")
                    }else{
                        toastr.error("删除失败")
                    }
                    re_load();
                }
            });
            layer.close(index)
        });
    }

    //批量删除
    function deleteSome() {
        var rows=$("#rfidTable").bootstrapTable("getSelections");

        if(rows.length==0){
            toastr.warning("请选择要删除的设备！")
            return;
        }

        layer.confirm('是否要删除选中的设备', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url:'${base}/sys/rfid/deleteSome',
                type:'post',
                dataType: "json",
                contentType: "application/json",
                data:JSON.stringify(rows),
                success:function (ret) {
                    if(ret.success){
                        toastr.success("删除成功")
                    }else{
                        toastr.error("删除失败")
                    }
                    layer.close(index)
                    re_load();
                }
            });
        });
    }
</script>
</body>
</html>