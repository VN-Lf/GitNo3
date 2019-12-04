package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.Examservice;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class Examserviceimpl implements Examservice{
    @Resource
    BaseDao baseDao;
    @Override
    public List examlist(String sql) {
        List list = baseDao.listBySQL(sql);
        return list;
    }

    @Override
    public int selectcount() {
        int count= baseDao.selectcount("select count(aduitModelid) from aduitModel");
        return count;
    }
}
