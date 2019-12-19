package com.nothing.service;

import com.nothing.vo.emp.Dept;

import java.util.List;

public interface TuitionService {
    //查询出学费信息
    List selectTuition(String sql);
    //查询总数信息
    int SelcctTuitioncount(String sql);
    //学费删除
    void deleteTuition(String id);
    void deleteDept(String id);
    void addDept(Dept dept);
    void deleteDeptAll(String id);
    void updateDept(Dept dept);
    Dept sqlDeptById(String id);
}
