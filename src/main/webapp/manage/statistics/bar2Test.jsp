<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/5/7
  Time: 13:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <title>ECharts · Example</title>
    <!-- ECharts单文件引入 -->
    <script src="<%=basePath%>/resources/echarts-2.2.7/build/dist/echarts-all.js"></script>
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>

    <script src="<%=basePath%>/resources/echarts-2.2.7/doc/example/www/js/echarts.js"></script>
    <script src="<%=basePath%>/resources/echarts-2.2.7/doc/asset/js/codemirror.js"></script>
    <script src="<%=basePath%>/resources/echarts-2.2.7/doc/asset/js/javascript.js"></script>


    <link href="<%=basePath%>/resources/echarts-2.2.7/doc/asset/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=basePath%>/resources/echarts-2.2.7/doc/asset/css/bootstrap.css" rel="stylesheet">
    <link href="<%=basePath%>/resources/echarts-2.2.7/doc/asset/css/carousel.css" rel="stylesheet">
    <link href="<%=basePath%>/resources/echarts-2.2.7/doc/asset/css/echartsHome.css" rel="stylesheet">

    <link href="<%=basePath%>/resources/echarts-2.2.7/doc/asset/css/codemirror.css" rel="stylesheet">
    <link href="<%=basePath%>/resources/echarts-2.2.7/doc/asset/css/monokai.css" rel="stylesheet">


</head>

<body>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<%--<div id="main" style="height:400px"></div>--%>
<div class="container-fluid">
    <div class="row-fluid example">

        <div id="graphic" class="col-md-8">
            <div id="main" class="main"></div>
            <div>
                <button type="button" class="btn btn-sm btn-success" onclick="refresh(true)">刷 新</button>
                <span class="text-primary">切换主题</span>
                <select id="theme-select"></select>

                <span id='wrong-message' style="color:red"></span>
            </div>
        </div><!--/span-->
    </div>
</div>




