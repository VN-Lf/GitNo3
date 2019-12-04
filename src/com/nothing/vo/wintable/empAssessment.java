package com.nothing.vo.wintable;

import javax.persistence.*;

/**
 * 员工考核表
 */
@Entity
@Table(name = "empAssessment")
public class empAssessment {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer empAssessId;
    private Integer aduitModelid;   //考核指标表id
    private float scores;     //考核分数
    private Integer empAssTotalId;      //考核总表

    public Integer getEmpAssessId() {
        return empAssessId;
    }

    public void setEmpAssessId(Integer empAssessId) {
        this.empAssessId = empAssessId;
    }

    public Integer getAduitModelid() {
        return aduitModelid;
    }

    public void setAduitModelid(Integer aduitModelid) {
        this.aduitModelid = aduitModelid;
    }

    public float getScores() {
        return scores;
    }

    public void setScores(float scores) {
        this.scores = scores;
    }

    public Integer getEmpAssTotalId() {
        return empAssTotalId;
    }

    public void setEmpAssTotalId(Integer empAssTotalId) {
        this.empAssTotalId = empAssTotalId;
    }
}
