package com.nothing.service;

import com.nothing.vo.sushe.studentFloor;
import com.nothing.vo.sushe.studentHour;

import java.util.List;

public interface BuildingService {
    //查询楼栋信息
    List selectBuildinglists(String sql);
    //查询总行数
    int SelcctBuildingcount(String sql);
    //添加的方法
    void addBuilding(studentFloor studentFloor);
    //删除楼栋的方法
    void delBuilding(Object id);
    //判断信息是否重复
    boolean boolBuilding(studentFloor studentFloor);
}
