package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Academe;
import com.ffcs.xkjs.domain.Teacher;
import com.ffcs.xkjs.service.IAcademeService;
import com.ffcs.xkjs.service.ITeacherService;
import com.ffcs.xkjs.utils.MD5Util;
import com.ffcs.xkjs.utils.TUtil;
import com.opensymphony.xwork2.ActionContext;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by tianf on 2016/4/26.
 */

@Controller("teacherAction")
@Scope(value="prototype")
public class TeacherAction extends BaseAction<Teacher> {

    Teacher teacher=this.getModel();

    @Resource(name= ITeacherService.SERVICE_NAME)
    ITeacherService teacherService;


    @Resource(name = IAcademeService.SERVICE_NAME)
    IAcademeService academeService;


    public String list() {


        //String condition=request.getParameter("condition");
        //String value=request.getParameter("value");

        String tno=request.getParameter("tno");
        String name=request.getParameter("name");

        String academe=request.getParameter("academe");
        String rank=request.getParameter("rank");

        Teacher teacher1=new Teacher();

        if(!TUtil.null2String(tno).equals("")) {
            teacher1.setTno(tno);
            request.setAttribute("tno", tno);
        }

        if(!TUtil.null2String(name).equals("")) {
            teacher1.setName(name);
            request.setAttribute("name", name);
        }

        if(!TUtil.null2String(academe).equals("")) {
            teacher1.setAcademe(academe);
            request.setAttribute("academe", academe);
        }
        if(!TUtil.null2String(rank).equals("")) {
            teacher1.setRank(rank);
            request.setAttribute("rank", rank);
        }


        List<Teacher> list=teacherService.findTeacherByCondition(teacher1);

        request.setAttribute("teacherList", list);

        List<Academe> academeList = academeService.findAcademeByCondition(null);
        request.setAttribute("academeList", academeList);

        return "list";

    }


    public String add() {
        String currentPage=request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);

        //request.setAttribute("content",null);

