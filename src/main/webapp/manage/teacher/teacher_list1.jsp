<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/26
  Time: 15:26
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
    <h3 class="seth">指导教师管理</h3>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/teacher_list.do"  class="this"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/teacher_add.do" ><b>新增</b></a></li>
            <%--<li><a href="<%=basePath%>/system/teacher_importExcel.do" class="this"><b>批量导入</b></a></li>--%>
            <li><a class="add_btn" <%--onclick="payoff_excel()"--%> href="<%=basePath%>/system/teacher_importExcel.do"> <b class="add_btn_b">导入Excel</b></a></li>
        </ul>
    </div>
    <form action="<%=basePath%>/system/teacher_list.do" method="post" name="ListForm" id="ListForm">
        <div class="search">
            <ul>
                <li>

                    <%-- <select name="condition" id="condition" >
                         <option name="title" value="title">标题</option>
 
                         <option name="content" value="content">内容</option>
                     </select>
                     </span>
 
                      <span class="size150">
           <input name="value" type="text" id="value" value="${value}" />
           </span>--%>

                    <span>工号</span> <span class="size150">
          <input name="tno" type="text" id="tno" value="${request.tno}" />
          </span>

                    <span>姓名</span> <span class="size150">
          <input name="name" type="text" id="name" value="${request.name}" />
          </span>

                        <span>学院</span> <span>
      <select name="academe" id="academe">
          <option value="" ${request.academe ==null?'selected':''}>请选择...</option>
          <s:if test="#request.academeList!=null && #request.academeList.size()>0">
              <s:iterator value="#request.academeList" id="academe1">
                  <option value="${academe1.academeName}" ${academe1.academeName ==request.academe?'selected':''}>${academe1.academeName}</option>
              </s:iterator>
          </s:if>


      </select>
      </span>

                        <span>职称</span> <span>
      <select name="rank" id="rank">
          <option value="" ${request.rank ==null?'selected':''}>请选择...</option>
          <option value="助教" ${request.rank =="助教"?'selected':''}>助教</option>
          <option value="讲师" ${request.rank =="讲师"?'selected':''}>讲师</option>
          <option value="副教授" ${request.rank =="副教授"?'selected':''}>副教授</option>
          <option value="教授" ${request.rank =="教授"?'selected':''}>教授</option>
      </select>
      </span>

        <span>
        <input name="" type="submit"  value="搜索" style="cursor:pointer;" class="search_btn"/>
        </span>



                </li>
            </ul>
        </div>
        <div class="operation">
            <h3>友情提示</h3>
            <ul>
                <li>您可以按条件查询教师信息，新增、编辑、删除、批量删除教师信息，并且能够通过Excel批量导入教师信息</li>
            </ul>
        </div>
        <div class="fshoptb">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="fshop_table">
                <tr>

                    <th width="4%" align="left">&nbsp;</th>

                    <th width="13%" ><span class="form_btna">工号</span></th>

                    <th width="8%" ><span class="form_btna">姓名</span></th>

                    <th width="13%" ><span class="form_btna">学院</span></th>
                    <th width="8%" ><span class="form_btna">学历</span></th>

                    <th width="8%" ><span class="form_btna">职称</span></th>
                    <th width="13%" ><span class="form_btna">研究方向</span></th>

                   <%-- <th width="15%" ><span class="form_btna">所获荣誉</span></th>--%>

                    <th width="8%" ><span class="form_btna">简介</span></th>
                    <th width="12%" ><span class="form_btna">邮箱</span></th>

                    <th align="center" ><span class="form_btna">操作</span></th>


                    <%-- <th>&nbsp;</th>
                     <th width="20%" ><span class="form_btna">店铺名称</span></th>
                     <th width="16%"><span class="form_btna">店主用户名 | 店主姓名</span></th>
                     <th width="10%"><span class="form_btna">所在地</span></th>
                     <th width="10%"><span class="form_btna">店铺类型</span></th>
                     <th width="10%"><span class="form_btna">有效期至</span></th>
                     <th width="6%"><span class="form_btna">状态</span></th>
                     <th width="6%"><span class="form_btna">公司信息</span></th>
                     <th><b class="form_btnb">操作</b></th>--%>
                </tr>
                <s:if test="#request.teacherList!=null && #request.teacherList.size()>0">
                    <s:iterator value="#request.teacherList" var="teacher">
                        <tr>
                            <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#teacher.teaId'/>" /></td>

                            <td align="center"><s:property value="#teacher.tno"/></td>
                            <td align="center"><s:property value="#teacher.name"/></td>

                            <td align="center"><s:property value="#teacher.academe"/></td>

                            <td align="center"><s:property value="#teacher.education"/></td>
                            <td align="center"><s:property value="#teacher.rank"/></td>




                            <td align="center"><s:property value="#teacher.research"/></td>
                            <%--<td align="center"><s:property value="#teacher.honor"/></td>--%>
                            <td align="center"> <a href="<%=basePath%>/system/teacher_edit.do?teaId=<s:property value='#teacher.teaId'/>">查看</a></td>
                           <%-- <td align="center"><s:property value="#teacher.brief"/></td>--%>
                            <td align="center"><s:property value="#teacher.email"/></td>

                            <!-- <td class="lightred"><ul>
                                <li>$!CommUtil.formatLongDate($!obj.lastLoginDate)</li>
                                <li>$!obj.lastLoginIp</li>
                              </ul></td> -->
                            <!--  #set($store_url=$!storeTools.query_user_store_url("$!obj.id","$!webPath")) -->
                            <!-- <td align="center">#if($!store_url!="")<a href="$!store_url" target="_blank"  class="blue" >店铺</a>#else <span style="color:#F00">未开店</span>#end</td> -->
                            <td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/teacher_edit.do?teaId=<s:property value='#teacher.teaId'/>&currentPage=${request.currentPage}" class="blue" >编辑</a>
                                |<a href="javascript:void(0);" onclick="if(confirm('删除教师后不可恢复，是否继续？'))window.location.href='<%=basePath%>/system/teacher_del.do?mulitId=<s:property value='#teacher.teaId'/>&currentPage=${request.currentPage}'" class="blue">删除</a></td>
                        </tr>

                    </s:iterator>
                </s:if>

            </table>

        </div>

        <%--<tr>
            <td colspan="9" style="border-bottom:0px; padding:0px;">--%>
        <div class="operate_bar">
            <%-- <div class="fenye">
             <input type="hidden" name="currentPage" id="currentPage" value="$!currentPage" />
             <input name="mulitId" type="hidden" id="mulitId" />

            <s:property value="#request.gotoPageFormHTML"/>

             </div>   --%>

            <div class="fenye">
                <input name="mulitId" type="hidden" id="mulitId" />
                <input type="hidden" name="currentPage" id="currentPage" value="<s:property value='#request.currentPage'/>" />
                ${request.gotoPageFormHTML}

                <%-- <s:property value="#request.gotoPageFormHTML"/> --%>

                <%-- <s:property value="#request.gotoPageFormHTML"/> --%>

            </div>

            <div class="oper_sp"> <span class="oper_check"><label><input name="all" type="checkbox" id="all" onclick="selectAll(this)" value="" />全部</label></span>
                <span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/teacher_del.do?currentPage=${request.currentPage}')"/></span></div>

        </div>
        <%--</td>
    </tr>--%>

    </FORM>
</div>

<%--  <%@include file="/WEB-INF/page/pageUI.jsp" %>      --%>

</body>
</html>


