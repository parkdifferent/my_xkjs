package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Information;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/22.
 */
public interface IInformationService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.InformationServiceImpl";


    void saveInformation(Information information);

    public List<Information> findInformationByCondition(Information information);

    void update(Information information);

    void deleteInformationByIds(Serializable... ids);

    Information findInformationByID(String  infoId);
}
