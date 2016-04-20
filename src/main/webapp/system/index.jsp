<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/3/30
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <base href="<%=basePath%>">
    <title><%--$!{config.title} - $!{config.poweredby}--%></title>
    <meta name="keywords" content="<%--$!config.keywords--%>" />
    <meta name="description" content="<%--$!config.description--%>" />
    <meta name="generator" content="xShop 1.3" />
    <meta name="author" content="<%--$!{config.meta_author}--%>" />
    <meta name="copyright" content="<%--$!{config.copyRight}--%>" />
    <link href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.base.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.common.js"></script>
    <script>
        jQuery(document).ready(function(){
            pagestyle();
            jQuery(".webmap a").click(function(){
                jQuery(".webmap_box").fadeIn('normal');
            });
            jQuery(".close_map").click(function(){
                jQuery(".webmap_box").fadeOut('normal');
            });
            jQuery("a[id^=complex_]").click(function(){
                var suffix=jQuery(this).attr("suffix");
                if(jQuery("#"+suffix+"info").css("display")!="block"){
                    jQuery(this).parent().parent().find("a[id^=complex_]").each(function(index,item){
                        jQuery(item).find("img").attr("src","<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg");
                        jQuery(item).parent().find("ul").hide();
                    });
                }
                if(jQuery("#"+suffix+"info").css("display")=="block"){
                    jQuery("#"+suffix+"info").hide();
                    jQuery("#"+suffix+"img").attr("src","<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg");
                }else{
                    jQuery("#"+suffix+"info").show();
                    jQuery("#"+suffix+"img").attr("src","<%=basePath%>/resources/style/system/manage/blue/images/contract.jpg");
                }
            });
            jQuery(".webskin em a img").click(function(){
                var webcss = jQuery(this).attr("webcss");
                jQuery.post("<%=basePath%>/admin/set_websiteCss.htm",{
                    "webcss":webcss
                },function(data){
                    window.location.href="<%=basePath%>/admin/index.htm";
                },"text");
            });
            jQuery("a[id^=about_]").click(function(){
                var id =jQuery(this).attr("id");
                if(id.indexOf("self")>=0){
                    jQuery("#bar_online").show();
                }else{
                    jQuery("#bar_online").hide();
                }
            });
        });

        jQuery(function(){
            run();             //加载页面时启动定时器
            var interval;
            function run(){
                interval = setInterval(chat, "5000");
            }
            function chat(){
                jQuery.ajax({type:'POST',
                    url:'<%=basePath%>/admin/plat_chatting_ajax_refresh.htm',
                    data:{},
                    success: function(data){
                        if((data-0)>0){
                            jQuery("#speak").addClass("this");
                        }else{
                            jQuery("#speak").removeClass("this");
                        }
                    }

                });
            }
        });

    </script>
