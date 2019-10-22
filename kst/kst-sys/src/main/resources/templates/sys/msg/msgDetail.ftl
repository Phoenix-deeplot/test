<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>组织管理</title>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <style>
        #textarea {
            display: block;
            margin: 0 auto;
            width: 98%;
            font-size: 14px;
            height: 18px;
            line-height: 24px;
            padding: 2px;
        }

        textarea {
            outline: 0 none;
            border-color: rgba(82, 168, 236, 0.8);
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
        }
    </style>

</head>
<body>
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>

<div style="margin-bottom:0px;">
    <input type="hidden" id="attachlist" value="${msg.attachlist}">
    <div align="center" class="col-sm-12" style="margin-bottom:0px;" >
        <div class="row" style="min-height: 60%;">
            <pre style="text-align: left;font-size:15px;margin-left: 5px;margin-right: 5px"><label style="margin-left: 10%">${msg.detail}</label></pre>

            <#--<textarea id="textarea" style="min-height: 250px;height: 100%;border: 0px;" class="form-control" rows="10" readonly>${msg.detail}</textarea>-->
        </div>
        <#if msg.attachlist?? && msg.attachlist!="">
            <div>
                <table id="attachTable" class="table table-condensed" style="line-height: 3px"></table>
            </div>
        </#if>

        <#if msg.pushType==1 >
            <div class="row">
                <br>
                <label class="col-sm-3 col-sm-offset-8"><@spring.message "sys.msg.sender" />：${msg.createBy}</label>
            </div>
        </#if>
    </div>
</div>

<script  type="text/javascript">
    $(function () {
        <#if msg.attachlist?? && msg.attachlist!="">
        initAttach();
        </#if>
    })
    
    function initAttach() {
        $('#attachTable').bootstrapTable({
            url: '${base}/sys/msg/getAttachList',         //请求后台的URL（*）
            method: 'post',              //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var searchParams={};
                searchParams["search_in_id"]=$("#attachlist").val().split(",");
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
            showRefresh: false,                  //是否显示刷新按钮
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
                    var pageSize = $('#attachTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#attachTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'name',
                title: '附件名',
                formatter: fileFormatter
            }, {
                field: 'fileSize',
                title: '附件大小'
            }, {
                field: 'fileType',
                title: '附件类型'
            }]
        });
    }

    function fileFormatter(value, row, index) {
        return [
            "<a href='${base}/sys/resource/outPutFile?id="+row.id+"' title='点击下载文件'  >"+row.name+"</a>"
        ].join("")
    }
</script>
</body>
</html>