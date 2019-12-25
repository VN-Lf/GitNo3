package com.nothing.service;

import com.nothing.vo.Edu.Course;
import com.nothing.vo.checking.AttendanceVo;

import java.util.List;

public interface AttendanceService {
    //查询考勤信息
    List selectAttendanlist(String sql);
    //查询考勤总行数
    int SelcctAttendancount(String sql);
    //添加的方法
    void AddAttrndan(AttendanceVo attendanceVo);
    //修改的方法
    void updateAttendance(AttendanceVo attendanceVo);
    //删除楼栋的方法
    void delBuilding(Object id);
}
