package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.IAdminDao;
import com.ffcs.xkjs.domain.Admin;
import com.ffcs.xkjs.domain.Teacher;
import com.ffcs.xkjs.service.IAdminService;
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
 * Created by tianf on 2016/4/27.
 */

@Service(IAdminService.SERVICE_NAME)
@Transactional(readOnly=true)
public class AdminServiceImpl implements IAdminService {

    @Resource(name= IAdminDao.SERVICE_NAME)
    IAdminDao adminDao;


    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveAdmin(Admin admin) {
        adminDao.save(admin);
    }

    @Override
    public List<Admin> findAdminByCondition(Admin admin) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if (!TUtil.null2String(admin.getAdminId()).equals("")) {
            condition += " and o.adminId = ?";
            paramsList.add(admin.getAdminId());
        }

        if (!TUtil.null2String(admin.getUserName()).equals("")) {
            condition += " and o.userName like ?";
            paramsList.add("%"+admin.getUserName()+"%");
        }

        if (!TUtil.null2String(admin.getRole()).equals("")) {
            condition += " and o.role like ?";
            paramsList.add("%"+admin.getRole()+"%");
        }

        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        //orderby.put("o.noticeTime", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());

        List<Admin> list=adminDao.findCollectionByConditionWithPage(condition,params,orderby,pageInfo);
        // List<Notice> list=noticeDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Admin admin) {
        adminDao.update(admin);
    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteAdminByIds(Serializable... ids) {
        adminDao.deleteObjectByIds(ids);
    }

    @Override
    public Admin findAdminByID(String adminId) {
       Admin admin=adminDao.findObjectByID(adminId);
        return admin;
    }

    @Override
    public Admin findAdminByUserName(String userName) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if (!TUtil.null2String(userName).equals("")) {
            condition += " and o.userName like ?";
            paramsList.add("%"+userName+"%");
        }

//将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();

        List<Admin> list=adminDao.findCollectionByConditionNoPage(condition,params,null);

        Admin admin=null;
        if(list!=null && list.size()>0) {
            admin=list.get(0);
        }
        return admin;

    }
}
