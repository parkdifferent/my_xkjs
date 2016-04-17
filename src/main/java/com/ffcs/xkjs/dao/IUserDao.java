package com.ffcs.xkjs.dao;

import com.ffcs.xkjs.domain.User;

/**
 * Created by tianf on 2016/4/6.
 */
public interface IUserDao extends ICommonDao<User> {
    public static final String SERVICE_NAME = "com.ffcs.xkjs.dao.impl.UserDaoImpl";
}
