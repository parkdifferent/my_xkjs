package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.ITeacherDao;
import com.ffcs.xkjs.domain.Teacher;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/26.
 */

@Repository(ITeacherDao.SERVICE_NAME)
public class TeacherDaoImpl extends CommonDaoImpl<Teacher> implements ITeacherDao {
}
