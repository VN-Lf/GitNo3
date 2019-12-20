package com.nothing.service;

import com.nothing.vo.emp.Emp;

import java.util.List;

public interface GoPageService {
    List selectGoPage(String sql);
    Object selectEmpGoPage(Object obj, int id);
    List deptList();
    List empList();
}
