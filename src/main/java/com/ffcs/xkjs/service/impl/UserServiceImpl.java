package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.IUserDao;
import com.ffcs.xkjs.domain.User;
import com.ffcs.xkjs.service.IUserService;
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
 * Created by tianf on 2016/4/6.
 */


@Service(IUserService.SERVICE_NAME)
@Transactional(readOnly=true)
public class UserServiceImpl implements IUserService {

    @Resource(name= IUserDao.SERVICE_NAME)
    IUserDao userDao;


    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveUser(User user) {
        userDao.save(user);

    }

    @Override
    public List<User> findUserByCondition(User user) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();



        if (!TUtil.null2String(user.getUserId()).equals("")) {
            condition += " and o.userId = ?";
            paramsList.add(user.getUserId());
        }


        if (!TUtil.null2String(user.getUserName()).equals("")) {
            condition += " and o.userName like ?";
            paramsList.add("%"+user.getUserName()+"%");
        }

        if (!TUtil.null2String(user.getRole()).equals("")) {
            condition += " and o.role like ?";
            paramsList.add("%"+user.getRole()+"%");
        }

        if (!TUtil.null2String(user.getSno()).equals("")) {
            condition += " and o.sno like ?";
            paramsList.add("%"+user.getSno()+"%");
        }

        if (!TUtil.null2String(user.getGrade()).equals("")) {
            condition += " and o.grade like ?";
            paramsList.add("%"+user.getGrade()+"%");
        }

        if (!TUtil.null2String(user.getAcademe()).equals("")) {
            condition += " and o.academe like ?";
            paramsList.add("%"+user.getAcademe()+"%");
        }

        if (!TUtil.null2String(user.getProfession()).equals("")) {
            condition += " and o.profession like ?";
            paramsList.add("%"+user.getProfession()+"%");
        }

        if (!TUtil.null2String(user.getClasses()).equals("")) {
            condition += " and o.classes like ?";
            paramsList.add("%"+user.getClasses()+"%");
        }

        if (!TUtil.null2String(user.getTelephone()).equals("")) {
            condition += " and o.telephone like ?";
            paramsList.add("%"+user.getTelephone()+"%");
        }








        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        //orderby.put("o.noticeTime", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<User> list=userDao.findCollectionByConditionWithPage(condition,params,orderby,pageInfo);
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
    public void update(User user) {
        userDao.update(user);

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteUserByIds(Serializable... ids) {
        userDao.deleteObjectByIds(ids);

    }

    @Override
    public User findUserByID(User user) {
        String userId=user.getUserId();
        User user1=userDao.findObjectByID(userId);
        return user1;

    }

    @Override
    public User findUserByUserName(String userName) {
        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();
        if (!TUtil.null2String(userName).equals("")) {
            condition += " and o.userName=?";
            paramsList.add(userName);
        }


        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();

       List<User> list=userDao.findCollectionByConditionNoPage(condition,params,null);

        User user=null;
        if(list!=null && list.size()>0) {
            user=list.get(0);
        }
        return user;
    }


    @Override
    public User findUserBySno(String sno) {


        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();
        if (!TUtil.null2String(sno).equals("")) {
            condition += " and o.sno=?";
            paramsList.add(sno);
        }


        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();

        List<User> list=userDao.findCollectionByConditionNoPage(condition,params,null);

        User user=null;
        if(list!=null && list.size()>0) {
            user=list.get(0);
        }
        return user;

    }
}
