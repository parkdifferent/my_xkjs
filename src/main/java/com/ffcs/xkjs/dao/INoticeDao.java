package com.ffcs.xkjs.dao;

import com.ffcs.xkjs.domain.Notice;

/**
 * Created by tianf on 2016/4/4.
 */
public interface INoticeDao extends ICommonDao<Notice> {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.dao.impl.NoticeDaoImpl";
}
