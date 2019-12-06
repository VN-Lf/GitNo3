package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.BuildingService;
import com.nothing.vo.sushe.studentFloor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BuildingServiceimpl extends BaseDao implements BuildingService {
    //查询楼栋信息
    @Override
    public List selectBuildinglists(String sql) {
        return listBySQL(sql);
    }
    //查询总行数
    @Override
    public int SelcctBuildingcount(String sql) {
        return this.selTotalRow(sql);
    }
    //添加
    @Override
    public void addBuilding(studentFloor studentFloor) {
        addObject(studentFloor);
    }
    //删除
    @Override
    public void delBuilding(Object id) {
        executeSQL("delete from studentfloor where floorId in ("+id+")");
    }
    //判断信息
    @Override
    public boolean boolBuilding(studentFloor studentFloor) {
        return false;
    }
}
