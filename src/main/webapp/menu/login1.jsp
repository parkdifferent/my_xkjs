<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/6
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%--$!{config.title}---%>学科竞赛管理登录</title>
    <link href="<%=basePath%>/resources/style/system/manage/blue/login.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.validate.min.js"></script>
    <script>
        function refreshCode(){
            jQuery("#code_img").attr("src","<%=basePath%>/system/verifyCode.do?d="+new Date().getTime());
        }
        function login(){
            jQuery("#theForm").submit();
        }
        var EnterSubmit = function(evt){
            evt = window.event || evt;
            if (evt.keyCode == 13)
            {
                login();
            }
        }
        /*window.document.onkeydown=EnterSubmit;
        jQuery(document).ready(function(){
            if(top.location!=this.location)top.location=this.location;//跳出框架在主窗口登录
            jQuery('#username').focus();
            jQuery("#theForm").validate({
                errorPlacement:function(error,element) {
                    error.appendTo(element.parent().find(".error_b"));
                    element.parent().find(".error_b").show('normal');
                },
                success:function(label){
                    label.parent().hide();
                },
                rules:{
                    username:{required:true},
                    password:{required:true},
                    code:{required:true}
                },
                messages:{
                    username:{required:"用户名不能为空"},
                    password:{required:"密码不能为空"},
                    code:{required:"验证码不能为空"}
                }
            });
        });*/
    </script>
</head>
<body>
<div class="login_bg">
    <form name="theForm" id="theForm" action="<%=basePath%>/system/user_login.do" method="post">

        <div class="main">
            <h1 class="login_h1">
                <%--<a href="<%=basePath%>/index.htm">
                    &lt;%&ndash;#set($imgUrl="<%=basePath%>/resources/style/system/manage/blue/images/login/login_logo.png")
                    #if($!config.admin_login_logo)
                    #set($imgUrl="$!imageWebServer/$!{config.admin_login_logo.path}/$!{config.admin_login_logo.name}")
                    #end&ndash;%&gt;
                    <img src="&lt;%&ndash;$!imgUrl&ndash;%&gt;" width="401" height="62" />
                </a></h1>--%>
            <div class="login_box">
                <div class="login_box_bg"></div>
                <div class="login_bg_left"></div>
                <div class="login_box_tab">
                    <h3>用户登录</h3>
                    <ul>
                        <%--#if(!$!user)--%>
                        <li><span class="username"></span>
                            <input name="username" type="text" id="username"  autocomplete="false" class="login_txt"  />
                            <b class="error_b"></b></li>
                       <%-- #else
                        <li><span class="username"></span>
                            <span class="login_txt" >$!user.userName<input name="username" type="hidden" value="$!user.userName" /></span><b class="error_b"></b></li>
                        #end--%>
                        <li><span class="password"></span>
                            <input name="password" type="password" id="password"  autocomplete="false" class="login_txt" />
                            <b class="error_b"></b>
                        </li>
                        <li><span class="code"></span>
                            <input name="code" type="text" id="code"  style="text-transform:uppercase;" autocomplete="false" class="code_txt" />
                            <a href="javascript:void(0);" onclick="refreshCode();"  class="code_img"><img style="cursor:pointer; padding-top:6px;" src="<%=basePath%>/system/verifyCode.do" id="code_img" onclick="refreshCode();" width="73" height="27" /></a><%--<a href="javascript:void(0);" onclick="refreshCode();" class="code_a">换一张</a>--%>
                            <b class="error_b"></b>
                        </li>
                        <li>
                            <input name=""  type="button" onclick="login();" style="cursor:pointer" value="登 录" class="login_btn" />
                            <input name="login_role" type="hidden" id="login_role" value="admin" />
                        </li>
                    </ul>
                </div>
            </div>
            <p class="login_p">Copyright 2011-2015 © <a href="<%=basePath%>" target="_blank"><%--$!{config.company_name}--%></a></p>
        </div>


    </form>
</div>
</body>
</html>

