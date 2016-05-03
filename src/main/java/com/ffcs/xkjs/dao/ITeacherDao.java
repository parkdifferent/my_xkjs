package com.ffcs.xkjs.dao;

import com.ffcs.xkjs.domain.Teacher;

/**
 * Created by tianf on 2016/4/26.
 */
public interface ITeacherDao extends ICommonDao<Teacher> {
    public static final String SERVICE_NAME = "com.ffcs.xkjs.dao.impl.TeacherDaoImpl";
}
