package com.nothing.vo.Sdudent;

import javax.persistence.*;
//学生事故状况表
@Table(name = "StuHappening")
@Entity
public class StuHappening{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2400, allocationSize = 1)
    private Integer stuHappenId;
    private Integer   studId;
    private String happening;
    private String opTime;
    private String empId;

    public Integer getStuHappenId() {
        return stuHappenId;
    }

    public void setStuHappenId(Integer stuHappenId) {
        this.stuHappenId = stuHappenId;
    }

    public Integer getStudId() {
        return studId;
    }

    public void setStudId(Integer studId) {
        this.studId = studId;
    }

    public String getHappening() {
        return happening;
    }

    public void setHappening(String happening) {
        this.happening = happening;
    }

    public String getOpTime() {
        return opTime;
    }

    public void setOpTime(String opTime) {
        this.opTime = opTime;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }
}
