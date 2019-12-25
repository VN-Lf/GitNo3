package com.nothing.vo.emp;

import javax.persistence.*;

@Table(name="weekArrange")
@Entity
public class WeekArrange{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2400, allocationSize = 1)
    private Integer weekArrangeId;
    private String weekArrangeName;//值班名称
    private String ranges;//值班要求
    private String week;//周几
    private String empId;
    private String startTime;//开始时间
    private String endTime;
    private String remark;//说明

    public Integer getWeekArrangeid() {
        return weekArrangeId;
    }

    public void setWeekArrangeid(Integer weekArrangeId) {
        this.weekArrangeId = weekArrangeId;
    }

    public String getWeekArrangeName() {
        return weekArrangeName;
    }

    public void setWeekArrangeName(String weekArrangeName) {
        this.weekArrangeName = weekArrangeName;
    }

    public String getRanges() {
        return ranges;
    }

    public void setRanges(String ranges) {
        this.ranges = ranges;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
