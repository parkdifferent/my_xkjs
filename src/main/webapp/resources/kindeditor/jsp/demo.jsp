<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("content1") != null ? request.getParameter("content1") : "";

    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8" />
	<title>KindEditor JSP</title>
	<link rel="stylesheet" href="<%=basePath%>/resources/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=basePath%>/resources/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="<%=basePath%>/resources/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="<%=basePath%>/resources/kindeditor/kindeditor-all-min.js"></script>
	<script charset="utf-8" src="<%=basePath%>/resources/kindeditor/lang/zh-CN.js"></script>
	<script charset="utf-8" src="<%=basePath%>/resources/kindeditor/plugins/code/prettify.js"></script>
	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="content1"]', {
				cssPath : '../plugins/code/prettify.css',
				uploadJson : '../jsp/upload_json.jsp',
				fileManagerJson : '../jsp/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
				}
			});
			prettyPrint();
		});
	</script>
</head>
<body>
	<%=htmlData%>
	<form name="example" method="post" action="<%=basePath%>/system/elecTextAction_kindeditorTest.do">
		<textarea name="content1" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;">

            <%--<%=htmlspecialchars(htmlData)%>--%>
            ${requestScope.content1Data}
        </textarea>
		<br />
		<input type="submit" name="button" value="提交内容" /> (提交快捷键: Ctrl + Enter)
	</form>
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