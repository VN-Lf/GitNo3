package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.GoPageService;
import com.nothing.vo.emp.Emp;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoPageServiceImpl extends BaseDao implements GoPageService {
    //查询出登录信息
    @Override
    public List selectGoPage(String sql) {
        return listBySQL(sql);
    }
    //查出总行数
    @Override
    public Object selectEmpGoPage(Emp obj, int id) {
        return getObject(obj.getClass(),id);
    }
    //查询未完成周报
    @Override
    public int selecthomeunfinished(String sql) {
        return selTotalRow(sql);
    }


}
