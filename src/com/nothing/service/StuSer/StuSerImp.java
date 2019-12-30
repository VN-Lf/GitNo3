package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Sdudent.StuFimaly;
import com.nothing.vo.Sdudent.Student;
import org.springframework.stereotype.Service;

import java.util.List;
//
@Service
public class StuSerImp extends BaseDao implements StuSer{
    @Override
    public List toStuList(){
            return listBySQL("select *\n" +
                    ",cla.className as classNames,floor.floorName as floorNames,house.hourName as hourNames from student stu \n" +
                    "left join classVo cla using(classId)\n" +
                    "left join studentFloor floor using(floorId)\n" +
                    "left join studentHour house using(stuHours,floorId)");
    }


    @Override
    public int allTitle(Object o) {
        return selTotalRow("select count(*) from student");

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
    public List stuHol(String  studId){
        return listBySQL("select j.*,s.stuName from jobs j left join student s on j.userId = s.studId where s.studId = "+studId+" and j.jobType = stuLeave" );
    }

    @Override
    public List stuRep(String  studId){
        return listBySQL("select * from stuReplyScore rep left join emp e using(empId) left join studentProject p using(projectId)  where rep.studId = "+studId);
    }

    @Override
    public List stuScore(String studId) {
        return listBySQL(
                "select sc.*,stuName,empName ,termName,courseName from studentscore sc left join student s using(studId) left join term t using (termId) left join \n" +
                "course c using(courseId) left join emp e using(empId) where studId = "+studId);
    }



    @Override
    public List classList(){
        return listBySQL("select c.classId,c.classAdviser,c.classCount,c.classFall,c.MajorId,c.classNo,c.classRemark,\n" +
                "c.classTeacher,c.classTerm,c.classType,c.deptId,c.className,t.termName as tnames,d.deptName,\n" +
                "ma.MajorName ,ma.deptId as maDept, ma.MajorRemark,ct.classTypeName, \n" +
                "e.empName as bzr,ee.empName as js ,f.fallLevel from classVo c left join emp e on  c.classAdviser = e.empId left join  emp ee on  c.classTeacher = ee.empId left join term t on c.classTerm = t.termId left join stuFall f on c.classFall = f.fallId left join eduMajor ma using(deptId,MajorId) left join dept d using(deptId) left join classtype ct using(classType) \n");
    }

    @Override
    public void delCla(String ids){
          executeSQL("delete from classVo where classId in ("+ids+")");
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
        return listBySQL("select e.empId,e.empName as names from  post left join emp e using(empId) where postName like '%"+type+"%' ");
    }

    @Override
    public void delClaStu(String classId){
        executeSQL("update student set classId = 0 where classId in ("+classId+")");
    }

    @Override
    public List stuByClaId(String classId){
        return listBySQL("select *,c.className as names from student left join classVo c using (classId) where classId = "+classId);
    }

    @Override
    public int stuByClaIdCount(String classId) {
        return selTotalRow("select count(*) from student where classId = "+classId);
    }

    @Override
    public int countClaCon(String claSelectName, String claSelectAdviser, String claSelectTeacher, String claSelectTerm, String claSelectType, String claSelectFall) {
        return selTotalRow("\n" +
                "select count(*) from classVo c left join emp e on  c.classAdviser = e.empId left join  emp ee on  c.classTeacher = ee.empId left join Term t on c.classTerm = t.termId left join StuFall f on c.classFall = f.fallId left join edumajor ma using(MajorId,deptId) left join dept d using(deptId) left join classtype ct using(classType) \n" +
                "where className like '%"+claSelectName+"%' \n" +
                "and e.empName like '%"+claSelectAdviser+"%'\n" +
                "and ee.empName like '%"+claSelectTeacher+"%'\n" +
                "and t.termName like '%"+claSelectTerm+"%'\n" +
                "and classTypeName like '%"+claSelectType+"%'\n" +
                "and  f.fallLevel like '%"+claSelectFall+"%'");
    }

    @Override
    public List conClas(String claSelectName, String claSelectAdviser, String claSelectTeacher, String claSelectTerm, String claSelectType, String claSelectFall) {
        return listBySQL("select c.classId,c.classAdviser,c.classCount,c.classFall,c.MajorId,c.classNo,c.classRemark,\n" +
                "c.classTeacher,c.classTerm,c.classType,c.deptId,c.className,t.termName as tnames,d.deptName,\n" +
                "ma.MajorName ,ma.deptId as maDept, ma.MajorRemark,ct.classTypeName,\n" +
                "e.empName as bzr,ee.empName as js ,f.fallLevel from classVo c left join emp e on  c.classAdviser = e.empId left join  emp ee on  c.classTeacher = ee.empId left join Term t on c.classTerm = t.termId left join StuFall f on c.classFall = f.fallId left join edumajor ma using(MajorId,deptId) left join dept d using(deptId) left join classtype ct using(classType) \n" +
                "where className like '%"+claSelectName+"%' \n" +
                "and e.empName like '%"+claSelectAdviser+"%'\n" +
                "and ee.empName like '%"+claSelectTeacher+"%'\n" +
                "and t.termName like '%"+claSelectTerm+"%'\n" +
                "and classTypeName like '%"+claSelectType+"%'\n" +
                "and  f.fallLevel like '%"+claSelectFall+"%'\n");
    }

    @Override
    public List classByFall(String fallId){
        return listBySQL("select * from ClassVo where classFall = "+fallId);
    }

    @Override
    public void classAddStu(String cid, String studIds) {
        executeSQL("update student set classId = "+cid+" where studId in ("+studIds+")");
    }

    @Override
    public List selectTeacherByStuId(String studId) {
        return listBySQL("select classTeacher from classvo where classId = (select classId from student where studId = "+studId+")");
    }


    @Override
    public int toStuAdditionCount(Object o, String studId) {
        return selTotalRow("select count(*) from "+o.getClass().getSimpleName()+" where studId = "+studId);
    }

    @Override
    public int stuHolCount(String studId) {
        return selTotalRow("select count(*) from jobs j left join student s on j.userId = s.studId where s.studId ="+studId);
    }

    @Override
    public int stuRepCount(String studId) {
        return selTotalRow("select count(*) from stuReplyScore rep left join emp e using(empId) left join studentProject p using(projectId)  where rep.studId = "+studId);
    }

    @Override
    public int stuScoreCount(String studId){
        return selTotalRow("select count(*) from studentscore sc left join student s using(studId) left join term t using (termId) left join "+
                "course c using(courseId) left join emp e using(empId) where studId = "+studId);
    }

    @Override
    public List ooo(Object o) {
        return listBySQL("select * from "+o.getClass().getSimpleName());
    }

    @Override
    public List allotStu() {
        return listBySQL("\t\n" +
                "SElECT\n" +
                "\ten.*,\n" +
                "\tclassTypeName,\n" +
                "\tMajorName\n" +
                "FROM\n" +
                "\tEnrollment en\n" +
                "\tLEFT JOIN classType c USING ( classType )\n" +
                "\tLEFT JOIN EduMajor ma USING ( MajorId )\n" +
                "where  status in (1,2,3)\n" +
                "\t");
    }

    @Override
    public List allotCon(String stuSelectName, String stuSelectPhone, String claSelectType) {
        return listBySQL("SElECT\n" +
                "\ten.*,\n" +
                "\tempName,\n" +
                "\tclassTypeName,\n" +
                "\tMajorName,\n" +
                "\tclassName,\n" +
                "\tentryTime,\n" +
                "\treviewer\n" +
                "FROM\n" +
                "\tEnrollment en\n" +
                "\tLEFT JOIN emp e USING ( empId )\n" +
                "\tLEFT JOIN classType c USING ( classType )\n" +
                "\tLEFT JOIN EduMajor ma USING ( MajorId )\n" +
                "\tLEFT JOIN classvo USING ( classId )\n" +
                "\tleft join EntryFinance\t  enf using(enrollmentId)\n" +
                "\twhere \n" +
                "\tstuName like '%"+stuSelectName+"%'\n" +
                "\tand classTypeName like '%"+claSelectType+"%'\n" +
                "\tand stuPhone like '%"+stuSelectPhone+"%'\n");
    }

    @Override
    public void delJobByStuId(String id) {
        executeSQL("delete from jobs where jobType = 'stuLeave' and userId in ("+id+")");
    }

}
