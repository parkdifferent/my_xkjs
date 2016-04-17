package com.ffcs.xkjs.domain;

/**
 * Created by tianf on 2016/3/27.
 */
@SuppressWarnings("serial")
public class Area implements java.io.Serializable {

    private Integer id;
    private Integer areaId;
    private String name;
    private String fullName;
    private Integer parentId;
    private Integer sort;
    private Integer deep;
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Integer getAreaId() {
        return areaId;
    }
    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public Integer getParentId() {
        return parentId;
    }
    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
    public Integer getSort() {
        return sort;
    }
    public void setSort(Integer sort) {
        this.sort = sort;
    }
    public Integer getDeep() {
        return deep;
    }
    public void setDeep(Integer deep) {
        this.deep = deep;
    }
}

