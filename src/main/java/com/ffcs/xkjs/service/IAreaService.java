package com.ffcs.xkjs.service;

import com.ffcs.xkjs.domain.Area;

import java.io.Serializable;
import java.util.List;

/**
 * Created by tianf on 2016/3/27.
 */
public interface IAreaService {

    public static final String SERVICE_NAME = "com.ffcs.xkjs.service.impl.AreaServiceImpl";

    void saveArea(Area area);

    Area findAreaByID(Serializable id);

    public List<Area> findCollectionByConditionNoPage(Integer areaId);

    void update(Area area);

}
