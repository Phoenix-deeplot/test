<!DOCTYPE html>
<html>
<head>
    <title>模型管理</title>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div id="toolbar" class="btn-group">
        <button type="button" id="delBtn" onclick="batchRemove();"class="btn btn-danger">
            <span class="glyphicon glyphicon-remove" ></span>删除
        </button>
    </div>
    <table id="exampleTable" ></table>
    <input id="handle" name="handle" value="" hidden="hidden">
</div>


<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap table -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script type="text/javascript" src="${base}/static/assets/js/pre-loader.js"></script>
<script src="${base}/static/assets/plugins/sweetalert/js/sweetalert.min.js"></script>


<script>
    $(function () {
        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
        //初始化Table
        initBootstrapTable();
    });


    //初始化Table
    function initBootstrapTable() {
        $('#exampleTable').bootstrapTable({
            url: '${base}/process/list',         //请求后台的URL（*）
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
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                $("#searchForm ._search").each(function () {
                    if ("" != $(this).val()) {
                        searchParams[$(this).attr('name')] = $(this).val();
                    }
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
                    var pageSize = $('#exampleTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#exampleTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'name',
                title: '流程名称'
            }, {
                field: 'key',
                title: '模型标识'
            }, {
                field: 'name',
                title: '流程名称'
            }, {
                field: 'version',
                title: '版本号'
            }, {
                field: 'resourceName',
                title: '流程XML',
                align: 'center',
                formatter: function (value, row, index) {
                    let depId = row.deploymentId;
                    let fileName = row.resourceName;
                    return '<a href="#" onclick="goViewXml(\'' + depId + '\',\''+ fileName + '\')">' + value + '</a>';
                }
            }, {
                field: 'dgrmResourceName',
                title: '流程图片',
                align: 'center',
                formatter: function (value, row, index) {
                    let depId = row.deploymentId;
                    let fileName = row.dgrmResourceName;
                    return '<a href="#" onclick="goViewPng(\'' + depId + '\',\''+ fileName + '\')">' + value + '</a>';
                }
            }, {
                field: 'DEPLOY_TIME_',
                title: '状态'
            }, {
                title: '操作',
                field: 'id',
                align: 'center',
                formatter: function (value, row, index) {
                    return dt_delete_button(row)+dt_active_button(row);
                }
            }
            ]
        });
    };

    //预览Xml
    function goViewXml(DEPLOYMENT_ID_,FILENAME){
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: 'xml展示',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            //area: ['80%', '520px'],
            area: ['90%', '90%'],
            content: '${base}/process/goViewXml?deployId='+DEPLOYMENT_ID_+'&fileName='+encodeURI(encodeURI(FILENAME))
        });
    }

    //预览Png
    function goViewPng(DEPLOYMENT_ID_,FILENAME){
        $("#handle").attr("value",0);
        // iframe层
        layer.open({
            type: 2,
            title: '流程图展示',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            //area: ['80%', '520px'],
            area: ['90%', '90%'],
            content: '${base}/process/goViewPng?deployId='+DEPLOYMENT_ID_+'&fileName='+encodeURI(encodeURI(FILENAME))
        });
    }
    function dt_delete_button(row) {
        var deploymentId = row.deploymentId;
        var deleteO = '<a class="btn btn-warning btn-sm" href="#" title="删除"  mce_href="#" ' +
            'onclick="remove(\'' + deploymentId + '\')">删除</a> ';
        return deleteO;

    }
    function dt_active_button(row) {
        var value = '';
        var status = '';
        if (row.suspend === false) {
            value = '挂起';
            status = 'suspend';
        } else {
            value = '激活'
            status = 'active';
        }
        var procDefId = row.processonDefinitionId;
        var deleteO = '<a class="btn btn-warning btn-sm" href="#" ' +
            'title="挂起/激活"  mce_href="#" onclick="active(\'' + procDefId + '\', \'' + status + '\')"> ' + value + ' </a> ';
        return deleteO;
    }

    function active(procDefId, state) {
        $.ajax({
            url: '${base}/procdef/status',
            type: "POST",
            data: {
                'procDefId': procDefId,
                'status': state
            },
            success: function (r) {
                dataTable_rep_message(r)
            }
        });
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