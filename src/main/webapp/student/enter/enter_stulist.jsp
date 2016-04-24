<%--
  Created by IntelliJ IDEA.
  User: tianf
  Date: 2016/4/12
  Time: 0:21
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

    <script type="text/javascript">

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
        });





        function export_excel(){

            var grade=$("#grade").val();
            var academe=$("#academe").val();
            var profession=$("#profession").val();
            var comName=$("#comName").val();
            var beginTime=$("#beginTime").val();
            var endTime=$("#endTime").val();


            <!--20160223新增代码-->

            window.location.href="<%=basePath%>/system/enter_exportExcel.do?grade="+grade+"&academe="+academe+"&profession="+profession+"&comName="+comName+"&beginTime="+beginTime+"&endTime="+endTime;

        }




    </script>
</head>
<body>
<div class="cont">
    <h3 class="seth">竞赛报名</h3>
    <div class="nav_list">
        <ul>
            <li><a href="<%=basePath%>/system/enter_stulist.do"  class="this"><b>主页</b></a> </li>
           <%-- <li><a href="<%=basePath%>/system/enter_add.do" ><b>新增</b></a></li>

            <li><a class="add_btn"  href="<%=basePath%>/system/enter_importExcel.do"> <b class="add_btn_b">导入Excel</b></a></li>
            <li><a class="add_btn" onclick="export_excel()" href="javascript:void(0);"> <b class="add_btn_b">导出Excel</b></a></li>--%>
        </ul>
    </div>
    <form action="<%=basePath%>/system/enter_stulist.do" method="post" name="ListForm" id="ListForm">
        <div class="search">
            <ul>

<li>



                    <span>竞赛名称</span> <span>
      <select name="comName" id="comName">
          <option value="" ${request.comName ==null?'selected':''}>请选择...</option>
          <s:if test="#request.competitionList!=null && #request.competitionList.size()>0">
              <s:iterator value="#request.competitionList" id="competition1">

                  <%--<option value=<s:property value='#competition.comName'/> &lt;%&ndash;${competition.comName ==request.comName?'selected':''}&ndash;%&gt;><s:property value='#competition.comName'/></option>--%>
                  <option value="${competition1.comName}" ${competition1.comName ==request.comName1?'selected':''}>${competition1.comName}</option>

              </s:iterator>
          </s:if>

      </select>
      </span>

                    <span>指导教师</span> <span class="size150">
          <input name="tutor" type="text" id="tutor" value="${request.tutor}" />
          </span>

                    <span>审核状态</span> <span>
      <select name="auditStatus" id="auditStatus">
          <option value="" ${request.auditStatus ==null?'selected':''}>请选择...</option>
          <option value="0" ${request.auditStatus =="0"?'selected':''}>未审核</option>
          <option value="1" ${request.auditStatus =="1"?'selected':''}>已审核</option>

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
                <li>我参与的学科竞赛</li>
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
                    <th width="6%" ><span class="form_btna">手机</span></th>
                    <th width="6%" ><span class="form_btna">邮箱</span></th>

                    <th width="6%" ><span class="form_btna">竞赛名称</span></th>
                    <%--<th width="10%" align="center"><span class="form_btna">参赛形式</span></th>--%>
                    <th width="6%" ><span class="form_btna">指导教师</span></th>

                    <th width="6%" ><span class="form_btna">报名时间</span></th>
                    <th width="6%" ><span class="form_btna">状态</span></th>

                   <%-- <th align="center" ><span class="form_btna">操作</span></th>--%>

                </tr>
                <s:if test="#request.enterList!=null && #request.enterList.size()>0">
                    <s:iterator value="#request.enterList" var="enter">
                        <tr>
                            <td class="check_position"><input name="id" type="checkbox" id="id" style="width:16px; border:none;" value="<s:property value='#enter.enterId'/>" /></td>

                            <td align="center"><s:property value="#enter.sno"/></td>
                            <td align="center"><s:property value="#enter.trueName"/></td>
                            <td align="center"><s:property value="#enter.grade"/></td>
                            <td align="center"><s:property value="#enter.academe"/></td>
                            <td align="center"><s:property value="#enter.profession"/></td>
                            <td align="center"><s:property value="#enter.classes"/></td>

                            <td align="center"><s:property value="#enter.telephone"/></td>
                            <td align="center"><s:property value="#enter.email"/></td>

                            <td align="center"><s:property value="#enter.comName"/></td>

                            <td align="center"><s:property value="#enter.tutor"/></td>

                            <td align="center"><s:date name="#enter.enterDate" format="yyyy-MM-dd"/></td>


                            <td align="center">
                                <s:if test="#enter.auditStatus==0">
                                    未审核
                                </s:if>
                                <s:if test="#enter.auditStatus==1">
                                    已审核
                                </s:if>

                            </td>

                            <%--<td align="center" class="hui oprate_con" style="min-width:80px"><a href="<%=basePath%>/system/enter_stuedit.do?enterId=<s:property value='#enter.enterId'/>&currentPage=${request.currentPage}" class="blue" >查看</a>
                               &lt;%&ndash; |<a href="javascript:void(0);" onclick="if(confirm('删除新闻后不可恢复，是否继续？'))window.location.href='<%=basePath%>/system/enter_del.do?mulitId=<s:property value='#enter.enterId'/>&currentPage=${request.currentPage}'" class="blue">删除</a>
                                |<a href="<%=basePath%>/system/enter_audit.do?mulitId=<s:property value='#enter.enterId'/>&currentPage=${request.currentPage}" class="blue" >审核</a>&ndash;%&gt;
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

            <div class="oper_sp"> <span class="oper_check"><label><input name="all" type="checkbox" id="all" onclick="selectAll(this)" value="" />全部</label></span>
              <%--  <span class="oper_del">  <input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/enter_del.do?currentPage=${request.currentPage}')"/></span>
                <span class="oper_del">  <input name="" type="button" value="批量审核" style="cursor:pointer;" onclick="cmd('<%=basePath%>/system/enter_audit.do?currentPage=${request.currentPage}')"/></span>--%>
            </div>

        </div>

    </FORM>
</div>

</body>
</html>

