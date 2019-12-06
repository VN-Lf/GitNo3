package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.DormitoryService;
import java.util.List;

import com.nothing.vo.sushe.studentHour;
import org.springframework.stereotype.Service;

@Service
public class DormitoryServiceImpl extends BaseDao implements DormitoryService {

    @Override
    public List selectDormitorylists(String sql) {
        return listBySQL(sql);

    }

    public List selectDormitorylist(int page, int rows) {
        return this.pageByHql("select * from studenthour", page, rows);
    }

    public int SelcctDormitorycount(String sql) {
        return this.selTotalRow(sql);

    }

    //添加的方法
    @Override
    public void addDormitory(studentHour studentHour) {
        addObject(studentHour);
    }

    @Override
    public void updateDormitory(studentHour studentHour) {
        updObject(studentHour);
    }

    @Override
    public void delDormitory(Object id) {
        executeSQL("delete from studenthour where HourId in ("+id+")");
    }

}