package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.*;
import com.ffcs.xkjs.service.*;
import com.ffcs.xkjs.utils.TUtil;
import com.ffcs.xkjs.utils.ValueUtils;
import com.opensymphony.xwork2.ActionContext;
import jxl.*;
import jxl.read.biff.BiffException;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by tianf221111 on 2016/4/8.
 */

@Controller("enterAction")
@Scope(value="prototype")
public class EnterAction extends BaseAction<Enter> {

    Enter enter = this.getModel();

    @Resource(name = IEnterService.SERVICE_NAME)
    IEnterService enterService;

    @Resource(name = IAcademeService.SERVICE_NAME)
    IAcademeService academeService;

    @Resource(name = IProfessionService.SERVICE_NAME)
    IProfessionService professionService;


    @Resource(name = ICompetitionService.SERVICE_NAME)
    ICompetitionService competitionService;


    @Resource(name= IUserService.SERVICE_NAME)
    IUserService userService;


    public String list() {


        String sno = request.getParameter("sno");
        String trueName = request.getParameter("trueName");
        String grade = request.getParameter("grade");

        String academe = request.getParameter("academe");   //null
        String profession = request.getParameter("profession");
        String comName = request.getParameter("comName");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");

        String tutor = request.getParameter("tutor");


        String auditStatus = request.getParameter("auditStatus");

        //获取专业id
        String proId = request.getParameter("profession");
        //System.out.println(comName+"      "+category+"         "+level);


        Enter enter1 = new Enter();

        if (!TUtil.null2String(auditStatus).equals("")) {
            enter1.setAuditStatus(new Integer(auditStatus));
            request.setAttribute("auditStatus",auditStatus);
        }



        if (!TUtil.null2String(sno).equals("")) {
            enter1.setSno(sno);
        }
        if (!TUtil.null2String(trueName).equals("")) {
            enter1.setTrueName(trueName);
        }
        if (!TUtil.null2String(grade).equals("")) {
            enter1.setGrade(grade);
        }

        //如果有学院，那么要加载学院下所属的专业
        if (!TUtil.null2String(academe).equals("")) {
            enter1.setAcademe(academe);

            //专业下拉列表框的值
            List<Academe> academeList1 = academeService.findAcademeByCondition(academe);

            if (!academeList1.isEmpty()) {
                Academe academe1 = academeList1.get(0);
                //Integer academeId=academe1.getAcademeId();

                //根据academeId查询专业
                Set<Profession> professionSet = academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }

            //获取专业名称
            if (!TUtil.null2String(proId).equals("")) {

                Profession profession1 = professionService.findProfessionByID(new Integer(proId));
                String professionName = profession1.getProfessionName();
                //按专业名称查询
                if (!TUtil.null2String(professionName).equals("")) {
                    enter1.setProfession(professionName);
                }
                request.setAttribute("profession", professionName);

            }
        }
        /*request.setAttribute("professionName", null);*/


        if (!TUtil.null2String(comName).equals("")) {
            enter1.setComName(comName);
        }

        if (!TUtil.null2String(tutor).equals("")) {
            enter1.setTutor(tutor);
        }


        List<Enter> list = enterService.findEnterByCondition(enter1, beginTime, endTime);

        List<Academe> academeList = academeService.findAcademeByCondition(null);
        List<Competition> competitionList = competitionService.findCompetitionsNoPage();
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
        request.setAttribute("tutor", tutor);


        request.setAttribute("proId", proId);

        request.setAttribute("comName1", comName);

        return "list";

    }

    public String add() {
        String currentPage = request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);

        List<Academe> academeList = academeService.findAcademeByCondition(null);
        List<Competition> competitionList = competitionService.findCompetitionsNoPage();

        request.setAttribute("academeList", academeList);
        request.setAttribute("competitionList", competitionList);

