<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>500--${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <meta name="description" content="${site.description}"/>
    <meta name="keywords" content="${site.keywords}"/>
    <meta name="author" content="${site.author}"/>
    <link rel="icon" href="${site.logo}">
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all" />
</head>
<body class="childrenBody">
<div style="text-align: center; padding:11% 0;">
    <i class="layui-icon" style="line-height:20rem; font-size:20rem; color: #393D50;">&#xe69c;</i>
    <p style="font-size: 20px; font-weight: 300; color: #999;">发生系统错误,请联系管理员</p>
    <p style="font-size: 20px; font-weight: 300; color: #999;" >
        <label style='color:red' id='errorMsg'></label>
    </p>
</div>
<script src="${base}/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script>
    var msg="${message}";
    if(msg=="1"){
        $("#errorMsg").html("媒体访问控制地址错误")
    }else if(msg=="2"){
        $("#errorMsg").html("系统过期")
    }else if (msg=="3"){
        $("#errorMsg").html("系统用户超出限制")
    }
</script>
</body>
</html>