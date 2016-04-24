package com.ffcs.xkjs.action;

import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.ffcs.xkjs.domain.Area;
import com.ffcs.xkjs.domain.Echarts;
import com.ffcs.xkjs.domain.ElecText;
import com.ffcs.xkjs.service.IElecTextService;
import com.ffcs.xkjs.utils.TUtil;
import com.ffcs.xkjs.utils.ValueUtils;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.util.ValueStack;

/**
 * Created by tianf on 2016/3/27.
 */
/**
 * @Controller("elecTextAction")
 * 相当于spring容器中定义
 * <bean id="elecTextAction" class="com.itheima.elec.web.action.ElecTextAction" scope="prototype">
 */
@SuppressWarnings("serial")
@Controller("elecTextAction")
@Scope(value="prototype")
public class ElecTextAction extends BaseAction<ElecText> {

    ElecText elecText = this.getModel();

    /**注入Service*/
    @Resource(name= IElecTextService.SERVICE_NAME)
    IElecTextService elecTextService;


    private Map<String, Object> returnMap;

    public Map<String, Object> getReturnMap() {
        return returnMap;
    }

    public void setReturnMap(Map<String, Object> returnMap) {
        this.returnMap = returnMap;
    }

    /**
     * @Name: save
     * @Description: 保存
     * @Author: 刘洋（作者）
     * @Version: V1.00 （版本号）
     * @Create Date: 2014-11-28 （创建日期）
     * @Parameters: 无
     * @Return: String：跳转到textAdd.jsp
     */



    public String save(){

        //String ID=request.getParameter("textID");
        String currentPage=request.getParameter("currentPage");
        System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());

        if(elecText.getTextID().equals("") || elecText.getTextID()==null) {

            elecTextService.saveElecText(elecText);
            //elecTextService.update(elecText);
        }
        else {
			/*ElecText obj=elecTextService.findElecTextByID(elecText);
			obj.setTextName(elecText.getTextName());
			obj.setTextDate(elecText.getTextDate());
			obj.setTextRemark(elecText.getTextRemark());*/

            elecTextService.update(elecText);
        }

        //String textDate = request.getParameter("textDate");

        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request)+"/system/elecTextAction_home.do?currentPage="+currentPage);

        request.setAttribute("op_title", "保存Text成功");


        request.setAttribute("add_url", add_url);


        return "save";
    }

    public String home() {

        String condition=request.getParameter("condition");
        String value=request.getParameter("value");

        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");


        System.out.println(condition+"      "+value);
        ElecText elecText = new ElecText();
        if(condition!=null && !TUtil.null2String(value).equals("")) {
            if(condition.equals("textName")) {
                elecText.setTextName(value);
            }
            if(condition.equals("textDate")) {

            }
            if(condition.equals("textRemark")) {
                elecText.setTextRemark(value);
            }
        }



//		elecText.setTextName("张");
//		elecText.setTextRemark("张");
        //List<ElecText> list = elecTextService.findCollectionByConditionNoPage(elecText,beginTime,endTime);
        List<ElecText> list=elecTextService.findTextListByCondition(elecText,beginTime,endTime);
        if(list!=null && list.size()>0){
            for(ElecText text:list){
                System.out.println(text.getTextName()+"    "+text.getTextDate()+"    "+text.getTextRemark());
            }
        }
        //ActionContext.getContext().put("textList", list);
        //ServletActionContext.getRequest().setAttribute("textList", list);
        request.setAttribute("textList", list);
        request.setAttribute("condition", condition);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("value", value);
        request.setAttribute("endTime", endTime);

        return "home";
    }


    public String edit() {

        String textID=request.getParameter("textID");
        String currentPage=request.getParameter("currentPage");
        if(textID != null && !textID.equals("")) {
            ElecText elecText=new ElecText();
            elecText.setTextID(textID);
            ElecText elecText1=elecTextService.findElecTextByID(elecText);
            request.setAttribute("text", elecText1);
        }

        request.setAttribute("edit", true);

        //ValueStack vs=ActionContext.getContext().getValueStack();
        //vs.set("edit", true);


        request.setAttribute("currentPage", currentPage);
        return "edit";
    }


    public String add() {
        String currentPage=request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);
        return "add";

    }

    public String del() {

        String mulitId=request.getParameter("mulitId");
        String currentPage=request.getParameter("currentPage");


        System.out.println("del方法---------------------"+mulitId);
        if(mulitId.contains(",")) {
            String[] ids=mulitId.split(",");
            elecTextService.deleteTextByIds(ids);
        }
        else{
            elecTextService.deleteTextByIds(mulitId);
        }

		/*for(String id:ids) {
			if(!id.equals("")) {
				ElecText text=new ElecText();
				text.setTextID(id);
				ElecText oldText=elecTextService.findElecTextByID(text);

			}
		}*/

        request.setAttribute("currentPage", currentPage);
        return "del";
    }


    @Override
    public String execute() throws Exception {
        System.out.println("quartz quartz quartz hello world!");
        return this.SUCCESS;

    }


    public String getJson() {


        try{
            List<Area> areaList =new ArrayList<>();
            Area area1=new Area();
            area1.setAreaId(11);
            area1.setName("北京");



            Area area3=new Area();
            area3.setAreaId(33);
            area3.setName("南京");

            Area area2=new Area();
            area2.setAreaId(22);
            area2.setName("上海");


            areaList.add(area2);
            areaList.add(area3);
            areaList.add(area1);


            ValueUtils.putValueStack(areaList);
            System.out.println("keyime");


        } catch(Exception e) {
            e.printStackTrace();

        }

        return this.SUCCESS;




         /*//returnMap=new HashMap<String,Object>();
         List<String>  userList=new ArrayList<>();
        userList.add("用户1");
        userList.add("用户2");
        userList.add("用户3");
        userList.add("用户4");
        userList.add("用户5");
        userList.add("用户6");
        userList.add("客户1");
        userList.add("客户3");
        userList.add("客户5");
        userList.add("客户7");
       // returnMap.put("msg","success");


        ValueUtils.putValueStack(userList);
        returnMap.put("userList",userList);
        System.out.println("keyime");*/


    }


    public void echartsTest() {


        Echarts echarts=new Echarts();

        List<String> categoryList=new ArrayList(Arrays.asList("衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"));
        List<Integer> seriesList=new ArrayList(Arrays.asList(5, 20, 40, 10, 10, 20));


        //request.setAttribute("categoryList",categoryList);
        //request.setAttribute("seriesList",seriesList);

        //return "echartsTest";


        echarts.setCategoryList(categoryList);
        echarts.setSeriesList(seriesList);

       // echarts.getCategoryList().add()

        String JsonString=JSON.toJSONString(echarts);

        System.out.println(JsonString);


        response.setContentType("text/html;charset=utf-8");
        try {
           PrintWriter out= response.getWriter();

            out.println(JsonString);
            out.flush();
            out.close();
        }catch (Exception e){
            e.printStackTrace();
        }



    }


    public String kindeditorTest() {
       String content1Data= request.getParameter("content1");
        System.out.println(content1Data);

        request.setAttribute("content1Data",content1Data);

        return "kindeditorTest";
    }
}

