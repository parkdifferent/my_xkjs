package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Profession;

import java.util.List;

/**
 * Created by tianf on 2016/4/14.
 */
public interface IProfessionService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.ProfessionServiceImpl";


    Profession findProfessionByID(Integer proId);
    public List<Profession> findProfessionByCondition(String academeId);
}
