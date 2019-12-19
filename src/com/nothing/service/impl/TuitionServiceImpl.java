package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.TuitionService;
import com.nothing.vo.emp.Dept;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TuitionServiceImpl extends BaseDao implements TuitionService {

    //查询出学费信息
    @Override
    public List selectTuition(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int SelcctTuitioncount(String sql) {
        return selTotalRow(sql);
    }

    @Override
    public void deleteTuition(String id) {
        executeSQL("delete from studenthour where HourId in ("+id+")");
    }

    @Override
    public void deleteDept(String id) {
        executeSQL("delete from dept where deptId ="+id);
    }

    @Override
    public void addDept(Dept dept) {
        addObject(dept);
    }

    @Override
    public void deleteDeptAll(String id) {
        executeSQL("delete from dept where deptId in ("+id+")");
    }

    @Override
    public void updateDept(Dept dept) {
        updObject(dept);
    }

    @Override
    public Dept sqlDeptById(String id) {
        Dept dept = new Dept();
        return (Dept)getObject(dept.getClass(),Integer.parseInt(id));
    }
}
