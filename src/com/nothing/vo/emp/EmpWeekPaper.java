package com.nothing.vo.emp;

import javax.persistence.*;
import java.util.Date;

//员工周报
@Table(name="EmpWeekPaper")
@Entity
public class EmpWeekPaper{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2400, allocationSize = 1)
    private Integer weekPaperId;
    private Integer empId;
    private Date weekCycle;
    private String weekDescription;//工作描述
    private String weekOption;//工作意见
    private String weekStudentQuestion;//学生问题
    private String weekNextPlan;//下周工作计划
    private  String weekTerm;//工作学期

    public Integer getWeekPaperId() {
        return weekPaperId;
    }

    public void setWeekPaperId(Integer weekPaperId) {
        this.weekPaperId = weekPaperId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public Date getWeekCycle() {
        return weekCycle;
    }

    public void setWeekCycle(Date weekCycle) {
        this.weekCycle = weekCycle;
    }

    public String getWeekDescription() {
        return weekDescription;
    }

    public void setWeekDescription(String weekDescription) {
        this.weekDescription = weekDescription;
    }

    public String getWeekOption() {
        return weekOption;
    }

    public void setWeekOption(String weekOption) {
        this.weekOption = weekOption;
    }

    public String getWeekStudentQuestion() {
        return weekStudentQuestion;
    }

    public void setWeekStudentQuestion(String weekStudentQuestion) {
        this.weekStudentQuestion = weekStudentQuestion;
    }

    public String getWeekNextPlan() {
        return weekNextPlan;
    }

    public void setWeekNextPlan(String weekNextPlan) {
        this.weekNextPlan = weekNextPlan;
    }

    public String getWeekTerm() {
        return weekTerm;
    }

    public void setWeekTerm(String weekTerm) {
        this.weekTerm = weekTerm;
    }
}
