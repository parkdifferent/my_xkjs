package com.ffcs.xkjs.domain;

/**
 * Created by tianf on 2016/4/26.
 */
public class Teacher implements java.io.Serializable {


    private String teaId;
    private String tno;   //工号
    private String name;  //姓名
    private String academe;  //所在学院
    private String education;   //学历
    private String rank;   //职称
    private String research;  //研究领域
    private String honor;       //所获荣誉
    private String brief;       //简介
    private String email;     //邮箱


    private String password;         //密码


    private String role;             //角色




    public String getTeaId() {
        return teaId;
    }

    public void setTeaId(String teaId) {
        this.teaId = teaId;
    }

    public String getTno() {
        return tno;
    }

    public void setTno(String tno) {
        this.tno = tno;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAcademe() {
        return academe;
    }

    public void setAcademe(String academe) {
        this.academe = academe;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getResearch() {
        return research;
    }

    public void setResearch(String research) {
        this.research = research;
    }

    public String getHonor() {
        return honor;
    }

    public void setHonor(String honor) {
        this.honor = honor;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
