package com.nothing.vo.Sdudent;

import javax.persistence.*;
import java.sql.Date;

@Table
@Entity(name="StuEdu")
public class StuEdu{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =4000, allocationSize = 1)

   private Integer EduId;
   private String  stuId;
   private String hisSchool;
   private String beginDate;
   private Date endDate;

    public Integer getEduId() {
        return EduId;
    }

    public void setEduId(Integer eduId) {
        EduId = eduId;
    }

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public String getHisSchool() {
        return hisSchool;
    }

    public void setHisSchool(String hisSchool) {
        this.hisSchool = hisSchool;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
