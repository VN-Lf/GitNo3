package com.nothing.service;

import com.nothing.vo.emp.Emp;

import java.util.List;

public interface GoPageService {
    List selectGoPage(String sql);
    Object selectEmpGoPage(Emp obj, int id);
    public List deptList();
}
