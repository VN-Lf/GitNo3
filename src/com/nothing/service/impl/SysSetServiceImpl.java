package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.SysSetService;
import com.nothing.vo.Edu.StuFall;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SysSetServiceImpl extends BaseDao implements SysSetService {
    @Override
    public List getFallList() {
        return this.listBySQL("select * from StuFall");
    }

    @Override
    public StuFall getFall(int id) {
        return (StuFall) this.getObject(StuFall.class,id);
    }

    @Override
    public void fallUp(StuFall sf) {
        this.delObject(sf);
    }

    @Override
    public void fallDel(String id) {
        this.executeSQL("delete from StuFall where fallId in("+id+")");
    }

    @Override
    public int getFallCount() {
        return this.selTotalRow("select count(*) from StuFall");
    }
}
