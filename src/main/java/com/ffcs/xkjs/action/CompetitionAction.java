package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Competition;
import com.ffcs.xkjs.service.ICompetitionService;
import com.ffcs.xkjs.utils.TUtil;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by tianf on 2016/4/8.
 */

@Controller("competitionAction")
@Scope(value="prototype")
public class CompetitionAction extends BaseAction<Competition> {

    Competition competition=this.getModel();

    @Resource(name= ICompetitionService.SERVICE_NAME)
    ICompetitionService competitionService;


    public String list() {


       // String condition=request.getParameter("condition");
        //String value=request.getParameter("value");


        String comName=request.getParameter("comName");
        String category=request.getParameter("category");
        String level=request.getParameter("level");


        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");


        System.out.println(comName+"      "+category+"         "+level);
        Competition competition1=new Competition();
       // News news1 = new News();
       /* if(!TUtil.null2String(condition).equals("") && !TUtil.null2String(value).equals("")) {
            if (condition.equals("comName")) {
                competition1.setComName(value);
                //news1.setTitle(value);
            }

            if (condition.equals("content")) {
                news1.setContent(value);
            }
        }*/

       /* request.setAttribute("category", null);
        request.setAttribute("level",null );*/
        if(!TUtil.null2String(comName).equals("")) {
            competition1.setComName(comName);
        }

        if(!TUtil.null2String(category).equals("")) {
            competition1.setCategory(category);
            request.setAttribute("category", category);
        }

        if(!TUtil.null2String(level).equals("")) {
            competition1.setLevel(level);
            request.setAttribute("level",level );
        }

        List<Competition> list=competitionService.findCompetitionByCondition(competition1,beginTime,endTime);
       // List<News> list=newsService.findNewsByCondition(news1,beginTime,endTime);
        /*if(list!=null && list.size()>0){
            for(News news:list){
                System.out.println(text.getTextName()+"    "+text.getTextDate()+"    "+text.getTextRemark());
            }
        }*/
        //ActionContext.getContext().put("textList", list);
        //ServletActionContext.getRequest().setAttribute("textList", list);
        request.setAttribute("competitionList", list);
       // request.setAttribute("condition", condition);
        request.setAttribute("beginTime", beginTime);
        //request.setAttribute("value", value);
        request.setAttribute("endTime", endTime);

        request.setAttribute("comName", comName);




        return "list";

    }

    public String add() {
        String currentPage=request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);
        return "add";
    }

    public String edit() {

        // String newsId=request.getParameter("newsId");
        String comId=request.getParameter("comId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(comId).equals("")) {

           // Notice notice1=new Notice();
            Competition competition1=new Competition();
            competition1.setComId(comId);
            //notice1.setNoticeId(noticeId);
           // Notice notice2=noticeService.findNoticeByID(notice1);
            Competition competition2=competitionService.findCompetitionByID(competition1);
            request.setAttribute("competition",competition2);

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
            competitionService.deleteCompetitionByIds(ids);
            //noticeService.deleteNoticeByIds(ids);
        }
        else{
            //noticeService.deleteNoticeByIds(mulitId);
            competitionService.deleteCompetitionByIds(mulitId);
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

    public String save(){

        //String ID=request.getParameter("textID");
        String comId=request.getParameter("comId");
        String currentPage=request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if (TUtil.null2String(comId).equals("")) {

            if (!TUtil.null2String(upload).equals("")) {
                try {
                    InputStream is = new FileInputStream(upload);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String fileName = sdf.format(new Date());

                    String path = "/upload/" + fileName;
                    //获取文件扩展名
                    int index = uploadFileName.lastIndexOf(".");
                    String extFileName = uploadFileName.substring(index, uploadFileName.length());

                    File destFile = new File(ServletActionContext.getServletContext()
                            .getRealPath(path));
                    OutputStream os = new FileOutputStream(destFile + extFileName);
                    byte[] buffer = new byte[1024];
                    int length = 0;
                    while ((length = is.read(buffer)) > 0) {
                        os.write(buffer, 0, length);
                    }
                    is.close();
                    os.close();
                    System.out.println(destFile);
                    System.out.println(uploadFileName);
                    System.out.println(uploadContentType);
                    competition.setFileName(uploadFileName);
                    competition.setFilePath(path + extFileName);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            competitionService.saveCompetition(competition);
        }


        else {

            if (!TUtil.null2String(upload).equals("")) {
                try {
                    InputStream is = new FileInputStream(upload);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String fileName = sdf.format(new Date());

                    String path = "/upload/" + fileName;
                    //获取文件扩展名
                    int index = uploadFileName.lastIndexOf(".");
                    String extFileName = uploadFileName.substring(index, uploadFileName.length());

                    File destFile = new File(ServletActionContext.getServletContext()
                            .getRealPath(path));
                    OutputStream os = new FileOutputStream(destFile + extFileName);
                    byte[] buffer = new byte[1024];
                    int length = 0;
                    while ((length = is.read(buffer)) > 0) {
                        os.write(buffer, 0, length);
                    }
                    is.close();
                    os.close();
                    System.out.println(destFile);
                    System.out.println(uploadFileName);
                    System.out.println(uploadContentType);
                    competition.setFileName(uploadFileName);
                    competition.setFilePath(path + extFileName);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            if(TUtil.null2String(upload).equals("")) {
                Competition competition1 = new Competition();
                competition1.setComId(comId);
                Competition competition2 = competitionService.findCompetitionByID(competition1);
                String fileName1 = competition2.getFileName();
                String filePath1 = competition2.getFilePath();
                competition.setFileName(fileName1);
                competition.setFilePath(filePath1);
            }

            competitionService.update(competition);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request) + "/system/competition_list.do?currentPage=" + currentPage);

        request.setAttribute("op_title", "保存竞赛项目成功");


        request.setAttribute("add_url", add_url);


        return "save";
    }



    InputStream inputStream1;

    public InputStream getInputStream1() {
        return inputStream1;
    }


    public String download() {

        String comId=request.getParameter("comId");

        Competition competition1=new Competition();
        competition1.setComId(comId);
        Competition competition2=competitionService.findCompetitionByID(competition1);
        String filePath=competition2.getFilePath();


        //Information information1=iInformationService.findInformationByID(infoId);
        //String filePath=information1.getFilePath();
        //文件路径
        String path= ServletActionContext.getServletContext().getRealPath(filePath);
        //文件名称
        //String fileName=information1.getFileName();
        String fileName=competition2.getFileName();

        try{
            //2：使用路径path，查找到对应的文件，转化成InputStream
            inputStream1 = new FileInputStream(new File(path));
            //可以出现中文
            fileName = new String(fileName.getBytes("gbk"),"iso8859-1");
            request.setAttribute("fileName", fileName);
            //与栈顶的InputStream关联
            //elecUser.setInputStream(in);
        } catch( Exception e) {
            e.printStackTrace();
        }

        return "download";
    }











}
