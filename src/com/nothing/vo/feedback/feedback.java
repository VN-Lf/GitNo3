package com.nothing.vo.feedback;

import javax.persistence.*;
import java.util.Date;
@Entity
@Table(name = "feedback")
public class feedback {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer feedbackId;
    private Integer feedBackType;
    private String empId;
    private String empname;
    private Date feedbackTime;
    private String remark;
    private String image;
    private Integer status;
    private Integer deptId;
    private String opinion;
    private String userId;

    public Integer getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(Integer feedbackId) {
        this.feedbackId = feedbackId;
    }

    public Integer getFeedBackType() {
        return feedBackType;
    }

    public void setFeedBackType(Integer feedBackType) {
        this.feedBackType = feedBackType;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getEmpname() {
        return empname;
    }

    public void setEmpname(String empname) {
        this.empname = empname;
    }

    public Date getFeedbackTime() {
        return feedbackTime;
    }

    public void setFeedbackTime(Date feedbackTime) {
        this.feedbackTime = feedbackTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
