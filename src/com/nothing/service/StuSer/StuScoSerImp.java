package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;

import static oracle.net.aso.C00.o;
////
@Service
public class StuScoSerImp extends BaseDao implements StuScoSer{

    @Override
    public List toAll() {
        return listBySQL("select ss.*,cl.classId as cId ,cl.className,s.stuName as sName,e.empName as eName ,c.courseName as cName , t.termName as tName from StudentScore as ss left join student as s using(studId) left join emp as e using(empId) left  join course as c using(courseId) left join term as t using(termId)  left join classVo as cl on s.classId = cl.classId");
    }
    public int toTitle(Object o){
        return selTotalRow("select count(*) from "+o.getClass().getSimpleName());
    }

    @Override
    public List stuByClassId(String classId){
        return listBySQL("select * from student left join classVo using(classId) where classId = "+classId);
    }

    @Override
    public int countStuByClassId(String classId){
        return selTotalRow("select count(*) from student left join classVo using(classId) where classId = "+classId);
    }

    @Override
    public List isExistsTest(int tId, int cId, int typeId,int classId){
        return listBySQL("select * from studentscore where exists(select *,classId from studentscore left join student using(studId) where courseId = "+cId+" and termId = "+tId+" and testType = "+typeId+" and testType = 1 and classId = "+classId+")"
                );
    }

    @Override
    public List scoCon(String stuSelectName, String stuSelectCla, String stuSelectCour, String stuSelectTerm) {
        return listBySQL("select ss.*,cl.classId as cId ,cl.className,s.stuName as sName,e.empName as eName ,c.courseName as cName , t.termName as tName from StudentScore as ss left join student as s using(studId) left join emp as e using(empId) left  join course as c using(courseId) left join term as t using(termId)  left join classVo as cl on s.classId = cl.classId\n" +
                "where stuName like '%"+stuSelectName+"%' and className like '%"+stuSelectCla+"%' and courseName\tlike '%"+stuSelectCour+"%' and termName like '%"+stuSelectTerm+"%'\n");
    }

    @Override
    public int scoConCount(String stuSelectName, String stuSelectCla, String stuSelectCour, String stuSelectTerm){
        return selTotalRow("select count(*) from StudentScore as ss left join student as s using(studId) left join emp as e using(empId) left  join course as c using(courseId) left join term as t using(termId)  left join classVo as cl on s.classId = cl.classId\n" +
                "where stuName like '%"+stuSelectName+"%' and className like '%"+stuSelectCla+"%' and courseName\tlike '%"+stuSelectCour+"%' and termName like '%"+stuSelectTerm+"%'");
    }

    @Override
    public void delSco(String  id){
        executeSQL("delete from StudentScore where scoreId in ("+id+")");
    }

    @Override
    public List replyScore() {
        return listBySQL("\t\t\t\t \n" +
                "\tselect ss.*,e.empName , c.classId as cid ,c.className,s.stuName,proName from stuReplyScore ss left join studentProject p using(projectId) left join student  s using (studId) left join emp e using(empId) left join classvo c using(classId)");
    }

    @Override
    public List repCon(String stuSelectName, String stuSelectCla, String stuSelectPro) {
        return listBySQL("\tselect ss.*,e.empName , c.classId as cid ,c.className,s.stuName,proName from stuReplyScore ss left join studentProject p using(projectId) left join student  s using (studId) left join emp e using(empId) left join classvo c using(classId)\n" +
                "\t\n" +
                "\twhere stuName like '%"+stuSelectName+"%' and className like '%"+stuSelectCla+"%' and proName like '%"+stuSelectPro+"%'");
    }

    @Override
    public int repConCount(String stuSelectName, String stuSelectCla, String stuSelectPro) {
        return selTotalRow("\tselect count(*) from stuReplyScore ss left join studentProject p using(projectId) left join student  s using (studId) left join emp e using(empId) left join classvo c using(classId)\n" +
                "\t\n" +
                "\twhere stuName like '%"+stuSelectName+"%' and className like '%"+stuSelectCla+"%' and proName like '%"+stuSelectPro+"%'");
    }

    @Override
    public void delReply(String id) {
        executeSQL("delete from StuReplyScore where stuReplyId in ("+id+")");
    }

    @Override
    public List stuReplyByClassId(String classId) {
        return listBySQL("select sc.*,ss.classId,ss.stuName,ss.studId as sid from student ss left join stureplyscore sc using(studId) where classId = "+classId);
    }

    @Override
    public int stuReplyByClassIdCount(String classId) {
        return selTotalRow("select count(*) from student ss left join stureplyscore sc using(studId) where classId = "+classId);
    }

    @Override
    public List isExistsTestReply(String classId, String projectId) {
        return null;
    }

}
