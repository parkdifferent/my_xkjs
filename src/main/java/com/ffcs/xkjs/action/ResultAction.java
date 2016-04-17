package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Academe;
import com.ffcs.xkjs.domain.Competition;
import com.ffcs.xkjs.domain.Profession;
import com.ffcs.xkjs.domain.Result;
import com.ffcs.xkjs.service.IAcademeService;
import com.ffcs.xkjs.service.ICompetitionService;
import com.ffcs.xkjs.service.IProfessionService;
import com.ffcs.xkjs.service.IResultService;
import com.ffcs.xkjs.utils.TUtil;
import com.ffcs.xkjs.utils.ValueUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

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
            resultService.saveResult(result);
        }


        else {
            // noticeService.update(notice);
            // competitionService.update(competition);
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






}
