<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring>
    <meta charset="utf-8">
    <title>组织管理</title>
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
        <input hidden="hidden" id="id" name="id" value="${msg.id}"/>
        <div class="box-body">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="title"><@spring.message "sys.msg.title" /></label>
                <div class="col-sm-6" >
                    <input type="text" id="title" name="title" class="form-control" placeholder="<@spring.message "sys.pleaseEnter" /><@spring.message "sys.msg.title" />" value="${msg.title}">
                </div>
            </div>
            <div class="form-group" style="height:100px;">
                <label class="col-sm-2 control-label"  for="detail"><@spring.message "sys.msg.detail" /></label>
                <div class="col-sm-6">
                    <textarea id="detail" name="detail" class="form-control" rows="4"
                              placeholder="<@spring.message "sys.pleaseEnter" /><@spring.message "sys.msg.detail" />" >${msg.detail}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="level"><@spring.message "sys.msg.level" /></label>
                <div class="col-sm-6">
                    <select id="level" name="level" class="form-control selectpicker" title="<@spring.message "sys.message.choice" />" data-width="200px">
                        <#list msgTypes as type>
                            <option value="${type.value}"
                                    <#if (msg.level=='${type.value}')>selected</#if>>${type.label}</option>
                        </#list>
                    </select>
                </div>
            </div>
            <#--<div class="form-group">-->
                <#--<label class="col-sm-2 control-label" for="pushType"><@spring.message "sys.msg.pushType" /></label>-->
                <#--<div class="col-sm-6">-->
                    <#--<select id="pushType" name="pushType" class="form-control selectpicker" title="<@spring.message "sys.message.choice" />" data-width="200px">-->
                        <#--<#list pushTypes as type>-->
                            <#--<option value="${type.value}"-->
                                    <#--<#if (msg.pushType=='${type.value}')>selected</#if>>${type.label}</option>-->
                        <#--</#list>-->
                    <#--</select>-->
                <#--</div>-->
            <#--</div>-->
            <div class="form-group">
                <label class="col-sm-2 control-label" for="showFrom"><@spring.message "sys.msg.showFrom" /></label>
                <div class="col-sm-5">
                    <div id="showFrom" name="showFrom" class="input-group date form_date" data-date=""
                         data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text"
                               value="<#if msg.showFrom??>${msg.showFrom?string('yyyy-MM-dd')}</#if>" readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="showTo"><@spring.message "sys.msg.showTo" /></label>
                <div class="col-sm-5">
                    <div id="showTo" name="showTo" class="input-group date form_date" data-date=""
                         data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text"
                               value="<#if msg.showTo??>${msg.showTo?string('yyyy-MM-dd')}</#if>" readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" for="remarks"><@spring.message "sys.user.remarks" /></label>
                <div class="col-sm-6">
                    <textarea id="remarks" name="remarks" class="form-control "
                              rows="4">${msg.remarks}</textarea>
                </div>
            </div>
            <div class="form-group">
                <div id="resourceTool">
                    <input type="button" onclick="$('#dropz').click()" class="btn btn-info" value="<@spring.message "sys.msg.addAttach" />"/>
                    <input type="button" onclick="deleteAttachment()" class="btn btn-danger" value="<@spring.message "sys.msg.delAttach" />"/>
                </div>
                <div class="col-sm-8 col-sm-offset-2">
                    <table id="resourceTable" class="table"></table>
                </div>
            </div>
            <div class="form-group">
                <div id="userTool">
                    <input type="button" onclick="choiceUserGroup()" class="btn btn-info" value="<@spring.message "sys.msg.addVisibleUser" />"/>
                    <input type="button" onclick="deleteUserTable()" class="btn btn-danger" value="<@spring.message "sys.msg.delVisibleUser" />"/>
                </div>
                <div class="col-sm-8 col-sm-offset-2">
                    <table id="userTable" class="table"></table>
                </div>
            </div>
        </div>

        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
        <!-- /.box-footer -->
    </form>
    <div align="center" class="col-sm-10 col-sm-offset-1" style="margin-bottom:0px;" hidden>
        <#--文件上传表单-->
        <form id="dropz" class=" well" enctype="multipart/form-data">
        </form>
    </div>
</div>


