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
    public List empexamlist(String sql) {
        List list = baseDao.listBySQL(sql);
        return list;
    }

    @Override
    public int selectcount(String sql) {
        int count= baseDao.selectcount(sql);
        return count;
    }

    @Override
    public void updateexam(Object obj) {
        baseDao.updObject(obj);
    }

    @Override
    public void deleteexam(Object obj) {
        baseDao.delObject(obj);
    }

    @Override
    public void alldelete(String sql) {
        baseDao.executeSQL(sql);
    }

    @Override
    public List examdate(String sql) {
        List list = baseDao.listBySQL(sql);
        return list;
    }
}
