package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IAreaDao;
import com.ffcs.xkjs.domain.Area;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/3/27.
 */
@Repository(IAreaDao.SERVICE_NAME)
public class AreaDaoImpl extends CommonDaoImpl<Area> implements IAreaDao {

}

