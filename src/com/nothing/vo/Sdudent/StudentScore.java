package com.nothing.vo.Sdudent;

import javax.persistence.*;
import java.util.Date;
@Entity
@Table(name="StudentScore")
public class StudentScore{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =3000, allocationSize = 1)
    private          Integer scoreId; //成绩主键id
    private          Integer studId;//学生表外键
    private          Integer score;//学生成绩
    private          Integer bukao;//补考成绩
    private          Integer courseId;//关联课程id
    private          Integer testType;//1:笔试2:机试3:模拟面试
    private          Integer termId;//关联学期id
    private           Date scoreTime ;//考试时间
    private          Integer empId;//录入人员,获取session值
    private          String remark;//备注
    public Integer getScoreId() {
        return scoreId;
    }

    public void setScoreId(Integer scoreId) {
        this.scoreId = scoreId;
    }

    public Integer getStudId() {
        return studId;
    }

    public void setStudId(Integer studId) {
        this.studId = studId;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }



    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getTestType() {
        return testType;
    }

    public void setTestType(Integer testType) {
        this.testType = testType;
    }

    public Integer getTermId() {
        return termId;
    }

    public void setTermId(Integer termId) {
        this.termId = termId;
    }

    public Date getScoreTime() {
        return scoreTime;
    }

    public void setScoreTime(Date scoreTime) {
        this.scoreTime = scoreTime;
    }

    public Integer getBukao() {
        return bukao;
    }

    public void setBukao(Integer bukao) {
        this.bukao = bukao;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "StudentScore{" +
                "scoreId=" + scoreId +
                ", studId=" + studId +
                ", score=" + score +
                ", bukao=" + bukao +
                ", courseId=" + courseId +
                ", testType=" + testType +
                ", termId=" + termId +
                ", scoreTime=" + scoreTime +
                ", empId=" + empId +
                ", remark='" + remark + '\'' +
                '}';
    }
}
