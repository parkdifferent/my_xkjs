package com.ffcs.xkjs.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.ffcs.xkjs.domain.Area;
import com.ffcs.xkjs.domain.ElecText;
import com.ffcs.xkjs.service.IAreaService;
import com.ffcs.xkjs.service.IElecTextService;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.DateFormat;
import jxl.write.DateTime;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


/**
 * Created by tianf on 2016/3/27.
 */
@SuppressWarnings("serial")
@Controller("uploadAction")
@Scope(value="prototype")
public class uploadAction {

    @Resource(name= IElecTextService.SERVICE_NAME)
    IElecTextService elecTextService;

    @Resource(name= IAreaService.SERVICE_NAME)
    IAreaService areaService;

    public String fileTest() throws IOException {

        //FileUtils.copyFile();

        // 上传简历
	/*	if (upload != null) {
			String uuidName = UUID.randomUUID().toString();
			String path = "/upload/" + uuidName;
			File destFile = new File(ServletActionContext.getServletContext()
					.getRealPath(path));
			FileUtils.copyFile(upload, destFile);


			// 接收员工数据
			// 在user 保存 uuid文件路径 和 真实文件名
			//user.setPath(path);
			//user.setFilename(uploadFileName);
			System.out.println(path);
			System.out.println(uploadFileName);
		}

		//UserService userService = new UserService();
		//userService.add(user);

		//return "addSUCCESS";
*/
        InputStream is =new FileInputStream(upload);
        String uploadPath=ServletActionContext.getServletContext().getRealPath("/upload");
        File toFile=new File(uploadPath,this.getUploadFileName());
        OutputStream os=new FileOutputStream(toFile);
        byte[] buffer=new byte[1024];
        int length=0;
        while((length=is.read(buffer))>0) {
            os.write(buffer,0,length);
        }
        is.close();
        os.close();

        System.out.println(uploadPath);
        System.out.println(uploadFileName);

        return "fileTest";
    }


    private File upload;
    private String uploadContentType;
    private String uploadFileName; // 真实文件名


    //方案1
	/*InputStream inputStream=ServletActionContext.getServletContext().getResourceAsStream("/upload/test.xls");*/
    public String downloadFile() throws Exception {
        return "success";

    }

    //方案1
	/*public InputStream getInputStream() throws Exception{
		return inputStream;
	}*/


	/*excel to java*/

    File file=new File("elecText.xls");

    public InputStream getInputStream() throws FileNotFoundException{
        return new FileInputStream(file);
    }


    public String exportExcel() throws Exception {

        ElecText elecText=new ElecText();
        //List<ElecText> elecTextList=elecTextService.findTextListByCondition(elecText, null, null);
        List<ElecText> elecTextList=elecTextService.findCollectionByConditionNoPage(elecText, null, null);
        //2.文件输出流
        OutputStream os=new FileOutputStream(file);
        WritableWorkbook wwb=Workbook.createWorkbook(os);
        //创建工作表
        WritableSheet ws=wwb.createSheet("elecTextInfo", 0);
        //Label

        Label label1=new Label(0,0,"textID");
        Label label2=new Label(1,0,"textName");
        Label label3=new Label(2,0,"textDate");
        Label label4=new Label(3,0,"textRemark");

        ws.addCell(label1);
        ws.addCell(label2);
        ws.addCell(label3);
        ws.addCell(label4);
        DateFormat df=new DateFormat("yyyy-MM-dd");
        WritableCellFormat wcf=new WritableCellFormat(df);
        for(int i=0;i<elecTextList.size();i++) {
            ElecText elecText1=elecTextList.get(i);

            Label textID=new Label(0,i+1,elecText1.getTextID());
            Label textName=new Label(1,i+1,elecText1.getTextName());
            DateTime textDate=new DateTime(2,i+1,elecText1.getTextDate(),wcf);
            Label textRemark=new Label(3,i+1,elecText1.getTextRemark());

            ws.addCell(textID);
            ws.addCell(textName);
            ws.addCell(textDate);
            ws.addCell(textRemark);

        }
        wwb.write();
        wwb.close();
        return "exportExcelSucc";
    }

	/*private File upload;
	private String uploadContentType;
	private String uploadFileName; // 真实文件名
*/

	/*public String importJava() {

		try {

			//1.构建Workbook
			Workbook rwb = Workbook.getWorkbook(upload);

			//2.获得工作表
			Sheet rs=rwb.getSheet(0);
			List<ElecText> elecTextList=new ArrayList<ElecText>();
			for(int i=1;i<rs.getRows();i++) {
				ElecText elecText=new ElecText();

				Cell fcell1=rs.getCell(1,i);
				String textName =fcell1.getContents();
				elecText.setTextName(textName);

				Cell fcell2=rs.getCell(2,i);
				if(fcell2.getType()==CellType.DATE){
					DateCell dateCell=(DateCell) fcell2;
					Date result= dateCell.getDate();
					elecText.setTextDate(result);
				    //System.out.println("生日："+new SimpleDateFormat("yyyy-MM-dd").format(result));//Thu Jan 10 08:00:00 CST 2013



				}
				Cell fcell3=rs.getCell(3,i);
					String textRemark =fcell3.getContents();
					elecText.setTextRemark(textRemark);
				//加入到List集合中
				elecTextList.add(elecText);


			}
			// 主体内容生成结束
		    // 写入文件
			rwb.close();
			System.out.println(uploadFileName);

			for(ElecText elecText:elecTextList) {
				elecTextService.saveElecText(elecText);
				System.out.println(elecText.getTextID());
				System.out.println(elecText.getTextName());
				System.out.println(elecText.getTextDate());
				System.out.println(elecText.getTextRemark());
			}
		}
			catch (BiffException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}


//			for(int i=0;i<rs.getRows();i++){
//				ContactPersonInfo contactPersonInfo=new ContactPersonInfo();
//				for(int j=0;j<rs.getColumns();j++){
//					Cell fcell=rs.getCell(j,i);
//					System.out.print(fcell.getContents()+"\t");
//				}
//			System.out.println();

		return "excelToJAVA";


	}*/


