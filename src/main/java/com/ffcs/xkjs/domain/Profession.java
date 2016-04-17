package com.ffcs.xkjs.domain;

/**
 * Created by tianf on 2016/4/8.
 */
@SuppressWarnings("serial")
public class Profession implements java.io.Serializable {

    private Integer proId;

    private String professionName;

    private Academe academe;        //所属学院


    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public String getProfessionName() {
        return professionName;
    }

    public void setProfessionName(String professionName) {
        this.professionName = professionName;
    }

    public Academe getAcademe() {
        return academe;
    }

    public void setAcademe(Academe academe) {
        this.academe = academe;
    }
}



