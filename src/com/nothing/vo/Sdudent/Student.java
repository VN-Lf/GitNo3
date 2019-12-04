package com.nothing.vo.Sdudent;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="Student")
public class Student{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =3000, allocationSize = 1)

    private Integer studId;
    private String stuPsw;

    private String stuName;
    private String stuHisSchool;//毕业院校
    private String stuSex;
    private Integer stuAge;

    private Date stuBirthday;
    private String stuPhone;
    private String  stuAddr;//地址
    private Integer stuCla;
    private  Integer stuHouse; //寝室标号
    private  Date  stuEnterTime;//入学时间
    private String interTecher;//介绍老师
    private Integer stuStu;
    private String stuNation;//民族
    private String  stuNatives;//籍贯
    private String residence;
    private Integer cardId;
    private String stuProfessional;//专业
    private String stuProLevel;//专业类别
    private  String studyType;

    private String audition;//面试人
    private Integer isvocational;//是否中专
    private Integer qkMoney;   //欠款金额
    private Double score;//入学成绩
    private String dibao;//低保
    private String sourceType;
    private String danbaoren;//担保人
    private String soldier;//兵役
    private String baominghao;//报名号
    private String zhuxiao;
    private String StuRemark;
    private String tuixue;
    private String xiuxue;
    private String stuno;
    private String isComputer;
    private String collar;
    private String zhuxuejin;

    public Integer getStudId() {
        return studId;
    }

    public void setStudId(Integer studId) {
        this.studId = studId;
    }

    public String getStuPsw() {
        return stuPsw;
    }

    public void setStuPsw(String stuPsw) {
        this.stuPsw = stuPsw;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getStuHisSchool() {
        return stuHisSchool;
    }

    public void setStuHisSchool(String stuHisSchool) {
        this.stuHisSchool = stuHisSchool;
    }

    public String getStuSex() {
        return stuSex;
    }

    public void setStuSex(String stuSex) {
        this.stuSex = stuSex;
    }

    public Integer getStuAge() {
        return stuAge;
    }

    public void setStuAge(Integer stuAge) {
        this.stuAge = stuAge;
    }

    public Date getStuBirthday() {
        return stuBirthday;
    }

    public void setStuBirthday(Date stuBirthday) {
        this.stuBirthday = stuBirthday;
    }

    public String getStuPhone() {
        return stuPhone;
    }

    public void setStuPhone(String stuPhone) {
        this.stuPhone = stuPhone;
    }

    public String getStuAddr() {
        return stuAddr;
    }

    public void setStuAddr(String stuAddr) {
        this.stuAddr = stuAddr;
    }

    public Integer getStuCla() {
        return stuCla;
    }

    public void setStuCla(Integer stuCla) {
        this.stuCla = stuCla;
    }

    public Integer getStuHouse() {
        return stuHouse;
    }

    public void setStuHouse(Integer stuHouse) {
        this.stuHouse = stuHouse;
    }

    public Date getStuEnterTime() {
        return stuEnterTime;
    }

    public void setStuEnterTime(Date stuEnterTime) {
        this.stuEnterTime = stuEnterTime;
    }

    public String getInterTecher() {
        return interTecher;
    }

    public void setInterTecher(String interTecher) {
        this.interTecher = interTecher;
    }

    public Integer getStuStu() {
        return stuStu;
    }

    public void setStuStu(Integer stuStu) {
        this.stuStu = stuStu;
    }

    public String getStuNation() {
        return stuNation;
    }

    public void setStuNation(String stuNation) {
        this.stuNation = stuNation;
    }

    public String getStuNatives() {
        return stuNatives;
    }

    public void setStuNatives(String stuNatives) {
        this.stuNatives = stuNatives;
    }

    public String getResidence() {
        return residence;
    }

    public void setResidence(String residence) {
        this.residence = residence;
    }

    public Integer getCardId() {
        return cardId;
    }

    public void setCardId(Integer cardId) {
        this.cardId = cardId;
    }

    public String getStuProfessional() {
        return stuProfessional;
    }

    public void setStuProfessional(String stuProfessional) {
        this.stuProfessional = stuProfessional;
    }

    public String getStuProLevel() {
        return stuProLevel;
    }

    public void setStuProLevel(String stuProLevel) {
        this.stuProLevel = stuProLevel;
    }

    public String getStudyType() {
        return studyType;
    }

    public void setStudyType(String studyType) {
        this.studyType = studyType;
    }


    public String getAudition() {
        return audition;
    }

    public void setAudition(String audition) {
        this.audition = audition;
    }

    public Integer getIsvocational() {
        return isvocational;
    }

    public void setIsvocational(Integer isvocational) {
        this.isvocational = isvocational;
    }

    public Integer getQkMoney() {
        return qkMoney;
    }

    public void setQkMoney(Integer qkMoney) {
        this.qkMoney = qkMoney;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getDibao() {
        return dibao;
    }

    public void setDibao(String dibao) {
        this.dibao = dibao;
    }

    public String getSourceType() {
        return sourceType;
    }

    public void setSourceType(String sourceType) {
        this.sourceType = sourceType;
    }

    public String getDanbaoren() {
        return danbaoren;
    }

    public void setDanbaoren(String danbaoren) {
        this.danbaoren = danbaoren;
    }

    public String getSoldier() {
        return soldier;
    }

    public void setSoldier(String soldier) {
        this.soldier = soldier;
    }

    public String getBaominghao() {
        return baominghao;
    }

    public void setBaominghao(String baominghao) {
        this.baominghao = baominghao;
    }

    public String getZhuxiao() {
        return zhuxiao;
    }

    public void setZhuxiao(String zhuxiao) {
        this.zhuxiao = zhuxiao;
    }

    public String getStuRemark() {
        return StuRemark;
    }

    public void setStuRemark(String stuRemark) {
        StuRemark = stuRemark;
    }

    public String getTuixue() {
        return tuixue;
    }

    public void setTuixue(String tuixue) {
        this.tuixue = tuixue;
    }

    public String getXiuxue() {
        return xiuxue;
    }

    public void setXiuxue(String xiuxue) {
        this.xiuxue = xiuxue;
    }

    public String getStuno() {
        return stuno;
    }

    public void setStuno(String stuno) {
        this.stuno = stuno;
    }

    public String getIsComputer() {
        return isComputer;
    }

    public void setIsComputer(String isComputer) {
        this.isComputer = isComputer;
    }

    public String getCollar() {
        return collar;
    }

    public void setCollar(String collar) {
        this.collar = collar;
    }

    public String getZhuxuejin() {
        return zhuxuejin;
    }

    public void setZhuxuejin(String zhuxuejin) {
        this.zhuxuejin = zhuxuejin;
    }
}
