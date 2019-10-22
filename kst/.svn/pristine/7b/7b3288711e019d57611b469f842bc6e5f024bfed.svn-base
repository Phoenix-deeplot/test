<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width"/>
    <title></title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">

    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->

    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link href="${base}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">
    <style type="text/css">
        .comments {
            width: 100%; /*自动适应父布局宽度*/
            overflow: auto;
            word-break: break-all;
            /*在ie中解决断行问题(防止自动变为在一行显示，主要解决ie兼容问题，ie8中当设宽度为100%时，文本域类容超过一行时，
            当我们双击文本内容就会自动变为一行显示，所以只能用ie的专有断行属性“word-break或word-wrap”控制其断行)*/
        }
    </style>

</head>
<body>
<form class="form-inline" id="searchForm">
    <div class="panel-body">
        <div class="form-group" style="margin-right:20px">
            <label for="asset_no">资产编号</label>
            <input type="text" class="form-control _search" id="asset_no" name="asset_no">
        </div>
        <div class="form-group" style="margin-right:20px">
            <label for="s_name">资产存放地点</label>
            <input type="text" class="form-control" id="locationName" readonly>
            <input type="text" name="location_id" id="locationId" class="_search" hidden>
        </div>
        <button type="button" class="btn btn-small" id="locationChoiceBtn" onclick="openLocationChoiceDig()">
            地点选择
        </button>
        <div class="form-group" style="margin-right:20px">
            <label for="examineResult_id">点检结果</label>
            <select name="examineResult_id" class="selectpicker _search" title="请选择"
                    data-width="150px">
                <option value="">请选择</option>
                <#list examineList as test>
                    <option value="${test.value}">${test.label}</option>
                </#list>
            </select>
        </div>
        <button type="button" style="margin-left:20px" onclick="$('#table').bootstrapTable('refresh')"
                class="btn btn-primary">查询
        </button>
    </div>
</form>
<div class="table-box" style="margin: 20px;">
    <div id="toolbar">
        <!--若editAbleFlg为1，则不显示增加点检明细按钮-->
        <#if editAbleFlg==2>
            <button type="button" id="addBtn" onclick="addExamineDetail();" class="btn btn-primary" role="dialog">
                <span class="glyphicon glyphicon-plus"></span>增加点检明细
            </button>
        </#if>
    </div>
    <form class="form-horizontal" id="editableForm">
        <table id="table">

        </table>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
        <!-- /.box-footer -->
    </form>
</div>

<div class="modal inmodal fade" id="myModal3" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">选择存放地点</h4>
            </div>
            <div class="col-sm-3" style="margin-top: 20px;">
                <ul id="locationTree" class="ztree">
                </ul>
            </div>
            <div class="modal-footer">
                <button id="closeBtn3" type="button" class="btn btn-primary">确认</button>
                <button id="resetBtn3" type="button" class="btn btn-default">清除</button>
            </div>
        </div>
    </div>
</div>
<!--资产查询-->

