package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IEnterDao;
import com.ffcs.xkjs.domain.Enter;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/8.
 */

@Repository(IEnterDao.SERVICE_NAME)
public class EnterDaoImpl extends CommonDaoImpl<Enter> implements IEnterDao {
}
