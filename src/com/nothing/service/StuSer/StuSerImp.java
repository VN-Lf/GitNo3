package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Sdudent.Student;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StuSerImp extends BaseDao implements StuSer{
    @Override
    public List toStuList(Object o) {
        return listBySQL("select * from "+o.getClass().getSimpleName());
    }

    @Override
    public int allTitle(Object o) {
        return selTotalRow("select count(*) from "+o.getClass().getSimpleName());

    }

    @Override
    public void addStu(Student student){
        addObject(student);
    }

    @Override
    public void updateStu(Student student){
        updObject(student);
    }

    @Override
    public void deleteStu(String  ids){
        executeSQL("delete from student where studId in ("+ids+")");
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
    public List toStuAddition(Object o,int studId) {
        return listBySQL("select * from "+o.getClass().getSimpleName() +" where studId ="+studId);
    }


}
