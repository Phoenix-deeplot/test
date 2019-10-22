<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>问题管理</title>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base }/static/plugins/dropzone/css/dropzone.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">

    <style>
        .form-group {
            height: 55px;
        }

        #dropz {
            min-height: 340px;
            width: 80%;
            margin-bottom: 30px;
            background-color: white;
            align-self: center;
        }
        #dropzDa {
            min-height: 340px;
            width: 80%;
            margin-bottom: 30px;
            background-color: white;
            align-self: center;
        }
    </style>
</head>
<body>
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-<@spring.message "sys.message.local" />.js"></script>
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.<@spring.message "sys.message.local" />.js"></script>
<script src="${base}/static/plugins/dropzone/js/dropzone.min.js"></script>


<div style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="form">
        <input hidden="hidden" id="id" name="id" value="${question.id}"/>
        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="qusTitle"><@spring.message "sys.question.title" /></label>
                <div class="col-sm-6" >
                    <input type="text" id="qusTitle" name="qusTitle" class="form-control" placeholder="<@spring.message "sys.enter.title" />" value="${question.qusTitle}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="qusFlag"><@spring.message "sys.question.flag" /></label>
                <div class="col-sm-6">
                    <select id="qusFlag" name="qusFlag" class="form-control selectpicker" title="<@spring.message "sys.message.choice" />" data-width="200px">
                        <#list questionFlag as type>
                            <option value="${type.value}"
                                    <#if (question.qusFlag=='${type.value}')>selected</#if>>${type.label}</option>
                        </#list>
                    </select>
                </div>
            </div>
            <div id="status" class="form-group">
                <label class="col-sm-2 control-label" for="qusStatus"><@spring.message "sys.question.status" /></label>
                <div class="col-sm-6">
                    <#if ('${question.qusStatus}'!='0' && '${question.qusStatus}'!='')>
                        <select disabled  id="qusStatus" name="qusStatus" class="form-control selectpicker" title="<@spring.message "sys.message.choice" />" data-width="200px">
                                <#list questionStatus as type>
                                    <option value="${type.value}"
                                            <#if (question.qusStatus=='${type.value}')>selected</#if>>${type.label}</option>
                                </#list>
                        </select>
                    </#if>
                    <#if ('${question.qusStatus}'=='0' || '${question.qusStatus}'=='')>
                        <select  id="qusStatus" name="qusStatus" class="form-control selectpicker" title="<@spring.message "sys.message.choice" />" data-width="200px">
                            <#list questionStatus as type>
                                <option value="${type.value}"
                                        <#if (question.qusStatus=='${type.value}')>selected</#if>>${type.label}</option>
                            </#list>
                        </select>
                    </#if>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="qusEnable">是否公开</label>
                <div class="col-sm-6">
                    <div class="switch">
                        <#if (question??)>
                            <input type="checkbox" name="qusEnable" id="qusEnable"
                                   <#if (question.qusEnable == false)>checked</#if> />
                        <#else>
                            <input type="checkbox" name="qusEnable" id="qusEnable" checked/>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="form-group" style="height:100px;">
                <label class="col-sm-2 control-label"  for="qusPushdetail"><@spring.message "sys.question.content" /></label>
                <#if ('${question.qusStatus}'!='0' && '${question.qusStatus}'!='')>
                    <div class="col-sm-6">
                        <textarea disabled id="qusPushdetail" name="qusPushdetail" class="form-control" rows="4"
                                  placeholder="<@spring.message "sys.enter.content" />" >${question.qusPushdetail}</textarea>
                    </div>
                </#if>
                <#if ('${question.qusStatus}'=='0' || '${question.qusStatus}'=='')>
                    <div class="col-sm-6">
                        <textarea id="qusPushdetail" name="qusPushdetail" class="form-control" rows="4"
                                  placeholder="<@spring.message "sys.enter.content" />" >${question.qusPushdetail}</textarea>
                    </div>
                </#if>
            </div>
            <div id="da" class="form-group" style="height:100px;">
                <label class="col-sm-2 control-label"  for="qusRequestdetail"><@spring.message "sys.question.response" /></label>
                <div class="col-sm-6">
                    <textarea  id="qusRequestdetail" name="qusRequestdetail" class="form-control" rows="4"
                               placeholder="<@spring.message "sys.enter.response" />" >${question.qusRequestdetail}</textarea>
                </div>
            </div>

            <div class="form-group" style="margin-top: 50px">
                <label class="col-sm-2 control-label" for="remarks"><@spring.message "sys.user.remarks" /></label>
                <div class="col-sm-6">
                    <textarea id="remarks" name="remarks" class="form-control "
                              rows="4">${question.remarks}</textarea>
                </div>
            </div>
            <div id="ti" class="form-group">
                <div class="col-sm-6" >
                    <input type="text" id="qusPusher" name="qusPusher" class="form-control" placeholder="<@spring.message "sys.enter.title" />" value="${question.qusPusher}">
                </div>
            </div>

            <div class="form-group">
                <div id="resourceTool">
                    <input type="button" onclick="$('#dropz').click()" class="btn btn-info" value="<@spring.message "sys.add.attachments" />"/>
                    <input type="button" onclick="deleteAttachment()" class="btn btn-danger" value="<@spring.message "sys.delete.attachments" />"/>
                </div>
                <div class="col-sm-8 col-sm-offset-2">
                    <table id="resourceTable" class="table"></table>
                </div>
            </div>
            <div id="accessory" class="form-group">
                <div id="resourceToolDa">
                    <input type="button" onclick="$('#dropzDa').click()" class="btn btn-info" value="<@spring.message "sys.answerAdd.attachment" />"/>
                    <input type="button" onclick="deleteAttachmentDa()" class="btn btn-danger" value="<@spring.message "sys.answerDelete.attachment" />"/>
                </div>
                <div class="col-sm-8 col-sm-offset-2">
                    <table id="resourceTableDa" class="table"></table>
                </div>
            </div>

            <div id="assignPerson" class="form-group" ">
                <div style="width:620px; margin-left: 210px" class="col-sm-6" >
                    <input type="button" onclick="assignPerson()" class="btn btn-info" value="指定回答者"/>
                    <input type="text" id="qusDesignator" name="qusDesignator" value="${question.qusDesignator}" hidden/>
                    <input type="text" id="hideDesignator" name="hideDesignator" class="form-control" placeholder="请选择指定的人回答" value="${nickNames}" readonly/>
                </div>
            </div>

        </div>

        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span><@spring.message "sys.question.save" />
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span><@spring.message "sys.question.close" />
        </button>
        <!-- /.box-footer -->
    </form>
    <div align="center" class="col-sm-10 col-sm-offset-1" style="margin-bottom:0px;" hidden>
        <#--文件上传表单-->
        <form id="dropz" class=" well" enctype="multipart/form-data">
        </form>
    </div>

    <div align="center" class="col-sm-10 col-sm-offset-1" style="margin-bottom:0px;" hidden>
        <#--文件上传表单-->
        <form id="dropzDa" class=" well" enctype="multipart/form-data">
        </form>
    </div>
