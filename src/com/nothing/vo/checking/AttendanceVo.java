package com.nothing.vo.checking;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "attendance")
public class AttendanceVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int attId; //编号
    private int empId; //员工姓名
    private Date punckClockTime; //打卡时间
    private String cause;   //原因说明
    private String auditor; //审核人
    private Date examineTime; //审核时间
    private String examineExplain; //审核说明
    private int status; //状态 1通过 2待审 3审核通过
    private Date applyTime;

    @Override
    public String toString() {
        return "AttendanceVo{" +
                "attId=" + attId +
                ", empId=" + empId +
                ", punckClockTime=" + punckClockTime +
                ", cause='" + cause + '\'' +
                ", auditor='" + auditor + '\'' +
                ", examineTime=" + examineTime +
                ", examineExplain='" + examineExplain + '\'' +
                ", status=" + status +
                ", applyTime=" + applyTime +
                '}';
    }

    public int getAttId() {
        return attId;
    }

    public void setAttId(int attId) {
        this.attId = attId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public Date getPunckClockTime() {
        return punckClockTime;
    }

    public void setPunckClockTime(Date punckClockTime) {
        this.punckClockTime = punckClockTime;
    }

    public String getCause() {
        return cause;
    }

    public void setCause(String cause) {
        this.cause = cause;
    }

    public String getAuditor() {
        return auditor;
    }

    public void setAuditor(String auditor) {
        this.auditor = auditor;
    }

    public Date getExamineTime() {
        return examineTime;
    }

    public void setExamineTime(Date examineTime) {
        this.examineTime = examineTime;
    }

    public String getExamineExplain() {
        return examineExplain;
    }

    public void setExamineExplain(String examineExplain) {
        this.examineExplain = examineExplain;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(Date applyTime) {
        this.applyTime = applyTime;
    }
}
