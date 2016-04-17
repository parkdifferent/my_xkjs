package com.ffcs.xkjs.service.impl;

import com.ffcs.xkjs.dao.INoticeDao;
import com.ffcs.xkjs.domain.Notice;
import com.ffcs.xkjs.service.INoticeService;
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
 * Created by tianf on 2016/4/4.
 */

@Service(INoticeService.SERVICE_NAME)
@Transactional(readOnly=true)
public class NoticeServiceImpl implements INoticeService {

    @Resource(name= INoticeDao.SERVICE_NAME)
    INoticeDao noticeDao;


    @Override
    @Transactional(isolation= Isolation.DEFAULT,propagation= Propagation.REQUIRED,readOnly=false)
    public void saveNotice(Notice notice) {
        noticeDao.save(notice);

    }

    @Override
    public List<Notice> findNoticeByCondition(Notice notice, String beginTime, String endTime) {

        //组织查询条件
        String condition = "";
        //存放可变参数？
        List<Object> paramsList = new ArrayList<Object>();
        if (!TUtil.null2String(notice.getTitle()).equals("")) {
            condition += " and o.title like ?";
            paramsList.add("%"+notice.getTitle()+"%");
        }
        if (!TUtil.null2String(notice.getContent()).equals("")) {
            condition += " and o.content like ?";
            paramsList.add("%"+notice.getContent()+"%");
        }

        if (!TUtil.null2String(beginTime).equals("")) {

            condition+=" and o.noticeTime >= ? ";
            paramsList.add(TUtil.formatDate(beginTime));

        }

        if(!TUtil.null2String(endTime).equals("")) {
            condition+=" and o.noticeTime <= ? ";
            paramsList.add(TUtil.formatDate(endTime));
        }

        //将集合中存放的可变参数转换成数组
        Object [] params = paramsList.toArray();
        //使用集合存放排序的条件(有序排列)
        Map<String, String> orderby = new LinkedHashMap<String, String>();
        orderby.put("o.noticeTime", "desc");
        //List<ElecText> list = elecTextDao.findCollectionByConditionNoPage(condition,params,orderby);
				/*2016-3-7,添加分页 begin*/
        PageInfo pageInfo=new PageInfo(ServletActionContext.getRequest());
        List<Notice> list=noticeDao.findCollectionByConditionWithPage(condition, params, orderby, pageInfo);
        //ServletActionContext.getRequest().setAttribute("page",pageInfo.getPageBean());
        String gotoPageFormHTML=TUtil.showPageFormHtml(pageInfo.getCurrentPageNo(), pageInfo.getTotalPage());
        ServletActionContext.getRequest().setAttribute("gotoPageFormHTML", gotoPageFormHTML);
        ServletActionContext.getRequest().setAttribute("currentPage",pageInfo.getCurrentPageNo());
				/*2016-3-7,添加分页 end*/
        return list;




    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Notice notice) {
        noticeDao.update(notice);

    }

    @Override
    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void deleteNoticeByIds(Serializable... ids) {
        noticeDao.deleteObjectByIds(ids);
    }

    @Override
    public Notice findNoticeByID(Notice notice) {
        //String newsId=news.getNewsId();
        String noticeId=notice.getNoticeId();
        Notice notice1=noticeDao.findObjectByID(noticeId);
        return notice1;
    }
}