</div>


<script type="text/javascript">
    $(function () {
        $("#ti").hide();
        <#if ('${question.qusStatus}'=='')>
           $("#status").hide();
           $("#da").hide();
           $("#accessory").hide();
        </#if>
        <#if ('${da}'=='0')>
           $("#status").hide();
           $("#da").hide();
           $("#accessory").hide();
        </#if>
        <#if ('${da}'=='1')>
           $("#assignPerson").hide();
           $("#status").show();
           $("#da").show();
           $("#accessory").show();
        </#if>
        formValidator();
        loadResourceTable();
        loadResourceTableDa();
        initBootstrapSwitch();

        <#list question.attachs as attach >
            var c = $("#resourceTable").bootstrapTable('getData').length;
            $('#resourceTable').bootstrapTable('insertRow', {
                index: c, row: {
                    'id': "${attach.id}",
                    'name': "${attach.name}",
                    'fileSize': "${attach.fileSize}",
                    'fileType': "${attach.fileType}",
                    'remarks': "${attach.assetFlag}"
                }
            });
        </#list>

        <#list question.attachsDa as attach >
        var c = $("#resourceTableDa").bootstrapTable('getData').length;
        $('#resourceTableDa').bootstrapTable('insertRow', {
            index: c, row: {
                'id': "${attach.id}",
                'name': "${attach.name}",
                'fileSize': "${attach.fileSize}",
                'fileType': "${attach.fileType}",
                'remarks': "${attach.assetFlag}"
            }
        });
        </#list>

        $('#form').data("bootstrapValidator").enableFieldValidators("hideDesignator", false, "callback")

    });

    $('.form_date').datetimepicker({
        format: 'yyyy-mm-dd',
        language: '<@spring.message "sys.message.local" />',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

    //启用/停用开关初始化
    function initBootstrapSwitch() {
        //有则销毁（Destroy）
        $('input[name="qusEnable"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="qusEnable"]').bootstrapSwitch({
            onText: "公开",      // 设置ON文本
            offText: "指定",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="qusEnable"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                console.log('公开');
                $('#form').data("bootstrapValidator").enableFieldValidators("hideDesignator", false, "callback")
                $(this).val(false);
            } else {
                console.log('指定');
                $('#form').data("bootstrapValidator").enableFieldValidators("hideDesignator", true, "callback")
                $(this).val(true);
            }
        });

        $("#hideDesignator").on("change",function () {
            if($("#hideDesignator").val() ==""){
                $("#qusEnable").bootstrapSwitch("state",true)
            }else{
                $("#qusEnable").bootstrapSwitch("state",false)
            }
        })
    }


    /*
    表单验证
    */
    function formValidator() {

        var id = $('[name="id"]').val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }

        $("#form").bootstrapValidator({
            message: "<@spring.message "sys.user.validate.illegal" />",
            fields: {
                qusTitle: {
                    validators: {
                        notEmpty: {
                            message: '问题标题不能为空'
                        }
                    }
                },qusFlag:{
                    validators: {
                        notEmpty: {
                            message: '问题区分不能为空'
                        }
                    }
                },qusPushdetail:{
                    validators: {
                        notEmpty: {
                            message: '问题内容不能为空'
                        }
                    }
                },
                hideDesignator: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '指定的人不能为空',
                            callback: function (value, validator) {
                                if ($("#hideDesignator").val() == "") {
                                    return false;
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            // 设定默认提交方式，防止重复提交
            e.preventDefault();
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                var rows=$("#resourceTable").bootstrapTable("getData");
                var str=[];
                rows.forEach(function (r) {
                    str.push(r.id);
                })
                var rowsDa=$("#resourceTableDa").bootstrapTable("getData");
                var strDa=[];
                rowsDa.forEach(function (r) {
                    strDa.push(r.id);
                })
                var checkFlg = $("#qusEnable")[0].checked;
                //判断用户是否启用
                if (undefined == checkFlg || null == checkFlg || true == checkFlg) {
                    checkFlg = true;
                } else {
                    checkFlg = false;
                }

                var formdata={
                    "id":$('[name="id"]').val(),
                    "qusTitle":$("#qusTitle").val(),
                    "qusPushdetail":$("#qusPushdetail").val(),
                    "qusFlag":$("#qusFlag").val(),
                    "qusPushattachlist":str.join(","),
                    "qusRequestattachlist":strDa.join(","),
                    "qusDesignator":$("#qusDesignator").val(),
                    "qusEnable": !checkFlg,
                    "attachs":$("#resourceTable").bootstrapTable("getData"),
                    "attachsDa":$("#resourceTableDa").bootstrapTable("getData"),
                    "qusStatus":$("#qusStatus").val(),
                    "qusRequestdetail":$("#qusRequestdetail").val(),
                    "qusPusher":$("#qusPusher").val(),
                    "remarks":$("#remarks").val(),
                };

                var url = "";
                if(1 == mode){
                    url = "/sys/question/add";
                }else{
                    url = "/sys/question/edit?da=${da}";
                }
                //发送ajax请求
                $.ajax({
                    url: url,
                    type: 'POST',
                    dataType:"json",
                    contentType:"application/json",
                    data: JSON.stringify(formdata),
                    complete: function (question) {
                        console.log('完成了');
                    },
                    success: function (result) {
                        if(result.success){
                            //刷新父页面
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.$("#handle").val(mode);
                            parent.$("#questionTable").bootstrapTable("refresh");
                        }else{
                            toastr.error(result.message);
                        }

                    },error:function () {
                    }
                });

            }
        });
    }
    //指定人回答
    function assignPerson(){
        layer.open({
            type: 2,
            title: '人员信息',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['80%', '80%'],
            content: '${base}/sys/user/choiceUser',
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                var child = window[layero.find('iframe')[0]['name']];
                var nickName=[];
                for(var i=0;i<child.getUser().users.length;i++){
                    nickName[i] = child.getUser().users[i].nickName;
                }
                $("#hideDesignator").val(nickName).change();
                var ids = [];
                for(var i=0;i<child.getUser().users.length;i++){
                    ids[i] = child.getUser().users[i].id;
                }
                $("#qusDesignator").val(ids);
                layer.close(index);

            }, end: function () {

            }
        });
    }



    $("#qusRequestdate").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('qusRequestdate',
            'NOT_VALIDATED',null).validateField('qusRequestdate');
    });

    $("#qusPushdate").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('qusPushdate',
            'NOT_VALIDATED',null).validateField('qusPushdate');
    });

    function loadResourceTable() {
        $("#resourceTable").bootstrapTable({
            toolbar: '#resourceTool',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
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
                visible:false
            }, {
                field: 'name',
                title: '<@spring.message "sys.msg.attachName" />'
            }, {
                field: 'fileSize',
                title: '<@spring.message "sys.resource.fileSize" />'
            }, {
                field: 'fileType',
                title: '<@spring.message "sys.resource.fileType" />'
            }, {
                field: 'remarks',
                title: '<@spring.message "sys.role.remarks" />'
            }]
        })
    }


    function loadResourceTableDa() {
        $("#resourceTableDa").bootstrapTable({
            toolbar: '#resourceToolDa',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                title: '<@spring.message "sys.home.No" />',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#resourceTableDa').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#resourceTableDa').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible:false
            }, {
                field: 'name',
                title: '<@spring.message "sys.msg.attachName" />'
            }, {
                field: 'fileSize',
                title: '<@spring.message "sys.resource.fileSize" />'
            }, {
                field: 'fileType',
                title: '<@spring.message "sys.resource.fileType" />'
            }, {
                field: 'remarks',
                title: '<@spring.message "sys.role.remarks" />'
            }]
        })
    }


    function deleteAttachment(){
        var rows=$("#resourceTable").bootstrapTable("getSelections");
        if(rows.length<=0){
            toastr.warning("<@spring.message "sys.msg.choiceAttachDel"/>");
            return;
        }

        $.ajax({
            url:'${base}/sys/question/deleteAttachment',
            type: 'POST',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(rows),
            success:function (ret) {

            }
        })
        rows.forEach(function (r) {
            $("#resourceTable").bootstrapTable("remove",{field:"id", values:[r.id]})
        })
    };
    function deleteAttachmentDa(){
        var rows=$("#resourceTableDa").bootstrapTable("getSelections");

        if(rows.length<=0){
            toastr.warning("<@spring.message "sys.msg.choiceAttachDel"/>");
            return;
        }

        $.ajax({
            url:'${base}/sys/question/deleteAttachment',
            type: 'POST',
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(rows),
            success:function (ret) {

            }
        })
        rows.forEach(function (r) {
            $("#resourceTableDa").bootstrapTable("remove",{field:"id", values:[r.id]})
        })
    };

    $("#dropz").dropzone({   //配置dropzone
        url:"${base}/sys/question/uploadAttachment",
        method:"post",
        maxFiles: 10,  //一次上传的量
        maxFilesize: 1024,   //M为单位.pdf,.ppt,.pptx,.xls,.xlsx,.doc,.docx,.rar,.zip,.7z,.txt,
        acceptedFiles: "image/*,application/*,document/*,video/*,7z,.mp3,.txt", //可接受的上传类型
        //".jpg,.jpeg,.png,.doc,.docx,.ppt,.pptx,.txt,.avi,.pdf,.mp3,.zip",
        autoProcessQueue: true,     //是否自动上传，false时需要触发上传
        parallelUploads: 50,  //手动触发时一次最大可以上传多少个文件
        paramName: "file",          //后台接受文件参数名
        addRemoveLinks:true,
        filesizeBase: 1024,
        previewsContainer:"#dropz",
        //uploadMultiple:true,
        dictDefaultMessage: "<@spring.message "sys.dropzone.DefaultMessage"/>",      //上传框默认显示文字
        dictMaxFilesExceeded: "<@spring.message "sys.dropzone.MaxFilesExceeded"/>",
        dictResponseError: '<@spring.message "sys.dropzone.ResponseError"/>',
        dictInvalidFileType: "<@spring.message "sys.dropzone.InvalidFileType"/>",
        dictFallbackMessage:"<@spring.message "sys.dropzone.FallbackMessage"/>",
        dictFileTooBig:"<@spring.message "sys.dropzone.FileTooBig"/>",
        dictRemoveFile: '<@spring.message "sys.dropzone.RemoveFile"/>',
        init: function () {
            var self = this;
            $("#btnConfirm").on("click",function(){
                self.processQueue();
            });

            self.on('success',function(file,data) {
                var c = $("#resourceTable").bootstrapTable('getData').length;
                file.id=data[0].id
                $('#resourceTable').bootstrapTable('insertRow', {
                    index: c, row: data[0]
                });
            });

            self.on('removedfile',function (file) {
                alert(file.name+"  "+file.id)
            })

        }
    });

    $("#dropzDa").dropzone({   //配置dropzone
        url:"${base}/sys/question/uploadAttachment",
        method:"post",
        maxFiles: 10,  //一次上传的量
        maxFilesize: 1024,   //M为单位.pdf,.ppt,.pptx,.xls,.xlsx,.doc,.docx,.rar,.zip,.7z,.txt,
        acceptedFiles: "image/*,application/*,document/*,video/*,7z,.mp3,.txt", //可接受的上传类型
        //".jpg,.jpeg,.png,.doc,.docx,.ppt,.pptx,.txt,.avi,.pdf,.mp3,.zip",
        autoProcessQueue: true,     //是否自动上传，false时需要触发上传
        parallelUploads: 50,  //手动触发时一次最大可以上传多少个文件
        paramName: "file",          //后台接受文件参数名
        addRemoveLinks:true,
        filesizeBase: 1024,
        previewsContainer:"#dropzDa",
        //uploadMultiple:true,
        dictDefaultMessage: "<@spring.message "sys.dropzone.DefaultMessage"/>",      //上传框默认显示文字
        dictMaxFilesExceeded: "<@spring.message "sys.dropzone.MaxFilesExceeded"/>",
        dictResponseError: '<@spring.message "sys.dropzone.ResponseError"/>',
        dictInvalidFileType: "<@spring.message "sys.dropzone.InvalidFileType"/>",
        dictFallbackMessage:"<@spring.message "sys.dropzone.FallbackMessage"/>",
        dictFileTooBig:"<@spring.message "sys.dropzone.FileTooBig"/>",
        dictRemoveFile: '<@spring.message "sys.dropzone.RemoveFile"/>',
        init: function () {
            var self = this;
            $("#btnConfirm").on("click",function(){
                self.processQueue();
            });

            self.on('success',function(file,data) {
                var c = $("#resourceTableDa").bootstrapTable('getData').length;
                file.id=data[0].id
                $('#resourceTableDa').bootstrapTable('insertRow', {
                    index: c, row: data[0]
                });
            });

            self.on('removedfile',function (file) {
                alert(file.name+"  "+file.id)
            })

        }
    });

</script>
</body>
</html>