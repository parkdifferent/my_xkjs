package com.ffcs.xkjs.dao;

import com.ffcs.xkjs.domain.Admin;

/**
 * Created by tianf on 2016/4/27.
 */
public interface IAdminDao extends ICommonDao<Admin> {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.dao.impl.AdminDaoImpl";
}
