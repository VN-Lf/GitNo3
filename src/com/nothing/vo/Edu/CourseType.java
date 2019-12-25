package com.nothing.vo.Edu;

import javax.persistence.*;
//课程类型表
@Entity
@Table(name="courseType")
public class CourseType{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =300, allocationSize = 1)
    private Integer courseTypeId;
    private  String  courseTypeName;//名称
    private String courseRemark;

    public Integer getCourseTypeId() {
        return courseTypeId;
    }

    public void setCourseTypeId(Integer courseTypeId) {
        this.courseTypeId = courseTypeId;
    }

    public String getCourseTypeName() {
        return courseTypeName;
    }

    public void setCourseTypeName(String courseTypeName) {
        this.courseTypeName = courseTypeName;
    }

    public String getCourseRemark() {
        return courseRemark;
    }

    public void setCourseRemark(String courseRemark) {
        this.courseRemark = courseRemark;
    }
}
