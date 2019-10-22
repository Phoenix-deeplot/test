<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
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


<div class="col-md-3" style="margin-top: 20px;">
    <ul id="directoryTree" class="ztree">
    </ul>
</div>
<div class="panel-body col-md-9" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form class="form-inline" id="searchForm">
                <div class="form-group" style="margin-right:20px">
                    <label for="s_file_name">文件名</label>
                    <input type="text" class="form-control _search" id="search_like_file_name" name="search_like_file_name" >
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_file_type">文件类型</label>
                    <input type="text" class="form-control _search" id="search_like_file_type" name="search_like_file_type">
                </div>
                <div class="form-group" style="margin-right:20px">
                    <label for="s_directory">分类</label>
                    <select id="search_eq_type_id" name="search_eq_type_id" class="selectpicker" title="请选择" data-width="100px">

                    </select>
                </div>
                <button type="button" style="margin-left:20px" onclick="re_load();" class="btn btn-primary">查询</button>
            </form>
        </div>
    </div>
    <input type="hidden" id="searchDirectoryId">
    <table id="resourceTable">

    </table>
</div>

<script type="text/javascript">
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        initBootstrapTable();
        selectFileType();
        ztree();
    });



    function ztree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示目录之间的连线
                selectedMulti: false,
            },
            treeNode: {
                icon: "./img/zTreeStandard.png"
            },
            callback: {
                onClick: onZtreeClick,
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
                },
            }
        };
        $.ajax({
            url: '${base}/isms/document/tree',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#directoryTree"), setting, data);
            },
            error: function () {
                console.log("ztree加载报错")
            }
        });
    }

    function onZtreeClick(event, treeId, treeNode) {
        var zTreeObj = $.fn.zTree.getZTreeObj(treeId);
        var selectedNodes = zTreeObj.getSelectedNodes();
        if(selectedNodes.length>0){
            $("#searchDirectoryId").val(selectedNodes[0].id);
        }else{
            $("#searchDirectoryId").val(null);
        }
        $("#resourceTable").bootstrapTable('refresh');



    }

    /*
    bootstraptable 加载事件
    */
    function initBootstrapTable() {

        $('#resourceTable').bootstrapTable({
            url: '${base}/isms/document/list',         //请求后台的URL（*）
            method: 'post',              //工具按钮用哪个容器
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
                var select=$("#search_eq_type_id").val();
                if (select!=null && select !=""){
                    searchParams["typeId"]=select;
                }
                if($("#searchDirectoryId").val()!=""||$("#searchDirectoryId").val()!="" ){
                    searchParams["id"]=$("#searchDirectoryId").val();
                }

                searchParams["name"]=$("#search_like_file_name").val();
                searchParams["fileType"]=$("#search_like_file_type").val();
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
                    var pageSize = $('#resourceTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#resourceTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'typeName',
                title: '分类'
            }, {
                field: 'name',
                title: '文件名',
                formatter: fileFormatter
            }, {
                field: 'fileSize',
                title: '文件大小'
            }, {
                field: 'fileType',
                title: '文件类型'
            // }, {
            //     field: 'fileCreateDate',
            //     title: '文件创建时间'
            // }, {
            //     field: 'fileUpdateDate',
            //     title: '文件最后修改时间'
            }, {
                field: 'operate',
                title: '操作',
                align: "center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            },
            ]
        });
    }


    //刷新
    function re_load(){
        $("#resourceTable").bootstrapTable('refresh');
    }

    <#--//操作格式自定义-->
    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="/sys/resource/outPutFile?id='+row.id+'"  class="btn btn-primary"><span class="glyphicon glyphicon-download" ></span>下载</a>  '
        ].join('');
    }

    //文件下载
    function fileFormatter(value, row, index) {
        return [
            "<a href='/sys/resource/outPutFile?id="+row.id+"' title='点击下载文件'  >"+row.name+"</a>"
        ].join("")
    }
    
    //查询type=sys_resource_category
    function selectFileType(){
        $.ajax({
            url:'${base}/isms/document/selectFileType',
            type:'post',
            success:function (data) {
                var options="<option value=''>请选择</option>";
                for (var i=0;i<data.length;i++){
                    console.log(data[i]);
                    options+="<option value='"+data[i].value+"'>"+data[i].label+"</option>";

                }
                $("#search_eq_type_id").append(options);
                $("#search_eq_type_id").selectpicker('refresh');
                $("#search_eq_type_id").selectpicker('render');
            },error:function () {
            }
        });
    }
</script>
</body>
</html>