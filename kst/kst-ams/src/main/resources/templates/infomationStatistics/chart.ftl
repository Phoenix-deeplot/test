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

<div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline" id="searchForm">
            <div class="form-group" style="margin-right:20px">
                <label for="s_name">日期</label>
                <div id="selectDate" onchange="loadPieData()" class="input-group date form_date col-md-9" data-date=""
                     data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="col-md-4">
    <div id="amountPie" style="min-width:250px;height:250px"></div>
</div>
<div class="col-md-4">
    <div id="pricePie" style="min-width:250px;height:250px"></div>
</div>
<div class="col-md-4">
    <div id="dividePricePie" style="min-width:250px;height:250px"></div>
</div>
<hr style="width: 99%; size: 5;color: #000000 ;">
<div id="classifyUseRatio" class="col-md-12"></div>
<hr style="width: 99%; size: 5;color: #000000;">
<div class="col-md-12">
    <div class="col-md-6">
        <div id="allAmountLine" style="max-width:800px;height:400px"></div>
    </div>
    <div class="col-md-6">
        <div id="allPriceLine" style="max-width:800px;height:400px"></div>
    </div>
</div>
<div class="col-md-12">
    <div class="col-md-6">
        <div id="assetAmountLine" style="max-width:800px;height:400px"></div>
    </div>
    <div class="col-md-6">
        <div id="assetPriceLine" style="max-width:800px;height:400px"></div>
    </div>
</div>
<div class="col-md-12">
    <div class="col-md-6">
        <div id="futureDivideAssetPriceLine" style="max-width:800px;height:400px">
        </div>
    </div>
</div>
<hr style="width: 99%; size: 5;color: #000000 ;">
<div class="col-md-12">
    <div id="assetPriceBar" class="col-md-10 col-md-offset-1 " style="min-width:400px;height:300px"></div>
</div>
<div class="col-md-12">
    <div id="assetAmountBar" class="col-md-10 col-md-offset-1" style="min-width:400px;height:300px"></div>
</div>
<div class="col-md-12">
    <div id="dividePriceBar" class="col-md-10 col-md-offset-1" style="min-width:400px;height:300px"></div>
</div>


