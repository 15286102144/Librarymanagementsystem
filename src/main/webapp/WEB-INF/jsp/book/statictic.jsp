
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script href="/static/js/bootstrap.js"></script>
    <script href="/static/lib/layui/layui.all.js"></script>
    <script href="/static/lib/layui/layui.js"></script>
    <link rel="stylesheet" href="/static/lib/layui/css/layui.css">
    <meta charset="utf-8"><link rel="icon" href="https://jscdn.com.cn/highcharts/images/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        /* css 代码  */
    </style>
    <script src="https://code.highcharts.com.cn/highcharts/highcharts.js"></script>
    <script src="https://code.highcharts.com.cn/highcharts/modules/exporting.js"></script>
    <script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
    <script src="https://code.highcharts.com.cn/highcharts/themes/grid-light.js"></script>
    <meta charset="utf-8"><link rel="icon" href="https://jscdn.com.cn/highcharts/images/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        /* css 代码  */
    </style>


</head>
<body onload="load()">


<div id="container" style="min-width:400px;height:400px"></div>

<div id="container4" style="min-width:400px;height:400px"></div>

<div id="container2" style="min-width:400px;height:400px"></div>

</body>
<script>
    // JS 代码

    function load(){

        $.ajax({
            url:"getStatictic.do",
            dataType:"json",
            success:function (dataS) {

                var B=new Array();
                for (var i = 0; i <dataS.length ; i++) {
                    var b=new Array();
                        b[0]=dataS[i].bookname+'';
                        b[1]=dataS[i].bookid;
                    B[i]=b;
                }
                var chart = Highcharts.chart('container', {
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: '借阅统计'
                    },
                    subtitle: {
                        text: '数据截止 2020-08，来源:图书馆'
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            rotation: -45  // 设置轴标签旋转角度
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: '借阅总次 (次)'
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    tooltip: {
                        pointFormat: '借阅总量: <b>{point.y:.1f}次</b>'
                    },

                    series: [{
                        name: '总借阅数',
                        data: B,
                        dataLabels: {
                            enabled: true,
                            rotation: -90,
                            color: '#FFFFFF',
                            align: 'right',
                            format: '{point.y}', // :.1f 为保留 1 位小数
                            y: 10
                        }
                    }]
                });
            },
            error:function () {
                alert("请求失败")
            }
        })
        $.ajax({
            url:"getStatictic2.do",
            dataType:"json",
            success:function (dataS) {
                Highcharts.chart('container4', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: '图书管理系统男女比例图'
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: false
                            },
                            showInLegend: true
                        }
                    },
                    series: [{
                        name: 'Brands',
                        colorByPoint: true,
                        data: [{
                            name: '男',
                            y: dataS.NAN,
                            sliced: true,
                            selected: true
                        }, {
                            name: '女',
                            y: dataS.NV
                        }]
                    }]
                });
            },
            error:function () {
                alert("请求失败")
            }
        })
        $.ajax({
            url:"getStatictic3.do",
            dataType:"json",
            success:function (dataS) {
                var B=new Array();
                for (var i = 0; i <dataS.length ; i++) {
                    var b=new Array();
                    b[0]=dataS[i].sum+"年"+dataS[i].price+"月"+'';
                    b[1]=dataS[i].bookid;
                    B[i]=b;
                }
                var chart = Highcharts.chart('container2', {
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: '借阅统计'
                    },
                    subtitle: {
                        text: '数据截止 2020-08，来源:图书馆'
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            rotation: -45  // 设置轴标签旋转角度
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: '借阅总次 (次)'
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    tooltip: {
                        pointFormat: '借阅总量: <b>{point.y:.1f}次</b>'
                    },
                    series: [{
                        name: '总借阅数',
                        data: B,
                        dataLabels: {
                            enabled: true,
                            rotation: -90,
                            color: '#FFFFFF',
                            align: 'right',
                            format: '{point.y}', // :.1f 为保留 1 位小数
                            y: 10
                        }
                    }]
                });
            },
            error:function () {
                alert("请求失败")
            }
        })
    }


</script>

</html>
