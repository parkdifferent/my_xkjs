package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Competition;
import com.ffcs.xkjs.service.ICompetitionService;
import com.ffcs.xkjs.utils.TUtil;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
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


    public String save(){

        //String ID=request.getParameter("textID");
        String comId=request.getParameter("comId");
        String currentPage=request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if(TUtil.null2String(comId).equals("")) {
            //noticeService.saveNotice(notice);
            competitionService.saveCompetition(competition);
        }


        else {
           // noticeService.update(notice);
            competitionService.update(competition);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request)+"/system/competition_list.do?currentPage="+currentPage);

        request.setAttribute("op_title", "保存竞赛项目成功");


        request.setAttribute("add_url", add_url);


        return "save";
    }











}