<script type="text/javascript">
    var tableIds=[];//已存在的用户id集合
    $(function () {
        formValidator();
        loadResourceTable();
        loadUserTable();

        <#list msg.attachs as attach >
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
        <#list msg.userLists as user >
        var c = $("#userTable").bootstrapTable('getData').length;
        $('#userTable').bootstrapTable('insertRow', {
            index: c, row: {
                'id': "${user.id}",
                'loginName': "${user.loginName}",
                'nickName': "${user.nickName}"
            }
        });
        tableIds.push("${user.id}")
        </#list>
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
                title: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.msg.title" /><@spring.message "sys.user.validate.notEmpty" />'
                        }
                    }
                },
                detail: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.msg.detail" /><@spring.message "sys.user.validate.notEmpty" />'
                        },
                    }
                },
                level: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.msg.level" /><@spring.message "sys.user.validate.notEmpty" />'
                        },
                    }
                },
                pushType: {
                    validators: {
                        notEmpty: {
                            message: '<@spring.message "sys.msg.pushType" /><@spring.message "sys.user.validate.notEmpty" />'
                        },
                    }
                },
                showFrom: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '<@spring.message "sys.msg.validate.showFrom" />',
                            callback:function(value,validator){
                                var showFrom=$("#showFrom").find("input").val() != "" ? $("#showFrom").data("datetimepicker").getDate(): null;
                                var showTo=$("#showTo").find("input").val() != "" ? $("#showTo").data("datetimepicker").getDate(): null;
                                if((showFrom !=null && showTo==null) || (showFrom==null && showTo!=null)){
                                    return false;
                                }else if(showFrom !=null && showTo!=null){
                                    return showFrom.getTime()<=showTo.getTime();
                                }
                                return true;
                            }
                        }
                    }
                },
                showTo:{
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '<@spring.message "sys.msg.validate.showTo" />',
                            callback:function(value,validator){
                                var showFrom=$("#showFrom").find("input").val() != "" ? $("#showFrom").data("datetimepicker").getDate(): null;
                                var showTo=$("#showTo").find("input").val() != "" ? $("#showTo").data("datetimepicker").getDate(): null;
                                if((showFrom !=null && showTo==null) || (showFrom==null && showTo!=null)){
                                    return false;
                                }else if(showFrom !=null && showTo!=null){
                                    return showFrom.getTime()<=showTo.getTime();
                                }
                                return true;
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
                var formdata={
                    "id":$('[name="id"]').val(),
                    "level":$("#level").val(),
                    "title":$("#title").val(),
                    "detail":$("#detail").val(),
                    "attachlist":str.join(","),
                    "showFrom":$("#showFrom").find("input").val() != "" ? timeStampExchange($("#showFrom").data("datetimepicker").getDate()): null,
                    "showTo":$("#showTo").find("input").val() != "" ? timeStampExchange($("#showTo").data("datetimepicker").getDate()): null,
                    "attachs":$("#resourceTable").bootstrapTable("getData"),
                    "pushType":2,
                    "pushDate":new Date(),
                    "remarks":$("#remarks").val(),
                    "userLists":$("#userTable").bootstrapTable("getData"),
                };

                var url = "";
                if(1 == mode){
                    url = "/sys/msg/add";
                }else{
                    url = "/sys/msg/edit";
                }

                //发送ajax请求
                $.ajax({
                    url: url,
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
                            var index=parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            parent.$("#handle").val(mode);
                            parent.$("#msgTable").bootstrapTable("refresh");
                        }else{
                            toastr.error(result.message);
                        }
                    },error:function () {
                    }
                });
            }
        });
    }

    $("#showTo").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('showFrom',
            'NOT_VALIDATED',null).validateField('showFrom');
    });

    $("#showFrom").change(function () {
        $('#form').data('bootstrapValidator').updateStatus('showTo',
            'NOT_VALIDATED',null).validateField('showTo');
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


    function loadUserTable() {
        $("#userTable").bootstrapTable({
            toolbar: '#userTool',                //工具按钮用哪个容器
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
                    var pageSize = $('#userTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#userTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                //visible:false
            }, {
                field: 'loginName',
                title: '<@spring.message "sys.user.loginName" />'
            }, {
                field: 'nickName',
                title: '<@spring.message "sys.user.nickName" />'
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
            url:'${base}/sys/msg/deleteAttachment',
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

    $("#dropz").dropzone({   //配置dropzone
        url:"${base}/sys/msg/uploadAttachment",
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


    function choiceUserGroup() {
        layer.open({
            type: 2,
            title: '<@spring.message "sys.msg.choiceVisibleUser"/>',
            maxmin: true,
            shadeClose: false, // 点击遮罩关闭层
            area: ['100%', '100%'],
            content: '${base}/sys/userGroup/choiceUserByGroup',
            btn: ['<@spring.message "common.button.confirm" />', '<@spring.message "common.button.cancel" />'],
            yes: function (index, layero) {
                // 获取弹出层中的form表单元素
                var child = window[layero.find('iframe')[0]['name']];
                var ret=child.uploadGroupUser();
                ret.forEach(function (r) {
                    var c = $("#userTable").bootstrapTable('getData').length;
                    var check=true;
                    tableIds.forEach(function (id) {
                        if(id==r.id){
                            check=false;
                        }
                    })
                    if(check){
                        $('#userTable').bootstrapTable('insertRow', {
                            index: c, row: {
                                'id': r.id,
                                'loginName': r.loginName,
                                'nickName': r.nickName
                            }
                        });
                        tableIds.push(r.id)
                    }
                })
                layer.close(index);//这块是点击确定关闭这个弹出层
            },
            end: function () {
            }
        });
    }

    //删除table
    function deleteUserTable() {
        var rows=$("#userTable").bootstrapTable("getSelections");
        rows.forEach(function (r) {
            $("#userTable").bootstrapTable("removeByUniqueId",r.id)
            tableIds.forEach(function (id,index) {
                if(r.id==id){
                    tableIds.splice(index,1)
                }
            });
        });
    }

    //日期格式转换
    function timeStampExchange(time) {
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0"
            + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
            : datetime.getDate();
        var hour = datetime.getHours() < 10 ? "0" + datetime.getHours()
            : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes()
            : datetime.getMinutes();
        var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds()
            : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute
            + ":" + second;
    }
</script>
</body>
</html>