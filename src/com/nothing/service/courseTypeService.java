package com.nothing.service;

import com.nothing.vo.Edu.CourseType;

import java.util.List;

public interface courseTypeService {
    //查询课程信息
    List selectCourselist(String sql);
    //查询课程总行数
    int SelcctCoursecount(String sql);
    //添加课程
    void addCourse(CourseType courseType);
    //删除课程
    void delCourse(String id);
    //修改课程
    void upateCourse(CourseType courseType);
}
