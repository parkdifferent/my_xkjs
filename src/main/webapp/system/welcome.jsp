<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    request.setAttribute("base",request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%--$!{config.title}---%>学科竞赛管理系统</title>
    <link href="${base}/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <script src="${base}/resources/js/jquery-1.6.2.js"></script>
    <script>
        var a = [];
        function init(){
            a.push(1);
        }

    </script>
</head>
<body>
<div class="cont">
    <h1 class="seth">欢迎页面</h1>
    <div class="system_top">
        <div class="welcome"><strong>您好,<span style="color:#06F">${sessionScope.userName}</span>,欢迎使用<span style="color:#F60">学科竞赛管理系统</span></strong> <%--<span class="welcome_sp"><b>[本次统计：<strong>addTime&lt;%&ndash;$!CommUtil.formatTime("yyyy-MM-dd HH:mm",$!stat.addTime)&ndash;%&gt;</strong></b>,<b>下次统计：<strong>next_time&lt;%&ndash;$!CommUtil.formatTime("yyyy-MM-dd HH:mm",$!stat.next_time)&ndash;%&gt;</strong>]</b></span>--%> </div>
       <%-- <div class="wela">
            <h2>一周动态</h2>
            <ul>
                <li><a href="${base}/admin/sys_tip_list.htm"><em>重要提醒</em><i><b class="wela_bg_red">size&lt;%&ndash;$!{sts.size()}&ndash;%&gt;</b></i></a></li>
                <li><em>新增会员数</em><i><b class="wela_bg_yellow">&lt;%&ndash;$!{stat.week_user}&ndash;%&gt;week_user</b></i></li>
                <li><em>新增商品数</em><i><b class="wela_bg_orange">&lt;%&ndash;$!{stat.week_goods}&ndash;%&gt;week_goods</b></i></li>
                <li><em>新增店铺数</em><i><b class="wela_bg_blue">&lt;%&ndash;$!{stat.week_store}&ndash;%&gt;week_store</b></i></li>
                &lt;%&ndash;<li><em>新增订单数</em><i><b class="wela_bg_green">$!{stat.week_order}</b></i></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/complaint_list.htm?status=new','main_workspace','complaint_manage_op','about_trade')"><em>新增投诉</em><i><b class="wela_bg_pink2">$!{stat.week_complaint}</b></i></a></li>
                <li><em>本周活跃会员</em><i><b class="wela_bg_pink3">$!{stat.week_live_user}</b></i></li>
                <li><em>新增直通车</em><i><b class="wela_bg_blue">$!{stat.week_ztc}</b></i></li>
                <li><em>新增自提点</em><i><b class="wela_bg_green">$!{stat.week_delivery}</b></i></li>
                <li><em>新增圈子</em><i><b class="wela_bg_orange">$!{stat.week_circle}</b></i></li>
                <li><em>新增资讯</em><i><b class="wela_bg_green">$!{stat.week_information}</b></i></li>
                <li><em>新增帖子</em><i><b class="wela_bg_blue">$!{stat.week_invitation}</b></i></li>&ndash;%&gt;
            </ul>
        </div>--%>

<c:if test="${sessionScope.role=='admin'}">
        <div class="wela">
            <h2>系统统计</h2>
            <ul>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/user_list.htm','main_workspace','member_manage_op','about_member')"><em>学生总数</em><i><b class="wela_bg_blue2"> 8<%--${sessionScope.userSize}--%></b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/store_list.htm','main_workspace','store_manage_op','about_store')"><em>指导教师总数 </em><i> <b class="wela_bg_pink">4 <%--${sessionScope.teacherSize}--%></b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/store_list.htm','main_workspace','store_manage_op','about_store')"><em>报名人数 </em><i> <b class="wela_bg_blue"> 6  <%-- ${sessionScope.enterSize}--%><%--$!{stat.all_store}--%></b></i></a></li>
                <%--<li><em>店铺待审核</em><i><b class="wela_bg_pink2">$!{stat.store_audit}</b></i></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/goods_list.htm','main_workspace','goods_manage_op','about_goods')"><em>商品总数</em><i><b class="wela_bg_pink3">$!{stat.all_goods}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/payofflog_list.htm?status=0','main_workspace','payoff_list_op','sys_payoff')"><em>未结算账单</em><i><b class="wela_bg_green">$!{stat.not_payoff_num}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/goods_list.htm?status=-5','main_workspace','goods_manage_op','about_goods')"><em>商品待审核</em><i><b class="wela_bg_blue">$!{stat.goods_audit}</b></i></a></li>
                <li><em>会员总预存款</em><i><b class="wela_bg_blue2">¥$!{stat.all_user_balance}</b></i></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/refund_list.htm','main_workspace','return_manage_op','about_trade')"><em>商品退款</em><i><b class="wela_bg_red">$!{stat.not_refund}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/groupinfo_refund_list.htm','main_workspace','return_manage_op','about_trade')"><em>消费码退款</em><i><b class="wela_bg_orange">$!{stat.not_grouplife_refund}</b></i></a></li>
                <!--  <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/ztc_apply.htm','main_workspace','ztc_set','business_operation')"><em>直通车申请</em><i><b class="wela_bg_green">$!{stat.ztc_audit_count}</b></i></a></li> -->
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/delivery_apply_list.htm','main_workspace','delivery_address','business_operation')"><em>自提点申请</em><i><b class="wela_bg_blue2">$!{stat.not_grouplife_refund}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/information_verifylist.htm','main_workspace','info_op','about_website')"><em>资讯待审核</em><i><b class="wela_bg_blue">$!{stat.not_grouplife_refund}</b></i></a></li>--%>
            </ul>
        </div>

    </c:if>

