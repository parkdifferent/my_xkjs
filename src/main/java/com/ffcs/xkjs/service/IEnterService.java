package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Enter;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/8.
 */
public interface IEnterService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.EnterServiceImpl";


    void saveEnter(Enter enter);

    public List<Enter> findEnterByCondition(Enter enter, String beginTime, String endTime);

    void update(Enter enter);

    void deleteEnterByIds(Serializable... ids);

    Enter findEnterByID(Enter enter);


    public List<Enter> findEnterListByConditionNoPage(Enter enter, String beginTime, String endTime);
}
