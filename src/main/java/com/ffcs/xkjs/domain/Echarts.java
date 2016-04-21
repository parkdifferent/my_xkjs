package com.ffcs.xkjs.domain;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by tianf on 2016/4/21.
 */
public class Echarts {



    private List<String> categoryList=new ArrayList<>();
    private List<Integer> seriesList=new ArrayList<>();

    public List<Integer> getSeriesList() {
        return seriesList;
    }

    public void setSeriesList(List<Integer> seriesList) {
        this.seriesList = seriesList;
    }

    public List<String> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<String> categoryList) {
        this.categoryList = categoryList;
    }


    @Override
    public String toString() {
        return "Echarts{" +
                "categoryList=" + categoryList +
                ", seriesList=" + seriesList +
                '}';
    }
}
