<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width"/>
    <title>预览二维码页面</title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- Bootstrap select -->


</head>
<body>
<form id="form">
    <div id="preview">

    </div>
    <button id="btnSubmit" style="margin-right: 20px;display: none" onclick="onprint()"></button>
</form>


<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>


<script>
    var upData = {};
    var length=0;
    $(function () {
        var rows = parent.$("#qrcodeList").val();
        var textDate=parent.$("#showTextList").val();
        //var deleteindex = parent.layer.msg('正在生成二维码，请稍候...', {icon: 16, time: false, shade: 0.8});
        $.ajax({
            url: '${base}/qrcode/createImage',
            type: "POST",
            //dataType: "json",
            //contentType:"application/json;charset=utf-8",
            data: {'qrcodeList':rows,'showTextList':textDate},
            success: function (result) {
                //parent.layer.close(deleteindex);
                upData = result;
                length=result.length;
                result.forEach(function (r, index) {
                    var img = "<div align='center' id='qrCode"+index+1+"'><label>二维码" + (index + 1) + "</label><br><div id= img"+(index+1)+"><img src='${base}" + r + "' style='width:700px;height: 800;border:lightgray 1px solid;align-items:center;'></div></div>";
                    $("#preview").append(img)
                })

            },error:function () {
            }
        });
    });

    <#--function doPrintQRcode() {-->
        <#--$.ajax({-->
            <#--url: '${base}/qrcode/printQrcode',-->
            <#--type: "POST",-->
            <#--dataType: "json",-->
            <#--contentType: "application/json",-->
            <#--data:JSON.stringify(upData) ,-->
            <#--success: function (result) {-->
                <#--deleteQrcodeImage();-->
            <#--}-->
        <#--});-->
        <#--window.print()-->
    <#--}-->

    //打印图片页面
    function printHtml(html) {
        var bodyHtml=document.body.innerHTML;
        document.body.innerHTML=html;
        window.print();
        document.body.innerHTML=bodyHtml;
    }

    //循环打开窗口的图片，逐个调用打印图片方法
    function onprint(){
        for (var i=0;i<length;i++){
            var html=$("#img"+(i+1)).html();
            printHtml(html);
        }
    }

    function deleteQrcodeImage(){
        $.ajax({
            url: '${base}/qrcode/deleteQrcodeImage',
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data:JSON.stringify(upData) ,
            success: function (result) {

            }
        });
    }

</script>
</body>
</html>