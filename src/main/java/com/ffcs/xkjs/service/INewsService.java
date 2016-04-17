package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.News;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/4.
 */
public interface INewsService {
    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.NewsServiceImpl";


    void saveNews(News news);

    public List<News> findNewsByCondition(News news, String beginTime, String endTime);

    void update(News news);

    void deleteNewsByIds(Serializable... ids);

    News findNewsByID(News news);

}