</head>
<body scroll="yes">
<div class="main">
    <div class="top">
        <div class="login">
            <ul>
                <li>
                    <span class="login_img"><img src="<%=basePath%>/resources/style/system/manage/blue/images/user.png" /></span>
                    <span class="login_word"><%--$!{user.userName}--%><%--loginName--%>admin</span>
                </li>
                <a href="<%=basePath%>/xShop_logout.htm" target="_self"><li>
                    <span class="login_img"><img src="<%=basePath%>/resources/style/system/manage/blue/images/exit.png" /></span>
                    <span class="login_word">安全退出</span>
                </li></a>
                <a href="<%=basePath%>/admin/admin_pws.htm" target="main_workspace"><li>
                    <span class="login_img"><img src="<%=basePath%>/resources/style/system/manage/blue/images/password.png" /></span>
                    <span class="login_word">修改密码</span>
                </li></a>
                <%--<a href="<%=basePath%>/wap/index.htm" target="_blank"><li>
                    <span class="login_img"><img src="<%=basePath%>/resources/style/system/manage/blue/images/home.png" /></span>
                    <span class="login_word">商城首页</span>
                </li></a>--%>
            </ul>
        </div>
        <div class="logo"> <%--#if($!config.admin_manage_logo)
            #set($imgUrl ="$!imageWebServer/$!config.admin_manage_logo.path/$!config.admin_manage_logo.name")
            #else
            #set($imgUrl ="<%=basePath%>/resources/style/system/manage/blue/images/logo.png")
            #end--%> <a href="javascript:void(0);" onclick="openURL('show','common_operation')"><img src="<%--$!{imgUrl}--%>" width="247" height="35" /></a> </div>
       <%-- <div class="nav">
            <ul>
                <li class="this"><a href="javascript:void(0);" id="common_operation_menu" onclick="openURL('show','common_operation')"><em class="nav_home"></em><b>首页</b></a></li>
                <li><a href="javascript:void(0);" id="base_set_menu" onclick="openURL('show','base_set')" ><em class="nav_set"></em><b>设置</b></a></li>
                <li><a href="javascript:void(0);" id="about_goods_menu" onclick="openURL('show','about_goods')"><em class="nav_product"></em><b>商品</b></a></li>
                <!--<li><a href="javascript:void(0);" id="about_fitment_menu" onclick="openURL('show','about_fitment')"><em class="nav_fitment"></em><b>装修</b></a></li>-->
                <!-- <li><a href="javascript:void(0);" id="about_self_menu" onclick="openURL('show_complex','about_self')"><em class="nav_self"></em><b>自营</b></a></li>   ## change by 2015/11/26 -->
                <li><a href="javascript:void(0);" id="about_store_menu" onclick="openURL('show','about_store')"><em class="nav_shop"></em><b>店铺</b></a></li>
                <li><a href="javascript:void(0);" id="about_member_menu" onclick="openURL('show','about_member')"><em class="nav_menber"></em><b>会员</b></a></li>
                <li><a href="javascript:void(0);" id="about_trade_menu" onclick="openURL('show','about_trade')"><em class="nav_pay"></em><b>交易</b></a></li>
                <!-- <li><a href="javascript:void(0);" id="about_website_menu" onclick="openURL('show','about_website')"><em class="nav_website"></em><b>网站</b></a></li>-->
                <li><a href="javascript:void(0);" id="business_operation_menu" onclick="openURL('show','business_operation')"><em class="nav_operate"></em><b>运营</b></a></li>
                <li><a href="javascript:void(0);" id="sys_payoff_menu" onclick="openURL('show','sys_payoff')"><em class="nav_payoff"></em><b>结算</b></a></li>
                <li><a href="javascript:void(0);" id="sys_tool_menu" onclick="openURL('show','sys_tool')"><em class="nav_tool"></em><b>工具</b></a></li>
            </ul>
        </div>--%>
    </div>
    <div class="index" id="workspace">
        <div class="left">
            <div class="left_box">
                <div class="lefttop"> </div>
                <div class="left_ul">
                    <ul class="ulleft" id="common_operation" style="display:block">
                        <div class="leftone">常用操作</div>
                        <li><a class="this" id="welcome_op" href="javascript:void(0);" onclick="openURL('url','<%--<%=basePath%>/admin/welcome.htm--%><%=basePath%>/system/welcome.jsp','main_workspace','welcome_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>欢迎页面000</span></a> </li>

                        <li><a href="javascript:void(0);" id="set_site_op_q" onclick="openURL('url','<%--<%=basePath%>/admin/set_site.htm--%><%=basePath%>/system/user_list.do','main_workspace','set_site_op_q')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>用户管理</span></a></li>
                        <li><a href="javascript:void(0);" id="user_list_op_q" onclick="openURL('url','<%--<%=basePath%>/admin/user_list.htm--%><%=basePath%>/system/news_list.do','main_workspace','user_list_op_q')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>竞赛新闻管理</span></a></li>
                        <li><a href="javascript:void(0);" id="store_list_op_q" onclick="openURL('url','<%--<%=basePath%>/admin/store_list.htm--%><%=basePath%>/system/notice_list.do','main_workspace','store_list_op_q')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>竞赛通知管理</span></a></li>
                        <li><a href="javascript:void(0);" id="goods_manage_op_q" onclick="openURL('url','<%--<%=basePath%>/admin/goods_list.htm--%><%=basePath%>/system/competition_list.do','main_workspace','goods_manage_op_q')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>竞赛项目管理</span></a></li>
                        <li><a href="javascript:void(0);" id="order_list_op_q" onclick="openURL('url','<%--<%=basePath%>/admin/order_list.htm--%><%=basePath%>/system/enter_list.do','main_workspace','order_list_op_q')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>竞赛报名管理</span></a></li>
                        <!-- qkj    on 2015/12/28-->
                        <li><a href="javascript:void(0);" id="pay_list_op_q" onclick="openURL('url','<%--<%=basePath%>/admin/pay_list.htm--%><%=basePath%>/system/result_list.do','main_workspace','pay_list_op_q')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>竞赛结果管理</span></a></li>



                    </ul>
                    <ul class="ulleft" id="base_set" style="display:none;">
                        <div class="leftone">基本设置</div>
                        <li><a href="javascript:void(0);" id="set_site_op" class="this" onclick="openURL('url','<%=basePath%>/admin/set_site.htm','main_workspace','set_site_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>站点设置</span></a></li>
                        <li><a href="javascript:void(0);" id="set_image_op" onclick="openURL('url','<%=basePath%>/admin/set_image.htm','main_workspace','set_image_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>上传设置</span></a></li>
                        <li><a href="javascript:void(0);" id="set_seo_op" onclick="openURL('url','<%=basePath%>/admin/set_seo.htm','main_workspace','set_seo_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>SEO设置</span></a></li>
                        <li><a href="javascript:void(0);" id="set_email_op" onclick="openURL('url','<%=basePath%>/admin/set_email.htm','main_workspace','set_email_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>Email设置</span></a></li>
                        <li><a href="javascript:void(0);" id="set_sms_op" onclick="openURL('url','<%=basePath%>/admin/set_sms.htm','main_workspace','set_sms_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>短信设置</span></a></li>
                        <li><a href="javascript:void(0);" id="set_second_domain_op" class="this" onclick="openURL('url','<%=basePath%>/admin/set_second_domain.htm','main_workspace','set_second_domain_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>二级域名</span></a></li>
                        <li><a href="javascript:void(0);" id="template_list_op" onclick="openURL('url','<%=basePath%>/admin/template_list.htm','main_workspace','template_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>通知模板</span></a></li>
                        <li><a href="javascript:void(0);" id="admin_list_op" onclick="openURL('url','<%=basePath%>/admin/admin_list.htm','main_workspace','admin_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>管理员管理</span></a></li>
                        <li><a href="javascript:void(0);" id="payment_list_op" onclick="openURL('url','<%=basePath%>/admin/payment_list.htm','main_workspace','payment_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>支付方式</span></a></li>
                        <li><a href="javascript:void(0);"id="complex_area" suffix="area_"><img id="area_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>地区管理</span></a>
                            <ul id="area_info" style="display:none;">
                                <li><a id="arealist_op" href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/area_list.htm','main_workspace','arealist_op')"><span>常用地区</span></a></li>
                                <li><a href="javascript:void(0);" id="trans_area_op" onclick="openURL('url','<%=basePath%>/admin/trans_area_list.htm','main_workspace','trans_area_op')"><span>运费区域</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);"id="complex_kuaidi" suffix="kuaidi_"><img id="kuaidi_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>快递设置</span></a>
                            <ul id="kuaidi_info" style="display:none;">
                                <li><a href="javascript:void(0);" id="kaudi_set_op" onclick="openURL('url','<%=basePath%>/admin/set_kuaidi.htm','main_workspace','kaudi_set_op')"><span>快递设置</span></a></li>
                                <li><a href="javascript:void(0);" id="kaudi_company_op" onclick="openURL('url','<%=basePath%>/admin/express_company_list.htm','main_workspace','kaudi_company_op')"><span>快递公司</span></a></li>
                                <%--#if($!config.kuaidi_type==1)
                                <li><a href="javascript:void(0);" id="kaudi_callback_op" onclick="openURL('url','<%=basePath%>/admin/express_info_list.htm','main_workspace','kaudi_callback_op')"><span>快递推送</span></a></li>
                                #end--%>
                            </ul>
                        </li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="about_goods">
                        <div class="leftone">商品相关</div>
                        <li><a href="javascript:void(0);" class="this" id="goods_class_op" onclick="openURL('url','<%=basePath%>/admin/goods_class_list.htm','main_workspace','goods_class_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>分类管理</span></a> </li>
                        <li><a href="javascript:void(0);" id="goods_brand_op" onclick="openURL('url','<%=basePath%>/admin/goods_brand_list.htm','main_workspace','goods_brand_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>品牌管理</span></a></li>
                        <li><a href="javascript:void(0);" id="goods_manage_op" onclick="openURL('url','<%=basePath%>/admin/goods_list.htm','main_workspace','goods_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>商品管理</span></a></li>
                        <li><a href="javascript:void(0);" id="goods_type_op" onclick="openURL('url','<%=basePath%>/admin/goods_type_list.htm','main_workspace','goods_type_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>类型管理</span></a></li>
                        <!-- 20160317新增-->
                        <li><a href="javascript:void(0);" id="goods_drp_op" onclick="openURL('url','<%=basePath%>/admin/drpGoods_list.htm','main_workspace','goods_drp_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>分销管理</span></a></li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="about_fitment">
                        <div class="leftone">首页装修</div>
                        <li><a href="javascript:void(0);" id="goods_floor_op" onclick="openURL('url','<%=basePath%>/admin/goods_floor_list.htm','main_workspace','goods_floor_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>首页楼层</span></a></li>
                        <li><a href="javascript:void(0);" id="goods_case_op" onclick="openURL('url','<%=basePath%>/admin/goods_case_list.htm','main_workspace','goods_case_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>橱窗管理</span></a></li>
                        <li><a href="javascript:void(0);" id="subject_set" onclick="openURL('url','<%=basePath%>/admin/subject_list.htm','main_workspace','subject_set')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>专题管理</span></a></li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="about_self">
                        <div class="leftone">自营相关</div>
                        <li><a href="javascript:void(0);"id="complex_goods" suffix="goods_"><img id="goods_img" src="<%=basePath%>/resources/style/system/manage/blue/images/contract.jpg" width="13" height="13" /><span>商品管理</span></a>
                            <ul id="goods_info">
                                <li><a href="javascript:void(0);" id="goods_self_manage_op" onclick="openURL('url','<%=basePath%>/admin/goods_self_list.htm','main_workspace','goods_self_manage_op')"><span>商品管理</span></a></li>
                                <li><a href="javascript:void(0);" id="goods_format_self_manage_op" onclick="openURL('url','<%=basePath%>/admin/goods_format_list.htm','main_workspace','goods_format_self_manage_op')"><span>商品版式</span></a></li>
                                <li><a href="javascript:void(0);" id="goods_spec_op" onclick="openURL('url','<%=basePath%>/admin/goods_spec_list.htm','main_workspace','goods_spec_op')"><span>规格管理</span></a></li>
                                <li><a href="javascript:void(0);" class="this" id="add_goods_op" onclick="openURL('url','<%=basePath%>/admin/add_goods_first.htm','main_workspace','add_goods_op')"><span>商品发布</span></a> </li>
                                <li><a href="javascript:void(0);" id="taobao_op" onclick="openURL('url','<%=basePath%>/admin/taobao.htm','main_workspace','taobao_op')"><span>淘宝导入</span></a></li>
                                <li><a href="javascript:void(0);" id="self_consult_op" onclick="openURL('url','<%=basePath%>/admin/consult_self.htm','main_workspace','self_consult_op')"><span>商品咨询</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);"id="complex_order" suffix="order_"><img id="order_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>交易管理</span></a>
                            <ul id="order_info" style="display:none;">
                                <li><a href="javascript:void(0);" id="self_order_ship_op" onclick="openURL('url','<%=basePath%>/admin/self_order_ship.htm','main_workspace','self_order_ship_op')"><span>发货管理</span></a></li>
                                <li><a href="javascript:void(0);" id="self_order_confirm_op" onclick="openURL('url','<%=basePath%>/admin/self_order_confirm.htm','main_workspace','self_order_confirm_op')"><span>收货管理</span></a></li>
                                <li><a href="javascript:void(0);" id="self_order_op" onclick="openURL('url','<%=basePath%>/admin/self_order.htm','main_workspace','self_order_op')"><span>订单管理</span></a></li>
                                <li><a href="javascript:void(0);" id="self_ship_address_op" onclick="openURL('url','<%=basePath%>/admin/ship_address_list.htm','main_workspace','self_ship_address_op')"><span>发货地址</span></a></li>
                                <li><a href="javascript:void(0);" id="group_code_op" onclick="openURL('url','<%=basePath%>/admin/group_code.htm','main_workspace','group_code_op')"><span>团购码验证</span></a></li>
                                <li><a href="javascript:void(0);" id="transport_list_op" onclick="openURL('url','<%=basePath%>/admin/transport_list.htm','main_workspace','transport_list_op')"><span>运费模板</span></a></li>
                                <li><a href="javascript:void(0);" id="ecc_list_op" onclick="openURL('url','<%=basePath%>/admin/ecc_set.htm','main_workspace','ecc_list_op')"><span>常用物流</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);"id="complex_saled" suffix="saled_"><img id="saled_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>售后管理</span></a>
                            <ul id="saled_info" style="display:none;">
                                <li><a href="javascript:void(0);" id="admin_eva_op" onclick="openURL('url','<%=basePath%>/admin/admin_eva.htm','main_workspace','admin_eva_op')"><span>服务评价</span></a></li>
                                <li><a href="javascript:void(0);" id="self_evaluate_list_op" onclick="openURL('url','<%=basePath%>/admin/self_evaluate_list.htm','main_workspace','self_evaluate_list_op')"><span>评价管理</span></a></li>
                                <li><a href="javascript:void(0);" id="self_return_op" onclick="openURL('url','<%=basePath%>/admin/self_return.htm','main_workspace','self_return_op')"><span>自营退货</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);"id="complex_promotion" suffix="promotion_"><img id="promotion_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>促销管理</span></a>
                            <ul id="promotion_info" style="display:none;">
                                <li><a href="javascript:void(0);" id="group_self_op" onclick="openURL('url','<%=basePath%>/admin/group_self.htm','main_workspace','group_self_op')"><span>团购管理</span></a></li>
                                <li><a href="javascript:void(0);" id="activity_self_op" onclick="openURL('url','<%=basePath%>/admin/activity_self.htm','main_workspace','activity_self_op')"><span>活动管理</span></a></li>
                                <!-- <li><a href="javascript:void(0);" id="combin_self_op" onclick="openURL('url','<%=basePath%>/admin/self_combin.htm','main_workspace','combin_self_op')"><span>组合销售</span></a></li>-->
                                <li><a href="javascript:void(0);" id="enoughreduce_self_op" onclick="openURL('url','<%=basePath%>/admin/enoughreduce_self_list.htm','main_workspace','enoughreduce_self_op')"><span>满就减管理</span></a></li>
                                <li><a href="javascript:void(0);" id="buygift_self_op" onclick="openURL('url','<%=basePath%>/admin/buygift_self_list.htm','main_workspace','buygift_self_op')"><span>满就送管理</span></a></li>
                                <!-- <li><a href="javascript:void(0);" id="freegoods_self_list_op" onclick="openURL('url','<%=basePath%>/admin/self_freegoods_list.htm','main_workspace','freegoods_self_list_op')"><span>0元试用管理</span></a></li>-->
                                <li><a href="javascript:void(0);" id="coupon_set_op" onclick="openURL('url','<%=basePath%>/admin/coupon_list.htm','main_workspace','coupon_set_op')"><span>优惠券管理</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);" id="album_op" onclick="openURL('url','<%=basePath%>/admin/album.htm','main_workspace','album_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>自营相册</span></a></li>
                        <li><a href="javascript:void(0);" id="imageself_list_op" onclick="openURL('url','<%=basePath%>/admin/imageself_list.htm','main_workspace','imageself_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>图片管理</span></a></li>
                        <li><a href="javascript:void(0);" id="self_crm_op" onclick="openURL('url','<%=basePath%>/admin/crm_list.htm','main_workspace','self_crm_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>客户管理</span></a></li>
                        <li><a href="javascript:void(0);" id="self_stat_goods_op" onclick="openURL('url','<%=basePath%>/admin/self_stat_goods.htm','main_workspace','self_stat_goods_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>商品统计</span></a></li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="about_store">
                        <div class="leftone">店铺相关</div>
                        <li><a href="javascript:void(0);" class="this" id="store_base_op" onclick="openURL('url','<%=basePath%>/admin/store_base.htm','main_workspace','store_base_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>入驻管理</span></a> </li>
                        <li><a href="javascript:void(0);" id="store_manage_op" onclick="openURL('url','<%=basePath%>/admin/store_list.htm','main_workspace','store_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>店铺管理</span></a></li>
                        <li style="display:none"><a href="javascript:void(0);" id="store_template_op" onclick="openURL('url','<%=basePath%>/admin/store_template.htm','main_workspace','store_template_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>店铺模板</span></a></li>
                        <li><a href="javascript:void(0);" id="store_grade_op" onclick="openURL('url','<%=basePath%>/admin/storegrade_list.htm','main_workspace','store_grade_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>店铺类型</span></a></li>
                        <li><a href="javascript:void(0);" id="adjust_info_op" onclick="openURL('url','<%=basePath%>/admin/adjust_info.htm','main_workspace','adjust_info_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>调整申请</span></a></li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="about_member">
                        <div class="leftone">会员相关</div>
                        <li><a href="javascript:void(0);" class="this" id="member_manage_op" onclick="openURL('url','<%=basePath%>/admin/user_list.htm','main_workspace','member_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>会员管理</span></a> </li>
                        <li><a href="javascript:void(0);" id="user_level_op"  onclick="openURL('url','<%=basePath%>/admin/user_level.htm','main_workspace','user_level_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>会员等级</span></a> </li>
                        <li><a href="javascript:void(0);" id="user_msg_op" onclick="openURL('url','<%=basePath%>/admin/user_msg.htm','main_workspace','user_msg_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>会员通知</span></a></li>
                        <li><a href="javascript:void(0);" id="user_integral_op" onclick="openURL('url','<%=basePath%>/admin/user_integral.htm','main_workspace','user_integral_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>积分管理</span></a></li>
                        <li><a href="javascript:void(0);" id="integrallog_list_op" onclick="openURL('url','<%=basePath%>/admin/integrallog_list.htm','main_workspace','integrallog_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>积分明细</span></a></li>
                        <li><a href="javascript:void(0);" id="predeposit_list_op" onclick="openURL('url','<%=basePath%>/admin/predeposit_list.htm','main_workspace','predeposit_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>预存款管理</span></a></li>
                        <li><a href="javascript:void(0);" id="predepositlog_list_op" onclick="openURL('url','<%=basePath%>/admin/predepositlog_list.htm','main_workspace','predepositlog_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>预存款明细</span></a></li>
                        <li><a href="javascript:void(0);" id="coinInfo_list_op" onclick="openURL('url','<%=basePath%>/admin/coin_info_list.htm?op=info','main_workspace','coinInfo_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>惠币明细</span></a></li>
                        <!--add by lgf-->
                        <li><a href="javascript:void(0);" id="img_op" onclick="openURL('url','<%=basePath%>/admin/user_photo_list.htm','main_workspace','img_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>图片管理</span></a></li>
                        <!---->
                        <!--    <li style="display:"><a href="javascript:void(0);"id="complex_sns" suffix="sns_"><img id="sns_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>SNS管理</span></a>
                              <ul id="sns_info"  style="display:none;">
                                <li><a id="user_share_op" href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/sns_share_list.htm','main_workspace','user_share_op')"><span>分享列表</span></a></li>
                                <li><a href="javascript:void(0);" id="user_dynamic_op" onclick="openURL('url','<%=basePath%>/admin/sns_dynamic_list.htm','main_workspace','user_dynamic_op')"><span>动态列表</span></a></li>
                              </ul>
                            </li>  ##change by 2015/11/26-->
                    </ul>
                    <ul class="ulleft" style="display:none;" id="about_trade">
                        <div class="leftone">交易管理</div>
                        <li><a href="javascript:void(0);" id="order_manage_op" onclick="openURL('url','<%=basePath%>/admin/order_list.htm','main_workspace','order_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>订单管理</span></a> </li>
                        <li><a href="javascript:void(0);" id="set_order_confirm_op" onclick="openURL('url','<%=basePath%>/admin/set_order_confirm.htm','main_workspace','set_order_confirm_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>订单设置</span></a> </li>
                        <li><a href="javascript:void(0);" id="consult_manage_op" onclick="openURL('url','<%=basePath%>/admin/consult_list.htm','main_workspace','consult_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>咨询管理</span></a></li>
                        <li style="display:none"><a href="javascript:void(0);" id="report_manage_op" onclick="openURL('url','<%=basePath%>/admin/report_list.htm','main_workspace','report_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>举报管理</span></a></li>
                        <li><a href="javascript:void(0);"  id="evaluate_manage_op" onclick="openURL('url','<%=basePath%>/admin/evaluate_list.htm','main_workspace','evaluate_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>商品评价</span></a></li>
                        <!-- <li><a href="javascript:void(0);" id="complaint_manage_op" onclick="openURL('url','<%=basePath%>/admin/complaint_list.htm','main_workspace','complaint_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>投诉管理</span></a></li> -->
                        <li><a href="javascript:void(0);" id="return_manage_op" onclick="openURL('url','<%=basePath%>/admin/refund_list.htm','main_workspace','return_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>退款管理</span></a></li>
                        <!-- by  qkj 2016/3/16  佣金管理-->
                        <li><a href="javascript:void(0);" id="commission_manage_op" onclick="openURL('url','<%=basePath%>/admin/commission_list.htm','main_workspace','commission_manage_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>佣金管理</span></a></li>

                        <!--  <li><a href="javascript:void(0);"id="complex_ofcard" suffix="ofcard_"><img id="ofcard_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>充值管理</span></a>
                          <ul id="ofcard_info"  style="display:none;">
                            <li><a href="javascript:void(0);" id="set_ofcard_op" onclick="openURL('url','<%=basePath%>/admin/set_ofcard.htm','main_workspace','set_ofcard_op')"><span>接口设置</span></a></li>
                            <li><a href="javascript:void(0);" id="order_recharge_op" onclick="openURL('url','<%=basePath%>/admin/order_recharge.htm','main_workspace','order_recharge_op')"><span>充值列表</span></a></li>
                          </ul>
                        </li>  ## change by 2015/11/26-->
                        <li><a href="javascript:void(0);"id="complex_stat" suffix="stat_"><img id="stat_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>商城统计</span></a>
                            <ul id="stat_info"  style="display:none;">
                                <li><a href="javascript:void(0);" id="stat_user_op" onclick="openURL('url','<%=basePath%>/admin/stat_user.htm','main_workspace','stat_user_op')"><span>用户统计</span></a></li>
                                <li><a href="javascript:void(0);" id="stat_order_op" onclick="openURL('url','<%=basePath%>/admin/stat_order.htm','main_workspace','stat_order_op')"><span>订单统计</span></a></li>
                                <li><a href="javascript:void(0);" id="stat_goods_op" onclick="openURL('url','<%=basePath%>/admin/stat_goods.htm','main_workspace','stat_goods_op')"><span>商品统计</span></a></li>
                                <li><a href="javascript:void(0);" id="stat_area_op" onclick="openURL('url','<%=basePath%>/admin/stat_area.htm','main_workspace','stat_area_op')"><span>地域统计</span></a></li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="about_website">
                        <div class="leftone">网站相关</div>
                        <li><a href="javascript:void(0);" class="this" id="articleClass_op" onclick="openURL('url','<%=basePath%>/admin/articleclass_list.htm','main_workspace','articleClass_op');"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>文章分类</span></a> </li>
                        <li><a href="javascript:void(0);" id="article_op" onclick="openURL('url','<%=basePath%>/admin/article_list.htm','main_workspace','article_op');"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>文章管理</span></a></li>
                        <li><a href="javascript:void(0);" id="document_op" onclick="openURL('url','<%=basePath%>/admin/document_list.htm','main_workspace','document_op');"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>系统文章</span></a></li>
                        <li><a href="javascript:void(0);" id="partner_op" onclick="openURL('url','<%=basePath%>/admin/partner_list.htm','main_workspace','partner_op');"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>合作伙伴</span></a></li>
                        <li><a href="javascript:void(0);" id="nav_op" onclick="openURL('url','<%=basePath%>/admin/navigation_list.htm','main_workspace','nav_op');"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>页面导航</span></a></li>
                        <li><a href="javascript:void(0);"id="complex_circle" suffix="circle_"><img id="circle_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>圈子管理</span></a>
                            <ul id="circle_info" style="display:none;">
                                <li><a href="javascript:void(0);" id="circle_op" onclick="openURL('url','<%=basePath%>/admin/circle_set.htm','main_workspace','circle_op');"><span>圈子管理</span></a></li>
                                <li><a href="javascript:void(0);" id="circleclass_op" onclick="openURL('url','<%=basePath%>/admin/circleclass_list.htm','main_workspace','circleclass_op');"><span>圈子类型</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);"id="complex_cms" suffix="cms_"><img id="cms_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>CMS管理</span></a>
                            <ul id="cms_info" style="display:none;">
                                <li><a href="javascript:void(0);" id="info_list" onclick="openURL('url','<%=basePath%>/admin/information_class_list.htm','main_workspace','info_list');"><span>资讯分类</span></a></li>
                                <li><a href="javascript:void(0);" id="info_op" onclick="openURL('url','<%=basePath%>/admin/information_list.htm','main_workspace','info_op');"><span>资讯管理</span></a></li>
                                <li><a href="javascript:void(0);" id="info_reply" onclick="openURL('url','<%=basePath%>/admin/information_reply.htm','main_workspace','info_reply');"><span>资讯回复</span></a></li>
                                <li><a href="javascript:void(0);" id="info_control" onclick="openURL('url','<%=basePath%>/admin/cms_template_list.htm','main_workspace','info_control');"><span>资讯楼层</span></a></li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="business_operation">
                        <div class="leftone">运营管理</div>
                        <li><a href="javascript:void(0);" class="this" id="operation_base_op" onclick="openURL('url','<%=basePath%>/admin/operation_base_set.htm','main_workspace','operation_base_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>基本设置</span></a> </li>
                        <li><a href="javascript:void(0);" id="gold_record_op" onclick="openURL('url','<%=basePath%>/admin/gold_record.htm','main_workspace','gold_record_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>金币管理</span></a></li>
                        <!-- <li><a href="javascript:void(0);" id="ztc_set" onclick="openURL('url','<%=basePath%>/admin/ztc_set.htm','main_workspace','ztc_set')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>竞价直通车</span></a></li>
                        <li><a href="javascript:void(0);" id="recharge_card" onclick="openURL('url','<%=basePath%>/admin/recharge_card_list.htm','main_workspace','recharge_card')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>平台充值卡</span></a></li> -->
                        <li><a href="javascript:void(0);" id="sms_set" onclick="openURL('url','<%=basePath%>/admin/sms_set.htm','main_workspace','sms_set')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>短消息管理</span></a></li>
                        <li><a href="javascript:void(0);" id="delivery_address" onclick="openURL('url','<%=basePath%>/admin/delivery_address_list.htm','main_workspace','delivery_address')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>自提点管理</span></a></li>
                        <li><a href="javascript:void(0);" id="advert_set_op" onclick="openURL('url','<%=basePath%>/admin/advert_list.htm','main_workspace','advert_set_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>广告管理</span></a></li>
                        <li><a href="javascript:void(0);" id="channel_set_op" onclick="openURL('url','<%=basePath%>/admin/channel_list.htm','main_workspace','channel_set_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>栏目管理</span></a></li>
                        <li><a href="javascript:void(0);" id="complex_integral" suffix="integral_center_"><img id="integral_center_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>积分中心</span></a>
                            <ul id="integral_center_info"  style="display:none;">
                                <li><a href="javascript:void(0);" id="integral_rule_op" onclick="openURL('url','<%=basePath%>/admin/operation_integral_rule.htm','main_workspace','integral_rule_op')"><span>积分规则</span></a></li>
                                <li><a href="javascript:void(0);" id="integral_shop_op" onclick="openURL('url','<%=basePath%>/admin/integral_goods.htm','main_workspace','integral_shop_op')"><span>积分商城</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);"id="complex_sale" suffix="sale_promotion_"><img id="sale_promotion_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>促销管理</span></a>
                            <ul id="sale_promotion_info"  style="display:none;">
                                <li><a href="javascript:void(0);" id="activity_set_op" onclick="openURL('url','<%=basePath%>/admin/activity_list.htm','main_workspace','activity_set_op')"><span>活动管理</span></a></li>
                                <li><a href="javascript:void(0);" id="group_op" onclick="openURL('url','<%=basePath%>/admin/group_list.htm','main_workspace','group_op')"><span>团购管理</span></a></li>
                                <!-- <li><a href="javascript:void(0);" id="combin_op" onclick="openURL('url','<%=basePath%>/admin/combin.htm','main_workspace','combin_op')"><span>组合销售</span></a></li>-->
                                <li><a href="javascript:void(0);" id="enoughreduce_set_op" onclick="openURL('url','<%=basePath%>/admin/enoughreduce_list.htm','main_workspace','enoughreduce_set_op')"><span>满就减管理</span></a></li>
                                <li><a href="javascript:void(0);" id="buygift_set_op" onclick="openURL('url','<%=basePath%>/admin/buygift_list.htm','main_workspace','buygift_set_op')"><span>满就送管理</span></a></li>
                                <li><a href="javascript:void(0);" id="buyfreepost_set_op" onclick="openURL('url','<%=basePath%>/admin/enoughfreepost_list.htm','main_workspace','buyfreepost_set_op')"><span>满包邮管理</span></a></li>
                                <li><a href="javascript:void(0);" id="coin_set_op" onclick="openURL('url','<%=basePath%>/admin/coin_list.htm','main_workspace','coin_set_op')"><span>惠币管理</span></a></li>
                                <li><a href="javascript:void(0);" id="coinHistory_list_op_q" onclick="openURL('url','<%=basePath%>/admin/coinHistory_list.htm','main_workspace','coinHistory_list_op_q')"><span>惠币历史管理</span></a></li>
                            </ul>
                        </li>
                        <!--  <li><a href="javascript:void(0);"id="complex_free" suffix="free_promotion_"><img id="free_promotion_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>0元试用管理</span></a>
                            <ul id="free_promotion_info"  style="display:none;">
                              <li><a href="javascript:void(0);" id="freegoods_set_op" onclick="openURL('url','<%=basePath%>/admin/freegoods_list.htm','main_workspace','freegoods_set_op')"><span>0元试用管理</span></a></li>
                              <li><a href="javascript:void(0);" id="freeclass_set_op" onclick="openURL('url','<%=basePath%>/admin/freeclass_list.htm','main_workspace','freeclass_set_op')"><span>0元试用分类</span></a></li>
                            </ul>
                          </li>-->
                        <li style="display:"><a href="javascript:void(0);"id="complex_client" suffix="mobile_promotion_"><img id="mobile_promotion_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>手机客户端</span></a>
                            <ul id="mobile_promotion_info"  style="display:none;">
                                <li><a href="javascript:void(0);" id="mobile_goods" onclick="openURL('url','<%=basePath%>/admin/mobile_goods.htm','main_workspace','mobile_goods')"><span>手机端商品</span></a></li>
                                <li><a href="javascript:void(0);" id="mobile_activity" onclick="openURL('url','<%=basePath%>/admin/mobile_activitygoods.htm','main_workspace','mobile_activity')"><span>手机端促销</span></a></li>
                                <li><a href="javascript:void(0);" id="mobile_group" onclick="openURL('url','<%=basePath%>/admin/mobile_groupgoods.htm','main_workspace','mobile_group')"><span>手机端团购</span></a></li>
                                <li><a href="javascript:void(0);" id="mobile_integralgoods" onclick="openURL('url','<%=basePath%>/admin/mobile_integralgoods.htm','main_workspace','mobile_integralgoods')"><span>手机端积分</span></a></li>
                                <li><a href="javascript:void(0);" id="mobile_freegoods" onclick="openURL('url','<%=basePath%>/admin/mobile_freegoods.htm','main_workspace','mobile_freegoods')"><span>手机端试用</span></a></li>
                                <li><a href="javascript:void(0);" id="mobile_class_list" onclick="openURL('url','<%=basePath%>/admin/mobile_class_list.htm','main_workspace','mobile_class_list')"><span>手机端分类</span></a></li>
                                <li><a href="javascript:void(0);" id="mobile_push" onclick="openURL('url','<%=basePath%>/admin/mobile_push.htm','main_workspace','mobile_push')"><span>手机端推送</span></a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0);"id="complex_wx" suffix="wx_"><img id="wx_img" src="<%=basePath%>/resources/style/system/manage/blue/images/spread.jpg" width="13" height="13" /><span>微商城管理</span></a>
                            <ul id="wx_info" style="display:none;">
                                <li><a href="javascript:void(0);" id="wx_set_op" onclick="openURL('url','<%=basePath%>/admin/weixin_plat_set.htm','main_workspace','wx_set_op')"><span>微信基本设置</span></a></li>
                                <!-- <li><a href="javascript:void(0);" id="wx_goods" onclick="openURL('url','<%=basePath%>/admin/weixin_goods.htm','main_workspace','wx_goods')"><span>微商城商品</span></a></li>
                                 <li><a href="javascript:void(0);" id="wx_class_img" onclick="openURL('url','<%=basePath%>/admin/weixin_class_img.htm','main_workspace','wx_class_img')"><span>微商城分类</span></a></li>
                                 <li><a href="javascript:void(0);" id="wx_group" onclick="openURL('url','<%=basePath%>/admin/weixin_groupgoods.htm','main_workspace','wx_group')"><span>微商城团购</span></a></li>
                                 <li><a href="javascript:void(0);" id="wx_activity" onclick="openURL('url','<%=basePath%>/admin/weixin_activitygoods.htm','main_workspace','wx_activity')"><span>微商城活动</span></a></li>
                                 <li><a href="javascript:void(0);" id="wx_brand" onclick="openURL('url','<%=basePath%>/admin/weixin_brand.htm','main_workspace','wx_brand')"><span>微商城品牌</span></a></li>
                                 <li><a href="javascript:void(0);" id="wx_freegoods" onclick="openURL('url','<%=basePath%>/admin/weixin_freegoods.htm','main_workspace','wx_freegoods')"><span>微商城0元试用</span></a></li>-->
                            </ul>
                        </li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="sys_payoff">
                        <div class="leftone">系统结算</div>
                        <li><a href="javascript:void(0);" id="payoff_set_op" onclick="openURL('url','<%=basePath%>/admin/payofflog_set.htm','main_workspace','payoff_set_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>结算设置</span></a></li>
                        <li><a href="javascript:void(0);" id="payoff_list_op" onclick="openURL('url','<%=basePath%>/admin/payofflog_list.htm','main_workspace','payoff_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>结算管理</span></a></li>
                    </ul>
                    <ul class="ulleft" style="display:none;" id="sys_tool">
                        <div class="leftone">系统工具</div>
                        <!--            <li><a href="javascript:void(0);" id="cache_list_op" onclick="openURL('url','<%=basePath%>/admin/cache_list.htm','main_workspace','cache_list_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>缓存管理</span></a></li>-->
                        <li><a href="javascript:void(0);" id="database_add_op" onclick="openURL('url','<%=basePath%>/admin/database_add.htm','main_workspace','database_add_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>数据库管理</span></a></li>
                        <!-- <li><a href="javascript:void(0);" id="lucene_op" onclick="openURL('url','<%=basePath%>/admin/lucene.htm','main_workspace','lucene_op')"><img src="<%=basePath%>/resources/style/system/manage/blue/images/menu_empty.gif" width="5" height="9" /><span>全文检索</span></a></li>-->
                    </ul>
                </div>

            </div>
            <div class="statement"><%--$!{config.poweredby}--%>poweredby V2015
                ©<%--$!{config.company_name}--%>company_name Inc.</div>
        </div>
        <div class="content">
            <div class="content_box">
                <div class="content_bar">
                    <div class="right_news" id="bar_online" style="display:none"><a id="speak" onclick="open_im('','<%=basePath%>','plat');" href="javascript:void(0);">在线客服</a></div>
                    <span class="webmap"><a href="javascript:void(0);">管理地图</a></span> <span class="webskin"> <b>更换皮肤：</b> <em> <a href="javascript:void(0);" class="this"<%--#if($!config.websiteCss=="blue") class="this" #end--%>> <i><img src="<%=basePath%>/resources/style/common/images/skin_blue.gif" width="15" height="16" webcss="blue" /></i> </a> <a href="javascript:void(0);" <%--#if($!config.websiteCss=="black") class="this" #end--%>> <i><img src="<%=basePath%>/resources/style/common/images/skin_black.gif" width="15" height="16" webcss="black" /></i> </a></em> </span>
                    <div class="position"> 您的位置：<a href="">首页</a> > <span id="top_nav_info">站点设置</span></div>
                </div>
                <div class="content_bottom">
                    <iframe id="main_workspace" name="main_workspace" src="<%=basePath%>/system/welcome.jsp" style="overflow:auto;height:550px" frameborder="0" width="100%" height="100%" scrolling="yes" onload="window.parent"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="webmap_box" style="display:none;">
    <h4><a href="javascript:void(0);" class="close_map"></a>管理中心导航</h4>
    <div class="webmap_list"> <span class="weblist_sp">
    <h5>设置</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_site.htm','main_workspace','set_site_op','base_set')">站点设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_image.htm','main_workspace','set_image_op','base_set')">上传设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_seo.htm','main_workspace','set_seo_op','base_set')">SEO设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_email.htm','main_workspace','set_email_op','base_set')">Email设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_sms.htm','main_workspace','set_sms_op','base_set')">短信设置</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_second_domain.htm','main_workspace','set_second_domain_op','base_set')">二级域名</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/template_list.htm','main_workspace','template_list_op','base_set')">通知模板</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/admin_list.htm','main_workspace','admin_list_op','base_set')">管理员管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/area_list.htm','main_workspace','arealist_op','base_set')">常用地区</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/trans_area_list.htm','main_workspace','trans_area_op','base_set')">运费区域</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/payment_list.htm','main_workspace','payment_list_op','base_set')">支付方式</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_plat_set.htm','main_workspace','wx_set_op','base_set')">微商城设置</a><a href="javascript:void(0);" id="kaudi_set_op" onclick="openURL('url','<%=basePath%>/admin/set_kuaidi.htm','main_workspace','kaudi_set_op','base_set')">快递设置</a> <a href="javascript:void(0);" id="kaudi_company_op" onclick="openURL('url','<%=basePath%>/admin/express_company_list.htm','main_workspace','kaudi_company_op','base_set')">快递公司</a>
        <%--#if($!config.kuaidi_type==1) <a href="javascript:void(0);" id="kaudi_callback_op" onclick="openURL('url','<%=basePath%>/admin/express_info_list.htm','main_workspace','kaudi_callback_op','base_set')">快递推送</a> #end --%>
    </span> <span class="weblist_sp">
    <h5>商品</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_class_list.htm','main_workspace','goods_class_op','about_goods')">分类管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_brand_list.htm','main_workspace','goods_brand_op','about_goods')">品牌管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_list.htm','main_workspace','goods_manage_op','about_goods')">商品管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_type_list.htm','main_workspace','goods_type_op','about_goods')">类型管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_spec_list.htm','main_workspace','goods_spec_op','about_goods')">规格管理</a></span> <span class="weblist_sp">
    <!--<h5>装修</h5>-->
    <!--<a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_floor_list.htm','main_workspace','goods_floor_op','about_fitment')">首页楼层</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_case_list.htm','main_workspace','goods_case_op','about_fitment')">橱窗管理</a> <a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/subject_list.htm','main_workspace','subject_set','about_fitment')">专题管理</a></span> <span class="weblist_sp">-->
    <!--<h5>自营</h5>-->
    <!--<a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_self_list.htm','main_workspace','goods_self_manage_op','about_self')">商品管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_format_list.htm','main_workspace','goods_format_self_manage_op','about_self')">商品版式</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/add_goods_first.htm','main_workspace','add_goods_op','about_self')">商品发布</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/self_order.htm','main_workspace','self_order_op','about_self')">订单管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/ship_address_list.htm','main_workspace','self_ship_address_op','about_self')">发货地址</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/taobao.htm','main_workspace','taobao_op','about_self')">淘宝导入</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/album.htm','main_workspace','album_op','about_self')">自营相册</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/imageself_list.htm','main_workspace','imageself_list_op','about_self')">图片管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/transport_list.htm','main_workspace','transport_list_op','about_self')">物流工具</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/goods_spec_list.htm','main_workspace','goods_spec_op','about_self')">规格管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/group_self.htm','main_workspace','group_self_op','about_self')">团购管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/activity_self.htm','main_workspace','activity_self_op','about_self')">活动管理</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/enoughreduce_self_list.htm','main_workspace','enoughreduce_self_list_op','about_self')">满就减管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/buygift_self_list.htm','main_workspace','buygift_self_list_op','about_self')">满就送管理</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/self_freegoods_list.htm','main_workspace','freegoods_self_list_op','about_self')">0元试用管理</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/coupon_list.htm','main_workspace','coupon_set_op','about_self')">优惠券管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/admin_eva.htm','main_workspace','admin_eva_op','about_self')">服务评价</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/self_evaluate_list.htm','main_workspace','self_evaluate_list_op','about_self')">评价管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/self_return.htm','main_workspace','self_return_op','about_self')">自营退货</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/consult_self.htm','main_workspace','self_consult_op','about_self')">商品咨询</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/crm_list.htm','main_workspace','self_crm_op','about_self')">客户管理</a><a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/self_stat_goods.htm','main_workspace','self_stat_goods_op','about_self')">商品统计</a></span> <span class="weblist_sp">-->
    <h5>店铺</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/store_base.htm','main_workspace','store_base_op','about_store')">入驻管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/store_list.htm','main_workspace','store_manage_op','about_store')">店铺管理</a> <a  style="display:none" href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/store_template.htm','main_workspace','store_template_op','about_store')">店铺模板</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/storegrade_list.htm','main_workspace','store_grade_op','about_store')">店铺类型</a></span> <span class="weblist_sp">
    <h5>会员</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/user_list.htm','main_workspace','member_manage_op','about_member')">会员管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/user_level.htm','main_workspace','user_level_op','about_member')">会员等级</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/user_msg.htm','main_workspace','user_msg_op','about_member')">会员通知</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/user_integral.htm','main_workspace','user_integral_op','about_member')">积分管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/integrallog_list.htm','main_workspace','integrallog_list_op','about_member')">积分明细</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/predeposit_list.htm','main_workspace','predeposit_list_op','about_member')">预存款管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/predepositlog_list.htm','main_workspace','predepositlog_list_op','about_member')">预存款明细</a> <a href="javascript:void(0);" onclick=
            "openURL('url','<%=basePath%>/admin/user_photo_list.htm','main_workspace','img_op','about_member')">图片管理</a> <a style="display:none" href="javascript:void(0);" onclick=
            "openURL('url','<%=basePath%>/admin/sns_user.htm','main_workspace','user_sns_op','about_member')">会员动态</a> <a style="display:none" href="javascript:void(0);" onclick=
            "openURL('url','<%=basePath%>/admin/sns_store.htm','main_workspace','store_sns_op','about_member')">店铺动态</a> </span> <span class="weblist_sp">
    <h5>交易</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/order_list.htm','main_workspace','order_manage_op','about_trade')">订单管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_order_confirm.htm','main_workspace','set_order_confirm_op','about_trade')">订单设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/consult_list.htm','main_workspace','consult_manage_op','about_trade')">咨询管理</a> <a style="display:none" href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/report_list.htm','main_workspace','report_manage_op','about_trade')">举报管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/evaluate_list.htm','main_workspace','evaluate_manage_op','about_trade')">商品评价</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/complaint_list.htm','main_workspace','complaint_manage_op','about_trade')">投诉管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/set_ofcard.htm','main_workspace','set_ofcard_op','about_trade')">充值设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/order_recharge.htm','main_workspace','order_recharge_op','about_trade')">充值列表</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/stat_user.htm','main_workspace','stat_user_op','about_trade')">用户统计</a> <a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/stat_order.htm','main_workspace','stat_order_op','about_trade')">订单统计</a> <a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/stat_goods.htm','main_workspace','stat_goods_op','about_trade')">商品统计</a></span> <span class="weblist_sp">
  <!--  <h5>网站</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/articleclass_list.htm','main_workspace','articleClass_op','about_website');">文章分类</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/article_list.htm','main_workspace','article_op','about_website');">文章管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/document_list.htm','main_workspace','document_op','about_website');">系统文章</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/partner_list.htm','main_workspace','partner_op','about_website');">合作伙伴</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/navigation_list.htm','main_workspace','nav_op','about_website');">页面导航</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/circle_set.htm','main_workspace','circle_op','about_website');">圈子管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/circleclass_list.htm','main_workspace','circleclass_op','about_website');">圈子类型</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/information_class_list.htm','main_workspace','info_list','about_website');">资讯分类</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/information_list.htm','main_workspace','info_op','about_website');">资讯管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/cms_template_list.htm','main_workspace','info_control','about_website');">资讯楼层</a> </span> <span class="weblist_sp">  ## change by 2015/11/26-->
    <h5>运营</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/operation_base_set.htm','main_workspace','operation_base_op','business_operation')">基本设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/gold_record.htm','main_workspace','gold_record_op','business_operation')">金币管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/ztc_set.htm','main_workspace','ztc_set','business_operation')">竞价直通车</a> <a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/recharge_card_list.htm','main_workspace','recharge_card','business_operation')">平台充值卡</a> <a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/sms_set.htm','main_workspace','sms_set','business_operation')">短消息管理</a> <a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/delivery_address_list.htm','main_workspace','delivery_address','business_operation')">自提点管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/advert_list.htm','main_workspace','advert_set_op','business_operation')">广告管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/operation_integral_rule.htm','main_workspace','integral_rule_op','business_operation')">积分规则</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/integral_goods.htm','main_workspace','integral_shop_op','business_operation')">积分商城</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/group_list.htm','main_workspace','group_op','business_operation')">团购管理</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/activity_list.htm','main_workspace','activity_set_op','business_operation')">活动管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/enoughreduce_list.htm','main_workspace','enoughreduce_set_op','business_operation')">满就减管理</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/buygift_list.htm','main_workspace','buygift_set_op','business_operation')">满就送管理</a><!--<a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/freegoods_list.htm','main_workspace','freegoods_set_op','business_operation')">0元试用管理</a>--><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/freeclass_list.htm','main_workspace','freeclass_set_op','business_operation')">0元试用分类</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/mobile_goods.htm','main_workspace','mobile_goods','business_operation')">手机端商品</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/mobile_activitygoods.htm','main_workspace','mobile_activity','business_operation')">手机端促销</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/mobile_groupgoods.htm','main_workspace','mobile_group','business_operation')">手机端团购</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/mobile_integralgoods.htm','main_workspace','mobile_integralgoods','business_operation')">手机端积分</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/mobile_freegoods.htm','main_workspace','mobile_group','business_operation')">手机端试用</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/mobile_class_list.htm','main_workspace','mobile_class_list','business_operation')">手机端分类</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/mobile_push.htm','main_workspace','mobile_push','business_operation')">手机端推送</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_plat_set.htm','main_workspace','wx_set_op','business_operation')">微信基本设置</a><!--<a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_goods.htm','main_workspace','wx_goods','business_operation')">微商城商品</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_class_img.htm','main_workspace','wx_class_img','business_operation')">微商城分类</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_groupgoods.htm','main_workspace','wx_group','business_operation')">微商城团购</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_activitygoods.htm','main_workspace','wx_activity','business_operation')">微商城活动</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_brand.htm','main_workspace','wx_brand','business_operation')">微商城品牌</a><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/weixin_freegoods.htm','main_workspace','wx_activity','business_operation')">微商城0元试用</a> </span> <span class="weblist_sp">-->
    <h5>结算</h5>
    <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/payofflog_set.htm','main_workspace','payoff_set_op','sys_payoff');">结算设置</a> <a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/payofflog_list.htm','main_workspace','payoff_list_op','sys_payoff');">结算管理</a> </span> <span class="weblist_sp">
    <h5>工具</h5>
    <!--<a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/cache_list.htm','main_workspace','cache_list_op','sys_tool');">缓存管理</a> --><a href="javascript:void(0);" onclick="openURL('url','<%=basePath%>/admin/database_add.htm','main_workspace','database_add_op','sys_tool');">数据库管理</a>
  <!--  <a href="javascript:void(0);"  onclick="openURL('url','<%=basePath%>/admin/lucene.htm','main_workspace','lucene_op','sys_tool')">全文检索</a></span>--> </div>
</div>
</body>
</html>

