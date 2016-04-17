package com.ffcs.xkjs.dao;

import com.ffcs.xkjs.domain.News;

/**
 * Created by tianf on 2016/4/4.
 */
public interface INewsDao extends ICommonDao<News> {
    public static final String SERVICE_NAME = "com.ffcs.xkjs.dao.impl.NewsDaoImpl";
}
