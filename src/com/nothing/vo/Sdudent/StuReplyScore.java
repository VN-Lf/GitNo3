package com.nothing.vo.Sdudent;

import javax.persistence.*;
//学生答辩成绩//////
@Entity
@Table(name="StuReplyScore")
public class StuReplyScore{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =3000, allocationSize = 1)
   private Integer stuReplyId;
   private Integer  studId;
   private Integer projectId;//答辩项目表Id
   private Integer   empId;
   private  Float score1;
   private Float   Score2;
   private Float  Score3;
   private  Float Score4;
   private  Float Score5;
   private  Float Score6;
   private  Float Score7;
   private  String   replyScoreRemark;

    public Integer getStuReplyId() {
        return stuReplyId;
    }

    public void setStuReplyId(Integer stuReplyId) {
        this.stuReplyId = stuReplyId;
    }

    public Integer getStudId() {
        return studId;
    }

    public void setStudId(Integer studId) {
        this.studId = studId;
    }

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public Float getScore1() {
        return score1;
    }

    public void setScore1(Float score1) {
        this.score1 = score1;
    }

    public Float getScore2() {
        return Score2;
    }

    public void setScore2(Float score2) {
        Score2 = score2;
    }

    public Float getScore3() {
        return Score3;
    }

    public void setScore3(Float score3) {
        Score3 = score3;
    }

    public Float getScore4() {
        return Score4;
    }

    public void setScore4(Float score4) {
        Score4 = score4;
    }

    public Float getScore5() {
        return Score5;
    }

    public void setScore5(Float score5) {
        Score5 = score5;
    }

    public Float getScore6() {
        return Score6;
    }

    public void setScore6(Float score6) {
        Score6 = score6;
    }

    public Float getScore7() {
        return Score7;
    }

    public void setScore7(Float score7) {
        Score7 = score7;
    }

    public String getReplyScoreRemark() {
        return replyScoreRemark;
    }

    public void setReplyScoreRemark(String replyScoreRemark) {
        this.replyScoreRemark = replyScoreRemark;
    }
}
