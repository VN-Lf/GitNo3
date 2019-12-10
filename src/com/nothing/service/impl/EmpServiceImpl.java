package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
//学生服
@Service
public class EmpServiceImpl extends BaseDao implements EmpService{
    @Override
    public List selEmpAll() {
        List list = listBySQL("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId");
        return list;
    }

    @Override
    public List selNoticeAll() {
        List list = listBySQL("select * from notice");
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
        List list = listBySQL2("select empId from emp order by empId desc limit 1");
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

    @Override
    public void czPwd(String id) {
        String upsql = "UPDATE emp SET empLogPsw = '123456' WHERE empId = "+id;
        System.out.println(upsql);
        executeSQL(upsql);
    }

    @Override
    public Emp sqlEmpVo(String id){
        System.out.println("id:"+id);
        Emp emp = new Emp();
        return (Emp)getObject(emp.getClass(),Integer.parseInt(id));
    }

    @Override
    public Post sqlPostVo(String eid) {
        /*Post emp = new Post();
        List list = listBySQL2("select postId from post where empId ="+eid);
        int pid = (int)list.get(0);
        return (Post) getObject(emp.getClass(),pid);*/
        List list = listBySQL(" select * from post where empId = "+eid);
        Map map = (Map) list.get(0);
        Post post = new Post();
        post.setPostId((int)map.get("postId"));
        post.setEmpId((int)map.get("empId"));
        post.setDeptId((int)map.get("deptId"));
        post.setPostName((String) map.get("postName"));
        post.setRemark((String)map.get("remark"));
        return post;
    }

    @Override
    public EmpEducation sqlEduVo(String eid) {
        EmpEducation emp = new EmpEducation();
        List list = listBySQL2("select empEduId from empeducation where empId ="+eid);
        int empid = (int)list.get(0);
        return (EmpEducation)getObject(emp.getClass(),empid);
        /*List list = listBySQL(" select * from empeducation where empId = "+eid);
        return (EmpEducation)list.get(0);*/
    }

    @Override
    public void empUpdate(Emp emp, EmpEducation Edu, Post post) {
        updObject(emp);
        updObject(Edu);
        updObject(post);
    }

    @Override//根据Id获取教育经历列表
    public List selEmpEducation(int id) {
        return this.listBySQL("select * from empeducation where empId="+id);
    }

    @Override//根据Id获取教育经历的数量
    public int getEmpEducationCount(int id) {
        return this.selectcount("select count(*) from empeducation where empId ="+id);
    }

    @Override//根据Id获取教育经历
    public EmpEducation getEdu(int eid) {
        EmpEducation education  = (EmpEducation) this.getObject(EmpEducation.class, eid);
        System.out.println(eid);
        System.out.println(education.toString());
        return education;
    }

    @Override//修改教育经历
    public void eduUp(EmpEducation edu) {
        this.updObject(edu);
    }

    @Override//删除教育经历
    public void eduDel(String id) {
        this.listBySQL("delete empeducation where empEduId in("+id+")");
    }

    @Override//新增教育经历
    public void eduAdd(EmpEducation edu) {
        this.addObject(edu);
    }
}
