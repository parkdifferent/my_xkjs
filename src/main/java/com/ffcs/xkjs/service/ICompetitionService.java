package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Competition;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/8.
 */
public interface ICompetitionService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.CompetitionServiceImpl";


    void saveCompetition(Competition competition);

    public List<Competition> findCompetitionByCondition(Competition competition, String beginTime, String endTime);

    public List<Competition> findCompetitionsNoPage();

    void update(Competition competition);

    void deleteCompetitionByIds(Serializable... ids);

    Competition findCompetitionByID(Competition competition);
}