<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('main'));
    /*var zrColor = require('zrender/tool/color');*/

    /*var zrColor =  zrender.tool.color;

    var colorList = [
        '#ff7f50','#87cefa','#da70d6','#32cd32','#6495ed',
        '#ff69b4','#ba55d3','#cd5c5c','#ffa500','#40e0d0'
    ];
    var itemStyle = {
        normal: {
            color: function(params) {
                if (params.dataIndex < 0) {
                    // for legend
                    return zrColor.lift(
                            colorList[colorList.length - 1], params.seriesIndex * 0.1
                    );
                }
                else {
                    // for bar
                    return zrColor.lift(
                            colorList[params.dataIndex], params.seriesIndex * 0.1
                    );
                }
            }
        }
    };
    option = {
        title: {
            text: '2010-2013年中国城镇居民家庭人均消费构成（元）',
            subtext: '数据来自国家统计局',
            sublink: 'http://data.stats.gov.cn/search/keywordlist2?keyword=%E5%9F%8E%E9%95%87%E5%B1%85%E6%B0%91%E6%B6%88%E8%B4%B9'
        },
        tooltip: {
            trigger: 'axis',
            backgroundColor: 'rgba(255,255,255,0.7)',
            axisPointer: {
                type: 'shadow'
            },
            formatter: function(params) {
                // for text color
                var color = colorList[params[0].dataIndex];
                var res = '<div style="color:' + color + '">';
                res += '<strong>' + params[0].name + '消费（元）</strong>'
                for (var i = 0, l = params.length; i < l; i++) {
                    res += '<br/>' + params[i].seriesName + ' : ' + params[i].value
                }
                res += '</div>';
                return res;
            }
        },
        legend: {
            x: 'right',
            data:['2010','2011','2012','2013']
        },
        toolbox: {
            show: true,
            orient: 'vertical',
            y: 'center',
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        grid: {
            y: 80,
            y2: 40,
            x2: 40
        },
        xAxis: [
            {
                type: 'category',
                data: ['食品', '衣着', '居住', '家庭设备及用品', '医疗保健', '交通和通信', '文教娱乐服务', '其他']
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '2010',
                type: 'bar',
                itemStyle: itemStyle,
                data: [4804.7,1444.3,1332.1,908,871.8,1983.7,1627.6,499.2]
            },
            {
                name: '2011',
                type: 'bar',
                itemStyle: itemStyle,
                data: [5506.3,1674.7,1405,1023.2,969,2149.7,1851.7,581.3]
            },
            {
                name: '2012',
                type: 'bar',
                itemStyle: itemStyle,
                data: [6040.9,1823.4,1484.3,1116.1,1063.7,2455.5,2033.5,657.1]
            },
            {
                name: '2013',
                type: 'bar',
                itemStyle: itemStyle,
                data: [6311.9,1902,1745.1,1215.1,1118.3,2736.9,2294,699.4]
            }
        ]
    };*/





    var zrColor =  zrender.tool.color;

     var colorList = [
     '#ff7f50','#87cefa','#da70d6','#32cd32','#6495ed',
     '#ff69b4','#ba55d3','#cd5c5c','#ffa500','#40e0d0'
     ];
     var itemStyle = {
     normal: {
     color: function(params) {
     if (params.dataIndex < 0) {
     // for legend
     return zrColor.lift(
     colorList[colorList.length - 1], params.seriesIndex * 0.1
     );
     }
     else {
     // for bar
     return zrColor.lift(
     colorList[params.dataIndex], params.seriesIndex * 0.1
     );
     }
     }
     }
     };
     option = {
     title: {
     text: '2014-2016年蓝桥杯竞赛获奖情况',
     subtext: '数据来自电科学院',
     sublink: 'http://data.stats.gov.cn/search/keywordlist2?keyword=%E5%9F%8E%E9%95%87%E5%B1%85%E6%B0%91%E6%B6%88%E8%B4%B9'
     },
     tooltip: {
     trigger: 'axis',
     backgroundColor: 'rgba(255,255,255,0.7)',
     axisPointer: {
     type: 'shadow'
     },
     formatter: function(params) {
     // for text color
     var color = colorList[params[0].dataIndex];
     var res = '<div style="color:' + color + '">';
     res += '<strong>' + params[0].name + '消费（元）</strong>'
     for (var i = 0, l = params.length; i < l; i++) {
     res += '<br/>' + params[i].seriesName + ' : ' + params[i].value
     }
     res += '</div>';
     return res;
     }
     },
     legend: {
     x: 'right',
     data:['省三','省二','省一','国奖']
     },
     toolbox: {
     show: true,
     orient: 'vertical',
     y: 'center',
     feature: {
     mark: {show: true},
     dataView: {show: true, readOnly: false},
     restore: {show: true},
     saveAsImage: {show: true}
     }
     },
     calculable: true,
     grid: {
     y: 80,
     y2: 40,
     x2: 40
     },
     xAxis: [
     {
     type: 'category',
     data: ['2014', '2015', '2016']
     }
     ],
     yAxis: [
     {
     type: 'value'
     }
     ],
     series: [
     {
     name: '省三',
     type: 'bar',
     itemStyle: itemStyle,
     data: [5,4,2]
     },
     {
     name: '省二',
     type: 'bar',
     itemStyle: itemStyle,
     data: [4,3,3]
     },
     {
     name: '省一',
     type: 'bar',
     itemStyle: itemStyle,
     data: [1,3,1]
     },
     {
     name: '国奖',
     type: 'bar',
     itemStyle: itemStyle,
     data: [1,3,1]
     }
     ]
     };


    myChart.setOption(option);

</script>

<footer id="footer"></footer>

<script src="<%=basePath%>/resources/echarts-2.2.7/doc/asset/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/resources/echarts-2.2.7/doc/asset/js/echartsHome.js"></script>
<script src="<%=basePath%>/resources/echarts-2.2.7/doc/asset/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/resources/echarts-2.2.7/doc/asset/js/echartsExample.js"></script>



</body>
</html>


