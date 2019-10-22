<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>组织管理</title>
    <meta name="viewport" content="width=device-width" />
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base }/static/plugins/dropzone/css/dropzone.css">
    <style>
        .form-group {
            height: 55px;
        }

        #dropz {
            min-height: 340px;
            width: 100%;
            margin-right: -810px;
            margin-bottom: 30px;
            background-color:white;
        }
    </style>
</head>
<body>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/dropzone/js/dropzone.min.js"></script>


<div class="box box-info" style="margin-bottom:0px;">
    <#--文件上传表单-->
    <form id="dropz" class="dropzone well" enctype="multipart/form-data">
        <input type="button" id="btnConfirm" class="btn btn-primary" value="保存" style="margin-right: 20px;display:none" >
    </form>
</div>

<script type="text/javascript">

    /*
       文件上传
    */
    $("#dropz").dropzone({   //配置dropzone
        url:"${base}/sys/resource/uploadFile",
        method:"post",
        maxFiles: 10,  //一次上传的量
        maxFilesize: 1024,   //M为单位.pdf,.ppt,.pptx,.xls,.xlsx,.doc,.docx,.rar,.zip,.7z,.txt,
        acceptedFiles: "image/*,application/*,document/*,video/*,7z,.mp3,.txt", //可接受的上传类型
        //".jpg,.jpeg,.png,.doc,.docx,.ppt,.pptx,.txt,.avi,.pdf,.mp3,.zip",
        autoProcessQueue: false,     //是否自动上传，false时需要触发上传
        parallelUploads: 10,  //手动触发时一次最大可以上传多少个文件
        paramName: "file",          //后台接受文件参数名
        addRemoveLinks:true,
        filesizeBase: 1024,
        previewsContainer:"#dropz",
        //uploadMultiple:true,
        dictDefaultMessage: "拖入需要上传的文件",      //上传框默认显示文字
        dictMaxFilesExceeded: "您最多只能上传10个文件！",
        dictResponseError: '文件上传失败!',
        dictInvalidFileType: "你不能上传该类型文件",
        dictFallbackMessage:"浏览器不受支持",
        dictFileTooBig:"文件过大上传文件最大支持.",
        dictRemoveFile: '移除文件',
        init: function () {
            var self = this;
            $("#btnConfirm").on("click",function(){
                self.processQueue();
            });
            self.on('sending', function (data, xhr, formData) {
                //向后台发送该文件的参数
                formData.append('directoryId', ${directoryId});
            });
        }
    });
</script>
</body>
</html>