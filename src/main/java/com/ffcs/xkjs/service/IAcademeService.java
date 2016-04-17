package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Academe;

import java.util.List;

/**
 * Created by tianf on 2016/4/10.
 */
public interface IAcademeService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.AcademeServiceImpl";

    Academe findAcademeByID(Academe academe);
    public List<Academe> findAcademeByCondition(String academeName);
}