<script>
    //初始化
    $(function () {
        $("#selectDate").datetimepicker("setDate", new Date());
        loadPieData();
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

    function loadPieData() {
        //根据资产类型查询资产使用比例的数据（仪表图）
        $.ajax({
            url: '${base}/ams/infomationStatistics/selectUseRatio',
            type: 'POST',
            data: {'selectDate': new Date($("#selectDate").datetimepicker("getDate"))},
            success: function (ret) {
                var html = $("#classifyUseRatio").html().length;
                if (html <= 10) {
                    ret.forEach(function (r) {
                        var div = "<div class='col-md-4'>" +
                            "<div id='" + r.classifyId + "' style='min-width: 310px; max-width: 400px; height: 300px; margin: 0 auto'></div>" +
                            "</div>"
                        $("#classifyUseRatio").append(div);
                    });
                }
                ret.forEach(function (r) {
                    selectUseRatio(r)
                })
            }, error: function () {
            }
        })
        //加载饼图
        $.ajax({
            url: '${base}/ams/infomationStatistics/selectPieData',
            type: 'POST',
            data: {'selectDate': new Date($("#selectDate").datetimepicker("getDate"))},
            success: function (ret) {
                var amountDatas = [];
                var priceDatas = [];
                var dividePriceDatas = [];
                ret.forEach(function (r) {

                    var amountData = {'name': r.classifyName, 'y': r.amount}
                    var priceData = {'name': r.classifyName, 'y': r.price}
                    var dividePriceData = {'name': r.classifyName, 'y': r.dividePrice}
                    amountDatas.push(amountData);
                    priceDatas.push(priceData);
                    dividePriceDatas.push(dividePriceData);
                })
                loadPieMap("amountPie", amountDatas, "资产数量分布图")
                loadPieMap("pricePie", priceDatas, "资产价值分布图")
                loadPieMap("dividePricePie", dividePriceDatas, "固定资产折旧价值分布图")
            }, error: function () {
            }
        })
        //加载折线图
        $.ajax({
            url: '${base}/ams/infomationStatistics/selectDivideAsset',
            type: 'POST',
            data: {'selectDate': new Date($("#selectDate").datetimepicker("getDate"))},
            success: function (ret) {
                var priceData = [];
                var amountData = [];
                var allPriceData = [];
                var allAmountData = [];
                ret.forEach(function (r) {
                    priceData.push({
                        'name': r.classifyName,
                        'data': r.everyMonthPrice
                    });
                    amountData.push({
                        'name': r.classifyName,
                        'data': r.everyMonthAmount
                    });
                    allPriceData.push({
                        'name': r.classifyName,
                        'data': r.everyMonthAllPrice
                    });
                    allAmountData.push({
                        'name': r.classifyName,
                        'data': r.everyMonthAllAmount
                    });
                })

                loadLineChart(priceData, 'assetPriceLine', '固定资产折旧剩余价值(过去一年)', '', '价值')
                loadLineChart(amountData, 'assetAmountLine', '固定资产折旧数量(过去一年)', '', '数量')
                loadLineChart(allPriceData, 'allPriceLine', '资产价值(过去一年)', '', '价值')
                loadLineChart(allAmountData, 'allAmountLine', '资产数量(过去一年)', '', '数量')
            }, error: function () {
            }
        })
        //加载柱状图
        $.ajax({
            url: '${base}/ams/infomationStatistics/selectBarGraphData',
            type: 'POST',
            data: {'selectDate': new Date($("#selectDate").datetimepicker("getDate"))},
            success: function (ret) {
                var allPriceData = [];
                var allAmountData = [];
                var priceData = [];
                ret.forEach(function (r) {
                    allPriceData.push({
                        'name': r.classifyName,
                        'data': r.everyMonthAllPrice
                    });
                    allAmountData.push({
                        'name': r.classifyName,
                        'data': r.everyMonthAllAmount
                    });
                    priceData.push({
                        'name': r.classifyName,
                        'data': r.everyMonthPrice
                    });
                })

                loadBarGraph(allPriceData, 'assetPriceBar', '资产报废价值预定(未来一年)', '', '价值', '元')
                loadBarGraph(allAmountData, 'assetAmountBar', '资产报废数量预定(未来一年)', '', '数量', '个')
                loadBarGraph(priceData, 'dividePriceBar', '固定资产折旧价值(未来一年)', '', '价值', '元')
                loadLineChart(priceData, 'futureDivideAssetPriceLine', '固定资产折旧价值(未来一年)', '', '数量')

            }, error: function () {
            }
        })
    }

    //生成饼图方法
    function loadPieMap(theId, data, title) {
        Highcharts.chart(theId, {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            credits: {
                enabled: false
            },
            title: {
                text: title
            },
            lang: {
                noData: "没有找到数据" //真正显示的文本
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                name: '占比',
                size: '90%',
                colorByPoint: true,
                data: data,
                dataLabels: {
                    distance: 5
                }
            }]
        })
    }

    //生成仪表图方法
    function selectUseRatio(data) {
        var classifyName = data.classifyName;
        var num = Number(Number(data.useCount) / Number(data.amount) * 100).toFixed(1);
        var chart = Highcharts.chart(data.classifyId, {
            chart: {
                type: 'gauge',
                plotBackgroundColor: null,
                plotBackgroundImage: null,
                plotBorderWidth: 0,
                plotShadow: false
            },
            title: {
                text: classifyName + '使用状况',
            },
            lang: {
                noData: "没有找到数据" //真正显示的文本
            },
            pane: {
                startAngle: -150,
                endAngle: 150,
                background: [{
                    backgroundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#FFF'],
                            [1, '#333']
                        ]
                    },
                    borderWidth: 0,
                    outerRadius: '109%'
                }, {
                    backgroundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#333'],
                            [1, '#FFF']
                        ]
                    },
                    borderWidth: 1,
                    outerRadius: '107%'
                }, {
                    // default background
                }, {
                    backgroundColor: '#DDD',
                    borderWidth: 0,
                    outerRadius: '105%',
                    innerRadius: '103%'
                }]
            },
            credits: {
                enabled: false
            },
            yAxis: {
                min: 0,
                max: 100,
                minorTickInterval: 'auto',
                minorTickWidth: 1,
                minorTickLength: 10,
                minorTickPosition: 'inside',
                minorTickColor: '#666',
                tickPixelInterval: 30,
                tickWidth: 2,
                tickPosition: 'inside',
                tickLength: 10,
                tickColor: '#666',
                labels: {
                    step: 2,
                    rotation: 'auto'
                },
                title: {
                    text: '%'
                },
                plotBands: [{
                    from: 0,
                    to: 60,
                    color: '#55BF3B' // green
                }, {
                    from: 60,
                    to: 80,
                    color: '#DDDF0D' // yellow
                }, {
                    from: 80,
                    to: 100,
                    color: '#DF5353' // red
                }]
            },
            series: [{
                name: '使用率',
                data: [Number(num)],
                tooltip: {
                    valueSuffix: ' %'
                }
            }]
        });
    }

    //生成折线图方法
    function loadLineChart(data, id, title, subtitle, yText) {
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
                }
            },
            credits: {
                enabled: false
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            plotOptions: {
                series: {
                    label: {
                        connectorAllowed: false
                    },
                    pointStart: Date.UTC($("#selectDate").datetimepicker("getDate").getFullYear() - 1, $("#selectDate").datetimepicker("getDate").getMonth() + 1),
                    pointInterval: 1,
                    pointIntervalUnit: 'month'
                }
            },
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

    //生成柱状图方法
    function loadBarGraph(data, id, title, subtitle, yText, unit) {
        var chart = Highcharts.chart(id, {
            chart: {
                type: 'column'
            },
            title: {
                text: title
            },
            lang: {
                noData: "没有找到数据" //真正显示的文本
            },
            subtitle: {
                text: subtitle
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 10,
                dateTimeLabelFormats: {
                    day: '%Y%m'
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: yText
                }
            },
            credits: {
                enabled: false
            },
            tooltip: {
                // head + 每个 point + footer 拼接成完整的 table
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} ' + unit + '</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                series: {
                    label: {
                        connectorAllowed: false
                    },
                    pointStart: Date.UTC($("#selectDate").datetimepicker("getDate").getFullYear(), $("#selectDate").datetimepicker("getDate").getMonth()),
                    pointInterval: 1,
                    pointIntervalUnit: 'month'
                }
            },
            series: data
        });
    }

</script>
</body>
</html>