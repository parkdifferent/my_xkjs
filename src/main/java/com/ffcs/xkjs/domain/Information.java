package com.ffcs.xkjs.domain;

import java.util.Date;

/**
 * Created by tianf on 2016/4/22.
 */
public class Information implements java.io.Serializable {

    private String infoId;

    private String fileName;

    private String filePath;

    private String description;


    private Date addTime;


    public String getInfoId() {
        return infoId;
    }

    public void setInfoId(String infoId) {
        this.infoId = infoId;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    @Override
    public String toString() {
        return "Information{" +
                "infoId='" + infoId + '\'' +
                ", fileName='" + fileName + '\'' +
                ", filePath='" + filePath + '\'' +
                ", description='" + description + '\'' +
                ", addTime=" + addTime +
                '}';
    }
}
