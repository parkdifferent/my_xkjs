<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/11
  Time: 23:46
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
    <h3 class="seth">竞赛项目管理</h3>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/competition_list.do"  class="this"><b>管理</b></a></li>
            <li><a href="<%=basePath%>/system/competition_add.do" ><b>新增</b></a></li>
        </ul>
    </div>
    <form action="<%=basePath%>/system/competition_list.do" method="post" name="ListForm" id="ListForm">
        <div class="search">
            <ul>
                <li>

                    <span>竞赛名称</span> <span class="size150">
          <input name="comName" type="text" id="comName" value="${request.comName}" />
          </span>

                    <span>竞赛类别</span> <span>
      <select name="category" id="category">


          <option value="" ${request.category ==null?'selected':''}>请选择...</option>
          <option value="A类" ${request.category =="A类"?'selected':''}>A类</option>
          <option value="B类" ${request.category =="B类"?'selected':''}>B类</option>
          <option value="C类" ${request.category =="C类"?'selected':''}>C类</option>
      </select>
      </span>

                    <span>竞赛级别</span> <span>
      <select name="level" id="level">


          <option value="" ${request.level ==null?'selected':''}>请选择...</option>
          <option value="校级" ${request.level =="校级"?'selected':''}>校级</option>
          <option value="市级" ${request.level =="市级"?'selected':''}>市级</option>
          <option value="省级" ${request.level =="省级"?'selected':''}>省级</option>
          <option value="国家级" ${request.level =="国家级"?'selected':''}>国家级</option>
      </select>
      </span>



                    <span>竞赛状态</span> <span>
      <select name="status" id="status">


          <option value="" ${request.status ==null?'selected':''}>请选择...</option>
          <option value="0" ${request.status =="0"?'selected':''}>未开始</option>
          <option value="1" ${request.status =="1"?'selected':''}>开始报名</option>
          <option value="2" ${request.status =="2"?'selected':''}>报名结束</option>

      </select>
      </span>





                    <span>开始时间</span><span class="size100">
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
                <li>您可以按条件查询竞赛项目，新增、编辑、删除、批量删除竞赛项目，并且新增竞赛项目可以上传附件</li>
            </ul>
        </div>
        <div class="fshoptb">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="fshop_table">
                <tr>

                    <th width="4%" align="left">&nbsp;</th>
                    <th width="14%" ><span class="form_btna">竞赛名称</span></th>
                    <th width="14%" ><span class="form_btna">主办单位</span></th>
                    <th width="14%" ><span class="form_btna">校内负责单位</span></th>
                    <th width="6%" ><span class="form_btna">竞赛类别</span></th>
                    <th width="6%" ><span class="form_btna">竞赛级别</span></th>
                    <th width="10%" ><span class="form_btna">开始时间</span></th>

                    <th width="12%" ><span class="form_btna">附件</span></th>

                    <th width="8%" ><span class="form_btna">竞赛状态</span></th>
                    <th align="center" ><span class="form_btna">操作</span></th>

                </tr>
<s:if test="#request.competitionList!=null && #request.competitionList.size()>0">
    <s:iterator value="#request.competitionList" var="competition">
        <tr>
        <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#competition.comId'/>" /></td>

        <td align="center"><s:property value="#competition.comName"/></td>
        <td align="center"><s:property value="#competition.organizer"/></td>
        <td align="center"><s:property value="#competition.responsibleUnit"/></td>
        <td align="center"><s:property value="#competition.category"/></td>
        <td align="center"><s:property value="#competition.level"/></td>
        <td align="center"><s:date name="#competition.startDate" format="yyyy-MM-dd"/></td>
            <td align="center"><s:property value="#competition.fileName"/></td>


            <td align="center">
                <s:if test="#competition.status==0">
                    未开始
                </s:if>
                <s:if test="#competition.status==1">
                    开始报名
                </s:if>
                <s:if test="#competition.status==2">
                    报名结束
                </s:if>

            </td>


        <td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/competition_edit.do?comId=<s:property value='#competition.comId'/>&currentPage=${request.currentPage}" class="blue" >编辑</a>
        |<a href="javascript:void(0);" onclick="if(confirm('删除竞赛项目后不可恢复，是否继续？'))window.location.href='<%=basePath%>/system/competition_del.do?mulitId=<s:property value='#competition.comId'/>&currentPage=${request.currentPage}'" class="blue">删除</a>
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
        <span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/competition_del.do?currentPage=${request.currentPage}')"/></span></div>
        </div>

    </form>
</div>
</body>
</html>

