<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/23
  Time: 13:50
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
    <h3 class="seth">竞赛资料管理</h3>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/information_list.do"  class="this"><b>管理</b></a></li>
            <li><a href="<%=basePath%>/system/information_add.do" ><b>新增</b></a></li>
        </ul>
    </div>
    <form action="<%=basePath%>/system/information_list.do" method="post" name="ListForm" id="ListForm">
        <div class="search">
            <ul>
                <li>

                    <span>文件名称</span> <span class="size150">
          <input name="fileName" type="text" id="fileName" value="${request.fileName}" />
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
                <li>到期已提交续费申请的店铺请尽快与店主联系并完成线下续费流程，待店主续费成功后请编辑店铺状态为正常营业</li>
            </ul>
        </div>
        <div class="fshoptb">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="fshop_table">
                <tr>

                    <th width="4%" align="left">&nbsp;</th>
                    <th width="15%" ><span class="form_btna">文件名称</span></th>
                    <th width="15%" ><span class="form_btna">文件描述</span></th>
                    <th width="15%" ><span class="form_btna">上传时间</span></th>
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
                <s:if test="#request.informationList!=null && #request.informationList.size()>0">
                    <s:iterator value="#request.informationList" var="information">
                        <tr>
                            <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#information.infoId'/>" /></td>
                            <!-- #set($user_img="$!webPath/resources/style/system/manage/blue/images/default_user_photo.gif")
                            #if($!obj.photo)
                            #set($user_img="$!imageWebServer/$!obj.photo.path/$!obj.photo.name")
                            #end
                            <td  align="left"><span class="memimg"><img  src="$!{user_img}" width="45" height="49" /></span> <span class="mem_detail">
                            <ul>
                            <li class="mem_font">$!obj.userName<i>(真实姓名：$!obj.trueName)</i></li>
                            <li>注册时间：$!CommUtil.formatLongDate($!obj.addTime)</li>
                            <li class="open"><span class="email"><a href="mailto:$!obj.email" title="用户邮箱:$!obj.email"><img src="$!webPath/resources/style/system/manage/blue/images/mail.jpg" width="15" height="11" /></a></span> <span><a href="#if($!obj.QQ)http://wpa.qq.com/msgrd?v=3&uin=$!obj.QQ&Site=$!obj.QQ&Menu=yes #else javascript:void(0);#end" #if($!obj.QQ)target="_blank"#end  title="#if($!obj.QQ)用户QQ:$!{obj.QQ}#else 用户没填写QQ#end"><img src="$!webPath/resources/style/system/manage/blue/images/qq.jpg" width="19" height="20" /></a></span> <span><a href="#if($!obj.WW)http://amos1.taobao.com/msg.ww?v=2&uid=$!{obj.WW}&s=2 #else javascript:void(0);#end" #if($!obj.WW)target="_blank"#end title="#if($!obj.WW)用户旺旺:$!obj.WW #else 用户没填写旺旺#end"><img src="$!webPath/resources/style/system/manage/blue/images/ww.jpg" width="17" height="17" border="0" /></a></span> <span><a  href="#if($!obj.MSN)msnim:chat?contact=$!{obj.MSN}#else javascript:void(0);#end"  title="#if($!obj.MSN)用户MSN:$!{obj.MSN}#else 用户没填写MSN #end" #if($!obj.MSN)target="_blank"#end><img src="$!webPath/resources/style/system/manage/blue/images/hotm.jpg" width="20" height="17" border="0" /></a></span> #if($!obj.user_type==1)<span><a  href="javascript:void(0);"  title="该用户为企业用户"><img src="$!webPath/resources/style/system/manage/blue/images/qiye.png" width="17" height="17" border="0" /></a></span>#end</li>
                            </ul>
                            </span></td> -->
                            <!-- <td align="center">
                            #if(!$obj.availableCoin)0.00#else$!obj.availableCoin#end
                            </td>add by lgf 2015-10-19
                            <td class="lightred"><ul>
                            <li>可用：<strong>#if($!{obj.availableBalance})$!{obj.availableBalance}#else 0 #end元</strong></li>
                            <li>冻结：<strong>#if($!{obj.freezeBlance})$!{obj.freezeBlance}#else 0 #end元</strong></li>
                            </ul></td> -->
                            <td align="center"><s:property value="#information.fileName"/></td>
                            <%--<td align="center"><s:property value="#information.description"/></td>--%>
                            <td align="center"><a href="<%=basePath%>/system/information_edit.do?infoId=<s:property value='#information.infoId'/>">查看内容</a></td>
                            <td align="center"><s:date name="#information.addTime" format="yyyy-MM-dd"/></td>


                            <!-- <td class="lightred"><ul>
                            <li>$!CommUtil.formatLongDate($!obj.lastLoginDate)</li>
                            <li>$!obj.lastLoginIp</li>
                            </ul></td> -->
                            <!--  #set($store_url=$!storeTools.query_user_store_url("$!obj.id","$!webPath")) -->
                            <!-- <td align="center">#if($!store_url!="")<a href="$!store_url" target="_blank"  class="blue" >店铺</a>#else <span style="color:#F00">未开店</span>#end</td> -->
                            <td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/information_edit.do?infoId=<s:property value='#information.infoId'/>&currentPage=${request.currentPage}" class="blue" >编辑</a>
                                |<a href="javascript:void(0);" onclick="if(confirm('删除资料后不可恢复，是否继续？'))window.location.href='<%=basePath%>/system/information_del.do?mulitId=<s:property value='#information.infoId'/>&currentPage=${request.currentPage}'" class="blue">删除</a>
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
                <span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/information_del.do?currentPage=${request.currentPage}')"/></span></div>
        </div>

    </form>
</div>
</body>
</html>


