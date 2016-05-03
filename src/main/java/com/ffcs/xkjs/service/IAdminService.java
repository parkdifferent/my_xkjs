package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Admin;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/4/27.
 */
public interface IAdminService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.AdminServiceImpl";

    void saveAdmin(Admin admin);

    public List<Admin> findAdminByCondition(Admin admin);

    void update(Admin admin);

    void deleteAdminByIds(Serializable... ids);

    Admin findAdminByID(String adminId);

    Admin findAdminByUserName(String userName);

    
    
}
