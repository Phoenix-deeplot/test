<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title></title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/plugins/jquery-treegrid/css/jquery.treegrid.css">
</head>

<body style="margin:10px 10px 0;">
    <div id="toolbar" class="btn-group">
        <button type="button" onclick="addRootMenu();" class="btn btn-primary">
            <span class="glyphicon glyphicon-plus" ></span>添加根权限
        </button>
    </div>

    <table id="menuTable"></table>
    <input id="handle" name="handle" value="" hidden="hidden">
</body>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table-treegrid.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/jquery-treegrid/js/jquery.treegrid.js"></script>

<script type="text/javascript">
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';

        //初始化Table
        initBootstrapTable();
    });

    //初始化Table
    function initBootstrapTable() {

        $('#menuTable').bootstrapTable({
            url: '${base}/sys/menu/treelist',         //请求后台的URL（*）
            idField: 'id',
            treeShowField: 'name',
            parentIdField: 'parentId',
            dataType:'json',
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            showRefresh: true,                  //是否显示刷新按钮
            columns: [
                { field: 'name',  title: '名称' },
                { field: 'href',  title: 'URL' },
                { field: 'showFlag', title: '状态', align:"center",
                    formatter : function(value, row, index) {
                        var c ="";
                        if(row.showFlag==true){
                            c = '<span class="label label-success">正常</span>';
                        }else{
                            c = '<span class="label label-default">停用</span>';
                        }
                        return c;
                    }
                },
                { field: 'permission', title: '权限标识'  },
                { field: 'sort',  title: '排序', align:"center" },
                { field: 'operate', title: '操作', align:"center",
                    formatter: operateFormatter //自定义方法，添加操作按钮
                },
            ],
            onLoadSuccess: function(data) {
                debugger;
               console.log(data);
                $('#menuTable').treegrid({
                    initialState: 'collapsed',// 所有节点都折叠
                    // initialState: 'expanded',// 所有节点都展开，默认展开
                    treeColumn: 0,
                    expanderExpandedClass: 'glyphicon glyphicon-triangle-bottom',
                    expanderCollapsedClass: 'glyphicon glyphicon-triangle-right',
                    onChange: function() {
                          $('#menuTable').bootstrapTable('resetWidth');
                    }
                });
                  //只展开树形的第一级节点
                  $('#menuTable').treegrid('getRootNodes').treegrid('expand');
            },
            onLoadError: function () {
                console.log("数据加载失败！");
            }
        });
    };

    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="#" onclick="addChildMenu(\''+ row.id + '\')" class="btn btn-primary"><span class="glyphicon glyphicon-plus" ></span> 添加子权限</a>  ',
            '<a href="#" onclick="editChildMenu(\''+ row.id + '\')" class="btn btn-warning"><span class="glyphicon glyphicon-pencil" ></span> 编辑</a>  ',
            '<a href="#" onclick="delMenu(\''+ row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span> 删除</a>  '
        ].join('');
    }

    /**
     * 新增根权限
     * @param id
     */
    function addRootMenu() {
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '新增根权限',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            //area: ['1200px', '660px'],
            area: ['90%', '90%'],
            resize: false,
            content: "${base}/sys/menu/add",
            btn: ['确定', '取消'],
            yes: function (index, layero) { //
                debugger;
                // 获取弹出层中的form表单元素
                var formSubmit=layer.getChildFrame('form', index);
                // 获取表单中的提交按钮（在我的表单里第一个button按钮就是提交按钮，使用find方法寻找即可）
                var submited = formSubmit.find('#btnConfirm');
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                submited.click();
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 1){
                    toastr.success('权限新增成功!');
                }
            }
        });
    }

    /**
     * 新增子权限
     * @param id
     */
    function addChildMenu(id) {
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '新增权限',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            //area: ['1200px', '660px'],
            area: ['90%', '90%'],
            resize: false,
            content: "${base}/sys/menu/add?parentId="+id,
            btn: ['确定', '取消'],
            yes: function (index, layero) { //
                debugger;
                // 获取弹出层中的form表单元素
                var formSubmit=layer.getChildFrame('form', index);
                // 获取表单中的提交按钮（在我的表单里第一个button按钮就是提交按钮，使用find方法寻找即可）
                var submited = formSubmit.find('#btnConfirm');
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                submited.click();
                //layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function(){
                var handle = $("#handle").val();
                if( handle == 1){
                    toastr.success('权限新增成功!');
                }
            }
        });
    }

    /**
     * 编辑菜单
     * @param id
     */
    function editChildMenu(id) {
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '编辑权限',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            //area: ['1200px', '660px'],
            area: ['90%', '90%'],
            resize: false,
            content: "${base}/sys/menu/edit?id="+id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                debugger;
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
                    toastr.success('权限编辑成功!');
                }
            }
        });
    }

    /**
     * 删除
     * @param url
     */
    function delMenu(id) {
        layer.confirm('确定要删除选中的记录？这将会使得其下的所有子项目都删除', {icon: 3, title:'提示'}, function (index) {
            $.ajax({
                url: "${base}/sys/menu/delete",
                type: "POST",
                data: {
                    'id': id
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

    //格式化时间
    Date.prototype.Format = function (fmt) {
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };
</script>

</html>