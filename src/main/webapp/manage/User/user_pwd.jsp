<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/21
  Time: 0:30
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link  href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <link  href="<%=basePath%>/resources/style/common/css/jquery-ui-1.8.22.custom.css" type=text/css rel=stylesheet />
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.validate.min.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.common.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.poshytip.min.js"></script>


    <script>

        jQuery(document).ready(function(){
            jQuery("#theForm").validate({
                rules:{
                    old_password:{
                        required :true,
                        minlength:6,
                        maxlength:20
                    },
                    password:{
                        required :true,
                        minlength:6,
                        maxlength:20
                    },
                    password1:{
                        required :true,
                        minlength:6,
                        maxlength:20,
                        equalTo:"#password"
                    }
                },
                messages:{
                    old_password:{required:"旧密码不能为空",minlength:"最小长度为6位",maxlength:"最大不能超过20位"},
                    password:{required:"新密码不能为空",minlength:"最小长度为6位",maxlength:"最大不能超过20位"},
                    password1:{required:"重复密码不能为空",minlength:"最小长度为6位",maxlength:"最大不能超过20位",equalTo:"两次输入密码不一致"},
                }
            });
            jQuery(":radio[id=sex]").each(function(){
                if(jQuery(this).val()=="$!obj.sex")jQuery(this).attr("checked",true);
            });
        });

        function saveForm(){
            jQuery("#theForm").submit();
        }


    </script>
</head>
<body>

<div class="cont">
    <h1 class="seth">修改密码</h1>
    <form name="theForm" id="theForm" action="<%=basePath%>/system/loginAction_pwdSave.do<%--$!webPath/admin/admin_pws_save.htm--%>" method="post">
        <input name="id" type="hidden" id="id" value="<%--$!obj.id--%>" />
        <div class="edit">
            <div class="editul setcont">
                <!--鼠标经过样式-->
                <ul class="set1">
                    <li class="setcont_bg"><strong class="sred">*</strong>旧密码</li>
                    <li><span class="webname">
        <input name="old_password" type="password" id="old_password" size="40" autocomplete="off" />
      </span></li>
                </ul>
                <ul class="set1">
                    <li  class="setcont_bg"><strong class="sred">*</strong>新密码</li>
                    <li><span class="webname">
        <input name="password" type="password" id="password" size="40" />
      </span></li>
                </ul>
                <ul class="set1">
                    <li  class="setcont_bg"><strong class="sred">*</strong>重复新密码</li>
                    <li><span class="webname">
        <input name="password1" type="password" id="password1" size="40" />
      </span></li>
                </ul>
            </div>
        </div>
    </form>
    <div class="submit">
        <span class="pad120"><input name="save" type="button" value="提交" onclick="saveForm()" /></span>
    </div>
</div>




</body>
</html>
