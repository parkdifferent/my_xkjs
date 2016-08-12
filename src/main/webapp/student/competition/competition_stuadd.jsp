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
            jQuery('#startDate').attr("readyonly","readyonly").datepicker({
                dateFormat:"yy-mm-dd",
                changeMonth: true,
                changeYear: true
            });



        });



        function downloadFile() {

            window.location.href="<%=basePath%>/system/competition_download.do?comId=<s:property value='#request.competition.comId'/>";
        }


    </script>

</head>

<body>

<div class="cont">
    <h1 class="seth">竞赛项目</h1>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/competition_stulist.do"><b>主页</b></a> </li>
            <%--<li><a href="<%=basePath%>/system/competition_add.do" <s:if test="#request.edit==null"> class="this" </s:if> ><b>新增</b></a></li>

            <s:if test="#request.edit">
                <li>  <a href="javascript:void(0);" class="this"><b>编辑</b></a></li>
            </s:if>--%>



        </ul>
    </div>

    <form name="theForm" id="theForm" action="<%=basePath%>/system/competition_save.do" method="post" enctype="multipart/form-data">

        <div class="edit">
            <div class="editul setcont">
                <!--鼠标经过样式-->


                <ul class="set1">
                    <li class="setcont_bg">竞赛名称</li>
                    <li><span class="webname">
        <input name="comName" type="text" id="comName" value="<s:property value="#request.competition.comName"/>" readonly/>
      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">主办单位</li>
                    <li><span class="webname">
        <input name="organizer" type="text" id="organizer" value="<s:property value="#request.competition.organizer"/>" readonly/>
      </span></li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg">校内负责单位</li>
                    <li><span class="webname">
        <input name="responsibleUnit" type="text" id="responsibleUnit" value="<s:property value="#request.competition.responsibleUnit"/>" readonly/>
      </span></li>
                </ul>


                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>竞赛类别</li>
                    <li><span class="webname">
         <%--<select name="category" id="category" >

             <option value="" ${request.competition.category ==null?'selected':''}>请选择...</option>
             <option value="A类" ${request.competition.category =="A类"?'selected':''}>A类</option>
             <option value="B类" ${request.competition.category =="B类"?'selected':''}>B类</option>
             <option value="C类" ${request.competition.category =="C类"?'selected':''}>C类</option>

         </select>--%>

               <input name="category" type="text" id="category" value="<s:property value="#request.competition.category"/>" readonly/>

        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>


                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>竞赛级别</li>
                    <li><span class="webname">
         <%--<select name="level" id="level">

             <option value="" ${request.competition.level ==null?'selected':''}>请选择...</option>
             <option value="校级" ${request.competition.level =="校级"?'selected':''}>校级</option>
             <option value="市级" ${request.competition.level =="市级"?'selected':''}>市级</option>
             <option value="省级" ${request.competition.level =="省级"?'selected':''}>省级</option>
             <option value="国家级" ${request.competition.level =="国家级"?'selected':''}>国家级</option>

         </select>--%>

                   <input name="level" type="text" id="level" value="<s:property value="#request.competition.level"/>" readonly/>


        </span>
                        <%--<span id="nothis"><strong class="q"></strong><strong class="w">该平台对应的商城分类，商家选择该分类时会显示该品牌</strong><strong class="c"></strong></span>--%>
                    </li>
                </ul>






                <ul class="set1">
                    <li class="setcont_bg">开始时间</li>
                    <li><span class="webname">
      
      <input name="startDate" type="text" id="startDate" value="<s:date name='#request.competition.startDate' format='yyyy-MM-dd'/>"  readonly="readonly"/>
     
        
      </span></li>
                </ul>







                <ul class="set1">
                    <li  class="setcont_bg"><strong class=""></strong>竞赛状态</li>
                    <li><span class="webname">
                <%--<select name="status" id="status">

                    <option value="0" ${request.competition.status =="0"?'selected':''}>未开始</option>
                    <option value="1" ${request.competition.status =="1"?'selected':''}>开始报名</option>
                    <option value="2" ${request.competition.status =="2"?'selected':''}>报名结束</option>
                </select>--%>

                        <c:if test="${request.competition.status =='0'}">
                            <input name="status" type="text" id="status" value="未开始" readonly/>
                        </c:if>

                        <c:if test="${request.competition.status =='1'}">
                            <input name="status" type="text" id="status" value="开始报名" readonly/>
                        </c:if>

                        <c:if test="${request.competition.status =='2'}">
                            <input name="status" type="text" id="status" value="报名结束" readonly/>
                        </c:if>

                        </span>
                    </li>
                </ul>


                <ul class="set1">
                    <li class="setcont_bg"><strong class="sred">*</strong>附件</li>

                    <li>
                        <s:if test="#request.edit">
                            <s:property value="#request.competition.fileName"/>
                        </s:if>
                    </li>

                    <li>
                    <div class="submit">
                        <input name="save" type="button" value="下载" onclick="downloadFile()"/>
                    </div>
                    </li>
                </ul>

            <%-- <ul class="set1">
                    <li class="setcont_bg"><strong class="sred">*</strong>附件</li>
                    <li><span> <input id="upload" type="file" name="upload" />
						</span><span id="nothis"><strong class="q"></strong><strong
                            class="w">选择要上传文件</strong><strong class="c"></strong></span></li>
                </ul>--%>


                 <%--<li><a id="down" href="<%=basePath%>/system/competition_download.do?comId=<s:property value='#request.competition.comId'/>"><b>导入竞赛报名模板下载</b></a></li>--%>

            </div>
        </div>
        <%--<div class="submit">
   			<span class="pad120">
   			<input name="save" type="button" value="提交" onclick="saveForm()" />
   			 <input name="comId" type="hidden" id="comId" value="<s:property value="#request.competition.comId"/>" />
   				<input name="currentPage" type="hidden"  id="currentPage" value="<s:property value='#request.currentPage'/>" />
  				<input name="list_url" type="hidden" id="list_url" value="<%=basePath%>/system/competition_list.do" />
 				 <input name="add_url" type="hidden" id="add_url" value="<%=basePath%>/system/competition_add.do" />
   </span>

        </div>--%>

    </form>

</div>

</body>
</html>

