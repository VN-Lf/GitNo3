package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.WeeklyService;
import com.nothing.vo.emp.EmpWeekPaper;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class WeeklyServiceImpl  extends BaseDao implements WeeklyService {
    //查询周报信息
    @Override
    public List selectWeeklylist(String sql) {
        return listBySQL(sql);
    }
    //查询总行数
    @Override
    public int SelcctWeeklycount(String sql) {
        return selTotalRow(sql);
    }

    //添加周报的方法
    @Override
    public void WeeklyAdd(EmpWeekPaper weekPaper) {

        addObject(weekPaper);
    }
    //修改周报的方法
    @Override
    public void WeeklyUpdate(EmpWeekPaper weekPaper) {

        updObject(weekPaper);
    }
    //多表删除的方法
    @Override
    public void WeeklyDelete(String id) {

        executeSQL("delete from empweekpaper where weekPaperId in ("+id+")");
    }

    @Override
    public List WeeklySerletData(String sql) {
        return
                listBySQL(sql);
    }


}
