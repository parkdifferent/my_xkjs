package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IAcademeDao;
import com.ffcs.xkjs.domain.Academe;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/10.
 */

@Repository(IAcademeDao.SERVICE_NAME)
public class AcademeDaoImpl extends CommonDaoImpl<Academe> implements IAcademeDao {
}
