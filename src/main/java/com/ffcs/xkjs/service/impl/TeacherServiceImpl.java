package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.ITeacherDao;
import com.ffcs.xkjs.domain.Teacher;
import com.ffcs.xkjs.service.ITeacherService;
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
 * Created by tianf on 2016/4/26.
 */

@Service(ITeacherService.SERVICE_NAME)
@Transactional(readOnly=true)
public class TeacherServiceImpl implements ITeacherService {

    @Resource(name= ITeacherDao.SERVICE_NAME)
    ITeacherDao teacherDao;


    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveTeacher(Teacher teacher) {
        teacherDao.save(teacher);
    }

    @Override
    public List<Teacher> findTeacherByCondition(Teacher teacher) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();

        if (!TUtil.null2String(teacher.getTeaId()).equals("")) {
            condition += " and o.teaId like ?";
            paramsList.add(teacher.getTeaId());
        }



        if (!TUtil.null2String(teacher.getTno()).equals("")) {
            condition += " and o.tno like ?";
            paramsList.add("%"+teacher.getTno()+"%");
        }


        if (!TUtil.null2String(teacher.getName()).equals("")) {
            condition += " and o.name like ?";
            paramsList.add("%"+teacher.getName()+"%");
        }

        if (!TUtil.null2String(teacher.getAcademe()).equals("")) {
            condition += " and o.academe like ?";
            paramsList.add("%"+teacher.getAcademe()+"%");
        }
        if (!TUtil.null2String(teacher.getRank()).equals("")) {
            condition += " and o.rank =?";
            paramsList.add(teacher.getRank());
        }


        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
       // orderby.put("o.noticeTime", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<Teacher> list=teacherDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Teacher teacher) {
        teacherDao.update(teacher);

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteTeacherByIds(Serializable... ids) {
        teacherDao.deleteObjectByIds(ids);
    }

    @Override
    public Teacher findTeacherByID(String teaId) {
        Teacher teacher1=teacherDao.findObjectByID(teaId);
        return teacher1;
    }


    @Override
    public Teacher findTeacherByTno(String tno) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();
        if (!TUtil.null2String(tno).equals("")) {
            condition += " and o.tno=?";
            paramsList.add(tno);
        }


        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();

        List<Teacher> list=teacherDao.findCollectionByConditionNoPage(condition,params,null);

        Teacher teacher=null;
        if(list!=null && list.size()>0) {
            teacher=list.get(0);
        }
        return teacher;
    }
}
