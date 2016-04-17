package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IElecTextDao;
import com.ffcs.xkjs.dao.INewsDao;
import com.ffcs.xkjs.domain.News;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/4.
 */

@Repository(INewsDao.SERVICE_NAME)
public class NewsDaoImpl extends CommonDaoImpl<News> implements INewsDao {

}
