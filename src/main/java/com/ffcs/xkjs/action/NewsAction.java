package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.News;
import com.ffcs.xkjs.service.INewsService;
import com.ffcs.xkjs.utils.TUtil;
import com.opensymphony.xwork2.ActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by tianf on 2016/4/4.
 */

@Controller("newsAction")
@Scope(value="prototype")
public class NewsAction extends BaseAction<News> {

    News news=this.getModel();

    @Resource(name= INewsService.SERVICE_NAME)
    INewsService newsService;

    public String list() {


        //String condition=request.getParameter("condition");
        //String value=request.getParameter("value");

        String title=request.getParameter("title");
        String content=request.getParameter("content");


        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");


        //System.out.println(condition+"      "+value);
        News news1 = new News();
       /* if(!TUtil.null2String(condition).equals("") && !TUtil.null2String(value).equals("")) {
            if (condition.equals("title")) {
                news1.setTitle(value);
            }

            if (condition.equals("content")) {
                news1.setContent(value);
            }
        }*/

        if(!TUtil.null2String(title).equals("")) {
            news1.setTitle(title);
            request.setAttribute("title", title);
        }

        if(!TUtil.null2String(content).equals("")) {
            news1.setContent(content);
            request.setAttribute("content", content);
        }

        List<News> list=newsService.findNewsByCondition(news1,beginTime,endTime);
        /*if(list!=null && list.size()>0){
            for(News news:list){
                System.out.println(text.getTextName()+"    "+text.getTextDate()+"    "+text.getTextRemark());
            }
        }*/
        //ActionContext.getContext().put("textList", list);
        //ServletActionContext.getRequest().setAttribute("textList", list);
        request.setAttribute("newsList", list);
        //request.setAttribute("condition", condition);
        request.setAttribute("beginTime", beginTime);
       // request.setAttribute("value", value);
        request.setAttribute("endTime", endTime);
        return "list";

    }


    public String add() {
        String currentPage=request.getParameter("currentPage");
        request.setAttribute("currentPage", currentPage);

//新增，初始化kindeditor的值为空
       request.setAttribute("content",null);


        //ActionContext actionContext = ActionContext.getContext();
        //Map<String,String> request = (Map) actionContext.get("request");
        //request.put("a", "a is in request");

        return "add";
    }

    public String edit() {

        String newsId=request.getParameter("newsId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(newsId).equals("")) {
            News news1=new News();
            news1.setNewsId(newsId);
            News news2=newsService.findNewsByID(news1);
            request.setAttribute("news", news2);
            //编辑，初始化kindeditor的显示值
            request.setAttribute("content",news2.getContent());
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
            newsService.deleteNewsByIds(ids);
        }
        else{
            newsService.deleteNewsByIds(mulitId);
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

        String content=request.getParameter("content");
        //System.out.println(content);
        //System.out.println(news.getContent());


        //String ID=request.getParameter("textID");
        String currentPage=request.getParameter("currentPage");
        //System.out.println(elecText.getTextName()+"   "+elecText.getTextDate()+"      "+elecText.getTextID());


        if(TUtil.null2String(news.getNewsId()).equals("")) {
            newsService.saveNews(news);
        }


        else {

            newsService.update(news);
        }

        //String textDate = request.getParameter("textDate");
        String list_url=request.getParameter("list_url");
        String add_url=request.getParameter("add_url");

        System.out.println(list_url+"          "+add_url);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("list_url", TUtil.getURL(request)+"/system/news_list.do?currentPage="+currentPage);

        request.setAttribute("op_title", "保存竞赛新闻成功");


        request.setAttribute("add_url", add_url);


       // request.setAttribute("content", content);


        return "save";
    }



    public String stulist() {


        String title=request.getParameter("title");
        String content=request.getParameter("content");


        String beginTime=request.getParameter("beginTime");
        String endTime=request.getParameter("endTime");

        News news1 = new News();

        if(!TUtil.null2String(title).equals("")) {
            news1.setTitle(title);
            request.setAttribute("title", title);
        }

        if(!TUtil.null2String(content).equals("")) {
            news1.setContent(content);
            request.setAttribute("content", content);
        }

        List<News> list=newsService.findNewsByCondition(news1,beginTime,endTime);

        request.setAttribute("newsList", list);

        request.setAttribute("beginTime", beginTime);

        request.setAttribute("endTime", endTime);
        return "stulist";


    }



    public String stuedit() {

        String newsId=request.getParameter("newsId");

        String currentPage=request.getParameter("currentPage");
        if(!TUtil.null2String(newsId).equals("")) {
            News news1=new News();
            news1.setNewsId(newsId);
            News news2=newsService.findNewsByID(news1);
            request.setAttribute("news", news2);
            //编辑，初始化kindeditor的显示值
            request.setAttribute("content",news2.getContent());
        }

        request.setAttribute("edit", true);


        request.setAttribute("currentPage", currentPage);
        return "stuedit";
    }













}
