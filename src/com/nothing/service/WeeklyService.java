package com.nothing.service;

import com.nothing.vo.emp.EmpWeekPaper;

import java.util.List;

public interface WeeklyService {
    //查询周报信息
    List selectWeeklylist(String sql);
    //查询周报总行数
    int SelcctWeeklycount(String sql);
    //添加周报的方法
    void WeeklyAdd(EmpWeekPaper weekPaper);
    //修改的方法
    void WeeklyUpdate(EmpWeekPaper weekPaper);
    //删除的方法
    void WeeklyDelete(String id);
    //获取到周报表的时间
    List WeeklySerletData(String sql);
}
