package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.IProfessionDao;
import com.ffcs.xkjs.domain.Profession;
import com.ffcs.xkjs.service.IProfessionService;
import com.ffcs.xkjs.utils.TUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tianf on 2016/4/14.
 */

@Service(IProfessionService.SERVICE_NAME)
@Transactional(readOnly=true)
public class ProfessionServiceImpl implements IProfessionService {

    @Resource(name= IProfessionDao.SERVICE_NAME)
    IProfessionDao professionDao;


    @Override
    public List<Profession> findProfessionByCondition(String academeId) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();
        //String academeName=academe.getAcademeName();
       /* if (!TUtil.null2String(academeId).equals("")) {
            condition += " and o.academeId =?";
            paramsList.add(academeId);
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
        try {
            List<Profession> list=professionDao.findCollectionByConditionNoPage(condition,params,orderby);
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }

        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        // String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        //ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        //ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return null;
    }


    @Override
    public Profession findProfessionByID(Integer proId) {

        Profession profession1=professionDao.findObjectByID(proId);
        return profession1;


    }
}
