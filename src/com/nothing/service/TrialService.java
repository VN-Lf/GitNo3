package com.nothing.service;

import com.nothing.vo.Edu.Course;
import com.nothing.vo.Edu.Trial;

import java.util.List;

public interface TrialService {
    //查询课程信息
    List Triallist(String sql);
    //查询课程总行数
    int Trialcount(String sql);
    //添加的方法
    void addTrial(Trial trial);
    //修改的方法
    void updateTrial(Trial trial);
    //删除的方法
    void delTrial(String id);
}
