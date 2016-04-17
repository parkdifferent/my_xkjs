package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Academe;
import com.ffcs.xkjs.domain.Competition;
import com.ffcs.xkjs.domain.Enter;
import com.ffcs.xkjs.domain.Profession;
import com.ffcs.xkjs.service.IAcademeService;
import com.ffcs.xkjs.service.ICompetitionService;
import com.ffcs.xkjs.service.IEnterService;
import com.ffcs.xkjs.service.IProfessionService;
import com.ffcs.xkjs.utils.TUtil;
import com.ffcs.xkjs.utils.ValueUtils;
import jxl.*;
import jxl.read.biff.BiffException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Created by tianf on 2016/4/8.
 */

@Controller("enterAction")
@Scope(value="prototype")
public class EnterAction extends BaseAction<Enter> {

    Enter enter=this.getModel();

    @Resource(name= IEnterService.SERVICE_NAME)
    IEnterService enterService;

    @Resource(name= IAcademeService.SERVICE_NAME)
    IAcademeService academeService;

    @Resource(name= IProfessionService.SERVICE_NAME)
    IProfessionService professionService;


    @Resource(name= ICompetitionService.SERVICE_NAME)
    ICompetitionService competitionService;


    public String list() {


        // String condition=request.getParameter("condition");
        //String value=request.getParameter("value");

        String sno=request.getParameter("sno");
        String trueName=request.getParameter("trueName");
        String grade=request.getParameter("grade");

        String academe=request.getParameter("academe");   //null
        String profession=request.getParameter("profession");
        String comName=request.getParameter("comName");
        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");

        //获取专业id
        String proId=request.getParameter("profession");
        //System.out.println(comName+"      "+category+"         "+level);


        Enter enter1=new Enter();
        if(!TUtil.null2String(sno).equals("")) {
            enter1.setSno(sno);
        }
        if(!TUtil.null2String(trueName).equals("")) {
            enter1.setTrueName(trueName);
        }
        if(!TUtil.null2String(grade).equals("")) {
            enter1.setGrade(grade);
        }

        //如果有学院，那么要加载学院下所属的专业
        if(!TUtil.null2String(academe).equals("")) {
            enter1.setAcademe(academe);

            //专业下拉列表框的值
            List<Academe> academeList1=academeService.findAcademeByCondition(academe);

            if(!academeList1.isEmpty()) {
                Academe academe1=academeList1.get(0);
                //Integer academeId=academe1.getAcademeId();

                //根据academeId查询专业
                Set<Profession> professionSet=academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }

            //获取专业名称
            if(!TUtil.null2String(proId).equals("")) {

                Profession profession1=professionService.findProfessionByID(new Integer(proId));
                String professionName=profession1.getProfessionName();
                //按专业名称查询
                if(!TUtil.null2String(professionName).equals("")) {
                    enter1.setProfession(professionName);
                }
                request.setAttribute("profession", professionName);

            }
        }
        /*request.setAttribute("professionName", null);*/



        if(!TUtil.null2String(comName).equals("")) {
            enter1.setComName(comName);
        }


        List<Enter> list=enterService.findEnterByCondition(enter1,beginTime,endTime);

        List<Academe> academeList =academeService.findAcademeByCondition(null);
        List<Competition> competitionList=competitionService.findCompetitionsNoPage();
       /* if(!TUtil.null2String(academe).equals("")) {
            List<Academe> academeList =academeService.findAcademeByCondition(null);
        }*/
        /*else {
            Academe academe11=new Academe();
            academe11.setAcademeName(academe);
            List<Academe> academeList=academeService.findAcademeByCondition(academe11);
            if(academeList!=null && academeList.size()>0) {
                String academeName=academeList.get(0).getAcademeName();
            }
        }*/

       // List<Competition> list=competitionService.findCompetitionByCondition(competition1,beginTime,endTime);
        // List<News> list=newsService.findNewsByCondition(news1,beginTime,endTime);
        /*if(list!=null && list.size()>0){
            for(News news:list){
                System.out.println(text.getTextName()+"    "+text.getTextDate()+"    "+text.getTextRemark());
            }
        }*/
        //ActionContext.getContext().put("textList", list);
        //ServletActionContext.getRequest().setAttribute("textList", list);
        request.setAttribute("enterList", list);

        request.setAttribute("academeList", academeList);
        request.setAttribute("competitionList", competitionList);
        // request.setAttribute("condition", condition);
        request.setAttribute("beginTime", beginTime);
        //request.setAttribute("value", value);
        request.setAttribute("endTime", endTime);

        request.setAttribute("sno", sno);
        request.setAttribute("trueName", trueName);
        request.setAttribute("grade", grade);
        request.setAttribute("academe", academe);


        request.setAttribute("proId", proId);

        request.setAttribute("comName1", comName);

        return "list";

    }

