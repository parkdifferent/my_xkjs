package com.ffcs.xkjs.domain;

import java.util.Date;
import java.util.Set;

/**
 * Created by tianf on 2016/4/7.
 */
@SuppressWarnings("serial")
public class Enter implements java.io.Serializable {

    private String enterId;


    //private Set<Competition> competitions;


    private String sno;   //学号

    private String grade;   //年级

    private String academe;   //学院

    private String profession;  //专业

    private String classes;     //班级

    private String trueName;   //姓名

    private String telephone;   //手机

    private String email;   //邮箱




    private String comName;  //  竞赛项目

    private String form;      //参赛形式   团体赛/个人赛


    private Date enterDate;     //报名时间

    private Integer auditStatus=0;   //   审核   0审核   1已审核


    public String getEnterId() {
        return enterId;
    }

    public void setEnterId(String enterId) {
        this.enterId = enterId;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getAcademe() {
        return academe;
    }

    public void setAcademe(String academe) {
        this.academe = academe;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getTrueName() {
        return trueName;
    }

    public void setTrueName(String trueName) {
        this.trueName = trueName;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public Date getEnterDate() {
        return enterDate;
    }

    public void setEnterDate(Date enterDate) {
        this.enterDate = enterDate;
    }

    public Integer getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(Integer auditStatus) {
        this.auditStatus = auditStatus;
    }
}
