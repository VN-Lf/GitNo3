package com.nothing.service;

import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.sushe.studentHour;

import java.util.List;

public interface DormitoryService {
    //查询宿舍信息
    List selectDormitorylists(String sql);
    //查询方页信息
    List selectDormitorylist(int var1, int var2);
    //查询总行数
    int SelcctDormitorycount(String sql);
    //添加宿舍的方法
    void addDormitory(studentHour studentHour);
    //修改宿舍的方法
    void updateDormitory(studentHour studentHour);
    //修改学生宿舍
    void updateStudentwtf(String id,int sushe);
    //删除宿舍的方法
    void delDormitory(Object id);
}
