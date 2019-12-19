package com.nothing.service;

import com.nothing.vo.Edu.Course;

import java.util.List;

public interface courseService {
    //查询课程信息
    List Courselist(String sql);
    //查询课程总行数
    int Coursecount(String sql);
    //添加的方法
    void addCourse(Course course);
    //修改的方法
    void updateCourse(Course course);
    //删除的方法
    void delCourse(String id);
}
