package com.ffcs.xkjs.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by tianf on 2016/4/8.
 */
@SuppressWarnings("serial")
public class Academe implements java.io.Serializable {

    private Integer academeId;

    private String academeName;

    private Set<Profession> professions=new HashSet<Profession>();          //专业


    public Integer getAcademeId() {
        return academeId;
    }

    public void setAcademeId(Integer academeId) {
        this.academeId = academeId;
    }

    public String getAcademeName() {
        return academeName;
    }

    public void setAcademeName(String academeName) {
        this.academeName = academeName;
    }

    public Set<Profession> getProfessions() {
        return professions;
    }

    public void setProfessions(Set<Profession> professions) {
        this.professions = professions;
    }
}
