package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Notice;
import com.ffcs.xkjs.service.INoticeService;
import com.ffcs.xkjs.utils.TUtil;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by tianf on 2016/4/4.
 */

@Controller("noticeAction")
@Scope(value="prototype")
public class NoticeAction extends BaseAction<Notice>{

    Notice notice=this.getModel();

    @Resource(name= INoticeService.SERVICE_NAME)
    INoticeService noticeService;




    public String list() {


        //String condition=request.getParameter("condition");
        //String value=request.getParameter("value");

        String title=request.getParameter("title");
        String content=request.getParameter("content");

        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");


        //System.out.println(condition+"      "+value);
        Notice notice1=new Notice();
        /*if(!TUtil.null2String(condition).equals("") && !TUtil.null2String(value).equals("")) {
            if (condition.equals("title")) {
                notice1.setTitle(value);
            }

            if (condition.equals("content")) {
                notice1.setContent(value);
            }
        }
*/
        if(!TUtil.null2String(title).equals("")) {
            notice1.setTitle(title);
            request.setAttribute("title", title);
        }

        if(!TUtil.null2String(content).equals("")) {
            notice1.setContent(content);
            request.setAttribute("content", content);
        }


        List<Notice> list=noticeService.findNoticeByCondition(notice1,beginTime,endTime);
        /*if(list!=null && list.size()>0){
            for(News news:list){
                System.out.println(text.getTextName()+"    "+text.getTextDate()+"    "+text.getTextRemark());
            }
        }*/
        //ActionContext.getContext().put("textList", list);
        //ServletActionContext.getRequest().setAttribute("textList", list);
        request.setAttribute("noticeList", list);
        //request.setAttribute("condition", condition);
        request.setAttribute("beginTime", beginTime);
        //request.setAttribute("value", value);
        request.setAttribute("endTime", endTime);
        return "list";

    }

    public String add() {
        String currentPage=request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);

