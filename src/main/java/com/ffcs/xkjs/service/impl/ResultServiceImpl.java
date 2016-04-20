package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.IResultDao;
import com.ffcs.xkjs.domain.Result;
import com.ffcs.xkjs.service.IResultService;
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
 * Created by tianf on 2016/4/10.
 */

@Service(IResultService.SERVICE_NAME)
@Transactional(readOnly=true)
public class ResultServiceImpl implements IResultService{

    @Resource(name= IResultDao.SERVICE_NAME)
    IResultDao resultDao;

    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveResult(Result result) {
        resultDao.save(result);
    }

    @Override
    public List<Result> findResultByCondition(Result result, String beginTime, String endTime) {


        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if (!TUtil.null2String(result.getSno()).equals("")) {
            condition += " and o.sno like ?";
            paramsList.add("%"+result.getSno()+"%");
        }

        if (!TUtil.null2String(result.getGrade()).equals("")) {
            condition += " and o.grade like ?";
            paramsList.add("%"+result.getGrade()+"%");
        }

        if (!TUtil.null2String(result.getAcademe()).equals("")) {
            condition += " and o.academe like ?";
            paramsList.add("%"+result.getAcademe()+"%");
        }

        if (!TUtil.null2String(result.getProfession()).equals("")) {
            condition += " and o.profession like ?";
            paramsList.add("%"+result.getProfession()+"%");
        }

        if (!TUtil.null2String(result.getComName()).equals("")) {
            condition += " and o.comName like ?";
            paramsList.add("%"+result.getComName()+"%");
        }

        if (!TUtil.null2String(result.getName()).equals("")) {
            condition += " and o.name like ?";
            paramsList.add("%"+result.getName()+"%");
        }

        if (!TUtil.null2String(result.getClasses()).equals("")) {
            condition += " and o.classes like ?";
            paramsList.add("%"+result.getClasses()+"%");
        }

        if (!TUtil.null2String(result.getTutor()).equals("")) {
            condition += " and o.tutor like ?";
            paramsList.add("%"+result.getTutor()+"%");
        }

        /*if (!TUtil.null2String(enter.getName()).equals("")) {
            condition += " and o.name like ?";
            paramsList.add("%"+enter.getName()+"%");
        }
        if (!TUtil.null2String(enter.getTelephone()).equals("")) {
            condition += " and o.telephone like ?";
            paramsList.add("%"+enter.getTelephone()+"%");
        }
*/
        if (!TUtil.null2String(beginTime).equals("")) {
            condition+=" and o.getTime >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.getTime <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }

        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        orderby.put("o.getTime", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<Result> list=resultDao.findCollectionByConditionWithPage(condition,params,orderby,pageInfo);
        //List<Enter> list=enterDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Result result) {

        resultDao.update(result);
    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteResultByIds(Serializable... ids) {

        resultDao.deleteObjectByIds(ids);
    }

    @Override
    public Result findResultByID(Result result) {

       String resultId=result.getResultId();
        Result result1=resultDao.findObjectByID(resultId);
        return result1;
    }


    @Override
    public List<Result> findResultListByConditionNoPage(Result result, String beginTime, String endTime) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if (!TUtil.null2String(result.getSno()).equals("")) {
            condition += " and o.sno like ?";
            paramsList.add("%"+result.getSno()+"%");
        }

        if (!TUtil.null2String(result.getGrade()).equals("")) {
            condition += " and o.grade like ?";
            paramsList.add("%"+result.getGrade()+"%");
        }

        if (!TUtil.null2String(result.getAcademe()).equals("")) {
            condition += " and o.academe like ?";
            paramsList.add("%"+result.getAcademe()+"%");
        }

        if (!TUtil.null2String(result.getProfession()).equals("")) {
            condition += " and o.profession like ?";
            paramsList.add("%"+result.getProfession()+"%");
        }

        if (!TUtil.null2String(result.getComName()).equals("")) {
            condition += " and o.comName like ?";
            paramsList.add("%"+result.getComName()+"%");
        }

        if (!TUtil.null2String(result.getName()).equals("")) {
            condition += " and o.name like ?";
            paramsList.add("%"+result.getName()+"%");
        }

        if (!TUtil.null2String(result.getClasses()).equals("")) {
            condition += " and o.classes like ?";
            paramsList.add("%"+result.getClasses()+"%");
        }

        if (!TUtil.null2String(result.getTutor()).equals("")) {
            condition += " and o.tutor like ?";
            paramsList.add("%"+result.getTutor()+"%");
        }

        /*if (!TUtil.null2String(enter.getName()).equals("")) {
            condition += " and o.name like ?";
            paramsList.add("%"+enter.getName()+"%");
        }
        if (!TUtil.null2String(enter.getTelephone()).equals("")) {
            condition += " and o.telephone like ?";
            paramsList.add("%"+enter.getTelephone()+"%");
        }
*/
        if (!TUtil.null2String(beginTime).equals("")) {
            condition+=" and o.getTime >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.getTime <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }


        //传递可变参数
        Object [] params = paramsList.toArray();
        //排序
        Map<String, String> orderby = new LinkedHashMap<String, String>();//有序
        orderby.put("o.getTime", "asc");

        //查询
        List<Result> list = resultDao.findCollectionByConditionNoPage(condition,params,orderby);
        return list;

    }
}
