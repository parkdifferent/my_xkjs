package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.INoticeDao;
import com.ffcs.xkjs.domain.Notice;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/4.
 */

@Repository(INoticeDao.SERVICE_NAME)
public class NoticeDaoImpl extends CommonDaoImpl<Notice> implements INoticeDao {


}
