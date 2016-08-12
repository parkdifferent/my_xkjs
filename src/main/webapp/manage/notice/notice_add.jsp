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


    <link rel="stylesheet" href="<%=basePath%>/resources/kindeditor/themes/default/default.css" />
    <link rel="stylesheet" href="<%=basePath%>/resources/kindeditor/plugins/code/prettify.css" />
    <script charset="utf-8" src="<%=basePath%>/resources/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="<%=basePath%>/resources/kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="<%=basePath%>/resources/kindeditor/lang/zh-CN.js"></script>
    <script charset="utf-8" src="<%=basePath%>/resources/kindeditor/plugins/code/prettify.js"></script>

    <script type="text/javascript">
        function saveForm(){
            editor1.sync();
            html=$('.content').val();
            //alert(html);
            jQuery("#theForm").submit();
        }

        jQuery(document).ready(function(){
            jQuery('#noticeTime').attr("readyonly","readyonly").datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });



        });


        var editor1;
        KindEditor.ready(function(K) {
            editor1 = K.create('textarea[name="content"]', {
                cssPath : '<%=basePath%>/resources/kindeditor/plugins/code/prettify.css',
                uploadJson : '<%=basePath%>/resources/kindeditor/jsp/upload_json.jsp',
                fileManagerJson : '<%=basePath%>/resources/kindeditor/jsp/file_manager_json.jsp',
                allowFileManager : true
                /*afterCreate : function() {
                 var self = this;
                 K.ctrl(document, 13, function() {
                 self.sync();
                 document.forms['theForm'].submit();
                 });
                 K.ctrl(self.edit.doc, 13, function() {
                 self.sync();
                 document.forms['theForm'].submit();
                 });
                 }*/
            });
            //prettyPrint();
        });


    </script>

</head>

<body>

<div class="cont">
    <h1 class="seth">竞赛通知管理</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/notice_list.do"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/notice_add.do" <s:if test="#request.edit==null"> class="this" </s:if> ><b>新增</b></a></li>

            <s:if test="#request.edit">
                <li>  <a href="javascript:void(0);" class="this"><b>编辑</b></a></li>
            </s:if>



        </ul>
    </div>

    <form name="theForm" id="theForm" action="<%=basePath%>/system/notice_save.do" method="post" enctype="multipart/form-data">

        <div class="edit">
            <div class="editul setcont">
                <!--鼠标经过样式-->


                <ul class="set1">
                    <li class="setcont_bg">通知标题</li>
                    <li><span class="webname">
        <input name="title" type="text" id="title" value="<s:property value="#request.notice.title"/>" />
      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">通知内容</li>
                    <li><span class="webname">
       <%-- <input name="content" type="text" id="content" value="<s:property value="#request.notice.content"/>" />--%>
                        <textarea name="content" cols="100" rows="10" style="width:700px;height:800px;visibility:hidden;"><%=htmlspecialchars(contentData)%></textarea>
      </span></li>
                </ul>

                <ul class="set1">
                    <li class="setcont_bg">发布时间</li>
                    <li><span class="webname">
      
      <input name="noticeTime" type="text" id="noticeTime" value="<s:date name='#request.notice.noticeTime' format='yyyy-MM-dd'/>"  readonly="readonly"/>
     
        
      </span></li>
                </ul>

                <ul class="set1">
                    <li class="setcont_bg">发布者</li>
                    <li><span class="webname">
        <input name="publisher" type="text" id="publisher" value="<s:property value="#request.notice.publisher"/>" />
      </span></li>
                </ul>



               <%-- <s:if test="#request.edit">
                    <ul class="set1">
                        <li class="setcont_bg">已上传附件名称</li>
                        <li><span class="webname">
        <input name="fileName" type="text" id="fileName" value="<s:property value="#request.notice.fileName"/>" />
      </span></li>
                    </ul>
                </s:if>--%>



                <ul class="set1">
                    <li class="setcont_bg"><strong class="sred">*</strong>附件</li>

                    <li>
                        <s:if test="#request.edit">
                            <s:property value="#request.notice.fileName"/>
                        </s:if>
                    </li>
                    <li><span> <input id="upload" type="file" name="upload" /></span>


                       <%-- <s:if test="${request.edit}">
                            <s:property value="#request.notice.fileName"/>
                        </s:if>--%>

                       <%-- <span id="nothis">
                            <strong class="q"></strong>
                            <strong class="w">选择要导入文件</strong><strong class="c"></strong>
                        </span>--%>


                    </li>
                </ul>

                <%-- <li><a id="down" href="<%=basePath%>/system/notice_download.do?noticeId=<s:property value='#request.notice.noticeId'/>"><b>导入竞赛报名模板下载</b></a></li>--%>




            </div>
        </div>
        <div class="submit">
   			<span class="pad120">
   			<input name="save" type="button" value="上传" onclick="saveForm()" />
   			 <input name="noticeId" type="hidden" id="noticeId" value="<s:property value="#request.notice.noticeId"/>" />
   				<input name="currentPage" type="hidden"  id="currentPage" value="<s:property value='#request.currentPage'/>" />
  				<input name="list_url" type="hidden" id="list_url" value="<%=basePath%>/system/notice_list.do" />
 				 <input name="add_url" type="hidden" id="add_url" value="<%=basePath%>/system/notice_add.do" />
   
   </span>
        </div>
    </form>

</div>

</body>
</html>



<%!
    private String htmlspecialchars(String str) {
        str = str.replaceAll("&", "&amp;");
        str = str.replaceAll("<", "&lt;");
        str = str.replaceAll(">", "&gt;");
        str = str.replaceAll("\"", "&quot;");
        return str;
    }
%>

