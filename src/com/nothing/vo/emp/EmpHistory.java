package com.nothing.vo.emp;

import org.springframework.stereotype.Repository;

import javax.persistence.*;

//员工工作经历表
@Entity
@Table(name = "EmpHistory")
public class EmpHistory{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2300, allocationSize = 1)
    private Integer empHisId;
    private Integer empId;
    private String empHisCompany;
    private String empHisDegree; //岗位
    private String empHisStartDay;
    private String empHisEndDay;
    private String empLiftReason;
    private String empHisRemark;

    public int getEmpHisId() {
        return empHisId;
    }

    public void setEmpHisId(int empHisId) {
        this.empHisId = empHisId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getEmpHisCompany() {
        return empHisCompany;
    }

    public void setEmpHisCompany(String empHisCompany) {
        this.empHisCompany = empHisCompany;
    }

    public String getEmpHisDegree() {
        return empHisDegree;
    }

    public void setEmpHisDegree(String empHisDegree) {
        this.empHisDegree = empHisDegree;
    }

    public String getEmpHisStartDay() {
        return empHisStartDay;
    }

    public void setEmpHisStartDay(String empHisStartDay) {
        this.empHisStartDay = empHisStartDay;
    }

    public String getEmpHisEndDay() {
        return empHisEndDay;
    }

    public void setEmpHisEndDay(String empHisEndDay) {
        this.empHisEndDay = empHisEndDay;
    }

    public String getEmpLiftReason() {
        return empLiftReason;
    }

    public void setEmpLiftReason(String empLiftReason) {
        this.empLiftReason = empLiftReason;
    }

    public String getEmpHisRemark() {
        return empHisRemark;
    }

    public void setEmpHisRemark(String empHisRemark) {
        this.empHisRemark = empHisRemark;
    }
}
