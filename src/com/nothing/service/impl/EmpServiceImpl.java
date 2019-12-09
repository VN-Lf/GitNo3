package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpServiceImpl extends BaseDao implements EmpService{
    @Override
    public List selEmpAll() {
        List list = listBySQL("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId");
        return list;
    }

    @Override
    public int selEmpCont() {
        int con = selTotalRow("select count(empId) from emp");
        return con;
    }

    @Override
    public void addEmp(Emp emp, EmpEducation empEducation, Post post) {
        emp.setEmpLoginStatus(1);//设置登录状态默认 1
        addObject(emp);
        List list = listBySQL("select empId from emp order by empId desc limit 1");
        System.out.println("list:"+list);
        int eid = (int)list.get(0);
        System.out.println("新增员工id:"+eid);
        empEducation.setEmpId(eid);
        addObject(empEducation);
        System.out.println("员工部门id:"+emp.getEmpDeptId());
        post.setDeptId(emp.getEmpDeptId());
        post.setEmpId(eid);
        addObject(post);
    }


    @Override
    public void delete(String ids){
        String sql = "delete from emp where empId in ("+ids+");";
        String sql2 = "delete from empeducation where empId in ("+ids+");";
        String sql3 = "delete from post where empId in ("+ids+");";
        executeSQL(sql);
        executeSQL(sql2);
        executeSQL(sql3);
        /*Emp emp = new Emp();
        Post psot = new Post();
        EmpEducation edu = new EmpEducation();
        emp.setEmpId(Integer.parseInt(ids));
        psot.setEmpId(Integer.parseInt(ids));
        edu.setEmpId(Integer.parseInt(ids));

        delObject(emp);
        delObject(psot);
        delObject(edu);*/
    }

    public List selEmpEducation(int id) {
        List list = this.listBySQL("select * from  empeducation where empId=" + id);
        return list;
    }

    public int getEmpEducationCount(int id) {
        int con = this.selTotalRow("select count(empEduId) from empeducation where empId=" + id);
        return con;
    }

    @Override
    public EmpEducation getEdu(int id) {
        EmpEducation education  = (EmpEducation) this.getObject(EmpEducation.class, id);
        System.out.println(education.toString());
        return education;
    }


    @Override
    public void eduUp(EmpEducation edu) {
        this.updObject(edu);
    }

    @Override
    public void eduDel(EmpEducation edu) {
        this.delObject(edu);
    }
}
