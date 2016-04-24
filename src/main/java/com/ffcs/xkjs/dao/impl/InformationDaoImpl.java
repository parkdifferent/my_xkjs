package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IInformationDao;
import com.ffcs.xkjs.domain.Information;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/22.
 */

@Repository(IInformationDao.SERVICE_NAME)
public class InformationDaoImpl extends CommonDaoImpl<Information> implements IInformationDao {
}
