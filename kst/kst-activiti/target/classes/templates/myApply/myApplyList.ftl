<!DOCTYPE html>
<html>
<head>
    <title>审核申请单</title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
</div>
<div class="box box-info" id="role_edit_table">
    <div id="toolbar" class="btn-group">
        <button  type="button" class="btn  btn-info" onclick="dt_apply()">
            <i class="fa fa-plus-square" aria-hidden="true"></i>新建申请单
        </button>
    </div>
    <form id="roleForm">

        <table id="taskListTable" ></table>
        <input id="name" name="name" value="" hidden="hidden">
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
        initBootstrapTable();
        //初始化表单
        //formValidator();
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
                    "applyer": $("#applyer").val(),
                    "name": $("#name").val()
                };
                console.log(formdata);

                //发送ajax请求
                $.ajax({
                    url: '${base}/workflow/accept',
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
                            parent.layer.close(index);
                            //toastr.success(result.message);
                        }else{
                            toastr.error(result.message);
                        }
                    }
                });
            }
        });
    }

    /**
     * 新建申请单
     */
    function dt_apply() {
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '资产申请单',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            //area: ['80%', '520px'],
            area: ['90%', '90%'],
            content: '${base}/myApply/applyShow',
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
                if( handle == 1){
                    toastr.success('用户添加成功!');
                }
            }
        });
    }

    /**
     * 打开编辑框
     * @param id
     */


    /**
     * 删除某条记录
     * @param url
     * @param id
     */

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
        let year = now.getFullYear();
        let month = now.getMonth()+1;
        let date = now.getDate();
        let hour = now.getHours();
        let minute = now.getMinutes();
        let second = now.getSeconds() > 10 ? now.getSeconds() : '0' + now.getSeconds();
        return year + "-" + month + "-" + date+ " " + hour + ":" + minute + ":" + second;
    }

    function initBootstrapTable() {
        $('#taskListTable').bootstrapTable({
            url: '${base}/myApply/list',       //请求后台的URL（*）
            method: 'post',                     //请求方式（*）
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
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                $("#searchForm ._search").each(function () {
                    // if ("" != $(this).val()) {
                    //     searchParams[$(this).attr('name')] = $(this).val();
                    // }
                });
                debugger;
                console.log(searchParams);
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
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#taskListTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#taskListTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            },{
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'flowId',
                title: '任务ID'
            }, {
                field: 'name',
                title: '资产名称'
            }, {
                field: 'filename',
                title: '流程文件名称'
            }, {
                field: 'applyer',
                title: '申请人'
            }, {
                field: 'applyStatus',
                title: '审核状态'
            }, {
                title: '操作',
                field: 'operator',
                align: 'center',
                formatter: operateFormatter //自定义方法，添加操作按钮
            }
            ]
        });
    };
    //操作格式自定义
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="#" onclick="dt_queryImg(\''+ row.flowId + '&'+ row.filename + '\')" class="btn btn-info"><span class="glyphicon glyphicon-search" ></span>查看流程图</a>  ',
            '<a href="#" onclick="dt_accept(\''+ row.flowId + '&' + row.id + '\')" class="btn btn-info"><span class="glyphicon glyphicon-ok" ></span>提交申請</a>  '
        ].join('');
    }
    /**
     * 打开查询框
     * @param id
     */
    function dt_queryImg(id) {
        debugger;
        var insId = id.split('&')[0];
        var file = id.split('&')[1];
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '资产转移编辑',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            //area: '80%',
            content: '${base}/workflow/openImg?instId='+insId+'&fileName='+encodeURI(encodeURI(file)),
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
                    toastr.success('申请信息编辑成功!');
                }
            }
        });
    }
    /**
     * 审核通过
     * @param id
     */
    function dt_accept(id) {
        var _id = id.split("&")[1];
        var _flowId = id.split("&")[0];
        var formdata={
            "flowId": _flowId,
            "id":_id
        };
    console.info('id='+_id);
        console.info('flowId='+_flowId);
        //发送ajax请求
        $.ajax({
            url: '${base}/workflow/accept',
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
                    parent.layer.close(index);
                    //toastr.success(result.message);
                }else{
                    $('button[name="refresh"]', window.document).click();
                    toastr.success(result.message);
                }
            }
        });
    }
</script>
</body>
</html>