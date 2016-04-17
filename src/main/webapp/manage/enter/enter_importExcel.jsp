<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/13
  Time: 22:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title></title>
    <%-- <link  href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.common.js"></script> --%>

    <link  href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <link  href="<%=basePath%>/resources/style/common/css/jquery-ui-1.8.22.custom.css" type=text/css rel=stylesheet />
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.validate.min.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.common.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.poshytip.min.js"></script>
    <script src="<%=basePath%>/resources/js/jquery-ui-1.8.21.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.zh.cn.js" charset="utf-8"></script>

    <script type="text/javascript">
        function saveForm(){
            jQuery("#theForm").submit();
        }

        jQuery(document).ready(function(){
            jQuery('#enterDate').attr("readyonly","readyonly").datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });



        });


    </script>

</head>




</head>
<body>
<div class="cont">
    <h1 class="seth">竞赛报名管理</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/enter_list.do"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/enter_add.do" ><b>新增</b></a></li>

            <li><a class="add_btn" onclick="payoff_excel()" href="<%=basePath%>/system/enter_importExcel.do" class="this"> <b class="add_btn_b">导入Excel</b></a></li>
            <li><a class="add_btn" onclick="payoff_excel()" href="javascript:void(0);"> <b class="add_btn_b">导出Excel</b></a></li>
        </ul>
    </div>
    <br />
    <form id="" action="<%=basePath%>/system/enter_importJava.do"
          method="post" enctype="multipart/form-data">
        <div class="edit">
            <div class="editul setcont" id="base">

                <ul class="set1">
                    <li class="setcont_bg">模板下载</li>
                    <li><a id="down" href="<%=basePath%>/resources/file/moudel.xlsx"><b>导入惠币模板下载</b></a></li>
                </ul>
                <ul class="set1">
                    <li class="setcont_bg"><strong class="sred">*</strong>批量导入</li>
                    <li><span> <input id="upload" type="file" name="upload" />
						</span><span id="nothis"><strong class="q"></strong><strong
                            class="w">选择要导入文件（EXCEL文件）</strong><strong class="c"></strong></span></li>
                </ul>
            </div>
        </div>
        <div class="submit">
				<span class="pad120"> <input type="submit" value="上传"
                                             style="cursor: pointer;" /></span>
        </div>

    </form>
</body>
</html>

