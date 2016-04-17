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

        //ajax的二级联动，使用选择的所属单位，查询该所属单位下对应的单位名称列表
        function findJctUnit(o){
            //货物所属单位的文本内容
            var jct = $(o).find("option:selected").text();
            $.post("${base}/system/elecTextAction_getJson.do",{"jctID":jct},function(data,textStatus){
                //先删除单位名称的下拉菜单，但是请选择要留下
                $("#jctUnitID option").remove();
                if(data!=null && data.length>0){
                    for(var i=0;i<data.length;i++){
                        var areaId = data[i].areaId;
                        var name = data[i].name;
                        //添加到单位名称的下拉菜单中
                        var $option = $("<option></option>");
                        $option.attr("value",areaId);
                        $option.text(name);
                        $("#jctUnitID").append($option);
                    }
                }
            });

        }


        function doSelectDept() {
            //1、获取部门
            var jct = $(o).find("option:selected").text();
                //2、根据部门查询列表
                $.ajax({
                    url: "${base}/system/elecTextAction_getJson.do",
                    data: {"jctID": jct},
                    type: "post",
                    dataType: "json",//返回数据类型
                    success: function (data) {
                        //先删除单位名称的下拉菜单，但是请选择要留下
                        alert(data);
                        $("#jctUnitID option").remove();
                        if(data!=null && data.length>0){
                            for(var i=0;i<data.length;i++){
                                var areaId = data[i].areaId;
                                var name = data[i].name;
                                //添加到单位名称的下拉菜单中
                                var $option = $("<option></option>");
                                $option.attr("value",areaId);
                                $option.text(name);
                                $("#jctUnitID").append($option);
                            }
                        }
                    },
                    error: function () {
                        alert("获取被投诉人列表失败1！");
                    }
                });
        }

    </script>
<body>

<table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >

    <tr>
        <td align="center" bgColor="#f5fafe" class="ta_01">所属单位：<font color="#FF0000">*</font></td>
        <td class="ta_01" bgColor="#ffffff">
           <%-- <s:select list="#request.areaList" name="jctID" id="jctID"
                      listKey="areaId" listValue="name"
                      headerKey="" headerValue="请选择"
                      cssStyle="width:155px" onchange="findJctUnit(this)">
            </s:select>--%>

            <select name="jctID" id="jctID" onchange="findJctUnit(this)">
                <option>A</option>
                <option>B</option>
                <option>c</option>

            </select>

        </td>
        <td align="center" bgColor="#f5fafe" class="ta_01">单位名称：<font color="#FF0000">*</font></td>
        <td class="ta_01" bgColor="#ffffff">
            <select id="jctUnitID" name="jctUnitID" style="width:155px"></select>
        </td>
    </tr>


</table>


</body>
</html>
