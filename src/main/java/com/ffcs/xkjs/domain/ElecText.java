package com.ffcs.xkjs.domain;

import java.util.Date;

/**
 * Created by tianf on 2016/3/27.
 */
@SuppressWarnings("serial")
public class ElecText implements java.io.Serializable {
    private String textID;
    private String textName;
    private Date textDate;
    private String textRemark;

    public String getTextID() {
        return textID;
    }
    public void setTextID(String textID) {
        this.textID = textID;
    }
    public String getTextName() {
        return textName;
    }
    public void setTextName(String textName) {
        this.textName = textName;
    }
    public Date getTextDate() {
        return textDate;
    }
    public void setTextDate(Date textDate) {
        this.textDate = textDate;
    }
    public String getTextRemark() {
        return textRemark;
    }
    public void setTextRemark(String textRemark) {
        this.textRemark = textRemark;
    }


}
