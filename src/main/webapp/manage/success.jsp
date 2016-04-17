
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
    <link  href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <title>success.jsp</title>

  </head>
  
  <body>
    
<div class="cont">
  <h1 class="seth">系统消息</h1>
  <div class="bigok">
    <div class="bigokimg"><img src="<%=basePath%>/resources/style/system/manage/blue/images/sys.jpg" /></div>
    <div class="bigleft">
      <ul>
        <li><s:property value='#request.op_title'/></li>
        <li class="hui">自动为您跳转到刚才的页面！</li>
        <li class="successbtn">
   
        <s:if test="#request.list_url!=null">
        	<a href="<s:property value='#request.list_url'/>">返回上一页</a>
        </s:if>
        
         <s:if test="#request.add_url!=null">
        	  <a href="<s:property value='#request.add_url'/>">继续新增</a></li>		
        </s:if>
        
     
      </ul>
    </div>
	<s:if test="#request.add_url!=null">
	<script>
	  var count=3;
	  window.setInterval(go,1000);
	  function go(){
	    count--;
	    if(count==0) window.location.href="<s:property value='#request.list_url'/>";
	  }
	</script>
	</s:if>
  </div>
</div>



  </body>
</html>
