package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IResultDao;
import com.ffcs.xkjs.domain.Result;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/10.
 */

@Repository(IResultDao.SERVICE_NAME)
public class ResultDaoImpl extends CommonDaoImpl<Result> implements IResultDao {
}
