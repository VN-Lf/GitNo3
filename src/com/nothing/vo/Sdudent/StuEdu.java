package com.nothing.vo.Sdudent;

import javax.persistence.*;
import java.util.Date;
//学生教育经历//
@Table
@Entity(name="stuEdu")
public class StuEdu{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =4000, allocationSize = 1)

   private Integer EduId;
   private String  studId;
   private String hisSchool;
   private Date beginDate;
   private Date endDate;

    public Integer getEduId() {
        return EduId;
    }

    public void setEduId(Integer eduId) {
        EduId = eduId;
    }

    public String getStudId(){
        return studId;
    }

    public void setStudId(String studId) {
        this.studId = studId;
    }

    public String getHisSchool() {
        return hisSchool;
    }

    public void setHisSchool(String hisSchool) {
        this.hisSchool = hisSchool;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