        List<Academe> academeList = academeService.findAcademeByCondition(null);
        request.setAttribute("academeList", academeList);
        return "add";
    }

    public String edit() {

        // String newsId=request.getParameter("newsId");
        String teaId=request.getParameter("teaId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(teaId).equals("")) {

            Teacher teacher2=teacherService.findTeacherByID(teaId);

            request.setAttribute("teacher",teacher2);
            request.setAttribute("academe1", teacher2.getAcademe());

            List<Academe> academeList = academeService.findAcademeByCondition(null);
            request.setAttribute("academeList", academeList);


            //编辑，初始化kindeditor的显示值
           // request.setAttribute("content",notice2.getContent());

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
            teacherService.deleteTeacherByIds(ids);
        }
        else{
            teacherService.deleteTeacherByIds(mulitId);
        }

        request.setAttribute("currentPage", currentPage);
        return "del";
    }


    public String save(){

        //String content=request.getParameter("content");
        String currentPage=request.getParameter("currentPage");

        String teaId=teacher.getTeaId();

        if(TUtil.null2String(teaId).equals("")) {


            //设置初始密码
            //teacher.setPassword(teacher.getTno());
            teacher.setPassword(MD5Util.getMD5String(teacher.getTno()).toUpperCase());


            //设置角色
            teacher.setRole("teacher");


            teacherService.saveTeacher(teacher);
        }

        else {
            Teacher teacher1=teacherService.findTeacherByID(teaId);

            //找回初始密码
            String password=teacher1.getPassword();
                //设置初始密码
                teacher.setPassword(password);
                //设置角色
                teacher.setRole("teacher");
                teacherService.update(teacher);




            //teacherService.update(teacher);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request)+"/system/teacher_list.do?currentPage="+currentPage);
        request.setAttribute("op_title", "保存教师信息成功");
        request.setAttribute("add_url", add_url);

        return "save";
    }


    public String importExcel() {


        return "importExcel";

    }

    private File upload;
    private String uploadContentType;
    private String uploadFileName; // 真实文件名

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
            Sheet rs = rwb.getSheet(0);
            List<Teacher> teacherList = new ArrayList<Teacher>();
            for (int i = 2; i < rs.getRows(); i++) {
                Teacher teacher2 = new Teacher();
				/*Cell fcell=rs.getCell(1,i);
				if(fcell.getType()==CellType.NUMBER){
					NumberCell nc=(NumberCell) fcell;//转换类型
					int areaId=(int) nc.getValue();//获取的值
				    area.setAreaId(areaId);;//将值插入到集合里去
				      System.out.println(areaId);
				}*/


                Cell fCell = rs.getCell(0, i);
                String tno = fCell.getContents();
                teacher2.setTno(tno);
                System.out.println(tno);

                Cell fCell1 = rs.getCell(1, i);
                String name = fCell1.getContents();
                teacher2.setName(name);
                System.out.println(name);

                Cell fCell2 = rs.getCell(2, i);
                String academe = fCell2.getContents();
                teacher2.setAcademe(academe);
                System.out.println(academe);

                Cell fCell3 = rs.getCell(3, i);
                String education = fCell3.getContents();
                teacher2.setEducation(education);
                System.out.println(education);

                Cell fCell4 = rs.getCell(4, i);
                String rank = fCell4.getContents();
                teacher2.setRank(rank);
                System.out.println(rank);

                Cell fCell5 = rs.getCell(5, i);
                String  research= fCell5.getContents();
               teacher2.setResearch(research);
                System.out.println(research);

                Cell fCell6 = rs.getCell(6, i);
                String brief = fCell6.getContents();
                teacher2.setBrief(brief);
                System.out.println(brief);

                Cell fCell7 = rs.getCell(7, i);
                String email = fCell7.getContents();
                teacher2.setEmail(email);
                System.out.println(email);


                //设置初始密码
                teacher2.setPassword(MD5Util.getMD5String(tno).toUpperCase());
                //设置角色
                teacher2.setRole("teacher");

                //加入到List集合中
                teacherList.add(teacher2);


            }
            // 主体内容生成结束
            // 写入文件
            rwb.close();
            System.out.println(uploadFileName);
            System.out.println(teacherList.size());

            //写入数据库
            for (Teacher teacher3 : teacherList) {
                teacherService.saveTeacher(teacher3);
            }

        } catch (BiffException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "importJava";
    }




    public String tealist() {

        Map session= ActionContext.getContext().getSession();
        String teaId=(String)session.get("teaId");
        Teacher teacher1=new Teacher();
        teacher1.setTeaId(teaId);
        List<Teacher> list=teacherService.findTeacherByCondition(teacher1);
        request.setAttribute("teacherList", list);

        return "tealist";

    }


    public String teaedit() {

        // String newsId=request.getParameter("newsId");
        String teaId=request.getParameter("teaId");

        if(!TUtil.null2String(teaId).equals("")) {

            Teacher teacher2=teacherService.findTeacherByID(teaId);

            request.setAttribute("teacher",teacher2);
            request.setAttribute("academe1", teacher2.getAcademe());

            List<Academe> academeList = academeService.findAcademeByCondition(null);
            request.setAttribute("academeList", academeList);



            //编辑，初始化kindeditor的显示值
            // request.setAttribute("content",notice2.getContent());

        }

        request.setAttribute("edit", true);



        return "teaedit";
    }


    public String teasave(){

        Map session=ActionContext.getContext().getSession();
        String teaId = (String)session.get("teaId");
        Teacher teacher1=teacherService.findTeacherByID(teaId);

        //找回初始密码
        String password=teacher1.getPassword();

        if(!TUtil.null2String(teaId).equals("")) {

            //设置初始密码
            teacher.setPassword(password);
            //设置角色
            teacher.setRole("teacher");


            teacherService.update(teacher);
        }

        String list_url=request.getParameter("list_url");

        request.setAttribute("list_url", TUtil.getURL(request)+"/system/teacher_tealist.do");
        request.setAttribute("op_title", "保存教师信息成功");


        return "teasave";
    }


    /*学生登陆*/

    public String stulist() {

        String tno=request.getParameter("tno");
        String name=request.getParameter("name");

        String academe=request.getParameter("academe");
        String rank=request.getParameter("rank");

        Teacher teacher1=new Teacher();

        if(!TUtil.null2String(tno).equals("")) {
            teacher1.setTno(tno);
            request.setAttribute("tno", tno);
        }

        if(!TUtil.null2String(name).equals("")) {
            teacher1.setName(name);
            request.setAttribute("name", name);
        }

        if(!TUtil.null2String(academe).equals("")) {
            teacher1.setAcademe(academe);
            request.setAttribute("academe", academe);
        }
        if(!TUtil.null2String(rank).equals("")) {
            teacher1.setRank(rank);
            request.setAttribute("rank", rank);
        }


        List<Teacher> list=teacherService.findTeacherByCondition(teacher1);

        request.setAttribute("teacherList", list);

        List<Academe> academeList = academeService.findAcademeByCondition(null);
        request.setAttribute("academeList", academeList);

        return "stulist";

    }


    public String stuedit() {

        // String newsId=request.getParameter("newsId");
        String teaId=request.getParameter("teaId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(teaId).equals("")) {

            Teacher teacher2=teacherService.findTeacherByID(teaId);

            request.setAttribute("teacher",teacher2);
            request.setAttribute("academe1", teacher2.getAcademe());

            List<Academe> academeList = academeService.findAcademeByCondition(null);
            request.setAttribute("academeList", academeList);


            //编辑，初始化kindeditor的显示值
            // request.setAttribute("content",notice2.getContent());

        }

        request.setAttribute("edit", true);

        //ValueStack vs=ActionContext.getContext().getValueStack();
        //vs.set("edit", true);
        request.setAttribute("currentPage", currentPage);



        return "stuedit";
    }
























}
