<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/9
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
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
    <base href="<%=basePath%>">

    <title></title>
    <%-- <link  href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.common.js"></script> --%>

    <link  href="<%=basePath%>/resources/style/system/manage/blue/template.css"  rel="stylesheet" type="text/css"/>
    <link  href="<%=basePath%>/resources/style/common/css/jquery-ui-1.8.22.custom.css" type=text/css rel=stylesheet />
    <script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.validate.min.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.shop.common.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.poshytip.min.js"></script>
    <script src="<%=basePath%>/resources/js/jquery-ui-1.8.21.js"></script>
    <script src="<%=basePath%>/resources/js/jquery.zh.cn.js" charset="utf-8"></script>

    <script type="text/javascript">
        function saveForm(){
            jQuery("#theForm").submit();
        }

        jQuery(document).ready(function(){
            jQuery('#getTime').attr("readyonly","readyonly").datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });



        });


        //ajax的二级联动，根据选择的学院，查询该学院下对应的专业
        function selectProfession(o){
            //货物所属单位的文本内容
            var academeName = $(o).find("option:selected").text();
            $.post("${base}/system/enter_getProfessionJson.do",{"academeName":academeName},function(data){
                //先删除单位名称的下拉菜单，但是请选择要留下
                $("#profession option").remove();

                var $option = $("<option></option>");
                $option.attr("value","");
                $option.text("请选择...");
                $("#profession").append($option);


                if(data!=null && data.length>0){
                    for(var i=0;i<data.length;i++){
                        var proId = data[i].proId;
                        var professionName = data[i].professionName;
                        //添加到单位名称的下拉菜单中
                        var $option = $("<option></option>");
                        $option.attr("value",professionName);
                        $option.text(professionName);
                        $("#profession").append($option);
                    }
                }
            });

        }


    </script>

</head>

<body>

<div class="cont">
    <h1 class="seth">报名管理</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/result_list.do"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/result_add.do" <s:if test="#request.edit==null"> class="this" </s:if> ><b>新增</b></a></li>

            <s:if test="#request.edit">
                <li>  <a href="javascript:void(0);" class="this"><b>编辑</b></a></li>
            </s:if>



        </ul>
    </div>

    <form name="theForm" id="theForm" action="<%=basePath%>/system/result_save.do" method="post">

        <div class="edit">
            <div class="editul setcont">
                <!--鼠标经过样式-->


                <ul class="set1">
                    <li class="setcont_bg">学号</li>
                    <li><span class="webname">
        <input name="sno" type="text" id="sno" value="<s:property value="#request.result.sno"/>" />
      </span></li>
                </ul>

