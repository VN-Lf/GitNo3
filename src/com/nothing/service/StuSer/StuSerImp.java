package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Sdudent.StuFimaly;
import com.nothing.vo.Sdudent.Student;
import org.springframework.stereotype.Service;

import java.util.List;
//修改学生要查出班级和寝室的name放在页面的下拉框上
@Service
public class StuSerImp extends BaseDao implements StuSer{
    @Override
    public List toStuList(){
            return listBySQL("select *\n" +
                    ",cla.className as classNames,floor.floorName as floorNames,house.hourName as hourNames from student stu \n" +
                    "left join classvo cla using(classId)\n" +
                    "left join studentfloor floor using(floorId)\n" +
                    "left join studenthour house using(stuHours,floorId)");
    }


    @Override
    public int allTitle(Object o) {
        return selTotalRow("select count(*) from "+o.getClass().getSimpleName());

    }

    @Override
    public void addStu(Object o){
        addObject(o);
    }

    @Override
    public void updateStu(Object o){
        updObject(o);
    }

    @Override
    public void deleteStu(String  ids,Object o){
        executeSQL("delete from "+o.getClass().getSimpleName() +" where studId in ("+ids+")");
    }

    @Override
    public List listObj(Object o){
        return listByHql("from "+o.getClass().getSimpleName());
    }

    @Override
    public Object findO(Object o,int id) {
        return getObject(o.getClass(),id);
    }

    @Override
    public List toStuAddition(Object o,String studId){
        return listBySQL("select * from "+o.getClass().getSimpleName() +" where studId ="+studId);
    }

    @Override
    public void delEdu(String id) {
        executeSQL("delete from StuEdu where EduId in ("+id+")");
    }

    @Override
    public void delHap(String id){
        executeSQL("delete from StuHappening where stuHappenId in ("+id+")");
    }

    @Override
    public void delFal(String id) {
        executeSQL("delete from StuFimaly where stuFamilyid in ("+id+")");
    }
    @Override
    public List toStuConList(String stuSelectName, String stuSelectPhone, String stuSelectCla, String stuSelectFloor){
        return listBySQL("select *\n" +
                ",cla.className as classNames,floor.floorName as floorNames,house.hourName as hourNames from student stu \n" +
                "left join classvo cla using(classId)\n" +
                "left join studentfloor floor using(floorId)\n" +
                "left join studenthour house using(stuHours,floorId)\n" +
                "where stuName like '%"+stuSelectName+"%' and stuPhone like '%"+stuSelectPhone+"%' and className  like  '%"+stuSelectCla+"%' and  hourName like '%"+stuSelectFloor+"%'");
    }

    @Override
    public List stuHap(String  studId) {
        return listBySQL("select * , e.empName as empNames from stuhappening hap left join emp e using(empId) where hap.studId = "+studId );
    }


    @Override
    public List stuRep(String  studId) {
        return listBySQL("select * , e.empName as empNames from stuReplyScore rep left join emp e  using(empId)  where rep.studId = "+studId );
    }

    @Override
    public List listO(Object o) {
        return listBySQL("select * from "+o.getClass().getSimpleName());
    }

    @Override
    public List classList() {
        return listBySQL("\n" +
                "select c.classId,c.classAdviser,c.classCount,c.classFall,c.MajorId,c.classNo,c.classRemark,\n" +
                "c.classTeacher,c.classTerm,c.classType,c.deptId,c.className,t.termName as tnames,d.deptName,\n" +
                "ma.MajorName ,ma.deptId as maDept, ma.MajorRemark,ct.classTypeName, \n" +
                "e.empName as bzr,ee.empName as js ,f.fallLevel from classVo c left join emp e on  c.classAdviser = e.empId left join  emp ee on  c.classTeacher = ee.empId left join Term t on c.classTerm = t.termId left join StuFall f on c.classFall = f.fallId left join edumajor ma using(deptId,MajorId) left join dept d using(deptId) left join classType ct using(classType) \n");
    }

    @Override
    public void delCla(String ids){
          executeSQL("delete from StuFimaly where classVo in ("+ids+")");
    }

    @Override
    public int conStu(String stuSelectName, String stuSelectPhone, String stuSelectCla, String stuSelectFloor) {
        return selTotalRow("select\n" +
                "       count(*)\n" +
                "    from\n" +
                "        student stu  \n" +
                "    left join\n" +
                "        classvo cla using(classId) \n" +
                "    left join\n" +
                "        studentfloor floor using(floorId) \n" +
                "    left join\n" +
                "        studenthour house using(stuHours,floorId) \n" +
                "    where\n" +
                "        stuName like '%"+stuSelectName+"%' \n" +
                "        and stuPhone like '%"+stuSelectPhone+"%' \n" +
                "        and className  like  '%"+stuSelectCla+"%' \n" +
                "        and  hourName like '%"+stuSelectFloor+"%'\n");
    }

    @Override
    public List  classTeacher(String type){
        return listBySQL("select *,e.empName as names from  post left join emp e using(empId) where postName like '%"+type+"%' ");
    }


}
