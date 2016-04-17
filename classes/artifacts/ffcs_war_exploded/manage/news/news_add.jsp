<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/4
  Time: 21:19
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
            jQuery('#newsTime').attr("readyonly","readyonly").datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });



        });


    </script>

</head>

<body>

<div class="cont">
    <h1 class="seth">竞赛新闻管理</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/news_list.do"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/news_add.do" <s:if test="#request.edit==null"> class="this" </s:if> ><b>新增</b></a></li>

            <s:if test="#request.edit">
                <li>  <a href="javascript:void(0);" class="this"><b>编辑</b></a></li>
            </s:if>



        </ul>
    </div>

    <form name="theForm" id="theForm" action="<%=basePath%>/system/news_save.do" method="post">

        <div class="edit">
            <div class="editul setcont">
                <!--鼠标经过样式-->


                <ul class="set1">
                    <li class="setcont_bg">新闻标题</li>
                    <li><span class="webname">
        <input name="title" type="text" id="title" value="<s:property value="#request.news.title"/>" />
      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">新闻内容</li>
                    <li><span class="webname">
        <input name="content" type="text" id="content" value="<s:property value="#request.news.content"/>" />
      </span></li>
                </ul>

                <ul class="set1">
                    <li class="setcont_bg">发布时间</li>
                    <li><span class="webname">
      
      <input name="newsTime" type="text" id="newsTime" value="<s:date name='#request.news.newsTime' format='yyyy-MM-dd'/>"  readonly="readonly"/>
     
        
      </span></li>
                </ul>

                <ul class="set1">
                    <li class="setcont_bg">发布者</li>
                    <li><span class="webname">
        <input name="publisher" type="text" id="publisher" value="<s:property value="#request.news.publisher"/>" />
      </span></li>
                </ul>



            </div>
        </div>
        <div class="submit">
   			<span class="pad120">
   			<input name="save" type="button" value="提交" onclick="saveForm()" />
   			 <input name="newsId" type="hidden" id="newsId" value="<s:property value="#request.news.newsId"/>" />
   				<input name="currentPage" type="hidden"  id="currentPage" value="<s:property value='#request.currentPage'/>" />
  				<input name="list_url" type="hidden" id="list_url" value="<%=basePath%>/system/news_list.do" />
 				 <input name="add_url" type="hidden" id="add_url" value="<%=basePath%>/system/news_add.do" />
   
   </span>

        </div>


    </form>

</div>

</body>
</html>

