package com.nothing.vo.wintable;

import javax.persistence.*;

@Entity
@Table(name = "emkaohu")
public class Empkaohe {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer empkaohuid;

    public Integer getEmpAssessId() {
        return empAssessId;
    }

    public void setEmpAssessId(Integer empAssessId) {
        this.empAssessId = empAssessId;
    }

    private Integer empAssessId;  //考核id
    private String studentname;   //学生姓名
    private String examtype;     //考核类型
    private Integer kaohuscore;      //考核分数

    public Integer getEmpkaohuid() {
        return empkaohuid;
    }

    public void setEmpkaohuid(Integer empkaohuid) {
        this.empkaohuid = empkaohuid;
    }

    public String getStudentname() {
        return studentname;
    }

    public void setStudentname(String studentname) {
        this.studentname = studentname;
    }

    public String getExamtype() {
        return examtype;
    }

    public void setExamtype(String examtype) {
        this.examtype = examtype;
    }

    public Integer getKaohuscore() {
        return kaohuscore;
    }

    public void setKaohuscore(Integer kaohuscore) {
        this.kaohuscore = kaohuscore;
    }
}
