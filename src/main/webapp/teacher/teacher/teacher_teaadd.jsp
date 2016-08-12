<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/27
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String contentData = request.getAttribute("content") != null ? (String)request.getAttribute("content") : "";



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
            jQuery('#teacherTime').attr("readyonly","readyonly").datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });



        });

    </script>

</head>

<body>

<div class="cont">
    <h1 class="seth">个人信息</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/teacher_tealist.do"><b>管理</b></a> </li>
            <%--<li><a href="<%=basePath%>/system/teacher_add.do" <s:if test="#request.edit==null"> class="this" </s:if> ><b>新增</b></a></li>--%>

            <s:if test="#request.edit">
                <li>  <a href="javascript:void(0);" class="this"><b>编辑</b></a></li>
            </s:if>



        </ul>
    </div>

    <form name="theForm" id="theForm" action="<%=basePath%>/system/teacher_teasave.do" method="post" enctype="multipart/form-data">

        <div class="edit">
            <div class="editul setcont">
                <!--鼠标经过样式-->


                <ul class="set1">
                    <li class="setcont_bg">工号</li>
                    <li><span class="webname">
        <input name="tno" type="text" id="tno" value="<s:property value="#request.teacher.tno"/>" />
      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">姓名</li>
                    <li><span class="webname">
        <input name="name" type="text" id="name" value="<s:property value="#request.teacher.name"/>" />
      </span></li>
                </ul>

                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>学院</li>
                    <li><span class="webname">
                        <select name="academe" id="academe">
                            <option value="" ${request.enter.academe ==null?'selected':''}>请选择...</option>
                            <s:if test="#request.academeList!=null && #request.academeList.size()>0">
                                <s:iterator value="#request.academeList" id="academe11">
                                    <option value="${academe11.academeName}" ${academe11.academeName ==request.academe1?'selected':''}>${academe11.academeName}</option>
                                </s:iterator>
                            </s:if>
                        </select></span>
                    </li>
                </ul>

                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>学历</li>
                    <li><span class="webname">
         <select name="education" id="education">
             <option value="" ${request.teacher.education ==null?'selected':''}>请选择...</option>
             <option value="本科" ${request.teacher.education =="本科"?'selected':''}>本科</option>
             <option value="硕士" ${request.teacher.education =="硕士"?'selected':''}>硕士</option>
             <option value="博士" ${request.teacher.education =="博士"?'selected':''}>博士</option>

         </select>
        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>

                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>职称</li>
                    <li><span class="webname">
         <select name="rank" id="rank">
             <option value="" ${request.teacher.rank ==null?'selected':''}>请选择...</option>
             <option value="助教" ${request.teacher.rank =="助教"?'selected':''}>助教</option>
             <option value="讲师" ${request.teacher.rank =="讲师"?'selected':''}>讲师</option>
             <option value="副教授" ${request.teacher.rank =="副教授"?'selected':''}>副教授</option>
             <option value="教授" ${request.teacher.rank =="教授"?'selected':''}>教授</option>

         </select>
        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>



                <ul class="set1">
                    <li class="setcont_bg">研究方向</li>
                    <li><span class="webname">
        <input name="research" type="text" id="research" value="<s:property value="#request.teacher.research"/>" />
      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">简介</li>
                    <li><span class="webname">

        <%--<input name="brief" type="text" id="brief" value="<s:property value="#request.teacher.brief"/>" />--%>
                        <textarea name="brief" cols="100" rows="10" style="width:500px;height:120px;"><s:property value="#request.teacher.brief"/></textarea>

      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">邮箱</li>
                    <li><span class="webname">
        <input name="email" type="text" id="email" value="<s:property value="#request.teacher.email"/>" />
      </span></li>
                </ul>



            </div>
        </div>
        <div class="submit">
   			<span class="pad120">
   			<input name="save" type="button" value="提交" onclick="saveForm()" />
   			 <input name="teaId" type="hidden" id="teaId" value="<s:property value="#request.teacher.teaId"/>" />
   				<input name="currentPage" type="hidden"  id="currentPage" value="<s:property value='#request.currentPage'/>" />
  				<input name="list_url" type="hidden" id="list_url" value="<%=basePath%>/system/teacher_tealist.do" />


   </span>
        </div>
    </form>

</div>

</body>
</html>



