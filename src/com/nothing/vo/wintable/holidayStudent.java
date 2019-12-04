package com.nothing.vo.wintable;

import javax.persistence.*;
import java.util.Date;

/**
 * 老师或学生请假
 */
@Entity
@Table(name = "holidayStudent")
public class holidayStudent {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer holidayId;
    private Integer userId;//教师或学生主键
    private Integer holidayDay;//假期天数
    private Date startTime;
    private Date endTime;
    private String title;//标题
    private String Remark;//内容
    private String Status;//审批状态
    private String type; //请假人员类型

    public Integer getHolidayId() {
        return holidayId;
    }

    public void setHolidayId(Integer holidayId) {
        this.holidayId = holidayId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        userId = userId;
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
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
