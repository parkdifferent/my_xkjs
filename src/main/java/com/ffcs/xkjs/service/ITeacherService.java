package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Competition;
import com.ffcs.xkjs.domain.Teacher;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/26.
 */
public interface ITeacherService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.TeacherServiceImpl";

    void saveTeacher(Teacher teacher);

    public List<Teacher> findTeacherByCondition(Teacher teacher);

    void update(Teacher teacher);

    void deleteTeacherByIds(Serializable... ids);

    Teacher findTeacherByID(String teaId);


    Teacher findTeacherByTno(String tno);

    public List<Teacher> findTeachersNoPage();
}
