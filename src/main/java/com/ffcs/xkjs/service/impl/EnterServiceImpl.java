package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.IEnterDao;
import com.ffcs.xkjs.domain.Enter;
import com.ffcs.xkjs.service.IEnterService;
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

@Service(IEnterService.SERVICE_NAME)
@Transactional(readOnly=true)
public class EnterServiceImpl implements IEnterService {

    @Resource(name= IEnterDao.SERVICE_NAME)
    IEnterDao enterDao;

    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveEnter(Enter enter) {
        enterDao.save(enter);
    }

    @Override
    public List<Enter> findEnterByCondition(Enter enter, String beginTime, String endTime) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if (!TUtil.null2String(enter.getAuditStatus()).equals("")) {
            condition+=" and o.auditStatus = ?";
            paramsList.add(enter.getAuditStatus());
        }

        if (!TUtil.null2String(enter.getSno()).equals("")) {
            condition += " and o.sno like ?";
            paramsList.add("%"+enter.getSno()+"%");
        }

        if (!TUtil.null2String(enter.getGrade()).equals("")) {
            condition += " and o.grade like ?";
            paramsList.add("%"+enter.getGrade()+"%");
        }

        if (!TUtil.null2String(enter.getAcademe()).equals("")) {
            condition += " and o.academe like ?";
            paramsList.add("%"+enter.getAcademe()+"%");
        }

        if (!TUtil.null2String(enter.getProfession()).equals("")) {
            condition += " and o.profession like ?";
            paramsList.add("%"+enter.getProfession()+"%");
        }

        if (!TUtil.null2String(enter.getComName()).equals("")) {
            condition += " and o.comName like ?";
            paramsList.add("%"+enter.getComName()+"%");
        }

        if (!TUtil.null2String(enter.getTrueName()).equals("")) {
            condition += " and o.trueName like ?";
            paramsList.add("%"+enter.getTrueName()+"%");
        }

        if (!TUtil.null2String(enter.getTutor()).equals("")) {
            condition += " and o.tutor like ?";
            paramsList.add("%"+enter.getTutor()+"%");
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
            condition+=" and o.beginTime >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.enterDate <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }

        /*if (!TUtil.null2String(enter.getAuditStatus()).equals("")) {
            condition += " and o.auditStatus=?";
            paramsList.add(enter.getAuditStatus());
        }*/



        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        orderby.put("o.enterDate", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<Enter> list=enterDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;
    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Enter enter) {
        enterDao.update(enter);

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteEnterByIds(Serializable... ids) {
        enterDao.deleteObjectByIds(ids);

    }

    @Override
    public Enter findEnterByID(Enter enter) {
        String enterId=enter.getEnterId();
        Enter enter1=enterDao.findObjectByID(enterId);
        return enter1;

    }

    @Override
    public List<Enter> findEnterListByConditionNoPage(Enter enter, String beginTime, String endTime) {
        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if (!TUtil.null2String(enter.getSno()).equals("")) {
            condition += " and o.sno like ?";
            paramsList.add("%"+enter.getSno()+"%");
        }

        if (!TUtil.null2String(enter.getGrade()).equals("")) {
            condition += " and o.grade like ?";
            paramsList.add("%"+enter.getGrade()+"%");
        }

        if (!TUtil.null2String(enter.getAcademe()).equals("")) {
            condition += " and o.academe like ?";
            paramsList.add("%"+enter.getAcademe()+"%");
        }

        if (!TUtil.null2String(enter.getProfession()).equals("")) {
            condition += " and o.profession like ?";
            paramsList.add("%"+enter.getProfession()+"%");
        }

        if (!TUtil.null2String(enter.getComName()).equals("")) {
            condition += " and o.comName like ?";
            paramsList.add("%"+enter.getComName()+"%");
        }

        if (!TUtil.null2String(enter.getTrueName()).equals("")) {
            condition += " and o.trueName like ?";
            paramsList.add("%"+enter.getTrueName()+"%");
        }

        if (!TUtil.null2String(enter.getTutor()).equals("")) {
            condition += " and o.tutor like ?";
            paramsList.add("%"+enter.getTutor()+"%");
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
            condition+=" and o.enterDate >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.enterDate <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }

       /* if (!TUtil.null2String(enter.getAuditStatus()).equals("")) {
            condition += " and o.auditStatus=?";
            paramsList.add(enter.getAuditStatus());
        }*/

        //传递可变参数
        Object [] params = paramsList.toArray();
        //排序
        Map<String, String> orderby = new LinkedHashMap<String, String>();//有序
        orderby.put("o.enterDate", "asc");

        //查询
        List<Enter> list = enterDao.findCollectionByConditionNoPage(condition,params,orderby);
        return list;


    }
}