        return "add";
    }


    public String edit() {

        // String newsId=request.getParameter("newsId");
        String enterId = request.getParameter("enterId");

        String currentPage = request.getParameter("currentPage");
        if (!TUtil.null2String(enterId).equals("")) {

            // Notice notice1=new Notice();
            Enter enter1 = new Enter();
            enter1.setEnterId(enterId);
            Enter enter2 = enterService.findEnterByID(enter1);
            //Competition competition1=new Competition();
            // competition1.setComId(comId);
            //notice1.setNoticeId(noticeId);
            // Notice notice2=noticeService.findNoticeByID(notice1);
            //Competition competition2=competitionService.findCompetitionByID(competition1);
            request.setAttribute("enter", enter2);

            List<Academe> academeList = academeService.findAcademeByCondition(null);
            List<Competition> competitionList = competitionService.findCompetitionsNoPage();

            request.setAttribute("academeList", academeList);
            request.setAttribute("competitionList", competitionList);

            //获取专业
            List<Academe> academeList1 = academeService.findAcademeByCondition(enter2.getAcademe());
            if (!academeList1.isEmpty()) {
                Academe academe1 = academeList1.get(0);
                //Integer academeId=academe1.getAcademeId();
                //根据academeId查询专业
                Set<Profession> professionSet = academe1.getProfessions();
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
        String mulitId = request.getParameter("mulitId");
        String currentPage = request.getParameter("currentPage");


        System.out.println("del方法---------------------" + mulitId);
        if (mulitId.contains(",")) {
            String[] ids = mulitId.split(",");
            //competitionService.deleteCompetitionByIds(ids);
            enterService.deleteEnterByIds(ids);
            //noticeService.deleteNoticeByIds(ids);
        } else {
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


    public String save() {

        String enterId = request.getParameter("enterId");
        String currentPage = request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if (TUtil.null2String(enterId).equals("")) {
            //noticeService.saveNotice(notice);
            //competitionService.saveCompetition(competition);
            enterService.saveEnter(enter);
        } else {
            // noticeService.update(notice);
            // competitionService.update(competition);
            enterService.update(enter);
        }

        //String textDate = request.getParameter("textDate");
        String list_url = request.getParameter("list_url");
        String add_url = request.getParameter("add_url");

        System.out.println(list_url + "          " + add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request) + "/system/enter_list.do?currentPage=" + currentPage);

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
            Sheet rs = rwb.getSheet(0);
            List<Enter> enterList = new ArrayList<Enter>();
            for (int i = 2; i < rs.getRows()+1; i++) {
                Enter enter2 = new Enter();
				/*Cell fcell=rs.getCell(1,i);
				if(fcell.getType()==CellType.NUMBER){
					NumberCell nc=(NumberCell) fcell;//转换类型
					int areaId=(int) nc.getValue();//获取的值
				    area.setAreaId(areaId);;//将值插入到集合里去
				      System.out.println(areaId);
				}*/


                Cell fCell = rs.getCell(0, i);
                String sno = fCell.getContents();
                enter2.setSno(sno);
                System.out.println(sno);

                Cell fCell1 = rs.getCell(1, i);
                String trueName = fCell1.getContents();
                enter2.setTrueName(trueName);
                System.out.println(trueName);

                Cell fCell2 = rs.getCell(2, i);
                String grade = fCell2.getContents();
                enter2.setGrade(grade);
                System.out.println(grade);

                Cell fCell3 = rs.getCell(3, i);
                String academe = fCell3.getContents();
                enter2.setAcademe(academe);
                System.out.println(academe);

                Cell fCell4 = rs.getCell(4, i);
                String profession = fCell4.getContents();
                enter2.setProfession(profession);
                System.out.println(profession);

                Cell fCell5 = rs.getCell(5, i);
                String classes = fCell5.getContents();
                enter2.setClasses(classes);
                System.out.println(classes);

                Cell fCell6 = rs.getCell(6, i);
                String telephone = fCell6.getContents();
                enter2.setTelephone(telephone);
                System.out.println(telephone);

                Cell fCell7 = rs.getCell(7, i);
                String email = fCell7.getContents();
                enter2.setEmail(email);
                System.out.println(email);

                Cell fCell8 = rs.getCell(8, i);
                String comName = fCell8.getContents();
                enter2.setComName(comName);
                System.out.println(comName);


                //报名时间
                Cell fCell9 = rs.getCell(9, i);
                if (fCell9.getType() == CellType.DATE) {
                    DateCell dateCell = (DateCell) fCell9;
                    Date result = dateCell.getDate();
                    enter2.setEnterDate(result);
                    System.out.println(new SimpleDateFormat("yyyy-MM-dd").format(result));
                    //contactPersonInfo.setContactBirthday(result);
                    //System.out.println("生日："+new SimpleDateFormat("yyyy-MM-dd").format(result));//Thu Jan 10 08:00:00 CST 2013
                }


                //初始状态为未审核
                enter2.setAuditStatus(new Integer(0));

                //加入到List集合中
                enterList.add(enter2);


            }
            // 主体内容生成结束
            // 写入文件
            rwb.close();
            System.out.println(uploadFileName);
            System.out.println(enterList.size());

            //写入数据库
            for (Enter enter3 : enterList) {
                enterService.saveEnter(enter3);
            }

        } catch (BiffException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "importJava";
    }


    public String getProfessionJson() {

        String academeName = request.getParameter("academeName");
        List<Academe> academeList = academeService.findAcademeByCondition(academeName);

        if (!academeList.isEmpty()) {
            Academe academe = academeList.get(0);
            Integer academeId = academe.getAcademeId();
            //List<Profession> professionList=professionService.findProfessionByCondition(academeId.toString());
            //ValueUtils.putValueStack(professionList);

            //根据academeId查询专业
            Set<Profession> professionSet = academe.getProfessions();
            /*for(Profession profession:professionSet) {

            }*/
            ValueUtils.putValueStack(professionSet);
        }


        return "getProfessionJson";

    }

    public String audit() {

        String mulitId = request.getParameter("mulitId");
        String currentPage = request.getParameter("currentPage");

        if (mulitId.contains(",")) {
            String[] ids = mulitId.split(",");
            //competitionService.deleteCompetitionByIds(ids);

            for(String id:ids) {

                Enter enter1 = new Enter();
                enter1.setEnterId(id);
                Enter enter2 = enterService.findEnterByID(enter1);
                enter2.setAuditStatus(new Integer(1));
                enterService.update(enter2);

            }
            //noticeService.deleteNoticeByIds(ids);
        } else {
            //noticeService.deleteNoticeByIds(mulitId);
            // competitionService.deleteCompetitionByIds(mulitId);
            Enter enter1 = new Enter();
            enter1.setEnterId(mulitId);
            Enter enter2 = enterService.findEnterByID(enter1);
            enter2.setAuditStatus(new Integer(1));
            enterService.update(enter2);
        }
		/*for(String id:ids) {
			if(!id.equals("")) {
				ElecText text=new ElecText();
				text.setTextID(id);
				ElecText oldText=elecTextService.findElecTextByID(text);

			}
		}*/
        request.setAttribute("currentPage", currentPage);
        return "audit";

    }


    File file=new File("export.xls");

    public InputStream getInputStream() throws FileNotFoundException{
        return new FileInputStream(file);
    }

    public String exportExcel() {

        String grade = request.getParameter("grade");
        String academe = request.getParameter("academe");
        String professionId = request.getParameter("profession");
        String comName = request.getParameter("comName");



        try {
            grade = new String(grade.getBytes("ISO8859-1"),"UTF-8");
            academe = new String(academe.getBytes("ISO8859-1"),"UTF-8");
            comName = new String(comName.getBytes("ISO8859-1"),"UTF-8");
        }
        catch(Exception e) {
            e.printStackTrace();

        }


        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");

        Enter enter1 = new Enter();

        //文件名称
        String title1 = "";

        if (!TUtil.null2String(grade).equals("")) {
            enter1.setGrade(grade);
            title1 += grade;
        }
        if (!TUtil.null2String(academe).equals("")) {
            enter1.setAcademe(academe);
            title1 += academe;
        }
        /*if (!TUtil.null2String(professionId).equals("")) {
            enter1.setProfession(professionName);
            title1 += profession;
        }*/
        //获取专业名称
        if (!TUtil.null2String(professionId).equals("")) {
            Profession profession1 = professionService.findProfessionByID(new Integer(professionId));
            String professionName = profession1.getProfessionName();

            if (!TUtil.null2String(professionName).equals("")) {
                enter1.setProfession(professionName);
                title1 += professionName;
            }
        }





        if (!TUtil.null2String(comName).equals("")) {
            enter1.setComName(comName);
            title1 += comName;
        }

        title1 += "报名表";


        // List<Enter> list=enterService.findEnterByCondition(enter1,beginTime,endTime);
        List<Enter> datas = enterService.findEnterListByConditionNoPage(enter1, beginTime, endTime);
        // 创建Excel的工作书册 Workbook,对应到一个excel文档
        HSSFWorkbook wb = new HSSFWorkbook();
        // 创建Excel的工作sheet,对应到一个excel文档的tab
        HSSFSheet sheet = wb.createSheet("报名表");
        HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
        List<HSSFClientAnchor> anchor = new ArrayList<HSSFClientAnchor>();
        for (int i = 0; i < datas.size(); i++) {
            anchor.add(new HSSFClientAnchor(0, 0, 1000, 255, (short) 1,
                    2 + i, (short) 1, 2 + i));
        }


        // 设置excel每列宽度
        sheet.setColumnWidth(0, 6000);
        sheet.setColumnWidth(1, 4000);
        sheet.setColumnWidth(2, 8000);
        sheet.setColumnWidth(3, 6000);
        sheet.setColumnWidth(4, 6000);
        sheet.setColumnWidth(5, 6000);
        sheet.setColumnWidth(6, 6000);
        sheet.setColumnWidth(7, 6000);
        sheet.setColumnWidth(8, 6000);
        sheet.setColumnWidth(9, 6000);
        sheet.setColumnWidth(10, 6000);


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
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 11));
        // 给Excel的单元格设置样式和赋值
        cell.setCellStyle(style);
        String title = "报名表";
        Date time1 = null;
        Date time2 = null;
        time1 = TUtil.formatDate(beginTime);
        time2 = TUtil.formatDate(endTime);
        String Time = TUtil.null2String(TUtil.formatShortDate(time1) + " - " + TUtil.formatShortDate(time2));
        cell.setCellValue(title + "(" + Time + ")");

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
        cell.setCellValue("手机");

        cell = row.createCell(7);
        cell.setCellStyle(style2);
        cell.setCellValue("邮箱");

        cell = row.createCell(8);
        cell.setCellStyle(style2);
        cell.setCellValue("竞赛名称");

       /* cell = row.createCell(1);
        cell.setCellStyle(style2);
        cell.setCellValue("参赛形式");*/

        cell = row.createCell(9);
        cell.setCellStyle(style2);
        cell.setCellValue("指导教师");

        cell = row.createCell(10);
        cell.setCellStyle(style2);
        cell.setCellValue("报名时间");

        for (int j = 2; j <= datas.size() + 1; j++) {
            row = sheet.createRow(j);
            // 设置单元格的样式格式
            int i = 0;

            cell = row.createCell(i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getSno());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getTrueName());

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
            cell.setCellValue(datas.get(j - 2).getTelephone());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getEmail());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getComName());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(datas.get(j - 2).getTutor());

            cell = row.createCell(++i);
            cell.setCellStyle(style2);
            cell.setCellValue(TUtil.formatShortDate(datas.get(j - 2).getEnterDate()));
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





    public String stuedit() {

        // String newsId=request.getParameter("newsId");

        /*获取学生信息*/
        Map session= ActionContext.getContext().getSession();
        String userId = (String)session.get("userId");

        //取回原来的密码
        User user1=new User();
        user1.setUserId(userId);
        User user2=userService.findUserByID(user1);

        String currentPage = request.getParameter("currentPage");


           // Enter enter2 = enterService.findEnterByID(enter1);
        Enter enter2=new Enter();
        enter2.setSno(user2.getSno());
        enter2.setTrueName(user2.getUserName());
        enter2.setGrade(user2.getGrade());
        enter2.setAcademe(user2.getAcademe());
        enter2.setProfession(user2.getProfession());
        enter2.setClasses(user2.getClasses());
        enter2.setTelephone(user2.getTelephone());
        enter2.setEmail(user2.getEmail());



        /*获取报名竞赛项目*/
        String comId=request.getParameter("comId");
        Competition competition1=new Competition();
        competition1.setComId(comId);
        Competition competition2=competitionService.findCompetitionByID(competition1);
       String comName= competition2.getComName();
        request.setAttribute("comName1", comName);


            request.setAttribute("enter", enter2);

            List<Academe> academeList = academeService.findAcademeByCondition(null);
            List<Competition> competitionList = competitionService.findCompetitionsNoPage();

            request.setAttribute("academeList", academeList);
            request.setAttribute("competitionList", competitionList);

            //获取专业
            List<Academe> academeList1 = academeService.findAcademeByCondition(enter2.getAcademe());
            if (!academeList1.isEmpty()) {
                Academe academe1 = academeList1.get(0);
                //Integer academeId=academe1.getAcademeId();
                //根据academeId查询专业
                Set<Profession> professionSet = academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }


            request.setAttribute("academe1", enter2.getAcademe());
            request.setAttribute("profession1", enter2.getProfession());





        request.setAttribute("edit", true);

        request.setAttribute("currentPage", currentPage);
        return "stuedit";
    }




    public String stusave() {

        String enterId = request.getParameter("enterId");
        String currentPage = request.getParameter("currentPage");

        if (TUtil.null2String(enterId).equals("")) {

            /*设置报名初始状态为未审核*/
            enter.setAuditStatus(new Integer(0));
            enterService.saveEnter(enter);
        } else {
            // noticeService.update(notice);
            // competitionService.update(competition);
            enterService.update(enter);
        }

        String list_url = request.getParameter("list_url");



        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request) + "/system/competition_stulist.do");

        request.setAttribute("op_title", "保存报名信息成功");



        return "stusave";
    }



    public String stulist() {

        //获取个人信息，
        Map session=ActionContext.getContext().getSession();
        String userId=(String)session.get("userId");
        User user1=new User();
        user1.setUserId(userId);
        User user2=userService.findUserByID(user1);
        String sno=user2.getSno();


        String comName = request.getParameter("comName");
        String beginTime = request.getParameter("beginTime");
        String endTime = request.getParameter("endTime");
        String tutor = request.getParameter("tutor");
        String auditStatus = request.getParameter("auditStatus");

        Enter enter1 = new Enter();

        if (!TUtil.null2String(sno).equals("")) {
            enter1.setSno(sno);
        }


        if (!TUtil.null2String(auditStatus).equals("")) {
            enter1.setAuditStatus(new Integer(auditStatus));
            request.setAttribute("auditStatus",auditStatus);
        }


        if (!TUtil.null2String(comName).equals("")) {
            enter1.setComName(comName);
        }

        if (!TUtil.null2String(tutor).equals("")) {
            enter1.setTutor(tutor);
        }

        List<Enter> list = enterService.findEnterByCondition(enter1, beginTime, endTime);

        request.setAttribute("enterList", list);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime);
        request.setAttribute("tutor", tutor);
        request.setAttribute("comName1", comName);

        return "stulist";

    }






}


