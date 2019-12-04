package com.nothing.vo.wintable;

import javax.persistence.*;

/**
 * 考核指标表
 */
@Entity
@Table(name = "aduitModel")
public class aduitModel {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer aduitModelid;
    private String aduitName;   //考核内容
    private Integer Scores;     //考核分数
    private Integer Depid;      //部门表
    private String Remark;      //说明

    public Integer getAduitModelid() {
        return aduitModelid;
    }

    public void setAduitModelid(Integer aduitModelid) {
        this.aduitModelid = aduitModelid;
    }

    public String getAduitName() {
        return aduitName;
    }

    public void setAduitName(String aduitName) {
        this.aduitName = aduitName;
    }

    public Integer getScores() {
        return Scores;
    }

    public void setScores(Integer scores) {
        Scores = scores;
    }

    public Integer getDepid() {
        return Depid;
    }

    public void setDepid(Integer depid) {
        Depid = depid;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }
}
