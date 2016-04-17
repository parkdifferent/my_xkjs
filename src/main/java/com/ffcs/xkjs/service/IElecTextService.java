package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.ElecText;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/3/27.
 */
public interface IElecTextService {
    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.ElecTextServiceImpl";

    void saveElecText(ElecText elecText);

    List<ElecText> findCollectionByConditionNoPage(ElecText elecText, String beginTime, String endTime);

    public List<ElecText> findTextListByCondition(ElecText elecText, String beginTime, String endTime);

    List<ElecText> findText(ElecText elecText);


    ElecText findElecTextByID(ElecText elecText);

    void update(ElecText elecText);

    void deleteTextByIds(Serializable... ids);


}

