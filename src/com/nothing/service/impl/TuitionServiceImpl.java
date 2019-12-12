package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.TuitionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TuitionServiceImpl implements TuitionService {

    @Resource
    BaseDao dao;
    //查询出学费信息
    @Override
    public List selectTuition(String sql) {
        return dao.listBySQL(sql);
    }

    @Override
    public int SelcctTuitioncount(String sql) {
        return dao.selTotalRow(sql);
    }

    @Override
    public void deleteTuition(String id) {
        dao.executeSQL("delete from studenthour where HourId in ("+id+")");
    }


}