<!--地点查询-->

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>
<script>
    var editAble = ${editAbleFlg};
    var dataList = [];
    $(function () {
        toastr.options.positionClass = 'toast-center-center';

        var $table = $('#table');
        var $button = $('#button');
        var $getTableData = $('#getTableData');
        formValidator();
        $table.bootstrapTable({
            url: '${base}/ams/examine/research',         //请求后台的URL（*）ams:apply:list
            method: 'post',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                var searchParams = {};
                searchParams = {"EXAMINE_NO":${id}};
                searchParams["startNo"] = (params.pageNumber - 1) * params.pageSize;
                $("#searchForm ._search").each(function () {
                    if ("" != $(this).val()) {
                        searchParams[$(this).attr('name')] = $(this).val();
                    }
                });
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },
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
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $table.bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $table.bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'no',
                title: '点检编号',
                visible: false
            }, {
                field: 'assetNo',
                title: '资产编号'
            }, {
                field: 'name',
                title: '资产名称'
            }, {
                field: 'examineDate',
                title: '点检日'
            }, {
                field: 'examinerId',
                title: '点检者',
                formatter: function (value, row, index) {
                    var re = "";
                    <#list userList as types>
                    if ("${types.loginName}" == value) {
                        re = "${types.nickName}";
                    }
                    </#list>
                    return re;
                }
            }, {
                field: 'OK',
                title: 'OK',
                align:'center',
                width:'7%',
                formatter: function (value, row, index) {
                    if (row.examineResultId == 1) {
                        return "√";
                    }
                }
            }, {
                field: 'NG',
                title: 'NG',
                align:'center',
                width:'7%',
                formatter: function (value, row, index) {
                    if (row.examineResultId == 2) {
                        return "√";
                    }
                }
            }, {
                field: 'noExamine',
                title: '未点检',
                align:'center',
                width:'7%',
                formatter: function (value, row, index) {
                    if (row.examineResultId == 4) {
                        return "√";
                    }
                }
            }, {
                field: 'examineResultId',
                title: '点检结果',
                formatter: resultIdFormatter
            }, {
                field: 'reasonTxt',
                title: '理由',
                formatter: moreInfoFormatter
            }, {
                field: 'operate',
                title: '操作',
                align: "center",
                formatter: operateFormatter //自定义方法，添加操作按钮
            }],
            onPageChange: function () {
                if (editAble == 3) {
                    var examineArr = [];
                    var moreInfoArr = [];
                    var data={};
                    $("input[name^='examineResult']:checked").each(function (i) {
                        examineArr[i] = $(this).val();
                    });

                    $("input[name^='moreInfo']").each(function (i) {
                        moreInfoArr[i] = $(this).val();
                    });

                    for (var i = 0; i < dataList.length; i++) {
                        if(dataList[i].examineResultId==examineArr[i]){
                            dataList[i].examineResultId = examineArr[i];
                            dataList[i].reasonTxt = moreInfoArr[i];
                        }else{
                            dataList[i].examineResultId = examineArr[i];
                            dataList[i].examinerId="${currentUser.loginName}";
                            dataList[i].reasonTxt = moreInfoArr[i];
                        }
                    }

                    var url = "/ams/examine/editDetail";
                    //发送ajax请求
                    $.ajax({
                        url: url,
                        type: 'POST',
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(dataList),
                        complete: function (msg) {
                            console.log('完成了');
                        },
                        success: function (result) {
                        }
                    });
                }
            },
            onLoadSuccess:function () {//加载成功事件
                dataList = $table.bootstrapTable("getData", true);
            },
        });

        $("#examineResult_id").selectpicker('refresh');
        $("#examineResult_id").selectpicker('render');

        if (editAble == 1) {
            $("#table").bootstrapTable("hideColumn", "examineResultId");
            $("#table").bootstrapTable("hideColumn", "operate");
        } else if (editAble == 2) {
            $("#table").bootstrapTable("hideColumn", "examineResultId");
        } else if (editAble == 3) {
            $("#table").bootstrapTable("hideColumn", "operate");
            $("#table").bootstrapTable("hideColumn", "OK");
            $("#table").bootstrapTable("hideColumn", "NG");
            $("#table").bootstrapTable("hideColumn", "noExamine");
        }

        //操作格式自定义
        function operateFormatter(value, row, index) {//赋予的参数
            if (editAble == 2) {
                return [
                    '<a href="javascript:void(0)" onclick="dt_remove(\'' + row.id + '\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span>删除</a>  ',

                ].join('');
            } else {
                $('#addBtn').attr({"disabled": "disabled"});
                return [].join('');
            }
        }

        //点检结果
        function resultIdFormatter(value, row, index) {//赋予的参数
            if (editAble == 1 || editAble == 2) { // 不可点检
                if (value == 1) {
                    return ['OK:<input type="radio" disabled checked name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" disabled name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" disabled name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                } else if (value == 2) {
                    return ['OK:<input type="radio" disabled name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" disabled checked name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" disabled name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                } else if (value == 4) {
                    return ['OK:<input type="radio" disabled name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" disabled name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" disabled checked name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                } else {
                    return ['OK:<input type="radio" disabled checked name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" disabled name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" disabled name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                }
            } else {
                if (value == 1) {
                    return ['OK:<input type="radio" checked name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                } else if (value == 2) {
                    return ['OK:<input type="radio" name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" checked name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                } else if (value == 4) {
                    return ['OK:<input type="radio" name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" checked name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                } else {
                    return ['OK:<input type="radio" checked name=\'examineResult' + index + '\' value="1"> NG:<input type="radio" name=\'examineResult' + index + '\' value="2"> 未点检:<input type="radio" name=\'examineResult' + index + '\' value="4">'
                    ].join('');
                }
            }

        }
    });

    function moreInfoFormatter(value, row, index) {
        if (editAble == 1 || editAble == 2) {
            return value;
        } else {
            return ['<input type="text" class="form-control" name="moreInfo' + index + '" value="' + (value == null ? "" : value) + '" />'];
        }
    }

    /**
     * 打开新增框
     */
    function addExamineDetail() {
        var id = ${id};
        $("#handle").attr("value", 0);
        // iframe层
        layer.open({
            type: 2,
            title: '点检明细添加',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/ams/examine/addDetail/' + id,
            btn: ['确定', '取消'],
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
                    toastr.success('资产点检添加成功!');
                }
            }
        });
    }

    /**
     * 打开编辑框
     * @param id
     */
    <#--function dt_update(id) {-->
        <#--$("#handle").attr("value", 0);-->
        <#--// iframe层-->
        <#--layer.open({-->
            <#--type: 2,-->
            <#--title: '点检明细编辑',-->
            <#--maxmin: true,-->
            <#--shadeClose: false, // 点击遮罩关闭层-->
            <#--area: ['100%', '100%'],-->
            <#--//area: '80%',-->
            <#--content: '${base}/ams/examine/editDetail/' + id,-->
            <#--btn: ['确定', '取消'],-->
            <#--yes: function (index, layero) {-->
                <#--// 获取弹出层中的form表单元素-->
                <#--var formSubmit = layer.getChildFrame('form', index);-->
                <#--// 获取表单中的提交按钮-->
                <#--var submited = formSubmit.find('#btnConfirm');-->
                <#--// 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息-->
                <#--submited.click();-->
                <#--//layer.close(index);//这块是点击确定关闭这个弹出层-->
            <#--},-->
            <#--end: function () {-->
                <#--var handle = $("#handle").val();-->
                <#--if (handle == 2) {-->
                    <#--toastr.success('点检明细编辑成功!');-->
                <#--}-->
            <#--}-->
        <#--});-->
    <#--}-->

    /**
     * 删除某条记录
     * @param url
     * @param id
     */
    function dt_remove(id) {
        layer.confirm('确定要删除选中的记录？', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                url: '${base}/ams/examine/deleteDetail',
                type: "POST",
                data: {
                    'id': id
                },
                success: function (result) {
                    if (result.success) {
                        $('button[name="refresh"]').click();
                        toastr.success('删除成功!');
                        layer.close(index);
                    } else {
                        toastr.error(result.message);
                        layer.close(index);
                    }
                }
            });
        })
    }

    function formValidator() {
        $('#editableForm').bootstrapValidator({
            message: '输入值不合法',
            fields: {
                remarks: {
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 255,
                            message: '长度要在255个字符以内'
                        },
                    }
                }
            }
        }).on('success.form.bv', function (e) {

            // 设定默认提交方式，防止重复提交
            var examineArr = [];
            var moreInfoArr = [];
            e.preventDefault();
            var $form = $(e.target);
            $("input[name^='examineResult']:checked").each(function (i) {
                examineArr[i] = $(this).val();
            });

            $("input[name^='moreInfo']").each(function (i) {
                moreInfoArr[i] = $(this).val();
            });

            for (var i = 0; i < dataList.length; i++) {
                if(dataList[i].examineResultId==examineArr[i]){
                    dataList[i].examineResultId = examineArr[i];
                    dataList[i].reasonTxt = moreInfoArr[i];
                }else{
                    dataList[i].examineResultId = examineArr[i];
                    dataList[i].examinerId="${currentUser.loginName}";
                    dataList[i].reasonTxt = moreInfoArr[i];
                }
            }

            //进行表单验证 assetExamine
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                if (editAble == 3) {
                    var url = "/ams/examine/editDetail";
                    //发送ajax请求
                    $.ajax({
                        url: url,
                        type: 'POST',
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(dataList),
                        complete: function (msg) {
                            console.log('完成了');
                        },
                        success: function (result) {
                            if (result.success) {
                                //刷新父页面
                                parent.toastr.success('更新成功!');
                                var index = parent.layer.getFrameIndex(window.name);
                                parent.layer.close(index);
                            } else {
                                toastr.error(result.message);
                            }
                        }
                    });
                }else{
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }
            }
        });
    };

    function openLocationChoiceDig() {
        $('#myModal3').modal('show');
        initLocationBootstrapTable();
    }

    function initLocationBootstrapTable() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            callback: {
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
                }
            }
        };
        $.ajax({
            url: '${base}/ams/location/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#locationTree"), setting, data);
            }
        });
    }

    $("#closeBtn3").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("locationTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#locationId").val(nodes[0].id);
            $("#locationName").val(nodes[0].name).change();
        } else {
            $("#locationId").val(null);
            $("#locationName").val(null);
        }
        $('#myModal3').modal('hide');
    });


    $("#resetBtn3").click(function () {
        $("#locationId").val(null);
        $("#locationName").val(null);
        $('#myModal3').modal('hide');
    });

    // function locationChange() {
    //     if($("#locationName").val()=="" || $("#locationName").val()==null){
    //         $("#locationId").val(null);
    //     }
    // }

</script>
</body>
</html>