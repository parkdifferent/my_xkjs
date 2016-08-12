<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/5/7
  Time: 13:23
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
    /*option = {
     title : {
     text: '某地区蒸发量和降水量',
     subtext: '纯属虚构'
     },
     tooltip : {
     trigger: 'axis'
     },
     legend: {
     data:['蒸发量','降水量']
     },
     toolbox: {
     show : true,
     feature : {
     mark : {show: true},
     dataView : {show: true, readOnly: false},
     magicType : {show: true, type: ['line', 'bar']},
     restore : {show: true},
     saveAsImage : {show: true}
     }
     },
     calculable : true,
     xAxis : [
     {
     type : 'category',
     data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
     }
     ],
     yAxis : [
     {
     type : 'value'
     }
     ],
     series : [
     {
     name:'蒸发量',
     type:'bar',
     data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3],
     markPoint : {
     data : [
     {type : 'max', name: '最大值'},
     {type : 'min', name: '最小值'}
     ]
     },
     markLine : {
     data : [
     {type : 'average', name: '平均值'}
     ]
     }
     },
     {
     name:'降水量',
     type:'bar',
     data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3],
     markPoint : {
     data : [
     {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183, symbolSize:18},
     {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
     ]
     },
     markLine : {
     data : [
     {type : 'average', name : '平均值'}
     ]
     }
     }
     ]
     };*/

    option = {
        title : {
            text: '2014-2016年数学建模报名人数和获奖人数',
            subtext: ''
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['获奖人数','报名人数']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                data : ['2014','2015','2016']
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'获奖人数',
                type:'bar',
                data:[15, 12, 12],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name: '平均值'}
                    ]
                }
            },
            {
                name:'报名人数',
                type:'bar',
                data:[24, 40, 42],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
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


