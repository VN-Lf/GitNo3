package com.nothing.service;

import com.nothing.vo.charge.Notice;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;

import java.util.List;
//jiekou
public interface EmpService {
    List selEmpAll();//查所有员工
    List selNoticeAll(String type);//查公告
    int selEmpCont();//查员工总条数
    void addEmp(Emp emp, EmpEducation empEducation, Post post);//添加员工
    void delete(String ids); //删除多员工
    void czPwd(String id);     //重置密码
    Emp sqlEmpVo(String id);    //根据id查员工
    Post sqlPostVo(String eid); //查职位
    EmpEducation sqlEduVo(String eid);//查学历
    void empUpdate(Emp emp, EmpEducation Edu, Post post);//修改员工
    void addNotice(Notice notice,int lx);//发布公告
    Notice chaNotice(String nid);    //根据id查员工
}
