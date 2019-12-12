package com.nothing.vo.Sdudent;

import javax.persistence.*;
//学生家庭信息
@Entity
@Table(name="StuFimaly")
public class StuFimaly{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2200, allocationSize = 1)
    private Integer stuFamilyid;
    private Integer studId;
    private String stuFamilyName;
    private String relation;
    private String familyPhone;


    public Integer getStuFamilyid(){
        return stuFamilyid;
    }

    public void setStuFamilyid(Integer stuFamilyid) {
        this.stuFamilyid = stuFamilyid;
    }

    public Integer getStudId() {
        return studId;
    }

    public void setStudId(Integer studId) {
        this.studId = studId;
    }

    public String getStuFamilyName() {
        return stuFamilyName;
    }

    public void setStuFamilyName(String stuFamilyName) {
        this.stuFamilyName = stuFamilyName;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    public String getFamilyPhone() {
        return familyPhone;
    }

    public void setFamilyPhone(String familyPhone) {
        this.familyPhone = familyPhone;
    }


    @Override
    public String toString() {
        return "StuFimaly{" +
                "stuFamilyid=" + stuFamilyid +
                ", studId=" + studId +
                ", stuFamilyName='" + stuFamilyName + '\'' +
                ", relation='" + relation + '\'' +
                ", familyPhone='" + familyPhone + '\'' +
                '}';
    }
}
