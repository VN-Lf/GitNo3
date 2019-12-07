package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import com.nothing.vo.Sdudent.Student;
import org.springframework.stereotype.Service;

import java.util.List;


public interface StuSer{
    List toStuList(Object o);
    int allTitle(Object o);
    void addStu(Student student);
    void updateStu(Student student);
    void deleteStu(String ids);
    List listObj(Object o);
    Object findO(Object o,int id);
    List toStuAddition(Object o,int studId);
}
