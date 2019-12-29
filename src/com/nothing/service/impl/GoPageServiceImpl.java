package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.GoPageService;
import com.nothing.vo.emp.Emp;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoPageServiceImpl extends BaseDao implements GoPageService {

    @Override
    public List selectGoPage(String sql) {
        return listBySQL(sql);
    }

    @Override
    public Object selectEmpGoPage(Object obj, int id) {
        return getObject(obj.getClass(),id);
    }

    @Override
    public List deptList() {
        return listBySQL("select deptId,deptName from dept");
    }

    @Override
    public List empList() {
        return listBySQL("select empId,empName from emp");
    }

    @Override
    public List emailcount(String sql) {
        return listBySQL(sql);
    }

}