    public String importJava() {

        try {

            //1.构建Workbook
            Workbook rwb = Workbook.getWorkbook(upload);

            //2.获得工作表
            Sheet rs=rwb.getSheet(0);
            List<Area> areaList=new ArrayList<Area>();
            for(int i=0;i<rs.getRows();i++) {
                Area area=new Area();
				/*Cell fcell=rs.getCell(1,i);
				if(fcell.getType()==CellType.NUMBER){
					NumberCell nc=(NumberCell) fcell;//转换类型
					int areaId=(int) nc.getValue();//获取的值
				    area.setAreaId(areaId);;//将值插入到集合里去
				      System.out.println(areaId);
				}*/


                Cell fcell=rs.getCell(1,i);
                String areaId=fcell.getContents();
                area.setAreaId(new Integer(areaId.trim()));
                System.out.println(areaId.trim());


                Cell fcell1=rs.getCell(2,i);
                String name =fcell1.getContents();
                area.setName(name.trim());
                System.out.println(name.trim());
                //加入到List集合中
                areaList.add(area);


            }
            // 主体内容生成结束
            // 写入文件
            rwb.close();
            System.out.println(uploadFileName);
            System.out.println(areaList.size());

			/*for(Area area:areaList) {
				areaService.saveArea(area);
			}*/


            for(Area area:areaList) {
                int areaId=area.getAreaId();
                String name=area.getName();

                if(areaId % 10000==0) {
                    area.setFullName(name);
                    area.setParentId(areaId);
                    area.setDeep(1);
                    area.setSort(1);
                    //area.setAreaId(areaId);
                    areaService.saveArea(area);
                    //areaService.update(area);
                }
                else {
                    if(areaId % 100==0) {
                        int parentId=areaId/10000*10000;
                        //Area parentArea=areaService.findAreaByID(parentId);
                        //Area parentArea=  areaService.findCollectionByConditionNoPage(areaId);
                        List<Area> list=areaService.findCollectionByConditionNoPage(parentId);
                        Area parentArea=null;
                        if(list!=null && list.size()>0) {
                            parentArea=list.get(0);
                        }

                        if(parentArea!=null) {
                            area.setFullName(parentArea.getName()+area.getName());
                            area.setParentId(parentId);
                            area.setDeep(2);
                            area.setSort(2);
                            area.setAreaId(areaId);
                            areaService.saveArea(area);
                            //areaService.update(area);
                        }

                        else {
                            System.out.println("2级："+areaId);
                        }


                    }

                    else {
                        int parentId1=areaId/10000*10000;
                        //Area parentArea1=areaService.findAreaByID(parentId1);
                        List<Area> list=areaService.findCollectionByConditionNoPage(parentId1);
                        Area parentArea1=null;
                        if(list!=null && list.size()>0) {
                            parentArea1=list.get(0);
                        }

                        int parentId2=areaId/100*100;
                        //Area parentArea2=areaService.findAreaByID(parentId2);
                        //Area parentArea2= (Area) areaService.findCollectionByConditionNoPage(areaId);

                        List<Area> list1=areaService.findCollectionByConditionNoPage(parentId2);
                        Area parentArea2=null;
                        if(list1!=null && list1.size()>0) {
                            parentArea2=list1.get(0);
                        }

                        if( parentArea1!=null && parentArea2!=null) {
                            area.setFullName(parentArea1.getName()+parentArea2.getName()+area.getName());
                            //area.setFullName(parentArea2.getFullName()+area.getName());
                            area.setParentId(parentId2);
                            area.setDeep(3);
                            area.setSort(3);
                            //area.setAreaId(areaId);
                            areaService.saveArea(area);
                            //areaService.update(area);
                        }
                        else {
                            System.out.println("3级："+areaId);
                        }

                    }
                }
            }





			/*for(Area area:areaList) {
				elecTextService.saveElecText(elecText);
				System.out.println(elecText.getTextID());
				System.out.println(elecText.getTextName());
				System.out.println(elecText.getTextDate());
				System.out.println(elecText.getTextRemark());
			}*/
        }
        catch (BiffException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


//			for(int i=0;i<rs.getRows();i++){
//				ContactPersonInfo contactPersonInfo=new ContactPersonInfo();
//				for(int j=0;j<rs.getColumns();j++){
//					Cell fcell=rs.getCell(j,i);
//					System.out.print(fcell.getContents()+"\t");
//				}
//			System.out.println();

        return "excelToJAVA";


    }



    public void setUpload(File upload) {
        this.upload = upload;
    }

    public void setUploadContentType(String uploadContentType) {
        this.uploadContentType = uploadContentType;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public File getUpload() {
        return upload;
    }

    public String getUploadContentType() {
        return uploadContentType;
    }

    public String getUploadFileName() {
        return uploadFileName;
    }

}

