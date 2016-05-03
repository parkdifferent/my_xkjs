package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IAdminDao;
import com.ffcs.xkjs.domain.Admin;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/27.
 */

@Repository(IAdminDao.SERVICE_NAME)
public class AdminDaoImpl extends CommonDaoImpl<Admin> implements IAdminDao {


}
