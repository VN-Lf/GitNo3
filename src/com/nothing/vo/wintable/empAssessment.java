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
    private String empexamid;   //考核类型id
    private String empid;//员工id
    private String classid;//班级id
    private Integer scores;//总评分

    public Integer getEmpAssessId() {
        return empAssessId;
    }

    public void setEmpAssessId(Integer empAssessId) {
        this.empAssessId = empAssessId;
    }

    public String getEmpexamid() {
        return empexamid;
    }

    public void setEmpexamid(String empexamid) {
        this.empexamid = empexamid;
    }

    public String getEmpid() {
        return empid;
    }

    public void setEmpid(String empid) {
        this.empid = empid;
    }

    public String getClassid() {
        return classid;
    }

    public void setClassid(String classid) {
        this.classid = classid;
    }

    public Integer getScores() {
        return scores;
    }

    public void setScores(Integer scores) {
        this.scores = scores;
    }
}
