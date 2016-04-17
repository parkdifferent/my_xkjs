<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'upload.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    
   <%--  <form id="form1" action="<%=basePath%>/system/uploadAction_fileTest.do" --%>
    <form id="form1" action="<%=basePath%>/system/uploadAction_importJava.do"
			method="post" enctype="multipart/form-data">
			
			<ul class="set1">
						<li class="setcont_bg"><strong class="sred">*</strong>批量导入</li>
						<li><span> <input id="upload" type="file" name="upload" />
						</span><span id="nothis"><strong class="q"></strong><strong
								class="w">选择要导入文件（EXCEL文件）</strong><strong class="c"></strong></span></li>
		   </ul>
		   
		  <div class="submit">
    <input name="save" type="submit" id="save" value="保存"/>
  </div>
		   
		   
	</form>
	
	
	
	<h3> <font color="blue"> Struts下载测试  </font>
	</h3>
	
	<a href="<%=basePath%>/system/uploadAction_downloadFile.do">
		下载文件
	</a>
	
	<a href="<%=basePath%>/system/uploadAction_exportExcel.do">
		导出excel
	</a>
    
    
    
  </body>
</html>
