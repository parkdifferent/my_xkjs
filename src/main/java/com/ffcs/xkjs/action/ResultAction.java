package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.*;
import com.ffcs.xkjs.service.*;
import com.ffcs.xkjs.utils.TUtil;
import com.ffcs.xkjs.utils.ValueUtils;
import com.opensymphony.xwork2.ActionContext;
import jxl.*;
import jxl.read.biff.BiffException;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by tianf on 2016/4/11.
 */

@Controller("resultAction")
@Scope(value="prototype")
public class ResultAction extends BaseAction<Result> {

    Result result=this.getModel();

    @Resource(name= IResultService.SERVICE_NAME)
    IResultService resultService;

    @Resource(name= IAcademeService.SERVICE_NAME)
    IAcademeService academeService;


    @Resource(name= ICompetitionService.SERVICE_NAME)
    ICompetitionService competitionService;

    @Resource(name= IProfessionService.SERVICE_NAME)
    IProfessionService professionService;

    @Resource(name= IUserService.SERVICE_NAME)
    IUserService userService;

    @Resource(name= ITeacherService.SERVICE_NAME)
    ITeacherService teacherService;

    @Resource(name = IEnterService.SERVICE_NAME)
    IEnterService enterService;


    public String list() {


        // String condition=request.getParameter("condition");
        //String value=request.getParameter("value");

        String sno=request.getParameter("sno");
        String name=request.getParameter("name");
        String grade=request.getParameter("grade");

        String academe=request.getParameter("academe");   //null
        //获取专业id
        String proId=request.getParameter("profession");

        String comName=request.getParameter("comName");

        String tutor=request.getParameter("tutor");

        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");
        //System.out.println(comName+"      "+category+"         "+level);

       // Result result1=new Result();
        Result result1=new Result();
        if(!TUtil.null2String(sno).equals("")) {
            result1.setSno(sno);
        }
        if(!TUtil.null2String(name).equals("")) {
            result1.setName(name);
        }
        if(!TUtil.null2String(grade).equals("")) {
            result1.setGrade(grade);
        }

        //如果有学院，那么要加载学院下所属的专业
        if(!TUtil.null2String(academe).equals("")) {
            result1.setAcademe(academe);

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
                    result1.setProfession(professionName);
                }
                request.setAttribute("profession", professionName);

            }
        }

        if(!TUtil.null2String(comName).equals("")) {
            result1.setComName(comName);
        }

        if(!TUtil.null2String(tutor).equals("")) {
            //result1.
            result1.setTutor(tutor);
        }


        //获取专业名称
        if(!TUtil.null2String(proId).equals("")) {

            Profession profession1=professionService.findProfessionByID(new Integer(proId));
            String professionName=profession1.getProfessionName();
            //按专业名称查询
            if(!TUtil.null2String(professionName).equals("")) {
                result1.setProfession(professionName);
            }
            request.setAttribute("professionName", professionName);


            //专业下拉列表框取值
            List<Academe> academeList=academeService.findAcademeByCondition(academe);

            if(!academeList.isEmpty()) {
                Academe academe1=academeList.get(0);
                //Integer academeId=academe1.getAcademeId();

                //根据academeId查询专业
                Set<Profession> professionSet=academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }

        }







        //List<Result> list=resultService.
        List<Result> list=resultService.findResultByCondition(result1,beginTime,endTime);
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
        request.setAttribute("resultList", list);

        request.setAttribute("academeList", academeList);
        request.setAttribute("competitionList", competitionList);
        // request.setAttribute("condition", condition);
        request.setAttribute("beginTime", beginTime);
        //request.setAttribute("value", value);
        request.setAttribute("endTime", endTime);

        request.setAttribute("sno", sno);
        request.setAttribute("name", name);
        request.setAttribute("grade", grade);
        request.setAttribute("academe", academe);

        request.setAttribute("comName1", comName);

        request.setAttribute("tutor", tutor);

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
        String resultId=request.getParameter("resultId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(resultId).equals("")) {

            // Notice notice1=new Notice();
            Result result1=new Result();
            result1.setResultId(resultId);
            Result result2=resultService.findResultByID(result1);
            //Competition competition1=new Competition();
            // competition1.setComId(comId);
            //notice1.setNoticeId(noticeId);
            // Notice notice2=noticeService.findNoticeByID(notice1);
            //Competition competition2=competitionService.findCompetitionByID(competition1);
            request.setAttribute("result",result2);

            List<Academe> academeList =academeService.findAcademeByCondition(null);
            List<Competition> competitionList=competitionService.findCompetitionsNoPage();

            request.setAttribute("academeList",academeList);
            request.setAttribute("competitionList",competitionList);

            //获取专业
            List<Academe> academeList1=academeService.findAcademeByCondition(result2.getAcademe());
            if(!academeList1.isEmpty()) {
                Academe academe1=academeList1.get(0);
                //Integer academeId=academe1.getAcademeId();
                //根据academeId查询专业
                Set<Profession> professionSet=academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }




            request.setAttribute("academe1", result2.getAcademe());
            request.setAttribute("profession1", result2.getProfession());
            request.setAttribute("comName1", result2.getComName());

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
            resultService.deleteResultByIds(ids);
            //noticeService.deleteNoticeByIds(ids);
        }
        else{
            //noticeService.deleteNoticeByIds(mulitId);
            // competitionService.deleteCompetitionByIds(mulitId);
            resultService.deleteResultByIds(mulitId);
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

        String resultId=request.getParameter("resultId");
        String currentPage=request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if(TUtil.null2String(resultId).equals("")) {
            //noticeService.saveNotice(notice);
            //competitionService.saveCompetition(competition);
           // resultService.saveResult(result);

            String sno=result.getSno();
            User user=userService.findUserBySno(sno);
            if(!TUtil.null2String(user).equals("")) {
                result.setName(user.getUserName());              //姓名
                result.setGrade(user.getGrade());                //年级
                result.setAcademe(user.getAcademe());              //学院
                result.setProfession(user.getProfession());            //专业
                result.setClasses(user.getClasses());              //班级
            }

            //指导教师
            Enter enter1=new Enter();
            enter1.setSno(sno);
            enter1.setComName(result.getComName());
            List<Enter> enterList = enterService.findEnterByCondition(enter1,null,null);
            if(!TUtil.null2String(enterList).equals("") && enterList.size()>0) {
                Enter enter2 = enterList.get(0);
                result.setTutor(enter2.getTutor());            //指导教师
            }






            resultService.saveResult(result);

        }


        else {
            // noticeService.update(notice);
            // competitionService.update(competition);
            String sno=result.getSno();
            User user=userService.findUserBySno(sno);
            if(!TUtil.null2String(user).equals("")) {
                result.setName(user.getUserName());              //姓名
                result.setGrade(user.getGrade());                //年级
                result.setAcademe(user.getAcademe());              //学院
                result.setProfession(user.getProfession());            //专业
                result.setClasses(user.getClasses());              //班级
            }

            //指导教师
            Enter enter1=new Enter();
            enter1.setSno(sno);
            enter1.setComName(result.getComName());
            List<Enter> enterList = enterService.findEnterByCondition(enter1,null,null);
            if(!TUtil.null2String(enterList).equals("") && enterList.size()>0) {
                Enter enter2 = enterList.get(0);
                result.setTutor(enter2.getTutor());            //指导教师
            }




            resultService.update(result);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request)+"/system/result_list.do?currentPage="+currentPage);

        request.setAttribute("op_title", "保存竞赛结果信息成功");


        request.setAttribute("add_url", add_url);


        return "save";
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

    public String importExcel() {


        return "importExcel";

    }

    private File upload;
    private String uploadContentType;
    private String uploadFileName; // 真实文件名


    public String getUploadContentType() {
        return uploadContentType;
    }

    public void setUploadContentType(String uploadContentType) {
        this.uploadContentType = uploadContentType;
    }

    public File getUpload() {
        return upload;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }


    public String importJava() {

        try {

            //1.构建Workbook
            Workbook rwb = Workbook.getWorkbook(upload);

            //2.获得工作表
            Sheet rs=rwb.getSheet(0);
            List<Result> resultList=new ArrayList<Result>();
            for(int i=2;i<rs.getRows();i++) {
                Result result2=new Result();
				/*Cell fcell=rs.getCell(1,i);
				if(fcell.getType()==CellType.NUMBER){
					NumberCell nc=(NumberCell) fcell;//转换类型
					int areaId=(int) nc.getValue();//获取的值
				    area.setAreaId(areaId);;//将值插入到集合里去
				      System.out.println(areaId);
				}*/


                Cell fCell=rs.getCell(0,i);
                String sno=fCell.getContents();
                result2.setSno(sno);
                System.out.println(sno);


                User user=userService.findUserBySno(sno);
                if(!TUtil.null2String(user).equals("")) {
                    result2.setName(user.getUserName());              //姓名
                    result2.setGrade(user.getGrade());                //年级
                    result2.setAcademe(user.getAcademe());              //学院
                    result2.setProfession(user.getProfession());            //专业
                    result2.setClasses(user.getClasses());              //班级
                }





               /* Cell fCell1=rs.getCell(1,i);
                String name=fCell1.getContents();
                result2.setName(name);
                System.out.println(name);

                Cell fCell2=rs.getCell(2,i);
                String grade=fCell2.getContents();
                result2.setGrade(grade);
                System.out.println(grade);

                Cell fCell3=rs.getCell(3,i);
                String academe=fCell3.getContents();
                result2.setAcademe(academe);
                System.out.println(academe);

                Cell fCell4=rs.getCell(4,i);
                String profession=fCell4.getContents();
                result2.setProfession(profession);
                System.out.println(profession);

                Cell fCell5=rs.getCell(5,i);
                String classes=fCell5.getContents();
                result2.setClasses(classes);
                System.out.println(classes);*/

                Cell fCell6=rs.getCell(1,i);
                String comName=fCell6.getContents();
                result2.setComName(comName);
                System.out.println(comName);

                Cell fCell7=rs.getCell(2,i);
                String form=fCell7.getContents();
                result2.setForm(form);
                System.out.println(form);

                Cell fCell8=rs.getCell(3,i);
                String prize=fCell8.getContents();
                result2.setPrize(prize);
                System.out.println(prize);



                //指导教师
                Enter enter1=new Enter();
                enter1.setSno(sno);
                enter1.setComName(comName);
              List<Enter> enterList = enterService.findEnterByCondition(enter1,null,null);
                if(!TUtil.null2String(enterList).equals("") && enterList.size()>0) {
                  Enter enter2 = enterList.get(0);
                    result2.setTutor(enter2.getTutor());            //指导教师
                }

                /*Cell fCell9=rs.getCell(4,i);
                String tutor=fCell9.getContents();
                result2.setTutor(tutor);
                System.out.println(tutor);*/


                //获奖时间
                Cell fCell10=rs.getCell(4,i);
                if(fCell10.getType()== CellType.DATE){
                    DateCell dateCell=(DateCell) fCell10;
                    Date result= dateCell.getDate();
                    result2.setGetTime(result);
                    //enter2.setEnterDate(result);
                    System.out.println(new SimpleDateFormat("yyyy-MM-dd").format(result));
                    //contactPersonInfo.setContactBirthday(result);
                    //System.out.println("生日："+new SimpleDateFormat("yyyy-MM-dd").format(result));//Thu Jan 10 08:00:00 CST 2013
                }


                //加入到List集合中
                resultList.add(result2);
            }
            // 主体内容生成结束
            // 写入文件
            rwb.close();
            System.out.println(uploadFileName);
            System.out.println(resultList.size());

            //写入数据库
            for(Result result3:resultList) {
                //userService.saveEnter(enter3);
                resultService.saveResult(result3);
            }

        }
        catch (BiffException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "importJava";
    }




    File file=new File("result.xls");

    public InputStream getInputStream() throws FileNotFoundException {
        return new FileInputStream(file);
    }



    public String exportExcel() {

        String grade = request.getParameter("grade");
        String academe = request.getParameter("academe");
        String professionId = request.getParameter("profession");
        String comName = request.getParameter("comName");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");


        try {
            grade = new String(grade.getBytes("ISO8859-1"),"UTF-8");
            academe = new String(academe.getBytes("ISO8859-1"),"UTF-8");
            comName = new String(comName.getBytes("ISO8859-1"),"UTF-8");
        }
        catch(Exception e) {
            e.printStackTrace();

        }
        //Enter enter1 = new Enter();

        Result result1=new Result();

        //文件名称
        String title1 = "";

        if (!TUtil.null2String(grade).equals("")) {
            result1.setGrade(grade);
            title1 += grade;
        }
        if (!TUtil.null2String(academe).equals("")) {
            result1.setAcademe(academe);
            title1 += academe;
        }
        /*if (!TUtil.null2String(profession).equals("")) {
            result1.setProfession(profession);
            title1 += profession;
        }*/

        //教师信息  指导教师姓名
        Map session=ActionContext.getContext().getSession();
        if(session.get("role").equals("teacher")) {
            String teaId = (String)session.get("teaId");
            Teacher teacher1=teacherService.findTeacherByID(teaId);
            String name=teacher1.getName();
            if (!TUtil.null2String(name).equals("")) {
                result1.setTutor(name);
            }

        }


        //获取专业名称
        if (!TUtil.null2String(professionId).equals("")) {
            Profession profession1 = professionService.findProfessionByID(new Integer(professionId));
            String professionName = profession1.getProfessionName();

            if (!TUtil.null2String(professionName).equals("")) {
                result1.setProfession(professionName);
                title1 += professionName;
            }
        }

        if (!TUtil.null2String(comName).equals("")) {
            result1.setComName(comName);
            title1 += comName;
        }

        title1 += "竞赛成绩表";

        // List<Enter> list=enterService.findEnterByCondition(enter1,beginTime,endTime);
        List<Result> datas = resultService.findResultListByConditionNoPage(result1, beginTime, endTime);
        // 创建Excel的工作书册 Workbook,对应到一个excel文档
        HSSFWorkbook wb = new HSSFWorkbook();
        // 创建Excel的工作sheet,对应到一个excel文档的tab
        HSSFSheet sheet = wb.createSheet("竞赛成绩表");
        HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
        List<HSSFClientAnchor> anchor = new ArrayList<HSSFClientAnchor>();
        for (int i = 0; i < datas.size(); i++) {
            anchor.add(new HSSFClientAnchor(0, 0, 1000, 255, (short) 1,
                    2 + i, (short) 1, 2 + i));
        }

        // 设置excel每列宽度
        sheet.setColumnWidth(0, 6000);
        sheet.setColumnWidth(1, 4000);
        sheet.setColumnWidth(2, 3000);
        sheet.setColumnWidth(3, 6000);
        sheet.setColumnWidth(4, 6000);
        sheet.setColumnWidth(5, 4000);

        sheet.setColumnWidth(6, 10000);
        sheet.setColumnWidth(7, 3000);
        sheet.setColumnWidth(8, 4000);
        sheet.setColumnWidth(9, 3000);
        sheet.setColumnWidth(10, 4000);

        // 创建字体样式
        HSSFFont font = wb.createFont();
        font.setFontName("Verdana");
        font.setBoldweight((short) 100);
        font.setFontHeight((short) 300);
        font.setColor(HSSFColor.BLUE.index);
        // 创建单元格样式
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        style.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        // 设置边框
        style.setBottomBorderColor(HSSFColor.RED.index);
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setFont(font);// 设置字体
        // 创建Excel的sheet的一行
        HSSFRow row = sheet.createRow(0);
        row.setHeight((short) 500);// 设定行的高度
        // 创建一个Excel的单元格
        HSSFCell cell = row.createCell(0);
        // 合并单元格(startRow，endRow，startColumn，endColumn)
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));
        // 给Excel的单元格设置样式和赋值
        cell.setCellStyle(style);
        String title = "竞赛成绩表";
        Date time1 = null;
        Date time2 = null;
        time1 = TUtil.formatDate(beginTime);
        time2 = TUtil.formatDate(endTime);
        String Time = TUtil.null2String(TUtil.formatShortDate(time1) + " - " + TUtil.formatShortDate(time2));
        //cell.setCellValue(title + "(" + Time + ")");
        cell.setCellValue(title);

        // 设置单元格内容格式时间
        HSSFCellStyle style1 = wb.createCellStyle();
        style1.setDataFormat(HSSFDataFormat.getBuiltinFormat("yyyy-mm-dd"));
        style1.setWrapText(true);// 自动换行
        style1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        HSSFCellStyle style2 = wb.createCellStyle();
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        row = sheet.createRow(1);

        cell = row.createCell(0);
        cell.setCellStyle(style2);
        cell.setCellValue("学号");

        cell = row.createCell(1);
        cell.setCellStyle(style2);
        cell.setCellValue("姓名");

        cell = row.createCell(2);
        cell.setCellStyle(style2);
        cell.setCellValue("年级");

        cell = row.createCell(3);
        cell.setCellStyle(style2);
        cell.setCellValue("学院");

        cell = row.createCell(4);
        cell.setCellStyle(style2);
        cell.setCellValue("专业");

        cell = row.createCell(5);
        cell.setCellStyle(style2);
        cell.setCellValue("班级");



        cell = row.createCell(6);
        cell.setCellStyle(style2);
        cell.setCellValue("竞赛名称");

       /* cell = row.createCell(1);
        cell.setCellStyle(style2);
        cell.setCellValue("参赛形式");*/

        cell = row.createCell(7);
        cell.setCellStyle(style2);
        cell.setCellValue("参赛形式");

        cell = row.createCell(8);
        cell.setCellStyle(style2);
        cell.setCellValue("奖项");

        cell = row.createCell(9);
        cell.setCellStyle(style2);
        cell.setCellValue("指导教师");

        cell = row.createCell(10);
        cell.setCellStyle(style2);
        cell.setCellValue("获奖时间");

        for (int j = 2; j <= datas.size() + 1; j++) {
            row = sheet.createRow(j);
            // 设置单元格的样式格式
            int i = 0;

            cell = row.createCell(i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getSno());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getName());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getGrade());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getAcademe());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getProfession());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getClasses());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getComName());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getForm());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getPrize());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getTutor());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(TUtil.formatShortDate(datas.get(j - 2).getGetTime()));
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String excel_name = sdf.format(new Date());


        try {
            OutputStream os = new FileOutputStream(file);
            wb.write(os);
            os.close();

               /* String path = request.getSession().getServletContext()
                        .getRealPath("")
                        + File.separator + "excel";
                response.setContentType("application/x-download");
                response.addHeader("Content-Disposition",
                        "attachment;filename=" + excel_name + ".xls");
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.close();*/
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "exportExcel";
    }




    public String stulist() {


        Map session= ActionContext.getContext().getSession();
        String userId=(String)session.get("userId");

        User user1=new User();
        user1.setUserId(userId);
        //List<User> list=userService.findUserByCondition(user1);
        User user2=userService.findUserByID(user1);


        String comName=request.getParameter("comName");

        String tutor=request.getParameter("tutor");

        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");

        Result result1=new Result();
        //查找自己的竞赛成绩
        result1.setSno(user2.getSno());

        if(!TUtil.null2String(comName).equals("")) {
            result1.setComName(comName);
        }

        if(!TUtil.null2String(tutor).equals("")) {
            //result1.
            result1.setTutor(tutor);
        }

        List<Result> list=resultService.findResultByCondition(result1,beginTime,endTime);

        List<Competition> competitionList=competitionService.findCompetitionsNoPage();

        request.setAttribute("resultList", list);

        request.setAttribute("competitionList", competitionList);

        request.setAttribute("beginTime", beginTime);

        request.setAttribute("endTime", endTime);

        request.setAttribute("comName1", comName);

        request.setAttribute("tutor", tutor);

        return "stulist";

    }




    public String tealist() {


        //教师信息
        Map session=ActionContext.getContext().getSession();
        String teaId = (String)session.get("teaId");
        Teacher teacher1=teacherService.findTeacherByID(teaId);


        // String condition=request.getParameter("condition");
        //String value=request.getParameter("value");

        String sno=request.getParameter("sno");
        String name=request.getParameter("name");
        String grade=request.getParameter("grade");

        String academe=request.getParameter("academe");   //null
        //获取专业id
        String proId=request.getParameter("profession");

        String comName=request.getParameter("comName");


        /*指导教师*/
        String tutor=teacher1.getName();
       // String tutor=request.getParameter("tutor");

        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");
        //System.out.println(comName+"      "+category+"         "+level);

        // Result result1=new Result();
        Result result1=new Result();
        if(!TUtil.null2String(sno).equals("")) {
            result1.setSno(sno);
        }
        if(!TUtil.null2String(name).equals("")) {
            result1.setName(name);
        }
        if(!TUtil.null2String(grade).equals("")) {
            result1.setGrade(grade);
        }

        //如果有学院，那么要加载学院下所属的专业
        if(!TUtil.null2String(academe).equals("")) {
            result1.setAcademe(academe);

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
                    result1.setProfession(professionName);
                }
                request.setAttribute("profession", professionName);

            }
        }

        if(!TUtil.null2String(comName).equals("")) {
            result1.setComName(comName);
        }

        if(!TUtil.null2String(tutor).equals("")) {
            //result1.
            result1.setTutor(tutor);
        }


        //获取专业名称
        if(!TUtil.null2String(proId).equals("")) {

            Profession profession1=professionService.findProfessionByID(new Integer(proId));
            String professionName=profession1.getProfessionName();
            //按专业名称查询
            if(!TUtil.null2String(professionName).equals("")) {
                result1.setProfession(professionName);
            }
            request.setAttribute("professionName", professionName);


            //专业下拉列表框取值
            List<Academe> academeList=academeService.findAcademeByCondition(academe);

            if(!academeList.isEmpty()) {
                Academe academe1=academeList.get(0);
                //Integer academeId=academe1.getAcademeId();

                //根据academeId查询专业
                Set<Profession> professionSet=academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }

        }


        //List<Result> list=resultService.
        List<Result> list=resultService.findResultByCondition(result1,beginTime,endTime);
        List<Academe> academeList =academeService.findAcademeByCondition(null);
        List<Competition> competitionList=competitionService.findCompetitionsNoPage();

        request.setAttribute("resultList", list);

        request.setAttribute("academeList", academeList);
        request.setAttribute("competitionList", competitionList);
        // request.setAttribute("condition", condition);
        request.setAttribute("beginTime", beginTime);
        //request.setAttribute("value", value);
        request.setAttribute("endTime", endTime);

        request.setAttribute("sno", sno);
        request.setAttribute("name", name);
        request.setAttribute("grade", grade);
        request.setAttribute("academe", academe);

        request.setAttribute("comName1", comName);

        //request.setAttribute("tutor", tutor);

        return "tealist";

    }









}
