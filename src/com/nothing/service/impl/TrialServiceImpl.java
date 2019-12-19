package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.TrialService;
import com.nothing.vo.Edu.Trial;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrialServiceImpl extends BaseDao implements TrialService {

    @Override
    public List Triallist(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int Trialcount(String sql) {
        return selTotalRow(sql);
    }

    @Override
    public void addTrial(Trial trial) {
        addObject(trial);
    }

    @Override
    public void updateTrial(Trial trial) {
        updObject(trial);
    }

    @Override
    public void delTrial(String id) {
        executeSQL("delete from trial where trialId in ("+id+")");
    }

}
