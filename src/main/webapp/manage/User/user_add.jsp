<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/18
  Time: 9:35
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
            jQuery('#userDate').attr("readyonly","readyonly").datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });



        });

        //ajax的二级联动，根据选择的学院，查询该学院下对应的专业
        function selectProfession(o){
            //货物所属单位的文本内容
            var academeName = $(o).find("option:selected").text();
            $.post("${base}/system/user_getProfessionJson.do",{"academeName":academeName},function(data){
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



       /* jQuery("#theForm").validate({

            rules:{
            email:{
                required :true,
                email:true
            }
            },
            messages:{
                email:{required:"电子邮箱不能为空",email:"邮箱格式不对"}
            }



        });
*/

        /*jQuery("#theForm").validate({

            rules:{
                sno:{required:true},
                password:{required:true},
                code:{required:true}
            },
            messages:{
                sno:{required:"用户名不能为空"},
                password:{required:"密码不能为空"},
                code:{required:"验证码不能为空"}
            }
        });*/




    </script>

</head>

<body>

<div class="cont">
    <h1 class="seth">学生管理</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/user_list.do"><b>管理</b></a> </li>
            <li><a href="<%=basePath%>/system/user_add.do" <s:if test="#request.edit==null"> class="this" </s:if> ><b>新增</b></a></li>

            <s:if test="#request.edit">
                <li>  <a href="javascript:void(0);" class="this"><b>编辑</b></a></li>
            </s:if>



        </ul>
    </div>

    <form name="theForm" id="theForm" action="<%=basePath%>/system/user_save.do" method="post">

        <div class="edit">
            <div class="editul setcont">
                <!--鼠标经过样式-->


                <ul class="set1">
                    <li class="setcont_bg">学号</li>
                    <li><span class="webname">
        <input name="sno" type="text" id="sno" value="<s:property value="#request.user.sno"/>" />
      </span></li>
                </ul>

                <ul class="set1">
                    <li class="setcont_bg">姓名</li>
                    <li><span class="webname">
        <input name="userName" type="text" id="userName" value="<s:property value="#request.user.userName"/>" />
      </span></li>
                </ul>


                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>年级</li>
                    <li><span class="webname">
         <select name="grade" id="grade">
             <option value="" ${request.user.grade ==null?'selected':''}>请选择...</option>
             <option value="11级" ${request.user.grade =="11级"?'selected':''}>11级</option>
             <option value="12级" ${request.user.grade =="12级"?'selected':''}>12级</option>
             <option value="13级" ${request.user.grade =="13级"?'selected':''}>13级</option>
             <option value="14级" ${request.user.grade =="14级"?'selected':''}>14级</option>
             <option value="15级" ${request.user.grade =="15级"?'selected':''}>15级</option>

             <option value="16级" ${request.grade =="16级"?'selected':''}>16级</option>
             <option value="17级" ${request.grade =="17级"?'selected':''}>17级</option>
             <option value="18级" ${request.grade =="18级"?'selected':''}>18级</option>

         </select>
        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>


                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>学院</li>
                    <li><span class="webname">
                        <select name="academe" id="academe" onchange="selectProfession(this)">

                            <option value="" ${request.user.academe ==null?'selected':''}>请选择...</option>

                            <s:if test="#request.academeList!=null && #request.academeList.size()>0">
                                <s:iterator value="#request.academeList" id="academe11">

                                    <%--<option value="11级" ${request.user.grade =="11级"?'selected':''}>11级</option>--%>
                                    <option value="${academe11.academeName}" ${academe11.academeName ==request.academe1?'selected':''}>${academe11.academeName}</option>
                                </s:iterator>
                            </s:if>


                        </select>


        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>







                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>专业</li>
                    <li><span class="webname">
         <select name="profession" id="profession" >
             <option value="" ${request.user.profession ==null?'selected':''}>请选择...</option>

             <s:if test="#request.professionSet!=null && #request.professionSet.size()>0">
                 <s:iterator value="#request.professionSet" id="profession11">

                     <option value="${profession11.professionName}" ${profession11.professionName ==request.profession1?'selected':''}>${profession11.professionName}</option>
                 </s:iterator>
             </s:if>

         </select>
        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">班级</li>
                    <li><span class="webname">
        <input name="classes" type="text" id="classes" value="<s:property value="#request.user.classes"/>" />
      </span>
                        <span id="nothis"><strong class="q"></strong><strong class="w">数字请用阿拉伯数字</strong><strong class="c"></strong></span>
                    </li>
                </ul>






                <ul class="set1">
                    <li class="setcont_bg">手机</li>
                    <li><span class="webname">
        <input name="telephone" type="text" id="telephone" value="<s:property value="#request.user.telephone"/>" />
      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">邮箱</li>
                    <li><span class="webname">
        <input name="email" type="text" id="email" value="<s:property value="#request.user.email"/>" />
      </span></li>
                </ul>

            </div>
        </div>
        <div class="submit">
   			<span class="pad120">
   			<input name="save" type="button" value="提交" onclick="saveForm()" />
   			 <input name="userId" type="hidden" id="userId" value="<s:property value='#request.user.userId'/>" />
   				<input name="currentPage" type="hidden"  id="currentPage" value="<s:property value='#request.currentPage'/>" />
  				<input name="list_url" type="hidden" id="list_url" value="<%=basePath%>/system/user_list.do" />
 				 <input name="add_url" type="hidden" id="add_url" value="<%=basePath%>/system/user_add.do" />
   
   </span>

        </div>


    </form>

</div>

</body>
</html>

