package com.nothing.vo.wintable;

import javax.persistence.*;
import java.util.Date;

/**
 *考核巡查
 */
@Entity
@Table(name = "aduitLog")
public class aduitLog {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer aduitLogid;
    private String aduitModelid;   //考核指标
    private Integer empid;     //员工
    private Date auditDate;     //考核时间
    private String auditPerson;      //录入人员


    public Integer getAduitLogid() {
        return aduitLogid;
    }

    public void setAduitLogid(Integer aduitLogid) {
        this.aduitLogid = aduitLogid;
    }

    public String getAduitModelid() {
        return aduitModelid;
    }

    public void setAduitModelid(String aduitModelid) {
        this.aduitModelid = aduitModelid;
    }

    public Integer getEmpid() {
        return empid;
    }

    public void setEmpid(Integer empid) {
        this.empid = empid;
    }

    public Date getAuditDate() {
        return auditDate;
    }

    public void setAuditDate(Date auditDate) {
        this.auditDate = auditDate;
    }

    public String getAuditPerson() {
        return auditPerson;
    }

    public void setAuditPerson(String auditPerson) {
        this.auditPerson = auditPerson;
    }
}
