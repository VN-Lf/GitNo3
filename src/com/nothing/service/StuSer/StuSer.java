package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import com.nothing.vo.Sdudent.Student;
import org.springframework.stereotype.Service;

import java.util.List;

//
public interface StuSer{
    List toStuList();
    int allTitle(Object o);
    void addStu(Object o);
    void updateStu(Object o);
    void deleteStu(String ids,Object o);
    List listObj(Object o);
    Object findO(Object o,int id);
    List toStuAddition(Object o,String studId);
    int  toStuAdditionCount(Object o,String studId);
    void delEdu(String id);
    void delFal(String id);

    List stuHol(String studId);
    List stuRep(String studId);
    List stuScore(String studId);
    int stuHolCount(String studId);
    int stuRepCount(String studId);
    int stuScoreCount(String studId);


    List listO (Object o);
    List classList();
    void delCla(String ids);

    List toStuConList(String stuSelectName,String  stuSelectPhone,String stuSelectCla,String stuSelectFloor);
    int conStu(String stuSelectName, String stuSelectPhone, String stuSelectCla, String stuSelectFloor);
    List  classTeacher(String type);
    void delClaStu(String classId);
    List stuByClaId(String classId);
    int stuByClaIdCount(String classId);
    int  countClaCon(String claSelectName , String claSelectAdviser, String claSelectTeacher, String claSelectTerm , String claSelectType , String claSelectFall);
    List conClas(String claSelectName , String claSelectAdviser, String claSelectTeacher, String claSelectTerm , String claSelectType , String claSelectFall);

    //根据学年查班级
    List classByFall(String fallId);
    //给某个班新增学生
    void classAddStu(String cid,String studIds);
    //根据学生id查授课教师和班主任
    List selectTeacherByStuId(String studId);
    List allotStu();

    List allotCon(String stuSelectName , String stuSelectPhone, String claSelectType);
}
