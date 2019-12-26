package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.SystemfromService;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SystemfromServiceimpl extends BaseDao implements SystemfromService {
    @Override
    public List kaohelist(String sql) {
        List list = listBySQL(sql);
        return list;
    }

    @Override
    public int Selectcount(String sql) {
        int selectcount = selectcount(sql);
        return selectcount;
    }
}
