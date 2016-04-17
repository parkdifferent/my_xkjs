package com.ffcs.xkjs.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.ffcs.xkjs.dao.IElecTextDao;
import com.ffcs.xkjs.domain.ElecText;
import com.ffcs.xkjs.service.IElecTextService;
import com.ffcs.xkjs.utils.PageInfo;
import com.ffcs.xkjs.utils.TUtil;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by tianf on 2016/3/27.
 */
/**
 * @Service
 * 相当于在spring容器中定义：
 * <bean id="com.itheima.elec.service.impl.ElecTextServiceImpl" class="com.itheima.elec.service.impl.ElecTextServiceImpl">
 */
@Service(IElecTextService.SERVICE_NAME)
@Transactional(readOnly=true)
public class ElecTextServiceImpl implements IElecTextService {

    @Resource(name=IElecTextDao.SERVICE_NAME)
    IElecTextDao elecTextDao;

    /**保存测试表*/
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void saveElecText(ElecText elecText) {
        elecTextDao.save(elecText);
    }

    /**指定查询条件，查询列表*/
    /**
     * SELECT * FROM elec_text o WHERE 1=1     #Dao层
     AND o.textName LIKE '%张%'   #Service层
     AND o.textRemark LIKE '%张%'   #Service层
     ORDER BY o.textDate ASC,o.textName DESC  #Service层
     */
    public List<ElecText> findCollectionByConditionNoPage(ElecText elecText,String beginTime,String endTime) {
        //查询条件
        String condition = "";
        //查询条件对应的参数
        List<Object> paramsList = new ArrayList<Object>();
        if (!TUtil.null2String(elecText.getTextName()).equals("")) {
            condition += " and o.textName like ?";
            paramsList.add("%"+elecText.getTextName()+"%");
        }
            if (!TUtil.null2String(elecText.getTextRemark()).equals("")) {
            condition += " and o.textRemark like ?";
            paramsList.add("%"+elecText.getTextRemark()+"%");
        }

        if (!TUtil.null2String(beginTime).equals("")) {

            condition+=" and o.textDate >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.textDate <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }

        //传递可变参数
        Object [] params = paramsList.toArray();
        //排序
        Map<String, String> orderby = new LinkedHashMap<String, String>();//有序
        orderby.put("o.textDate", "asc");
        orderby.put("o.textName", "desc");
        //查询
        List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
        return list;
    }

    public List<ElecText> findTextListByCondition(ElecText elecText,String beginTime,String endTime) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();
        if (!TUtil.null2String(elecText.getTextName()).equals("")) {
            condition += " and o.textName like ?";
            paramsList.add("%"+elecText.getTextName()+"%");
        }
        if (!TUtil.null2String(elecText.getTextRemark()).equals("")) {
            condition += " and o.textRemark like ?";
            paramsList.add("%"+elecText.getTextRemark()+"%");
        }

        if (!TUtil.null2String(beginTime).equals("")) {

            condition+=" and o.textDate >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.textDate <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }

        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        orderby.put("o.textDate", "asc");
        orderby.put("o.textRemark", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<ElecText> list=elecTextDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;
    }



    public List<ElecText> findText(ElecText elecText) {

        String condition = "";
        //查询条件对应的参数
        List<Object> paramsList = new ArrayList<Object>();
        //传递可变参数
        Object [] params = paramsList.toArray();
        //排序
        Map<String, String> orderby = new LinkedHashMap<String, String>();//有序
        List<ElecText> list=elecTextDao.findCollectionByConditionNoPage(condition, params, orderby);
        return list;
    }

    public ElecText findElecTextByID(ElecText elecText) {
        // TODO Auto-generated method stub

        String textID = elecText.getTextID();
        ElecText text = elecTextDao.findObjectByID(textID);
        return text;
    }

    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(ElecText elecText) {
        elecTextDao.update(elecText);
    }

    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteTextByIds(Serializable... ids) {

        elecTextDao.deleteObjectByIds(ids);

    }












}

