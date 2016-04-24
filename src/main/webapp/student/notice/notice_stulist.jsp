<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/12
  Time: 0:41
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
<div class="cont">
    <h3 class="seth">竞赛通知</h3>
   <%-- <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/notice_list.do"  class="this"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/notice_add.do" ><b>新增</b></a></li>
        </ul>
    </div>--%>
    <form action="<%=basePath%>/system/notice_stulist.do" method="post" name="ListForm" id="ListForm">
        <div class="search">
            <ul>
                <li>

                       <span>标题</span> <span class="size150">
          <input name="title" type="text" id="title" value="${request.title}" />
          </span>

                       <span>内容</span> <span class="size150">
          <input name="content" type="text" id="content" value="${request.content}" />
          </span>


                    <span>通知时间</span><span class="size100">
        <input name="beginTime" type="text" id="beginTime" value="${beginTime}"  readonly="readonly"/>
        </span><span>—</span><span class="size100">
        <input name="endTime" type="text" id="endTime" value="${endTime}"  readonly="readonly" /></span>

        <span>
        <input name="" type="submit"  value="搜索" style="cursor:pointer;" class="search_btn"/>
        </span>

                </li>
            </ul>
        </div>
        <div class="operation">
            <h3>友情提示</h3>
            <ul>
                <li>查看竞赛通知</li>
            </ul>
        </div>
        <div class="fshoptb">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="fshop_table">
                <tr>

                    <th width="4%" align="left">&nbsp;</th>

                    <th width="15%" ><span class="form_btna">通知标题</span></th>

                    <th width="15%" ><span class="form_btna">通知内容</span></th>

                    <th width="15%" ><span class="form_btna">附件</span></th>

                    <th width="15%" ><span class="form_btna">发布时间</span></th>
                    <th width="15%" ><span class="form_btna">发布者</span></th>

                    <th align="center" ><span class="form_btna">操作</span></th>

                </tr>
                <s:if test="#request.noticeList!=null && #request.noticeList.size()>0">
                    <s:iterator value="#request.noticeList" var="notice">
                        <tr>
                            <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#notice.noticeId'/>" /></td>

                            <td align="center"><s:property value="#notice.title"/></td>


                            <td align="center"><a href="<%=basePath%>/system/notice_stuedit.do?noticeId=<s:property value='#notice.noticeId'/>">点击查看</a></td>
                            <td align="center"><s:property value="#notice.fileName"/></td>
                            <td align="center"><s:date name="#notice.noticeTime" format="yyyy-MM-dd"/></td>
                            <td align="center"><s:property value="#notice.publisher"/></td>


                            <td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/notice_stuedit.do?noticeId=<s:property value='#notice.noticeId'/>&currentPage=${request.currentPage}" class="blue" >查看</a>
                                <%--|<a href="javascript:void(0);" onclick="if(confirm('删除新闻后不可恢复，是否继续？'))window.location.href='<%=basePath%>/system/notice_del.do?mulitId=<s:property value='#notice.noticeId'/>&currentPage=${request.currentPage}'" class="blue">删除</a>--%>
                            </td>
                        </tr>

                    </s:iterator>
                </s:if>

            </table>

        </div>


        <div class="operate_bar">

            <div class="fenye">
                <input name="mulitId" type="hidden" id="mulitId" />
                <input type="hidden" name="currentPage" id="currentPage" value="<s:property value='#request.currentPage'/>" />
                ${request.gotoPageFormHTML}

            </div>

            <div class="oper_sp"> <span class="oper_check"><label><input name="all" type="checkbox" id="all" onclick="selectAll(this)" value="" />全部</label></span>
                <%--<span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/notice_del.do?currentPage=${request.currentPage}')"/></span>--%>
            </div>

        </div>


    </FORM>
</div>


</body>
</html>

