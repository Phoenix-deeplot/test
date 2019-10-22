<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>组织管理</title>
    <meta name="viewport" content="width=device-width" />
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- Bootstrap table -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
</head>
<body>

<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<!--bootstrap-table-->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>



<div class="box box-info" style="margin-bottom:0px;">
    <select name="search_eq_type_id" id="search_eq_type_id" class="form-control" title="请选择"
            data-width="100%">
    </select>
</div>


<script type="text/javascript">
    $(function () {
        selectFileType();
    })

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
            }
        });
    }
</script>
</body>
</html>