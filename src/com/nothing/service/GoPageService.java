package com.nothing.service;

import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.emp.Emp;

import java.util.List;

public interface GoPageService {
    //查询出登录信息
    List selectGoPage(String sql);
    //查出总行数
    Object selectEmpGoPage(Emp obj, int id);
    //根据时间查询还未完成的周报

    Object selectStuGoPage(Student obj, int id);

    int selecthomeunfinished(String sql);
}
