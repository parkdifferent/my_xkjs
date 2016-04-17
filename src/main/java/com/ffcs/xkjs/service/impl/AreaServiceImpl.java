package com.ffcs.xkjs.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.ffcs.xkjs.dao.IAreaDao;
import com.ffcs.xkjs.domain.Area;
import com.ffcs.xkjs.service.IAreaService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;



/**
 * Created by tianf on 2016/3/27.
 */
@Service(IAreaService.SERVICE_NAME)
@Transactional(readOnly=true)
public class AreaServiceImpl implements IAreaService{

    @Resource(name= IAreaDao.SERVICE_NAME)
    IAreaDao areaDao;

    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void saveArea(Area area) {
        areaDao.save(area);
    }

    public Area findAreaByID(Serializable id) {

        Area area=areaDao.findObjectByID(id);
        return area;
    }

    public List<Area> findCollectionByConditionNoPage(Integer areaId) {
        //查询条件
        String condition = "";
        //查询条件对应的参数
        List<Object> paramsList = new ArrayList<Object>();

        if(areaId!=null){
            condition += " and o.areaId = ?";
            paramsList.add(areaId);
        }

        //传递可变参数
        Object [] params = paramsList.toArray();
        //排序
        Map<String, String> orderby = new LinkedHashMap<String, String>();//有序
		/*orderby.put("o.textDate", "asc");
		orderby.put("o.textName", "desc");*/
        //查询
        List<Area> list = areaDao.findCollectionByConditionNoPage(condition,params,orderby);
        return list;
    }

    @Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
    public void update(Area area) {
        areaDao.update(area);

    }

}

