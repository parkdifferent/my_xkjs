<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/8
  Time: 13:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
    request.setAttribute("base",request.getContextPath());
%>
<html>
<head>

    <title></title>
    <script src="${base}/resources/js/jquery-1.6.2.js"></script>
</head>

    <script>

        //根据部门查询该部门下的用户列表
        function doSelectDept() {
            //1、获取部门
            var dept = $("#toCompDept option:selected").val();
            if (dept != "") {
                //2、根据部门查询列表
                $.ajax({
                    url: "${base}/system/elecTextAction_getJson.do",
                    data: {"dept": dept},
                    type: "post",
                    dataType: "json",//返回数据类型
                    success: function (data) {
                        //2.1、将用户列表设置到被投诉人下拉框中
                        alert(data);
                        if (data != null && data != "" && data != undefined) {
                            if ("success" == data.msg) {
                                var toCompName = $("#toCompName");
                                toCompName.empty();
                                $.each(data.userList, function (index, user) {
                                    toCompName.append("<option value='" + user + "'>" + user + "</option>");
                                });
                            } else {
                                alert("获取被投诉人列表失败3！");
                            }
                        } else {
                            alert("获取被投诉人列表失败2！");
                        }
                    },
                    error: function () {
                        alert("获取被投诉人列表失败1！");
                    }
                });
            } else {
                //清空被投诉人列表下拉框
                $("#toCompName").empty();
            }
        }

    </script>
<body>

<table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >

    <tr>
        <td class="tdBg">被投诉人部门：</td>
        <td><select id="toCompDept" name="comp.toCompDept" <%--list="#{'':'请选择','部门A':'部门A','部门B':'部门B' }"--%> onchange="doSelectDept()">
            <option>A</option>
            <option>B</option>
            <option>c</option>

        </select>

        </td>
    </tr>
    <tr>
        <td class="tdBg">被投诉人姓名：</td>
        <td>
            <select id="toCompName" name="comp.toCompName">
            </select>
        </td>
    </tr>


</table>


</body>
</html>