<c:if test="${sessionScope.role=='student'}">

    <div class="wela">
        <h2>系统统计</h2>
        <ul>
            <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/user_list.htm','main_workspace','member_manage_op','about_member')"><em>竞赛开始报名</em><i><b class="wela_bg_blue2"> 3<%--$!{stat.all_user}--%></b></i></a></li>
            <%--<li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/store_list.htm','main_workspace','store_manage_op','about_store')"><em>指导教师总数 </em><i> <b class="wela_bg_pink"> 3&lt;%&ndash;$!{stat.all_store}&ndash;%&gt;</b></i></a></li>
            <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/store_list.htm','main_workspace','store_manage_op','about_store')"><em>报名人数 </em><i> <b class="wela_bg_blue"> 4&lt;%&ndash;$!{stat.all_store}&ndash;%&gt;</b></i></a></li>--%>
                <%--<li><em>店铺待审核</em><i><b class="wela_bg_pink2">$!{stat.store_audit}</b></i></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/goods_list.htm','main_workspace','goods_manage_op','about_goods')"><em>商品总数</em><i><b class="wela_bg_pink3">$!{stat.all_goods}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/payofflog_list.htm?status=0','main_workspace','payoff_list_op','sys_payoff')"><em>未结算账单</em><i><b class="wela_bg_green">$!{stat.not_payoff_num}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/goods_list.htm?status=-5','main_workspace','goods_manage_op','about_goods')"><em>商品待审核</em><i><b class="wela_bg_blue">$!{stat.goods_audit}</b></i></a></li>
                <li><em>会员总预存款</em><i><b class="wela_bg_blue2">¥$!{stat.all_user_balance}</b></i></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/refund_list.htm','main_workspace','return_manage_op','about_trade')"><em>商品退款</em><i><b class="wela_bg_red">$!{stat.not_refund}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/groupinfo_refund_list.htm','main_workspace','return_manage_op','about_trade')"><em>消费码退款</em><i><b class="wela_bg_orange">$!{stat.not_grouplife_refund}</b></i></a></li>
                <!--  <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/ztc_apply.htm','main_workspace','ztc_set','business_operation')"><em>直通车申请</em><i><b class="wela_bg_green">$!{stat.ztc_audit_count}</b></i></a></li> -->
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/delivery_apply_list.htm','main_workspace','delivery_address','business_operation')"><em>自提点申请</em><i><b class="wela_bg_blue2">$!{stat.not_grouplife_refund}</b></i></a></li>
                <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/information_verifylist.htm','main_workspace','info_op','about_website')"><em>资讯待审核</em><i><b class="wela_bg_blue">$!{stat.not_grouplife_refund}</b></i></a></li>--%>
        </ul>
    </div>


    </c:if>


        <c:if test="${sessionScope.role=='teacher'}">

            <div class="wela">
                <h2>系统统计</h2>
                <ul>
                    <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/user_list.htm','main_workspace','member_manage_op','about_member')"><em>指导学生</em><i><b class="wela_bg_blue2"> 2<%--$!{stat.all_user}--%></b></i></a></li>
                        <%--<li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/store_list.htm','main_workspace','store_manage_op','about_store')"><em>指导教师总数 </em><i> <b class="wela_bg_pink"> 3&lt;%&ndash;$!{stat.all_store}&ndash;%&gt;</b></i></a></li>
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/store_list.htm','main_workspace','store_manage_op','about_store')"><em>报名人数 </em><i> <b class="wela_bg_blue"> 4&lt;%&ndash;$!{stat.all_store}&ndash;%&gt;</b></i></a></li>--%>
                        <%--<li><em>店铺待审核</em><i><b class="wela_bg_pink2">$!{stat.store_audit}</b></i></li>
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/goods_list.htm','main_workspace','goods_manage_op','about_goods')"><em>商品总数</em><i><b class="wela_bg_pink3">$!{stat.all_goods}</b></i></a></li>
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/payofflog_list.htm?status=0','main_workspace','payoff_list_op','sys_payoff')"><em>未结算账单</em><i><b class="wela_bg_green">$!{stat.not_payoff_num}</b></i></a></li>
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/goods_list.htm?status=-5','main_workspace','goods_manage_op','about_goods')"><em>商品待审核</em><i><b class="wela_bg_blue">$!{stat.goods_audit}</b></i></a></li>
                        <li><em>会员总预存款</em><i><b class="wela_bg_blue2">¥$!{stat.all_user_balance}</b></i></li>
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/refund_list.htm','main_workspace','return_manage_op','about_trade')"><em>商品退款</em><i><b class="wela_bg_red">$!{stat.not_refund}</b></i></a></li>
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/groupinfo_refund_list.htm','main_workspace','return_manage_op','about_trade')"><em>消费码退款</em><i><b class="wela_bg_orange">$!{stat.not_grouplife_refund}</b></i></a></li>
                        <!--  <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/ztc_apply.htm','main_workspace','ztc_set','business_operation')"><em>直通车申请</em><i><b class="wela_bg_green">$!{stat.ztc_audit_count}</b></i></a></li> -->
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/delivery_apply_list.htm','main_workspace','delivery_address','business_operation')"><em>自提点申请</em><i><b class="wela_bg_blue2">$!{stat.not_grouplife_refund}</b></i></a></li>
                        <li><a href="javascript:void(0);" onclick="window.parent.openURL('url','${base}/admin/information_verifylist.htm','main_workspace','info_op','about_website')"><em>资讯待审核</em><i><b class="wela_bg_blue">$!{stat.not_grouplife_refund}</b></i></a></li>--%>
                </ul>
            </div>


        </c:if>





    </div>
    <%--<div class="system_info">
        <h3>系统信息</h3>
        <div class="system_info_box"> <span><strong>服务器操作系统：操作系统&lt;%&ndash;$!os&ndash;%&gt;</strong></span> <span><strong>Web服务器：Web服务器&lt;%&ndash;$!web_server_version&ndash;%&gt;</strong></span> <span><strong>JAVA版本：java_version&lt;%&ndash;$!java_version&ndash;%&gt; </strong></span> <span><strong>数据库版本信息：database_version&lt;%&ndash;$!database_version&ndash;%&gt;</strong></span> <span><strong>xShop版本号：shop_version&lt;%&ndash;$!shop_version&ndash;%&gt;</strong></span> <span><strong>安装日期：addTime&lt;%&ndash;$!CommUtil.formatLongDate($!config.addTime)&ndash;%&gt;</strong></span> </div>
    </div>--%>
</div>
</body>
</html>
