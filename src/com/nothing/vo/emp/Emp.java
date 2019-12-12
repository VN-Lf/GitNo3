package com.nothing.vo.emp;

import javax.persistence.*;
import java.util.Date;

/**
 * 员工表
 */
@Entity
@Table(name = "Emp")
public class Emp{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =1000, allocationSize = 1)
    private Integer empId;
    private String empName;
    private Integer empDeptId;
    private String empSex;
    private Date empBirthday;
    private String empCardno;
    private String empNation;
    private String empPhone;
    private String empQQ;
    private String empWeixin;
    private String empEmail;
    private String empMarried; //已婚，单身，离异，丧偶
    private String empAddress;
    private String empRemark;
    private String empBank;
    private String empBankaccountName;
    private String empBankNumber;
    private String empAlipay;
    private  Date empHireday;
    private  Date empFireday;
    private String empLogPsw;
    private Integer  empLoginStatus; //登录状态


    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public int getEmpDeptId() {
        return empDeptId;
    }

    public void setEmpDeptId(int empDeptId) {
        this.empDeptId = empDeptId;
    }

    public String getEmpSex() {
        return empSex;
    }

    public void setEmpSex(String empSex) {
        this.empSex = empSex;
    }

    public Date getEmpBirthday() {
        return empBirthday;
    }

    public void setEmpBirthday(Date empBirthday) {
        this.empBirthday = empBirthday;
    }

    public String getEmpCardno() {
        return empCardno;
    }

    public void setEmpCardno(String empCardno){
        this.empCardno = empCardno;
    }

    public String getEmpNation() {
        return empNation;
    }

    public void setEmpNation(String empNation) {
        this.empNation = empNation;
    }

    public String getEmpPhone() {
        return empPhone;
    }

    public void setEmpPhone(String empPhone) {
        this.empPhone = empPhone;
    }

    public String getEmpQQ() {
        return empQQ;
    }

    public void setEmpQQ(String empQQ) {
        this.empQQ = empQQ;
    }

    public String getEmpWeixin() {
        return empWeixin;
    }

    public void setEmpWeixin(String empWeixin) {
        this.empWeixin = empWeixin;
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public String getEmpMarried() {
        return empMarried;
    }

    public void setEmpMarried(String empMarried) {
        this.empMarried = empMarried;
    }


    public String getEmpAddress() {
        return empAddress;
    }

    public void setEmpAddress(String empAddress) {
        this.empAddress = empAddress;
    }

    public String getEmpRemark() {
        return empRemark;
    }

    public void setEmpRemark(String empRemark) {
        this.empRemark = empRemark;
    }

    public String getEmpBank() {
        return empBank;
    }

    public void setEmpBank(String empBank) {
        this.empBank = empBank;
    }

    public String getEmpBankaccountName() {
        return empBankaccountName;
    }

    public void setEmpBankaccountName(String empBankaccountName) {
        this.empBankaccountName = empBankaccountName;
    }

    public String getEmpBankNumber() {
        return empBankNumber;
    }

    public void setEmpBankNumber(String empBankNumber) {
        this.empBankNumber = empBankNumber;
    }

    public String getEmpAlipay() {
        return empAlipay;
    }

    public void setEmpAlipay(String empAlipay) {
        this.empAlipay = empAlipay;
    }

    public Date getEmpHireday() {
        return empHireday;
    }

    public void setEmpHireday(Date empHireday) {
        this.empHireday = empHireday;
    }

    public Date getEmpFireday() {
        return empFireday;
    }

    public void setEmpFireday(Date empFireday) {
        this.empFireday = empFireday;
    }

    public String getEmpLogPsw() {
        return empLogPsw;
    }

    public void setEmpLogPsw(String empLogPsw) {
        this.empLogPsw = empLogPsw;
    }

    public int getEmpLoginStatus() {
        return empLoginStatus;
    }

    public void setEmpLoginStatus(int empLoginStatus) {
        this.empLoginStatus = empLoginStatus;
    }
}
