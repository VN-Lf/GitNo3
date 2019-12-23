package com.nothing.vo.Edu;

import javax.persistence.*;
import java.util.Date;
//试讲与培训计划表  Trial
@Table(name="Trial")
@Entity
public class Trial{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =700, allocationSize = 1)
    private Integer trialId;
    private  Date  trialDate; //日期
    private  Integer trialWeekDay; //工作日
    private  Integer  courseId; //关联课程/章节id
    private  Integer trialType; //授课类型(试讲/培训)
    private  Integer    empId; //授课老师
    private  String   trialRemark; //备注

    public Integer getTrialId() {
        return trialId;
    }

    public void setTrialId(Integer trialId) {
        this.trialId = trialId;
    }

    public Date getTrialDate() {
        return trialDate;
    }

    public void setTrialDate(Date trialDate) {
        this.trialDate = trialDate;
    }

    public Integer getTrialWeekDay() {
        return trialWeekDay;
    }

    public void setTrialWeekDay(Integer trialWeekDay) {
        this.trialWeekDay = trialWeekDay;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getTrialType() {
        return trialType;
    }

    public void setTrialType(Integer trialType) {
        this.trialType = trialType;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getTrialRemark() {
        return trialRemark;
    }

    public void setTrialRemark(String trialRemark) {
        this.trialRemark = trialRemark;
    }
}
