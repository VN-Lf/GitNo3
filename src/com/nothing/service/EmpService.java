package com.nothing.service;

import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;

import java.util.List;

public interface EmpService {
    List selEmpAll();
    void addEmp(Emp emp, EmpEducation empEducation, Post post);
    void delete(String ids);
}
