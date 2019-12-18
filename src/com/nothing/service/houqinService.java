package com.nothing.service;

import com.nothing.dao.BaseDao;

import java.util.List;

public interface houqinService {
    public List repairList(String sql);
    public int getCount(String sql);
}
