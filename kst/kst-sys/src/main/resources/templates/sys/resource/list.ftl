<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>系统资源管理</title>
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
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local"/>.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>

<div id="handle" type="text" hidden="hidden"></div>

<div class="col-md-3" style="margin-top: 20px;">
    <button type="button" id="addRootBtn" onclick="addRootNode();" class="btn btn-group-sm btn-primary"
            role="dialog">
        <span class="glyphicon glyphicon-plus"></span><@spring.message "sys.userGroup.addRoot" />
    </button>
    <ul id="directoryTree" class="ztree">
    </ul>
</div>
<div class="panel-body col-md-9" style="padding-bottom:0px;">
    <div id="toolbar" class="btn-group" style="padding-bottom:5px;">
        <button type="button" id="upload" onclick="uploadFile()" class="btn btn-group-sm btn-primary"
                role="dialog">
            <span class="glyphicon glyphicon-remove"></span><@spring.message "common.button.uploadFile" />
        </button>
        <button type="button" id="updateBtn" onclick="removeSome()" class="btn btn-group-sm btn-danger"
                role="dialog">
            <span class="glyphicon glyphicon-remove"></span><@spring.message "common.button.deleteInBatches" />
        </button>
        <button type="button" id="choiceType" onclick="choiceType()" class="btn btn-group-sm btn-info"
                role="dialog">
            <span class="glyphicon glyphicon-remove"></span><@spring.message "common.button.selectType" />
        </button>
    </div>
    <input type="hidden" id="searchDirectoryId">
    <table id="resourceTable">

    </table>

</div>


