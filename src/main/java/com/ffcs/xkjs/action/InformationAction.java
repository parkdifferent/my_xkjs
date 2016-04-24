package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Information;
import com.ffcs.xkjs.service.IInformationService;
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
 * Created by tianf on 2016/4/22.
 */


@Controller("informationAction")
@Scope(value="prototype")
public class InformationAction extends BaseAction<Information> {

    Information information=this.getModel();

    @Resource(name = IInformationService.SERVICE_NAME)
    IInformationService iInformationService;



    public String list() {


        //fileName
        String fileName=request.getParameter("fileName");

        Information information1=new Information();

        if(!TUtil.null2String(fileName).equals("")) {
            information1.setFileName(fileName);
            request.setAttribute("fileName", fileName);
        }

        List<Information> list=iInformationService.findInformationByCondition(information1);
        request.setAttribute("informationList",list);
        return "list";
    }


    public String add() {
        String currentPage = request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);

        request.setAttribute("description",null);
        return "add";
    }

    public String edit() {

        // String newsId=request.getParameter("newsId");
        String infoId = request.getParameter("infoId");

        String currentPage = request.getParameter("currentPage");
        if (!TUtil.null2String(infoId).equals("")) {

            Information information2 = iInformationService.findInformationByID(infoId);

            request.setAttribute("information", information2);

            //编辑，初始化kindeditor的显示值
            request.setAttribute("description",information2.getDescription());
        }

        request.setAttribute("edit", true);

        request.setAttribute("currentPage", currentPage);
        return "edit";


    }


    public String del() {
        String mulitId = request.getParameter("mulitId");
        String currentPage = request.getParameter("currentPage");


        System.out.println("del方法---------------------" + mulitId);
        if (mulitId.contains(",")) {
            String[] ids = mulitId.split(",");

            iInformationService.deleteInformationByIds(ids);

        } else {

            iInformationService.deleteInformationByIds(mulitId);
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

    public String save() {

        String infoId = request.getParameter("infoId");
        String currentPage = request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if (TUtil.null2String(infoId).equals("")) {

            if(!TUtil.null2String(upload).equals("")) {
                try {
                    InputStream is =new FileInputStream(upload);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String fileName = sdf.format(new Date());

                    String path= "/upload/" + fileName;
                    //获取文件扩展名
                    int index=uploadFileName.lastIndexOf(".");
                    String extFileName=uploadFileName.substring(index,uploadFileName.length());

                    File destFile = new File(ServletActionContext.getServletContext()
                            .getRealPath(path));
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
                    information.setFileName(uploadFileName);


                    information.setFilePath(path+extFileName);
                }catch (Exception e)  {
                    e.printStackTrace();
                }
            }

            iInformationService.saveInformation(information);


        } else {

            if(!TUtil.null2String(upload).equals("")) {
                try {
                    InputStream is =new FileInputStream(upload);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String fileName = sdf.format(new Date());

                    String path= "/upload/" + fileName;
                    //获取文件扩展名
                    int index=uploadFileName.lastIndexOf(".");
                    String extFileName=uploadFileName.substring(index,uploadFileName.length());

                    File destFile = new File(ServletActionContext.getServletContext()
                            .getRealPath(path));
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
                    information.setFileName(uploadFileName);
                    information.setFilePath(path+extFileName);


                }catch (Exception e)  {
                    e.printStackTrace();
                }
            }


           // infoId

            if(TUtil.null2String(upload).equals("")) {
                Information information1=iInformationService.findInformationByID(infoId);
                String fileName1=information1.getFileName();
                String filePath1=information1.getFilePath();
                information.setFileName(fileName1);
                information.setFilePath(filePath1);
            }


            iInformationService.update(information);
        }

        //String textDate = request.getParameter("textDate");
        String list_url = request.getParameter("list_url");
        String add_url = request.getParameter("add_url");

        System.out.println(list_url + "          " + add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request) + "/system/information_list.do?currentPage=" + currentPage);
        request.setAttribute("op_title", "竞赛资料信息保存成功");
        request.setAttribute("add_url", add_url);
        return "save";
    }



    InputStream inputStream;

    public InputStream getInputStream() {
        return inputStream;
    }

   /* public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }*/

    public String download() {

        String infoId=request.getParameter("infoId");
        Information information1=iInformationService.findInformationByID(infoId);
        String filePath=information1.getFilePath();
        //文件路径
        String path=ServletActionContext.getServletContext().getRealPath(filePath);
        //文件名称
        String fileName=information1.getFileName();

        try{
            //2：使用路径path，查找到对应的文件，转化成InputStream
            inputStream = new FileInputStream(new File(path));
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
