package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Sdudent.Student;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StuSerImp extends BaseDao implements StuSer{
    @Override
    public List toStuList() {
        return listBySQL("select * from student");
    }

    @Override
    public int allTitle() {
        return selTotalRow("select count(*) from student");

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


}
