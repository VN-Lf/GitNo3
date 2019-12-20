package com.nothing.service;

import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.charge.Notice;
import com.nothing.vo.emp.*;
import com.nothing.vo.wintable.chatRecord;

import java.util.List;
//jiekou
public interface EmpService {
    List selEmpAll(String sql);
    List selNoticeAll(String type);
    int selEmpCont(String sql);
    void addEmp(Emp emp, EmpEducation empEducation, Post post);
    void delete(String ids);
    void czPwd(String id);
    void banEmp(String id, String zt);
    Emp sqlEmpVo(String id);
    Post sqlPostVo(String eid);
    EmpEducation sqlEduVo(String eid);
    void empUpdate(Emp emp, EmpEducation Edu, Post post);
    void addNotice(Notice notice, int lx);//发布公告
    Notice chaNotice(String nid);    //根据id查公告

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

    //根据Id查家庭信息列表
    List famInf(int id);
    //根据Id查家庭信息条数
    int famInfCount(int id);
    //根据Id查家庭信息
    EmpFamilyImf getFam(int id);
    //根据Id修改家庭信息
    void famUp(EmpFamilyImf efi);
    //根据Id删除家庭信息
    void famDel(String id);
    //新增家庭信息
    void famAdd(EmpFamilyImf efi);

    //新增谈心记录
    void chatAdd(chatRecord cr);
    //修改谈心记录
    void chatUp(chatRecord cr);
    //查询谈心记录
    List chatList(String sql);
    //根据Id查谈心记录
    List getChat(int id);
    public int chatCount();
    //删除谈心记录
    public void chatDel(String id);
    //根据名字得到学生
    public Student getStu(String name);

    //查找所有值班
    List weekList(String sql);
    void addWeek(WeekArrange war);
    void delWeek(String id);
    void updateWeek(WeekArrange week);
    void delWeekAll(String id);
}
