<!DOCTYPE html>
<html>
<head>
    <title>图表统计</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
    <#--<link rel="stylesheet" href="${base}/static/plugins/highcharts/highcharts.css">-->
</head>
<body>
<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>
<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/layer/layer.js"></script>
<script src="${base}/static/plugins/highcharts/highcharts.js"></script>
<script src="${base}/static/plugins/highcharts/exporting.js"></script>
<script src="${base}/static/plugins/highcharts/highcharts-more.js"></script>
<script src="${base}/static/plugins/highcharts/series-label.js"></script>
<script src="${base}/static/plugins/highcharts/oldie.js"></script>
<script src="${base}/static/plugins/highcharts/highcharts-zh_CN.js"></script>
<script src="${base}/static/plugins/highcharts/no-data-to-display.js"></script>
<input type="hidden" id="pjId" value="${pjId}">

<div class="col-md-12">
    <div class="col-md-6">
        <div id="dayLine" style="max-width:800px;height:400px"></div>
    </div>
    <div class="col-md-6">
        <div id="rateLine" style="max-width:800px;height:400px"></div>
    </div>
</div>
<div class="col-md-12">
    <div class="col-md-6">
        <div id="deviationLine" style="max-width:800px;height:400px"></div>
    </div>
</div>
<hr style="width: 99%; size: 5;color: #000000 ;">


<script>
    //初始化
    $(function () {
        loadProjectChart();
    })

    $('.form_date').datetimepicker({
        format: 'yyyy-mm-dd',
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
    
    //加载项目图表
    function loadProjectChart() {
        $.ajax({
            url:'${base}/pjs/project/projectChart',
            type:'post',
            data:{'pjId':$("#pjId").val()},
            success:function (ret) {
                //整理数据
                var planDay=[];
                var factDay=[];
                var planRate=[];
                var factRate=[];
                var deviationValue=[];

                var dayDate=[];
                ret.forEach(function (r) {
                    planDay.push(r.planFinishDay);
                    factDay.push(r.factFinishDay);
                    planRate.push(r.planFinishRate);
                    factRate.push(r.factFinishRate);
                    deviationValue.push(r.dayDeviationValue);
                    dayDate.push(r.date);
                });
                var dayData=[{'name':'预定日数','data':planDay},{'name':'实际日数','data':factDay}];
                var rateData=[{'name':'预定比率','data':planRate},{'name':'实际比率','data':factRate}];
                var deviation=[{'name':'偏离值','data':deviationValue}]

                loadLineChart(dayData,dayDate,"dayLine","预定实际日数比较","日","天")
                loadLineChart(rateData,dayDate,"rateLine","预定实际比率比较","%","%")
                loadLineChart(deviation,dayDate,"deviationLine","预定实际日数偏离值","天","天")
            }
        })
    }

    //加载折线图
    function loadLineChart(data,xData, id, title, subtitle, yText) {
        var date = new Date();
        date.getMonth() - 11;
        var chart = Highcharts.chart(id, {
            title: {
                text: title
            },
            subtitle: {
                text: subtitle
            },
            lang: {
                noData: "没有找到数据" //真正显示的文本
            },
            yAxis: {
                title: {
                    text: yText
                }
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 10,
                dateTimeLabelFormats: {
                    day: '%Y%m'
                },
                categories:xData
            },
            credits: {
                enabled: false
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            // plotOptions: {
            //     series: {
            //         label: {
            //             connectorAllowed: false
            //         },
            //         pointStart: Date.UTC($("#selectDate").datetimepicker("getDate").getFullYear() - 1, $("#selectDate").datetimepicker("getDate").getMonth() + 1),
            //         pointInterval: 1,
            //         pointIntervalUnit: 'month'
            //     }
            // },
            series: data,
            responsive: {
                rules: [{
                    condition: {
                        maxWidth: 500
                    },
                    chartOptions: {
                        legend: {
                            layout: 'horizontal',
                            align: 'center',
                            verticalAlign: 'bottom'
                        }
                    }
                }]
            }
        });
    }

</script>
</body>
</html>