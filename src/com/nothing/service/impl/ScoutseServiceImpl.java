package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.SCoutseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScoutseServiceImpl extends BaseDao implements SCoutseService {


    @Override
    public List selectScoutselist(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int SelcctScoutsecount(String sql) {
        return this.selTotalRow(sql);
    }
}
