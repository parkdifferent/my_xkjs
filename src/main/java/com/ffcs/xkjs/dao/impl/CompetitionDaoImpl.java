package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.ICompetitionDao;
import com.ffcs.xkjs.domain.Competition;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/8.
 */

@Repository(ICompetitionDao.SERVICE_NAME)
public class CompetitionDaoImpl extends CommonDaoImpl<Competition> implements ICompetitionDao {
}
