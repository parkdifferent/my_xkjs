package com.ffcs.xkjs.dao.impl;

/**
 * Created by tianf on 2016/3/27.
 */

import com.ffcs.xkjs.dao.IElecTextDao;
import com.ffcs.xkjs.domain.ElecText;
import org.springframework.stereotype.Repository;

/**
 * @Repository(IElecTextDao.SERVICE_NAME)
 * 相当于在spring容器中定义：
 * <bean id="com.itheima.elec.dao.impl.ElecTextDaoImpl" class="com.itheima.elec.dao.impl.ElecTextDaoImpl">
 *
 */
@Repository(IElecTextDao.SERVICE_NAME)
public class ElecTextDaoImpl  extends CommonDaoImpl<ElecText> implements IElecTextDao {

}

