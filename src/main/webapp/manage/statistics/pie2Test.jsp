<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/5/7
  Time: 10:21
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
            text: '某站点用户访问来源',
            subtext: '纯属虚构',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient : 'vertical',
            x : 'left',
            data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'center',
                            max: 1548
                        }
                    }
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        series : [
            {
                name:'访问来源',
                type:'pie',
                radius : ['50%', '70%'],
                itemStyle : {
                    normal : {
                        label : {
                            show : false
                        },
                        labelLine : {
                            show : false
                        }
                    },
                    emphasis : {
                        label : {
                            show : true,
                            position : 'center',
                            textStyle : {
                                fontSize : '30',
                                fontWeight : 'bold'
                            }
                        }
                    }
                },
                data:[
                    {value:335, name:'直接访问'},
                    {value:310, name:'邮件营销'},
                    {value:234, name:'联盟广告'},
                    {value:135, name:'视频广告'},
                    {value:1548, name:'搜索引擎'}
                ]
            }
        ]
    };*/

    option = {

        title : {
            text: 'A类、B类、C类学科竞赛比例',
            subtext: '',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient : 'vertical',
            x : 'left',
            data:['A类','B类','C类']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'center',
                            max: 8
                        }
                    }
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        series : [
            {
                name:'所属分类',
                type:'pie',
                radius : ['50%', '70%'],
                itemStyle : {
                    normal : {
                        label : {
                            show : false
                        },
                        labelLine : {
                            show : false
                        }
                    },
                    emphasis : {
                        label : {
                            show : true,
                            position : 'center',
                            textStyle : {
                                fontSize : '30',
                                fontWeight : 'bold'
                            }
                        }
                    }
                },
                data:[
                    {value:4, name:'A类'},
                    {value:8, name:'B类'},
                    {value:3, name:'C类'}

                ]
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