<%--                <ul class="set1">
                    <li class="setcont_bg">姓名</li>
                    <li><span class="webname">
        <input name="name" type="text" id="name" value="<s:property value="#request.result.name"/>" />
      </span></li>
                </ul>


                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>年级</li>
                    <li><span class="webname">
         <select name="grade" id="grade">
             <option value="" ${request.result.grade ==null?'selected':''}>请选择...</option>
             <option value="11级" ${request.result.grade =="11级"?'selected':''}>11级</option>
             <option value="12级" ${request.result.grade =="12级"?'selected':''}>12级</option>
             <option value="13级" ${request.result.grade =="13级"?'selected':''}>13级</option>
             <option value="14级" ${request.result.grade =="14级"?'selected':''}>14级</option>
             <option value="15级" ${request.result.grade =="15级"?'selected':''}>15级</option>

         </select>
        </span>
                    </li>
                </ul>


                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>学院</li>
                    <li><span class="webname">
                        <select name="academe" id="academe" onchange="selectProfession(this)">

             <option value="" ${request.result.academe ==null?'selected':''}>请选择...</option>

        <s:if test="#request.academeList!=null && #request.academeList.size()>0">
            <s:iterator value="#request.academeList" id="academe11">

                <option value=${academe11.academeName} ${academe11.academeName ==request.academe1?'selected':''}>${academe11.academeName}</option>
                </s:iterator>
            </s:if>


         </select>


        </span>
                    </li>
                </ul>


                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>专业</li>
                    <li><span class="webname">
         <select name="profession" id="profession" >
             <option value="" ${request.result.profession ==null?'selected':''}>请选择...</option>

             <s:if test="#request.professionSet!=null && #request.professionSet.size()>0">
                 <s:iterator value="#request.professionSet" id="profession11">

                     <option value="${profession11.professionName}" ${profession11.professionName ==request.profession1?'selected':''}>${profession11.professionName}</option>
                 </s:iterator>
             </s:if>

         </select>
        </span>
                    </li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">班级</li>
                    <li><span class="webname">
        <input name="classes" type="text" id="classes" value="<s:property value="#request.result.classes"/>" />
      </span>
                        <span id="nothis"><strong class="q"></strong><strong class="w">数字请用1，2，3</strong><strong class="c"></strong></span>
                    </li>
                </ul>--%>




                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>竞赛名称</li>
                    <li><span class="webname">
         <select name="comName" id="comName">

            <%-- <option value="校级">校级</option>
             <option value="市级">市级</option>
             <option value="省级">省级</option>
             <option value="国家级">国家级</option>--%>

             <option value="" ${request.result.comName ==null?'selected':''}>请选择...</option>


        <s:if test="#request.competitionList!=null && #request.competitionList.size()>0">
            <s:iterator value="#request.competitionList" id="competition1">

                <%--<option value="11级" ${request.result.grade =="11级"?'selected':''}>11级</option>--%>
                <option value=${competition1.comName} ${competition1.comName ==request.comName1?'selected':''}>${competition1.comName}</option>
            </s:iterator>
        </s:if>

         </select>
        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>



                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>参赛形式</li>
                    <li><span class="webname">
         <select name="form" id="form">
             <option value="" ${request.result.form ==null?'selected':''}>请选择...</option>
             <option value="个人赛" ${request.result.form =="个人赛"?'selected':''}>个人赛</option>
             <option value="团体赛" ${request.result.form =="团体赛"?'selected':''}>团体赛</option>


         </select>
        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>

                <ul class="set1">
                    <li class="setcont_bg">奖项</li>
                    <li><span class="webname">
        <input name="prize" type="text" id="prize" value="<s:property value="#request.result.prize"/>" />
      </span>
                        <span id="nothis"><strong class="q"></strong><strong class="w">数字请用大写的一、二、三</strong><strong class="c"></strong></span>
                    </li>
                </ul>


               <%-- <ul class="set1">
                    <li class="setcont_bg">指导教师</li>
                    <li><span class="webname">
        <input name="tutor" type="text" id="tutor" value="<s:property value="#request.result.tutor"/>" />
      </span>
                    </li>
                </ul>--%>





                <ul class="set1">
                    <li class="setcont_bg">获奖时间</li>
                    <li><span class="webname">
      
      <input name="getTime" type="text" id="getTime" value="<s:date name='#request.result.getTime' format='yyyy-MM-dd'/>"  readonly="readonly"/>
     
        
      </span></li>
                </ul>

               



            </div>
        </div>

<c:if test="${sessionScope.role=='admin'}">
        <div class="submit">
   			<span class="pad120">
   			<input name="save" type="button" value="提交" onclick="saveForm()" />
   			 <input name="resultId" type="hidden" id="resultId" value="<s:property value='#request.result.resultId'/>" />
   				<input name="currentPage" type="hidden"  id="currentPage" value="<s:property value='#request.currentPage'/>" />
  				<input name="list_url" type="hidden" id="list_url" value="<%=basePath%>/system/result_list.do" />
 				 <input name="add_url" type="hidden" id="add_url" value="<%=basePath%>/system/result_add.do" />
   
   </span>

        </div>
    </c:if>


    </form>

</div>

</body>
</html>

