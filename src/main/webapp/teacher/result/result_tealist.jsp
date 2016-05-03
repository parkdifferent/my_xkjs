<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/12
  Time: 0:45
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
                        $option.attr("value",proId);
                        $option.text(professionName);
                        $("#profession").append($option);
                    }
                }
            });

        }



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


        function export_excel() {

            var grade = $("#grade").val();
            var academe = $("#academe").val();
            var profession = $("#profession").val();
            var comName = $("#comName").val();
            var beginTime = $("#beginTime").val();
            var endTime = $("#endTime").val();
            window.location.href="<%=basePath%>/system/result_exportExcel.do?grade="+grade+"&academe="+academe+"&profession="+profession+"&comName="+comName+"&beginTime="+beginTime+"&endTime="+endTime;

        }

    </script>
</head>
<body>
<div class="cont">
    <h3 class="seth">竞赛结果管理</h3>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/result_tealist.do"  class="this"><b>主页</b></a> </li>
           <%-- <li><a href="<%=basePath%>/system/result_add.do" ><b>新增</b></a></li>--%>

            <%--<li><a class="add_btn" &lt;%&ndash;onclick="payoff_excel()"&ndash;%&gt; href="<%=basePath%>/system/result_importExcel.do"> <b class="add_btn_b">导入Excel</b></a></li>--%>
            <li><a class="add_btn" onclick="export_excel()" href="javascript:void(0);"> <b class="add_btn_b">导出Excel</b></a></li>
        </ul>
    </div>
    <form action="<%=basePath%>/system/result_tealist.do" method="post" name="ListForm" id="ListForm">
        <div class="search">
            <ul>
                <li>

                    <span>学号</span> <span class="size150">
          <input name="sno" type="text" id="sno" value="${request.sno}" />
          </span>

                    <span>姓名</span> <span class="size150">
          <input name="name" type="text" id="name" value="${request.name}" />
          </span>

                    <span>年级</span> <span>
      <select name="grade" id="grade">
          <option value="" ${request.grade ==null?'selected':''}>请选择...</option>
          <option value="11级" ${request.grade =="11级"?'selected':''}>11级</option>
          <option value="12级" ${request.grade =="12级"?'selected':''}>12级</option>
          <option value="13级" ${request.grade =="13级"?'selected':''}>13级</option>
          <option value="14级" ${request.grade =="14级"?'selected':''}>14级</option>
          <option value="15级" ${request.grade =="15级"?'selected':''}>15级</option>

      </select></span>

                    <span>学院</span> <span>
      <select name="academe" id="academe" onchange="selectProfession(this)">
          <option value="" ${request.academe ==null?'selected':''}>请选择...</option>
          <s:if test="#request.academeList!=null && #request.academeList.size()>0">
              <s:iterator value="#request.academeList" id="academe1">

                  <option value=${academe1.academeName} ${academe1.academeName ==request.academe?'selected':''}>${academe1.academeName}</option>
              </s:iterator>
          </s:if>


      </select>
      </span>
                    </li>
                <li>

                    <span>专业</span> <span>
      <select name="profession" id="profession" >
          <option value="" ${request.profession ==null?'selected':''}>请选择...</option>
          <s:if test="#request.professionSet!=null && #request.professionSet.size()>0">
              <s:iterator value="#request.professionSet" id="profession1">

                  <option value="${profession1.proId}" ${profession1.professionName ==request.profession?'selected':''}>${profession1.professionName}</option>
              </s:iterator>
          </s:if>


      </select>
      </span>


                    <span>竞赛名称</span> <span>
      <select name="comName" id="comName">
          <option value="" ${request.comName ==null?'selected':''}>请选择...</option>
          <s:if test="#request.competitionList!=null && #request.competitionList.size()>0">
              <s:iterator value="#request.competitionList" id="competition1">

                  <%--<option value=<s:property value='#competition.comName'/> &lt;%&ndash;${competition.comName ==request.comName?'selected':''}&ndash;%&gt;><s:property value='#competition.comName'/></option>--%>
                  <option value=${competition1.comName} ${competition1.comName ==request.comName1?'selected':''}>${competition1.comName}</option>

              </s:iterator>
          </s:if>


      </select>
      </span>

                    <%--<span>指导教师</span> <span class="size150">
          <input name="tutor" type="text" id="tutor" value="${request.tutor}" />
          </span>--%>

                    <span>获奖时间</span><span class="size100">
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
                <li>查询所指导学生的竞赛成绩</li>
            </ul>
        </div>
        <div class="fshoptb">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="fshop_table">
                <tr>

                    <th width="4%" align="left">&nbsp;</th>

                    <th width="6%" ><span class="form_btna">学号</span></th>
                    <th width="6%" ><span class="form_btna">姓名</span></th>
                    <th width="6%" ><span class="form_btna">年级</span></th>
                    <th width="6%" ><span class="form_btna">学院</span></th>
                    <th width="6%" ><span class="form_btna">专业</span></th>

                    <th width="6%" ><span class="form_btna">班级</span></th>
                    <th width="6%" ><span class="form_btna">竞赛名称</span></th>
                    <th width="6%" ><span class="form_btna">参赛形式</span></th>

                    <th width="6%" ><span class="form_btna">奖项</span></th>
                    <th width="6%" ><span class="form_btna">指导教师</span></th>

                    <th width="6%" ><span class="form_btna">获奖时间</span></th>
                   <%-- <th align="center" ><span class="form_btna">操作</span></th>--%>

                </tr>
                <s:if test="#request.resultList!=null && #request.resultList.size()>0">
                    <s:iterator value="#request.resultList" var="result">
                        <tr>
                            <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#result.resultId'/>" /></td>

                            <td align="center"><s:property value="#result.sno"/></td>
                            <td align="center"><s:property value="#result.name"/></td>
                            <td align="center"><s:property value="#result.grade"/></td>
                            <td align="center"><s:property value="#result.academe"/></td>
                            <td align="center"><s:property value="#result.profession"/></td>
                            <td align="center"><s:property value="#result.classes"/></td>



                            <td align="center"><s:property value="#result.comName"/></td>
                            <td align="center"><s:property value="#result.form"/></td>
                            <td align="center"><s:property value="#result.prize"/></td>
                            <td align="center"><s:property value="#result.tutor"/></td>

                            <td align="center"><s:date name="#result.getTime" format="yyyy-MM-dd"/></td>

                            <%--<td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/result_edit.do?resultId=<s:property value='#result.resultId'/>&currentPage=${request.currentPage}" class="blue" >编辑</a>
                                |<a href="javascript:void(0);" onclick="if(confirm('删除竞赛成绩后不可恢复，是否继续？'))window.location.href='<%=basePath%>/system/result_del.do?mulitId=<s:property value='#result.resultId'/>&currentPage=${request.currentPage}'" class="blue">删除</a>
                            </td>--%>
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

            <%--<div class="oper_sp"> <span class="oper_check"><label><input name="all" type="checkbox" id="all" onclick="selectAll(this)" value="" />全部</label></span>
                <span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/result_del.do?currentPage=${request.currentPage}')"/></span>

            </div>--%>

        </div>


    </FORM>
</div>



</body>
</html>

