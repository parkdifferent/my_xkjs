package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.IInformationDao;
import com.ffcs.xkjs.domain.Information;
import com.ffcs.xkjs.service.IInformationService;
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
 * Created by tianf on 2016/4/22.
 */

@Service(IInformationService.SERVICE_NAME)
@Transactional(readOnly=true)
public class InformationServiceImpl implements IInformationService {


    @Resource(name= IInformationDao.SERVICE_NAME)
    IInformationDao iInformationDao;



    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveInformation(Information information) {
        iInformationDao.save(information);


    }

    @Override
    public List<Information> findInformationByCondition(Information information) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();


        if (!TUtil.null2String(information.getFileName()).equals("")) {
            condition += " and o.fileName like ?";
            paramsList.add("%"+information.getFileName()+"%");
        }

        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        orderby.put("o.addTime", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<Information> list=iInformationDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Information information) {
        iInformationDao.update(information);

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteInformationByIds(Serializable... ids) {
        iInformationDao.deleteObjectByIds(ids);

    }

    @Override
    public Information findInformationByID(String  infoId) {
        Information information1=iInformationDao.findObjectByID(infoId);
        return information1;

    }
}
