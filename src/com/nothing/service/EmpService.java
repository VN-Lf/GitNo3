package com.nothing.service;

import com.nothing.vo.charge.Notice;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.EmpHistory;
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

    //根据Id查教育经历列表
    List selEmpEducation(int id);
    //根据Id查教育经历条数
    int getEmpEducationCount(int id);
    //根据Id查教育经历
    EmpEducation getEdu(int id);
    //根据Id修改教育经历
    void eduUp(EmpEducation edu);
    //根据Id删除教育经历
    void eduDel(String id);
    //新增教育经历
    void eduAdd(EmpEducation edu);

    //根据Id查工作经历列表
    List jobHis(int id);
    //根据Id查工作经历条数
    int jobHisCount(int id);
    //根据Id查工作经历
    EmpHistory getJob(int id);
    //根据Id修改工作经历
    void jobUp(EmpHistory hs);
    //根据Id删除工作经历
    void jobDel(String id);
    //新增工作经历
    void jobAdd(EmpHistory hs);
}
