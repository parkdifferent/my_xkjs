package com.ffcs.xkjs.dao.impl;

import com.ffcs.xkjs.dao.IUserDao;
import com.ffcs.xkjs.domain.User;
import org.springframework.stereotype.Repository;

/**
 * Created by tianf on 2016/4/6.
 */

@Repository(IUserDao.SERVICE_NAME)
public class UserDaoImpl extends CommonDaoImpl<User> implements IUserDao {
}
