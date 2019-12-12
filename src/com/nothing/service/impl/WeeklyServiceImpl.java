package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.WeeklyService;
import com.nothing.vo.emp.EmpWeekPaper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class WeeklyServiceImpl  implements WeeklyService {
    @Resource
    BaseDao dao;
    //查询周报信息
    @Override
    public List selectWeeklylist(String sql) {
        return dao.listBySQL(sql);
    }
    //查询总行数
    @Override
    public int SelcctWeeklycount(String sql) {
        return dao.selTotalRow(sql);
    }

    //添加周报的方法
    @Override
    public void WeeklyAdd(EmpWeekPaper weekPaper) {
            dao.addObject(weekPaper);
    }
    //修改周报的方法
    @Override
    public void WeeklyUpdate(EmpWeekPaper weekPaper) {
        dao.updObject(weekPaper);
    }
    //多表删除的方法
    @Override
    public void WeeklyDelete(String id) {
        dao.executeSQL("delete from empweekpaper where weekPaperId in ("+id+")");
    }

    @Override
    public List WeeklySerletData(String sql) {
        return dao.listBySQL(sql);
    }


}
