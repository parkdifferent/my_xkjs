package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.User;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/6.
 */
public interface IUserService {
    
    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.UserServiceImpl";

    void saveUser(User user);

    public List<User> findUserByCondition(User user);

    void update(User user);

    void deleteUserByIds(Serializable... ids);

    User findUserByID(User user);

    User findUserByUserName(String userName);
}
