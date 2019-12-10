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
    private Integer empexamid;   //考核类型id
    private Integer empid;//员工id
    private Integer classid;//班级id
    private Integer scores;//总评分

    public Integer getEmpAssessId() {
        return empAssessId;
    }

    public void setEmpAssessId(Integer empAssessId) {
        this.empAssessId = empAssessId;
    }

    public Integer getEmpexamid() {
        return empexamid;
    }

    public void setEmpexamid(Integer empexamid) {
        this.empexamid = empexamid;
    }

    public Integer getEmpid() {
        return empid;
    }

    public void setEmpid(Integer empid) {
        this.empid = empid;
    }

    public Integer getClassid() {
        return classid;
    }

    public void setClassid(Integer classid) {
        this.classid = classid;
    }

    public Integer getScores() {
        return scores;
    }

    public void setScores(Integer scores) {
        this.scores = scores;
    }
}
