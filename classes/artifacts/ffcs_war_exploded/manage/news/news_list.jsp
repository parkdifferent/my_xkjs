<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/4
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%-- <base href="<%=basePath%>"> --%>

    <title>竞赛新闻管理</title>

    <link  href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <link  href="<%=basePath%>/resources/style/common/css/jquery-ui-1.8.22.custom.css" type=text/css rel=stylesheet />
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.validate.min.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.common.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.poshytip.min.js"></script>
    <script src="<%=basePath%>/resources/js/jquery-ui-1.8.21.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.zh.cn.js" charset="utf-8"></script>

    <script type="text/javascript">
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





<%-- <div class="content">
     <div class="content_box">
         <div class="content_bar">
             <div class="right_news" id="bar_online" style="display:none"><a id="speak" onclick="open_im('','$!webPath','plat');" href="javascript:void(0);">在线客服</a></div>
             <span class="webmap"><a href="javascript:void(0);">管理地图</a></span> <span class="webskin"> <b>更换皮肤：</b> <em> <a href="javascript:void(0);" &lt;%&ndash;#if($!config.websiteCss=="blue") class="this" #end&ndash;%&gt;> <i><img src="$!webPath/resources/style/common/images/skin_blue.gif" width="15" height="16" webcss="blue" /></i> </a> <a href="javascript:void(0);" #if($!config.websiteCss=="black") class="this" #end> <i><img src="$!webPath/resources/style/common/images/skin_black.gif" width="15" height="16" webcss="black" /></i> </a></em> </span>
             <div class="position"> 您的位置：<a href="">首页</a> > <span id="top_nav_info">站点设置</span></div>
         </div>
         <div class="content_bottom">
             <iframe id="main_workspace" name="main_workspace" src="&lt;%&ndash;$!webPath/admin/welcome.htm&ndash;%&gt;" style="overflow:auto;height:550px" frameborder="0" width="100%" height="100%" scrolling="yes" onload="window.parent"></iframe>
         </div>
     </div>
 </div>--%>

<div class="cont">
    <h1 class="seth">竞赛新闻管理</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/news_list.do"  class="this"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/news_add.do" ><b>新增</b></a></li>
        </ul>
    </div>
    <FORM name="ListForm" id="ListForm"  action="<%=basePath%>/system/news_list.do" method="post">
        <div class="search">
      <span>
          <select name="condition" id="condition" >
              <option name="title" value="title">标题</option>

              <option name="content" value="content">内容</option>
          </select>
          </span> 
          
                  
          
          <span class="size150">
          <input name="value" type="text" id="value" value="${value}" />
          </span>

            <span>发布时间</span><span class="size100">
        <input name="beginTime" type="text" id="beginTime" value="${beginTime}"  readonly="readonly"/>
        </span><span>—</span><span class="size100">
        <input name="endTime" type="text" id="endTime" value="${endTime}"  readonly="readonly" /></span>
          
          <span>
          <input name="" type="submit"  value="搜索" style="cursor:pointer;" title="搜索"  class="search_btn"/>
          </span>

        </div>
        <div class="operation">
            <h3>友情提示</h3>
            <ul>
                <li>友情提示1友情提示1友情提示1</li>
                <li>友情提示2友情提示2友情提示2</li>
            </ul>
        </div>

        <div class="fshoptb">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="fshop_table">
                <tr>
                    <th width="4%" align="left">&nbsp;</th>

                    <th width="15%" ><span class="form_btna">新闻标题</span></th>

                    <th width="15%" ><span class="form_btna">新闻内容</span></th>
                    <th width="15%" ><span class="form_btna">发布时间</span></th>
                    <th width="15%" ><span class="form_btna">发布者</span></th>

                    <th align="center" ><span class="form_btna">操作</span></th>
                </tr>

                <%-- <s:if test="${textList}!=null && #${textList}.size()>0">
                                        <s:iterator value="${textList}" var="text">
                                        
                 <td class="lightred"><s:property value="textName"/></td>
                 <td class="lightred">${text.textDate }</td>
                 <td class="lightred">${text.textRemark }</td>
                 </s:iterator>
                                    </s:if> --%>

                <s:if test="#request.newsList!=null && #request.newsList.size()>0">
                    <s:iterator value="#request.newsList" var="news">
                        <tr>
                            <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#news.newsId'/>" /></td>
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
                            <td align="center"><s:property value="#news.title"/></td>
                            <td align="center"><s:property value="#news.content"/></td>
                            <td align="center"><s:date name="#news.newsTime" format="yyyy-MM-dd"/></td>
                            <td align="center"><s:property value="#news.publisher"/></td>

                            <!-- <td class="lightred"><ul>
                                <li>$!CommUtil.formatLongDate($!obj.lastLoginDate)</li>
                                <li>$!obj.lastLoginIp</li>
                              </ul></td> -->
                            <!--  #set($store_url=$!storeTools.query_user_store_url("$!obj.id","$!webPath")) -->
                            <!-- <td align="center">#if($!store_url!="")<a href="$!store_url" target="_blank"  class="blue" >店铺</a>#else <span style="color:#F00">未开店</span>#end</td> -->
                            <td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/news_edit.do?newsId=<s:property value='#news.newsId'/>&currentPage=${request.currentPage}" class="blue" >编辑</a>
                                |<a href="javascript:void(0);" onclick="if(confirm('删除新闻后不可恢复，是否继续？'))window.location.href='<%=basePath%>/system/news_del.do?mulitId=<s:property value='#news.newsId'/>&currentPage=${request.currentPage}'" class="blue">删除</a></td>
                        </tr>

                    </s:iterator>
                </s:if>

            </table>

        </div>

               <%-- <tr>
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
                                <span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/news_del.do?currentPage=${request.currentPage}')"/></span></div>

                        </div>
                   <%-- </td>
                </tr>--%>

    </FORM>
</div>

<%--  <%@include file="/WEB-INF/page/pageUI.jsp" %>      --%>

</body>
</html>

