package com.nothing.service;

import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;
import org.jboss.logging.annotations.Pos;

import java.util.List;

public interface EmpService {
    List selEmpAll();
    int selEmpCont();
    void addEmp(Emp emp, EmpEducation empEducation, Post post);
    void delete(String ids);
    void czPwd(String id);
    Emp sqlEmpVo(String id);
    Post sqlPostVo(String eid);
    EmpEducation sqlEduVo(String eid);
    void empUpdate(Emp emp, EmpEducation Edu, Post post);
}
