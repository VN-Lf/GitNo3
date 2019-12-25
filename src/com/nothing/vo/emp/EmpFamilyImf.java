package com.nothing.vo.emp;

import javax.persistence.*;
//员工家庭
@Entity
@Table(name="empFamilyImf")
public class EmpFamilyImf{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2200, allocationSize = 1)
    Integer empFamImfId;
    Integer empId;
    String empContact;//联系人名字
    String empRelation;
    String empContactphone;
    String empFamImfRemark;

    public Integer getEmpFamImfId() {
        return empFamImfId;
    }

    public void setEmpFamImfId(Integer empFamImfId) {
        this.empFamImfId = empFamImfId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpContact() {
        return empContact;
    }

    public void setEmpContact(String empContact) {
        this.empContact = empContact;
    }

    public String getEmpRelation() {
        return empRelation;
    }

    public void setEmpRelation(String empRelation) {
        this.empRelation = empRelation;
    }

    public String getEmpContactphone() {
        return empContactphone;
    }

    public void setEmpContactphone(String empContactphone) {
        this.empContactphone = empContactphone;
    }

    public String getEmpFamImfRemark() {
        return empFamImfRemark;
    }

    public void setEmpFamImfRemark(String empFamImfRemark) {
        this.empFamImfRemark = empFamImfRemark;
    }



}