        request.setAttribute("content",null);
        return "add";
    }

    public String edit() {

       // String newsId=request.getParameter("newsId");
        String noticeId=request.getParameter("noticeId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(noticeId).equals("")) {

            Notice notice1=new Notice();
            notice1.setNoticeId(noticeId);
            Notice notice2=noticeService.findNoticeByID(notice1);
            request.setAttribute("notice",notice2);

            //编辑，初始化kindeditor的显示值
            request.setAttribute("content",notice2.getContent());

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
            noticeService.deleteNoticeByIds(ids);
        }
        else{
            noticeService.deleteNoticeByIds(mulitId);
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

    public String save() throws IOException{

        //String ID=request.getParameter("textID");
        String noticeId=request.getParameter("noticeId");
        String currentPage=request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if(TUtil.null2String(noticeId).equals("")) {

            if(!TUtil.null2String(upload).equals("")) {

                try {
                    InputStream is =new FileInputStream(upload);
                    //获取文件扩展名
                    int index=uploadFileName.lastIndexOf(".");
                    String extFileName=uploadFileName.substring(index,uploadFileName.length());
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String fileName = sdf.format(new Date());

                    String path= "/upload/" + fileName;

                    File destFile = new File(ServletActionContext.getServletContext()
                            .getRealPath(path));

                    // File destFile = new File(ServletActionContext.getServletContext()
                    // .getRealPath("/")+"upload/"+fileName+uploadFileName.substring(uploadFileName.lastIndexOf(".")));

               /* if(!destFile.exists()){
                    destFile.mkdirs();
                }*/
                    //FileUtils.copyFile(upload, destFile);
                    //File toFile=new File(uploadPath,this.getUploadFileName());
                    OutputStream os=new FileOutputStream(destFile+extFileName);
                    byte[] buffer=new byte[1024];
                    int length=0;
                    while((length=is.read(buffer))>0) {
                        os.write(buffer,0,length);
                    }
                    is.close();
                    os.close();
                    System.out.println(destFile);
                    System.out.println(uploadFileName);
                    System.out.println(uploadContentType);
                    notice.setFileName(uploadFileName);
                    notice.setFilePath(path+extFileName);
                    // notice.setFilePath(destFile);

                } catch (Exception e) {
                    e.printStackTrace();

                }
            }

            noticeService.saveNotice(notice);
        }
        else {

            if(!TUtil.null2String(upload).equals("")) {
                try {
                    InputStream is =new FileInputStream(upload);
                    //获取文件扩展名
                    int index=uploadFileName.lastIndexOf(".");
                    String extFileName=uploadFileName.substring(index,uploadFileName.length());
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String fileName = sdf.format(new Date());
                    String path= "/upload/" + fileName;
                    File destFile = new File(ServletActionContext.getServletContext()
                            .getRealPath(path));

                    // File destFile = new File(ServletActionContext.getServletContext()
                    // .getRealPath("/")+"upload/"+fileName+uploadFileName.substring(uploadFileName.lastIndexOf(".")));

               /* if(!destFile.exists()){
                    destFile.mkdirs();
                }*/
                    //FileUtils.copyFile(upload, destFile);
                    //File toFile=new File(uploadPath,this.getUploadFileName());
                    OutputStream os=new FileOutputStream(destFile+extFileName);
                    byte[] buffer=new byte[1024];
                    int length=0;
                    while((length=is.read(buffer))>0) {
                        os.write(buffer,0,length);
                    }
                    is.close();
                    os.close();

                    System.out.println(destFile);
                    System.out.println(uploadFileName);
                    System.out.println(uploadContentType);
                    notice.setFileName(uploadFileName);
                    notice.setFilePath(path+extFileName);

                }catch (Exception e) {
                    e.printStackTrace();

                }
            }

            if(TUtil.null2String(upload).equals("")) {
                Notice notice1 = new Notice();
                notice1.setNoticeId(noticeId);
                Notice notice2 = noticeService.findNoticeByID(notice1);
                String fileName1 = notice2.getFileName();
                String filePath1 = notice2.getFilePath();
                notice.setFileName(fileName1);
                notice.setFilePath(filePath1);
            }

            noticeService.update(notice);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");
        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request) + "/system/notice_list.do?currentPage=" + currentPage);
        request.setAttribute("op_title", "保存竞赛通知成功");
        request.setAttribute("add_url", add_url);

        return "save";
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



    InputStream inputStream1;

    public InputStream getInputStream1() {
        return inputStream1;
    }

    public String download() {

        String noticeId=request.getParameter("noticeId");

        Notice notice1=new Notice();
        notice1.setNoticeId(noticeId);
        Notice notice2=noticeService.findNoticeByID(notice1);
        String filePath=notice2.getFilePath();


        //Information information1=iInformationService.findInformationByID(infoId);
        //String filePath=information1.getFilePath();
        //文件路径
        String path=ServletActionContext.getServletContext().getRealPath(filePath);
        //文件名称
        //String fileName=information1.getFileName();
        String fileName=notice2.getFileName();

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





    public String stulist() {

        String title=request.getParameter("title");
        String content=request.getParameter("content");

        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");



        Notice notice1=new Notice();

        if(!TUtil.null2String(title).equals("")) {
            notice1.setTitle(title);
            request.setAttribute("title", title);
        }

        if(!TUtil.null2String(content).equals("")) {
            notice1.setContent(content);
            request.setAttribute("content", content);
        }


        List<Notice> list=noticeService.findNoticeByCondition(notice1,beginTime,endTime);
        request.setAttribute("noticeList", list);
        request.setAttribute("beginTime", beginTime);
        request.setAttribute("endTime", endTime);
        return "stulist";

    }



    public String stuedit() {

        // String newsId=request.getParameter("newsId");
        String noticeId=request.getParameter("noticeId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(noticeId).equals("")) {

            Notice notice1=new Notice();
            notice1.setNoticeId(noticeId);
            Notice notice2=noticeService.findNoticeByID(notice1);
            request.setAttribute("notice",notice2);

            //编辑，初始化kindeditor的显示值
            request.setAttribute("content",notice2.getContent());
        }

        request.setAttribute("edit", true);
        //ValueStack vs=ActionContext.getContext().getValueStack();
        //vs.set("edit", true);
        request.setAttribute("currentPage", currentPage);
        return "stuedit";
    }









}
