package com.nothing.service;

import com.nothing.vo.charge.Notice;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;

import java.util.List;
//jiekou
public interface EmpService {
    List selEmpAll();
    List selNoticeAll(String type);
    int selEmpCont();
    void addEmp(Emp emp, EmpEducation empEducation, Post post);
    void delete(String ids);
    void czPwd(String id);
    Emp sqlEmpVo(String id);
    Post sqlPostVo(String eid);
    EmpEducation sqlEduVo(String eid);
    void empUpdate(Emp emp, EmpEducation Edu, Post post);
    void addNotice(Notice notice,int lx);//发布公告
    Notice chaNotice(String nid);    //根据id查员工
    List selEmpEducation(int id);
    int getEmpEducationCount(int id);
    EmpEducation getEdu(int id);
    void eduUp(EmpEducation edu);
    void eduDel(String id);
    void eduAdd(EmpEducation edu);
}
