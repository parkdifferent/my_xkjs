package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Academe;
import com.ffcs.xkjs.domain.Profession;
import com.ffcs.xkjs.domain.User;
import com.ffcs.xkjs.service.IAcademeService;
import com.ffcs.xkjs.service.IProfessionService;
import com.ffcs.xkjs.service.IUserService;
import com.ffcs.xkjs.utils.MD5Util;
import com.ffcs.xkjs.utils.TUtil;
import com.ffcs.xkjs.utils.ValueUtils;
import com.opensymphony.xwork2.ActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.jws.soap.SOAPBinding;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by tianf on 2016/4/18.
 */

@Controller("userAction")
@Scope(value="prototype")
public class UserAction extends BaseAction<User>{
    User user=this.getModel();

    private String vcode;

    public String getVcode() {
        return vcode;
    }

    public void setVcode(String vcode) {
        this.vcode = vcode;
    }

    @Resource(name= IUserService.SERVICE_NAME)
    IUserService userService;

    @Resource(name= IAcademeService.SERVICE_NAME)
    IAcademeService academeService;

    @Resource(name= IProfessionService.SERVICE_NAME)
    IProfessionService professionService;


    /*public String login() throws Exception {
        Map session= ActionContext.getContext().getSession();
        //获取验证码
        String code=(String)session.get("code");
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        //判断验证码输入是否正确
        if(code.equals(TUtil.null2String(vcode))) {
            this.addActionError("验证码输入不正确！");
            return this.INPUT;
        } else {
            User user1=userService.findUserByUserName(username);
            if(TUtil.null2String(user1).equals("")) {
                this.addActionError("用户不存在！");
                return this.INPUT;

            } else {
                String password1=user1.getPassword();
                System.out.println(password1);
                if(!MD5Util.getMD5String(password).toUpperCase().equals(user1.getPassword())) {
                    this.addActionError("密码输入不正确！");
                    return this.INPUT;
                }
            }
        }

        return "login";
    }
*/

    public String list() {


        // String condition=request.getParameter("condition");
        //String value=request.getParameter("value");

        String sno=request.getParameter("sno");
        String userName=request.getParameter("userName");
        String grade=request.getParameter("grade");

        String academe=request.getParameter("academe");   //null
        String profession=request.getParameter("profession");

        String classes=request.getParameter("classes");
        String telephone=request.getParameter("telephone");


        //获取专业id
        String proId=request.getParameter("profession");
        //System.out.println(comName+"      "+category+"         "+level);


        User user1=new User();
        if(!TUtil.null2String(sno).equals("")) {
            user1.setSno(sno);
        }
        if(!TUtil.null2String(userName).equals("")) {
            user1.setUserName(userName);
        }
        if(!TUtil.null2String(grade).equals("")) {
            user1.setGrade(grade);
        }
        if(!TUtil.null2String(classes).equals("")) {
            user1.setClasses(classes);
        }
        if(!TUtil.null2String(telephone).equals("")) {
            user1.setTelephone(telephone);
        }




        //如果有学院，那么要加载学院下所属的专业
        if(!TUtil.null2String(academe).equals("")) {
            user1.setAcademe(academe);

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
                    user1.setProfession(professionName);
                }
                request.setAttribute("profession", professionName);

            }
        }
        /*request.setAttribute("professionName", null);*/






        List<User> list=userService.findUserByCondition(user1);

        List<Academe> academeList =academeService.findAcademeByCondition(null);
       // List<Competition> competitionList=competitionService.findCompetitionsNoPage();
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
        request.setAttribute("userList", list);

        request.setAttribute("academeList", academeList);
        //request.setAttribute("competitionList", competitionList);
        // request.setAttribute("condition", condition);
        //request.setAttribute("beginTime", beginTime);
        //request.setAttribute("value", value);
       // request.setAttribute("endTime", endTime);

        request.setAttribute("sno", sno);
        request.setAttribute("userName", userName);
        request.setAttribute("grade", grade);
        request.setAttribute("academe", academe);


        request.setAttribute("proId", proId);

        request.setAttribute("classes", classes);
        request.setAttribute("telephone", telephone);

       // request.setAttribute("comName1", comName);

        return "list";

    }

    public String add() {
        String currentPage=request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);

        List<Academe> academeList =academeService.findAcademeByCondition(null);
        //List<Competition> competitionList=competitionService.findCompetitionsNoPage();

        request.setAttribute("academeList",academeList);
       // request.setAttribute("competitionList",competitionList);

        return "add";
    }


    public String edit() {

        // String newsId=request.getParameter("newsId");
        String userId = request.getParameter("userId");

        String currentPage = request.getParameter("currentPage");
        if (!TUtil.null2String(userId).equals("")) {

            // Notice notice1=new Notice();
            User user1 = new User();
            user1.setUserId(userId);
            User user2 = userService.findUserByID(user1);
            //Competition competition1=new Competition();
            // competition1.setComId(comId);
            //notice1.setNoticeId(noticeId);
            // Notice notice2=noticeService.findNoticeByID(notice1);
            //Competition competition2=competitionService.findCompetitionByID(competition1);
            request.setAttribute("user", user2);

            List<Academe> academeList = academeService.findAcademeByCondition(null);
            //List<Competition> competitionList=competitionService.findCompetitionsNoPage();

            request.setAttribute("academeList", academeList);
            //request.setAttribute("competitionList",competitionList);

            //获取专业
            List<Academe> academeList1 = academeService.findAcademeByCondition(user2.getAcademe());
            if (!academeList1.isEmpty()) {
                Academe academe1 = academeList1.get(0);
                //Integer academeId=academe1.getAcademeId();
                //根据academeId查询专业
                Set<Profession> professionSet = academe1.getProfessions();
                request.setAttribute("professionSet", professionSet);
            }


            request.setAttribute("academe1", user2.getAcademe());
            request.setAttribute("profession1", user2.getProfession());
            //request.setAttribute("comName1", enter2.getComName());

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
            userService.deleteUserByIds(ids);
            //noticeService.deleteNoticeByIds(ids);
        }
        else{
            //noticeService.deleteNoticeByIds(mulitId);
            // competitionService.deleteCompetitionByIds(mulitId);
            userService.deleteUserByIds(mulitId);
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

        String userId=request.getParameter("userId");
        String currentPage=request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if(TUtil.null2String(userId).equals("")) {
            //noticeService.saveNotice(notice);
            //competitionService.saveCompetition(competition);
            userService.saveUser(user);
        }


        else {
            // noticeService.update(notice);
            // competitionService.update(competition);
            userService.update(user);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request)+"/system/user_list.do?currentPage="+currentPage);

        request.setAttribute("op_title", "保存用户信息成功");


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
