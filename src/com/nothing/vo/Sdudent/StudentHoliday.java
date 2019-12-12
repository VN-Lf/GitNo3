package com.nothing.vo.Sdudent;

import javax.persistence.*;
import java.util.Date;//
//学生请假表
@Entity
@Table(name="StudentHoliday")
public class StudentHoliday{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =3500, allocationSize = 1)
    private Integer holidayId;
    private Integer studId;
    private Integer holidayDay;
    private Date startTime;
    private Date endTime;
    private String Title;
    private String holidayRemark;
    private Integer holidayStatus;

    public Integer getHolidayId() {
        return holidayId;
    }

    public void setHolidayId(Integer holidayId) {
        this.holidayId = holidayId;
    }

    public Integer getStudId() {
        return studId;
    }

    public void setStudId(Integer studId) {
        this.studId = studId;
    }

    public Integer getHolidayDay() {
        return holidayDay;
    }

    public void setHolidayDay(Integer holidayDay) {
        this.holidayDay = holidayDay;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public String getHolidayRemark() {
        return holidayRemark;
    }

    public void setHolidayRemark(String holidayRemark) {
        this.holidayRemark = holidayRemark;
    }

    public Integer getHolidayStatus() {
        return holidayStatus;
    }

    public void setHolidayStatus(Integer holidayStatus){
        this.holidayStatus = holidayStatus;
    }
}

