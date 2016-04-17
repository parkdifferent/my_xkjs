package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IProfessionDao;
import com.ffcs.xkjs.domain.Profession;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/14.
 */

@Repository(IProfessionDao.SERVICE_NAME)
public class ProfessionDaoImpl extends CommonDaoImpl<Profession> implements IProfessionDao {
}