    public String add() {
        String currentPage=request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);

        List<Academe> academeList =academeService.findAcademeByCondition(null);
        List<Competition> competitionList=competitionService.findCompetitionsNoPage();

        request.setAttribute("academeList",academeList);
        request.setAttribute("competitionList",competitionList);

        return "add";
    }


    public String edit() {

        // String newsId=request.getParameter("newsId");
        String enterId=request.getParameter("enterId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(enterId).equals("")) {

            // Notice notice1=new Notice();
            Enter enter1=new Enter();
            enter1.setEnterId(enterId);
            Enter enter2=enterService.findEnterByID(enter1);
            //Competition competition1=new Competition();
           // competition1.setComId(comId);
            //notice1.setNoticeId(noticeId);
            // Notice notice2=noticeService.findNoticeByID(notice1);
            //Competition competition2=competitionService.findCompetitionByID(competition1);
            request.setAttribute("enter",enter2);

            List<Academe> academeList =academeService.findAcademeByCondition(null);
            List<Competition> competitionList=competitionService.findCompetitionsNoPage();

            request.setAttribute("academeList",academeList);
            request.setAttribute("competitionList",competitionList);

            //获取专业
            List<Academe> academeList1=academeService.findAcademeByCondition(enter2.getAcademe());
            if(!academeList1.isEmpty()) {
                Academe academe1=academeList1.get(0);
                //Integer academeId=academe1.getAcademeId();
                //根据academeId查询专业
                Set<Profession> professionSet=academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }



            request.setAttribute("academe1", enter2.getAcademe());
            request.setAttribute("profession1", enter2.getProfession());
            request.setAttribute("comName1", enter2.getComName());

        }



        request.setAttribute("edit", true);

        //ValueStack vs=ActionContext.getContext().getValueStack();
        //vs.set("edit", true);
        request.setAttribute("currentPage", currentPage);
        return "edit";
    }


    public String del() {
        String mulitId=request.getParameter("mulitId");
        String currentPage=request.getParameter("currentPage");


        System.out.println("del方法---------------------"+mulitId);
        if(mulitId.contains(",")) {
            String[] ids=mulitId.split(",");
            //competitionService.deleteCompetitionByIds(ids);
            enterService.deleteEnterByIds(ids);
            //noticeService.deleteNoticeByIds(ids);
        }
        else{
            //noticeService.deleteNoticeByIds(mulitId);
           // competitionService.deleteCompetitionByIds(mulitId);
            enterService.deleteEnterByIds(mulitId);
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


    public String save(){

        String enterId=request.getParameter("enterId");
        String currentPage=request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if(TUtil.null2String(enterId).equals("")) {
            //noticeService.saveNotice(notice);
            //competitionService.saveCompetition(competition);
            enterService.saveEnter(enter);
        }


        else {
            // noticeService.update(notice);
           // competitionService.update(competition);
            enterService.update(enter);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request)+"/system/enter_list.do?currentPage="+currentPage);

        request.setAttribute("op_title", "保存报名信息成功");


        request.setAttribute("add_url", add_url);


        return "save";
    }




    public String importExcel() {


        return "importExcel";

    }


    private File upload;
    private String uploadContentType;
    private String uploadFileName; // 真实文件名


    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public File getUpload() {
        return upload;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public String getUploadContentType() {
        return uploadContentType;
    }

    public void setUploadContentType(String uploadContentType) {
        this.uploadContentType = uploadContentType;
    }

    public String importJava() {

        try {

            //1.构建Workbook
            Workbook rwb = Workbook.getWorkbook(upload);

            //2.获得工作表
            Sheet rs=rwb.getSheet(0);
            List<Enter> enterList=new ArrayList<Enter>();
            for(int i=1;i<rs.getRows();i++) {
                Enter enter2=new Enter();
				/*Cell fcell=rs.getCell(1,i);
				if(fcell.getType()==CellType.NUMBER){
					NumberCell nc=(NumberCell) fcell;//转换类型
					int areaId=(int) nc.getValue();//获取的值
				    area.setAreaId(areaId);;//将值插入到集合里去
				      System.out.println(areaId);
				}*/


                Cell fCell=rs.getCell(0,i);
                String sno=fCell.getContents();
                enter2.setSno(sno);
                System.out.println(sno);

                Cell fCell1=rs.getCell(1,i);
                String trueName=fCell1.getContents();
                enter2.setTrueName(trueName);
                System.out.println(trueName);

                Cell fCell2=rs.getCell(2,i);
                String grade=fCell2.getContents();
                enter2.setGrade(grade);
                System.out.println(grade);

                Cell fCell3=rs.getCell(3,i);
                String academe=fCell3.getContents();
                enter2.setAcademe(academe);
                System.out.println(academe);

                Cell fCell4=rs.getCell(4,i);
                String profession=fCell4.getContents();
                enter2.setProfession(profession);
                System.out.println(profession);

                Cell fCell5=rs.getCell(5,i);
                String classes=fCell5.getContents();
                enter2.setClasses(classes);
                System.out.println(classes);

                Cell fCell6=rs.getCell(6,i);
                String telephone=fCell6.getContents();
                enter2.setTelephone(telephone);
                System.out.println(telephone);

                Cell fCell7=rs.getCell(7,i);
                String email=fCell7.getContents();
                enter2.setEmail(email);
                System.out.println(email);

                Cell fCell8=rs.getCell(8,i);
                String comName=fCell8.getContents();
                enter2.setComName(comName);
                System.out.println(comName);


                //报名时间
                Cell fCell9=rs.getCell(9,i);
                if(fCell9.getType()== CellType.DATE){
                    DateCell dateCell=(DateCell) fCell9;
                    Date result= dateCell.getDate();
                    enter2.setEnterDate(result);
                    System.out.println(new SimpleDateFormat("yyyy-MM-dd").format(result));
                    //contactPersonInfo.setContactBirthday(result);
                    //System.out.println("生日："+new SimpleDateFormat("yyyy-MM-dd").format(result));//Thu Jan 10 08:00:00 CST 2013
                }


                //加入到List集合中
                enterList.add(enter2);


            }
            // 主体内容生成结束
            // 写入文件
            rwb.close();
            System.out.println(uploadFileName);
            System.out.println(enterList.size());

            //写入数据库
            for(Enter enter3:enterList) {
                enterService.saveEnter(enter3);
            }

        }
        catch (BiffException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "importJava";
    }


    public String  getProfessionJson() {

        String academeName=request.getParameter("academeName");
        List<Academe> academeList=academeService.findAcademeByCondition(academeName);

        if(!academeList.isEmpty()) {
            Academe academe=academeList.get(0);
            Integer academeId=academe.getAcademeId();
            //List<Profession> professionList=professionService.findProfessionByCondition(academeId.toString());
            //ValueUtils.putValueStack(professionList);

            //根据academeId查询专业
            Set<Profession> professionSet=academe.getProfessions();
            /*for(Profession profession:professionSet) {

            }*/
            ValueUtils.putValueStack(professionSet);
        }


        return "getProfessionJson";

    }
















}
