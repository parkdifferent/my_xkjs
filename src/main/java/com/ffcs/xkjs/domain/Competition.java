package com.ffcs.xkjs.domain;

import java.util.Date;

/**
 * Created by tianf on 2016/4/7.
 */
@SuppressWarnings("serial")
public class Competition implements java.io.Serializable {

    private String comId;

    private String comName;    //竞赛名称

    private String organizer;  //主办单位

    private String responsibleUnit;  //校内负责单位

    private String category;     //竞赛类别   创新创业类/学科知识类/文化素质类/体育竞赛类

    private String level;        //竞赛级别

    private String form;      //参赛形式   团体赛/个人赛

    private Date startDate;       //起始日期

                                   //附件

    private String fileName;
    private String filePath;


    private Integer status = 0;              //    0 未开始    1  开始报名    2  报名截止


    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public String getOrganizer() {
        return organizer;
    }

    public void setOrganizer(String organizer) {
        this.organizer = organizer;
    }

    public String getResponsibleUnit() {
        return responsibleUnit;
    }

    public void setResponsibleUnit(String responsibleUnit) {
        this.responsibleUnit = responsibleUnit;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }


    @Override
    public String toString() {
        return "Competition{" +
                "comId='" + comId + '\'' +
                ", comName='" + comName + '\'' +
                ", organizer='" + organizer + '\'' +
                ", responsibleUnit='" + responsibleUnit + '\'' +
                ", category='" + category + '\'' +
                ", level='" + level + '\'' +
                ", form='" + form + '\'' +
                ", startDate=" + startDate +
                ", fileName='" + fileName + '\'' +
                ", filePath='" + filePath + '\'' +
                ", status=" + status +
                '}';
    }
}
