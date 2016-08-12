<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/21
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
    <title>ECharts</title>
    <!-- ECharts单文件引入 -->
    <script src="<%=basePath%>/resources/echarts-2.2.7/build/dist/echarts-all.js"></script>
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>

    <script>








    </script>


</head>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div>

<script type="text/javascript">
    // 路径配置
    /* require.config({
     paths: {
     echarts: '<%=basePath%>/resources/echarts-2.2.7/build/dist'
     }
     });
     */

    // 使用 option.legend.data=result.legend
    var myChart = echarts.init(document.getElementById('main'));
    var data1=new Array();
    var data2=new Array();

    var option = {
        tooltip: {
            show: true
        },
        legend: {
            data:['销量legend']
        },
        xAxis : [
            {
                type : 'category',
                /*data : ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]*/
                data :data1
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:"销量series",
                type:"bar",
                /* "data":[5, 20, 40, 10, 10, 20]*/
                data:data2

            }
        ]
    };




    function test() {

        $.ajax({
            type: 'post',
            url: '<%=basePath%>/system/elecTextAction_echartsTest.do',
            dataType: 'json',
            success: function (result) {
                /*将返回的category和series对象赋值给option内的category和series*/

                //var results =$.parseJSON(result);
                alert(result);
                var categoryArr = result.categoryList;
                for (var i = 0; i < categoryArr.length; i++) {
                    //alert(categoryArr[i]);

                    //option.xAxis.data[i]=categoryArr[i];
                     //option.xAxis.data[i]=categoryArr[i];
                    data1[i]=categoryArr[i];
                }

                var seriesArr = result.seriesList;
                for (var i = 0; i < seriesArr.length; i++) {
                    //alert(seriesArr[i]);
                    //option.series.data[i]=seriesArr[i];
                     //option.series.data[i]=seriesArr[i];
                    data2[i]=seriesArr[i];
                }


                myChart.hideLoading();

                // 为echarts对象加载数据
                myChart.setOption(option);


            }, error: function () {
                alert("数据加载失败");

            }
        });
    }

</script>

<button onclick="test()">测试</button>

</body>
</html>
