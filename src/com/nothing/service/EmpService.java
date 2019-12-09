package com.nothing.service;

import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;

import java.util.List;

public interface EmpService {
    List selEmpAll();
    int selEmpCont();
    void addEmp(Emp emp, EmpEducation empEducation, Post post);
    void delete(String ids);
    List selEmpEducation(int var1);
    int getEmpEducationCount(int var1);
    EmpEducation getEdu(int id);
    void eduUp(EmpEducation edu);
    void eduDel(EmpEducation edu);
}
