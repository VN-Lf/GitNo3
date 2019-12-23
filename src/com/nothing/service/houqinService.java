package com.nothing.service;

import com.nothing.dao.BaseDao;
import com.nothing.vo.houqin.equipmentRepair;

import java.util.List;

public interface houqinService {
    public List repairList();
    public int getCount();
    //根据Id查报修信息
    equipmentRepair getEr(int id);
    //根据Id修改报修信息
    void erUp(equipmentRepair er);
    //根据Id删除报修信息
    void erDel(String id);
    //新增报修信息
    void erAdd(equipmentRepair er);
}
