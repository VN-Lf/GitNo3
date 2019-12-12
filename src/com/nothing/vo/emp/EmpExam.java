package com.nothing.vo.emp;

import javax.persistence.*;

//员工考试表
@Entity
@Table(name="EmpExam")
public class EmpExam {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =300, allocationSize = 1)
    private Integer empexamid;
    private String empexamname;

    public String getEmpexamname() {
        return empexamname;
    }

    public void setEmpexamname(String empexamname) {
        this.empexamname = empexamname;
    }

    private  String  exam1;
    private String exam2;
    private  String  exam3;
    private String exam4;
    private  String  exam5;

    public Integer getEmpexamid() {
        return empexamid;
    }

    public void setEmpexamid(Integer empexamid) {
        this.empexamid = empexamid;
    }

    public String getExam1() {
        return exam1;
    }

    public void setExam1(String exam1) {
        this.exam1 = exam1;
    }

    public String getExam2() {
        return exam2;
    }

    public void setExam2(String exam2) {
        this.exam2 = exam2;
    }

    public String getExam3() {
        return exam3;
    }

    public void setExam3(String exam3) {
        this.exam3 = exam3;
    }

    public String getExam4() {
        return exam4;
    }

    public void setExam4(String exam4) {
        this.exam4 = exam4;
    }

    public String getExam5() {
        return exam5;
    }

    public void setExam5(String exam5) {
        this.exam5 = exam5;
    }
}
