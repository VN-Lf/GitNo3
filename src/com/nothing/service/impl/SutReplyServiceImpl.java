package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.StrreplyService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SutReplyServiceImpl extends BaseDao implements StrreplyService {
    @Override
    public List selectStrreplylist(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int SelcctStrreplycount(String sql) {
        return this.selTotalRow(sql);
    }
}
