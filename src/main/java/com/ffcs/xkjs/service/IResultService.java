package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Result;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/10.
 */
public interface IResultService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.ResultServiceImpl";

    void saveResult(Result result);

    public List<Result> findResultByCondition(Result result, String beginTime, String endTime);

    void update(Result result);

    void deleteResultByIds(Serializable... ids);

    Result findResultByID(Result result);

    public List<Result> findResultListByConditionNoPage(Result result, String beginTime, String endTime);
}
