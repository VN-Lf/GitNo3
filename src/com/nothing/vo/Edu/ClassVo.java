package com.nothing.vo.Edu;

import javax.persistence.*;
//
//班级表
@Entity
@Table(name="ClassVo")
public class ClassVo{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =100, allocationSize = 1)
    private  Integer classId;
    private Integer classNo;
    private Integer classAdviser ;//班主任
    private String className;
    private Integer classCount;
    private Integer classTeacher ;//授课老师
    private Integer classTerm ;//学期
        private Integer classType;
    private String  classRemark;
    private Integer classFall;//学年
    private Integer deptId;
    private Integer MajorId;

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Integer getClassId(){
        return classId;
    }

    public void setClassId(Integer classId) {
        this.classId = classId;
    }

    public Integer getClassNo() {
        return classNo;
    }

    public void setClassNo(Integer classNo) {
        this.classNo = classNo;
    }

    public Integer getClassAdviser() {
        return classAdviser;
    }

    public void setClassAdviser(Integer classAdviser) {
        this.classAdviser = classAdviser;
    }

    public Integer getClassCount() {
        return classCount;
    }

    public void setClassCount(Integer classCount) {
        this.classCount = classCount;
    }

    public Integer getClassTeacher() {
        return classTeacher;
    }

    public void setClassTeacher(Integer classTeacher) {
        this.classTeacher = classTeacher;
    }

    public Integer getClassTerm() {
        return classTerm;
    }

    public void setClassTerm(Integer classTerm) {
        this.classTerm = classTerm;
    }

    public Integer getClassType() {
        return classType;
    }

    public void setClassType(Integer classType) {
        this.classType = classType;
    }

    public String getClassRemark() {
        return classRemark;
    }

    public void setClassRemark(String classRemark) {
        this.classRemark = classRemark;
    }

    public Integer getClassFall() {
        return classFall;
    }

    public void setClassFall(Integer classFall) {
        this.classFall = classFall;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Integer getMajorId() {
        return MajorId;
    }

    public void setMajorId(Integer majorId) {
        MajorId = majorId;
    }
}
