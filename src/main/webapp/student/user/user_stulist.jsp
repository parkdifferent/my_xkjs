<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/24
  Time: 20:08
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
    <script src="<%=basePath%>/resources/js/jquery-ui-1.8.21.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.zh.cn.js" charset="utf-8"></script>

    <script>

        jQuery(document).ready(function(){
            /* jQuery(" select #payment").val("$!payment");
             jQuery("#order_status").val("$!order_status");
             jQuery("#type").val("$!type");
             jQuery("#payment").val("$!payment"); */
            jQuery("#condition").val("${condition}");

            jQuery('#beginTime').datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });
            jQuery('#endTime').datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });
            //

            /* jQuery('pageHtml').html(); */

        });

    </script>
</head>
<body>
<%--<h>Hello World!</h>--%>



<div class="cont">
    <h3 class="seth">个人信息</h3>
    <%--<div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/user_list.do"  class="this"><b>管理</b></a></li>
            <li><a href="<%=basePath%>/system/user_add.do" ><b>新增</b></a></li>

            <li><a class="add_btn" &lt;%&ndash;onclick="payoff_excel()"&ndash;%&gt; href="<%=basePath%>/system/user_importExcel.do"> <b class="add_btn_b">导入Excel</b></a></li>
        </ul>
    </div>--%>
    <form action="<%=basePath%>/system/user_stulist.do" method="post" name="ListForm" id="ListForm">

        <div class="operation">
            <h3>友情提示</h3>
            <ul>
                <li>您可以查看、编辑个人信息</li>
            </ul>
        </div>
        <div class="fshoptb">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="fshop_table">
                <tr>

                    <th width="4%" align="left">&nbsp;</th>
                    <th width="15%" ><span class="form_btna">学号</span></th>
                    <th width="15%" ><span class="form_btna">姓名</span></th>
                    <th width="15%" ><span class="form_btna">年级</span></th>
                    <th width="15%" ><span class="form_btna">学院</span></th>
                    <th width="15%" ><span class="form_btna">专业</span></th>
                    <th width="15%" ><span class="form_btna">班级</span></th>
                    <th width="15%" ><span class="form_btna">手机</span></th>
                    <th width="15%" ><span class="form_btna">邮箱</span></th>
                    <th align="center" ><span class="form_btna">操作</span></th>

                </tr>
                <s:if test="#request.userList!=null && #request.userList.size()>0">
                    <s:iterator value="#request.userList" var="user">
                        <tr>
                            <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#user.userId'/>" /></td>
                            <td align="center"><s:property value="#user.sno"/></td>
                            <td align="center"><s:property value="#user.userName"/></td>
                            <td align="center"><s:property value="#user.grade"/></td>
                            <td align="center"><s:property value="#user.academe"/></td>
                            <td align="center"><s:property value="#user.profession"/></td>
                            <td align="center"><s:property value="#user.classes"/></td>
                            <td align="center"><s:property value="#user.telephone"/></td>
                            <td align="center"><s:property value="#user.email"/></td>

                            <td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/user_stuedit.do" class="blue" >编辑</a>

                            </td>
                        </tr>
                    </s:iterator>
                </s:if>


            </table>
        </div>

        <%--<div class="operate_bar">
            <div class="fenye">
                <input name="mulitId" type="hidden" id="mulitId" />
                <input type="hidden" name="currentPage" id="currentPage" value="<s:property value='#request.currentPage'/>" />
                ${request.gotoPageFormHTML}
            </div>

            <div class="oper_sp"> <span class="oper_check"><label><input name="all" type="checkbox" id="all" onclick="selectAll(this)" value="" />全部</label></span>
                <span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/user_del.do?currentPage=${request.currentPage}')"/></span></div>
        </div>--%>

    </form>
</div>
</body>
</html>