<script type="text/javascript">
    $(function () {
        toastr.options.positionClass = 'toast-center-center';
        //初始加载table，
        ztree();
        initBootstrapTable();
    });

    /*
    树形菜单的点击事件
     */
    function onZtreeClick(event, treeId, treeNode) {
        $("#searchDirectoryId").val(treeNode.id);
        $("#resourceTable").bootstrapTable('refresh');

    }

    /*
    bootstraptable 加载事件
    */
    function initBootstrapTable() {

        $('#resourceTable').bootstrapTable({
            url: '${base}/sys/resource/loadResource',         //请求后台的URL（*）
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
                var directoryId = $("#searchDirectoryId").val();

                if (directoryId != null && directoryId != 0 && directoryId != "") {
                    searchParams["id"] = directoryId;
                    searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
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
                title: '<@spring.message "sys.resource.type" />'
            }, {
                field: 'name',
                title: '<@spring.message "sys.resource.name" />',
                formatter: fileFormatter
            }, {
                field: 'fileSize',
                title: '<@spring.message "sys.resource.fileSize" />'
            }, {
                field: 'fileType',
                title: '<@spring.message "sys.resource.fileType" />'
            }, {
                field: 'remarks',
                title: '<@spring.message "sys.role.remarks" />'
            },{
                //     field: 'fileCreateDate',
                //     title: '文件创建时间'
                // }, {
                //     field: 'fileUpdateDate',
                //     title: '文件最后修改时间'
                // }, {
                field: 'operate',
                title: '<@spring.message "sys.user.operation" />',
                align: "center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            }
            ]
        });
    }


    //刷新
    function fresh() {
        $("#resourceTable").bootstrapTable('refresh');
    }

    <#--//操作格式自定义-->

    function operateFormatter(value, row, index) {//赋予的参数
        return [
            '<a href="javascript:void(0)" onclick="editResource(\'' + row.id + '\')" class="btn btn-primary"><span class="glyphicon glyphicon-cog" ></span><@spring.message "common.button.edit" /></a>  ',
            '<a href="javascript:void(0)" onclick="dt_remove(\'' + row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span><@spring.message "common.button.delete" /></a>  '

        ].join('');
    }

    //单独删除
    function dt_remove(id) {
        layer.confirm('<@spring.message "sys.resource.deleteFile" />', {icon: 3, title: '<@spring.message "sys.message.warning" />'}, function (index) {
            $.ajax({
                url: '${base}/sys/resource/deleteOneResource',
                type: "POST",
                data: {
                    'resourceId': id,
                    'directoryId': $("#searchDirectoryId").val()
                },
                success: function (result) {
                    if (result.success) {
                        $('button[name="refresh"]').click();
                        toastr.success('<@spring.message "sys.message.deleteSuccess" />');
                        layer.close(index);
                    } else {
                        toastr.error(result.message);
                        layer.close(index);
                    }
                }
            });
        })
    }

    //批量删除
    function removeSome() {
        var rows = $('#resourceTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("<@spring.message "sys.message.choiceDelete" />");
            return;
        }

        layer.confirm("<@spring.message "sys.user.message.isDelete" />", {icon: 3, title: '<@spring.message "sys.message.warning" />'}, function (index) {
            var directoryId = $("#searchDirectoryId").val();
            var list = [];
            for (var i = 0; i < rows.length; i++) {
                list[i] = {'resourceId': rows[i].id, 'directoryId': directoryId}
            }
            $.ajax({
                url: '${base}/sys/resource/deleteSomeResource',
                type: 'POST',
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(list),
                success: function (result) {
                    toastr.success('<@spring.message "sys.message.deleteSuccess" />');
                    layer.close(index);
                    $("#resourceTable").bootstrapTable('refresh');
                }
            });
        });
    }

    //修改文件类别
    function choiceType() {
        var rows = $('#resourceTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("<@spring.message "sys.resource.message.selectData" />");
            return;
        }

        layer.open({
            type: 2,
            title: '<@spring.message "sys.resource.message.selectFileType" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['35%', '30%'],
            content: '${base}/sys/resource/toFileType',
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {
                var list = [];
                var typeId = layer.getChildFrame('#search_eq_type_id', index).val();
                if (typeId == null || typeId == "") {
                    toastr.warning("<@spring.message "sys.resource.message.noClassify" />")
                } else {
                    for (var i = 0; i < rows.length; i++) {
                        list[i] = {'id': rows[i].id, 'typeId': typeId}
                    }
                    $.ajax({
                        url: '${base}/sys/resource/updateFileType',
                        type: 'post',
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(list),
                        success: function (data) {
                            toastr.success('<@spring.message "sys.message.editSuccess" />');
                            $('#resourceTable').bootstrapTable('refresh');
                        },
                        error: function () {
                            toastr.error("<@spring.message "sys.message.editFailed" />")
                            $('#resourceTable').bootstrapTable('refresh');
                        }
                    });
                }
                layer.close(index);
            }, end: function () {

            }
        });
    }

    //文件下载
    function fileFormatter(value, row, index) {
        return [
            "<a href='/sys/resource/outPutFile?id=" + row.id + "' title='<@spring.message "common.button.clickToDownload" />'  >" + row.name + "</a>"
        ].join("")
    }

    /*
    加载树形菜单
     */
    function ztree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示目录之间的连线
                selectedMulti: false,
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
            },
            treeNode: {
                icon: "./img/zTreeStandard.png"
            },
            edit: {
                enable: true,
                editNameSelectAll: true,
                removeTitle: '<@spring.message "common.button.deleteDirectory" />',
                renameTitle: '<@spring.message "common.button.editDirectory" />'
            },
            callback: {
                onClick: onZtreeClick,
                beforeRemove: beforeRemove,
                beforeEditName: beforeEditName,
                beforeDrag: function () {
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
            url: '${base}/sys/resource/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#directoryTree"), setting, data);
            },
            error: function () {
                console.log("ztree加载报错")
            }
        });
    }

    /*
    添加根目录
     */
    function addRootNode() {
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '<@spring.message "addNewRootMenu" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/sys/resource/addRoot',
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {

                // 获取弹出层中的form表单元素
                var formSubmit = layer.getChildFrame('form', index);
                // 获取表单中的提交按钮
                var submited = formSubmit.find('#btnConfirm');
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                submited.click();
                //layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 1) {
                    toastr.success('<@spring.message "sys.message.addSuccess" />!');
                }
            }
        });
    }

    /*
    自定义添加下级目录按钮
     */
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='<@spring.message "sys.directory.message.addChildNode" />' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var id = treeNode.id;
        var btn = $("#addBtn_" + treeNode.tId);
        if (btn) btn.bind("click", function () {
            $("#handle").val(0);
            layer.open({
                type: 2,
                title: '<@spring.message "sys.directory.message.addChildNode" />',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '90%'],
                content: '${base}/sys/resource/add/' + id,
                btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
                yes: function (index, layero) {

                    // 获取弹出层中的form表单元素
                    var formSubmit = layer.getChildFrame('form', index);
                    // 获取表单中的提交按钮
                    var submited = formSubmit.find('#btnConfirm');
                    // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                    submited.click();
                    //layer.close(index);//这块是点击确定关闭这个弹出层
                },
                end: function () {
                    var handle = $("#handle").val();
                    if (handle == 1) {
                        toastr.success('<@spring.message "sys.message.addSuccess" />');
                    }
                }
            });
        });

    }

    /*
    移除自定义按钮
     */
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_" + treeNode.tId).unbind().remove();
    };

    /*
    删除事件
     */
    function beforeRemove(treeId, treeNode) {
        var re = false;
        layer.confirm('<@spring.message "sys.directory.message.deleteDirectory" />', {icon: 3, title: '<@spring.message "sys.message.warning" />'}, function (index) {
            var data = {
                'id': treeNode.id,
                'level': treeNode.level + 1
            }
            $.ajax({
                url: '${base}/sys/resource/delete',
                type: 'post',
                data: {'directory': JSON.stringify(data)},
                success: function (data) {
                    layer.closeAll('dialog');
                    toastr.success("<@spring.message "sys.message.deleteSuccess" />");
                    ztree()
                },error:function () {
                    toastr.error("<@spring.message "sys.message.deleteFailed" />");
                }
            });
        });
        return re;
    }

    /*
    修改事件
     */
    function beforeEditName(treeId, treeNode) {
        id = treeNode.id;
        $("#handle").val(0);
        layer.open({
            type: 2,
            title: '<@spring.message "common.button.editDirectory" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['90%', '90%'],
            content: '${base}/sys/resource/edit/' + id,
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {

                // 获取弹出层中的form表单元素
                var formSubmit = layer.getChildFrame('form', index);
                // 获取表单中的提交按钮
                var submited = formSubmit.find('#btnConfirm');
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                submited.click();
                //layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function () {
                var handle = $("#handle").val();
                if (handle == 2) {
                    toastr.success('<@spring.message "sys.message.editSuccess" />');
                }
            }
        });
        return false;
    }

    /*
    上传文件
     */
    function uploadFile() {
        var id = $("#searchDirectoryId").val();
        if (id == null || id == 0 || id == "") {
            layer.alert("<@spring.message "sys.directory.message.selectDirectory" />", {icon: 7, title: '<@spring.message "sys.message.warning" />'})
        } else {
            layer.open({
                type: 2,
                title: '<@spring.message "common.button.uploadFile" />',
                maxmin: true,
                shadeClose: false, // 点击遮罩关闭层
                area: ['90%', '90%'],
                content: '${base}/sys/resource/uploadFile/' + id,
                btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
                yes: function (index, layero) {
                    var formSubmit = layer.getChildFrame('form', index);
                    var submited = formSubmit.find('#btnConfirm');
                    submited.click();
                    layer.close(index);
                    toastr.success('<@spring.message "sys.directory.message.uploadSuccess" />');
                },
                end: function () {
                    // setTimeout( function(){
                    //     $('#resourceTable').bootstrapTable('refresh');
                    // }, 1000 );
                }
            });
        }
    }

    function editResource(id) {
        layer.open({
            type: 2,
            title: '<@spring.message "sys.resource.message.editResource" />',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '80%'],
            content: '${base}/sys/resource/editResource/'+id,
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {
                var formSubmit = layer.getChildFrame('form', index);
                var submited = formSubmit.find('#btnConfirm');
                submited.click();
            },
            end: function () {
            }
        });
    }


</script>
</body>
</html>