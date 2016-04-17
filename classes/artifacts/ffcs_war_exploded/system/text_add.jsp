<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="s" uri="/struts-tags" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>文本编辑</title>
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
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript">
	function saveForm(){
   jQuery("#theForm").submit();
	}
	
	jQuery(document).ready(function(){
		jQuery('#textDate').attr("readyonly","readyonly").datepicker({
	  dateFormat:"yy-mm-dd",
	  changeMonth: true,
	  changeYear: true
  });
	
	
	
	});
	
	
	</script>

  </head>
  
  <body>
    
    <div class="cont">
    <h1 class="seth">文本管理</h1>
    <div class="nav_list">
    <ul> 
    <li><a href="<%=basePath%>/system/elecTextAction_home.do"><b>管理</b></a> </li>
    <li><a href="<%=basePath%>/system/elecTextAction_add.do" <s:if test="#request.edit==null"> class="this" </s:if> ><b>新增</b></a></li>
    
     <s:if test="#request.edit">
	   <li>  <a href="javascript:void(0);" class="this"><b>编辑</b></a></li>
	   </s:if> 
    
    
    
     </ul> 
     </div>
     
     <form name="theForm" id="theForm" action="<%=basePath%>/system/elecTextAction_save.do" method="post">
  
      <div class="edit">
 <div class="editul setcont">
    <!--鼠标经过样式-->
    <ul class="set1">
      <li class="setcont_bg">textName</li>
      <li><span class="webname">
        <input name="textName" type="text" id="textName" value="<s:property value="#request.text.textName"/>" />
      </span></li>
    </ul>
    
     <ul class="set1">
      <li class="setcont_bg">textDate</li>
      <li><span class="webname">
      
      <input name="textDate" type="text" id="textDate" value="<s:date name='#request.text.textDate' format='yyyy-MM-dd'/>"  readonly="readonly"/>
     
        
      </span></li>
    </ul>
    
     <ul class="set1">
      <li class="setcont_bg">textRemark</li>
      <li><span class="webname">
        <input name="textRemark" type="text" id="textRemark" value="<s:property value="#request.text.textRemark"/>" />
      </span></li>
    </ul>
    
    
    
    </div>
    </div>
    <div class="submit">
   			<span class="pad120">
   			<input name="save" type="button" value="提交" onclick="saveForm()" />
   			 <input name="textID" type="hidden" id="textID" value="<s:property value="#request.text.textID"/>" />
   				<input name="currentPage" type="hidden"  id="currentPage" value="<s:property value='#request.currentPage'/>" />
  				<input name="list_url" type="hidden" id="list_url" value="<%=basePath%>/system/elecTextAction_home.do" />
 				 <input name="add_url" type="hidden" id="add_url" value="<%=basePath%>/system/elecTextAction_add.do" />  
   
   </span>
   
  </div>
    
    
  </form>
  
</div>
     
  </body>
</html>
