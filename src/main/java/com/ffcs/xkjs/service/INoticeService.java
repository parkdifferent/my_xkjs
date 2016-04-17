package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Notice;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/4.
 */
public interface INoticeService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.NoticeServiceImpl";


    void saveNotice(Notice notice);

    public List<Notice> findNoticeByCondition(Notice notice, String beginTime, String endTime);

    void update(Notice notice);

    void deleteNoticeByIds(Serializable... ids);

    Notice findNoticeByID(Notice notice);

}
