package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.ICompetitionDao;
import com.ffcs.xkjs.domain.Competition;
import com.ffcs.xkjs.service.ICompetitionService;
import com.ffcs.xkjs.utils.PageInfo;
import com.ffcs.xkjs.utils.TUtil;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tianf on 2016/4/8.
 */

@Service(ICompetitionService.SERVICE_NAME)
@Transactional(readOnly=true)
public class CompetitionServiceImpl implements ICompetitionService {

    @Resource(name= ICompetitionDao.SERVICE_NAME)
    ICompetitionDao competitionDao;


    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveCompetition(Competition competition) {
        competitionDao.save(competition);
    }

    @Override
    public List<Competition> findCompetitionByCondition(Competition competition, String beginTime, String endTime) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if(!TUtil.null2String(competition.getStatus()).equals("")) {
            condition+=" and o.status = ?";
            paramsList.add(competition.getStatus());
        }


        if (!TUtil.null2String(competition.getComName()).equals("")) {
            condition += " and o.comName like ?";
            paramsList.add("%"+competition.getComName()+"%");
        }
        if (!TUtil.null2String(competition.getCategory()).equals("")) {
            condition += " and o.category like ?";
            paramsList.add("%"+competition.getCategory()+"%");
        }

        if (!TUtil.null2String(competition.getLevel()).equals("")) {
            condition += " and o.level like ?";
            paramsList.add("%"+competition.getLevel()+"%");
        }


        if (!TUtil.null2String(beginTime).equals("")) {

            condition+=" and o.startDate >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.startDate <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }

        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        orderby.put("o.startDate", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<Competition> list=competitionDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Competition competition) {
        competitionDao.update(competition);
    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteCompetitionByIds(Serializable... ids) {
        competitionDao.deleteObjectByIds(ids);

    }

    @Override
    public Competition findCompetitionByID(Competition competition) {

        String comId=competition.getComId();
        Competition competition1=competitionDao.findObjectByID(comId);
        return competition1;

    }


    @Override
    public List<Competition> findCompetitionsNoPage() {
        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();
        //String academeName=academe.getAcademeName();
      /*  if (!TUtil.null2String(academeName).equals("")) {
            condition += " and o.academeName like ?";
            paramsList.add("%"+academeName+"%");
        }*/


        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        // orderby.put("o.enterDate", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        //PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        // List<Enter> list=enterDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        List<Competition> list=competitionDao.findCollectionByConditionNoPage(condition,params,orderby);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        // String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        //ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        //ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;
    }
}
