package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.houqinService;
import com.nothing.vo.emp.EmpFamilyImf;
import com.nothing.vo.houqin.equipmentRepair;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class houqinServiceImpl extends  BaseDao implements houqinService {

    //获取保修列表
    public List repairList(){
        return listBySQL("select * from equipmentrepair");
    }
    //获取数据数量
    public int getCount(){
        return selectcount("select count(equipmentId) from equipmentrepair");
    }

    @Override
    public equipmentRepair getEr(int id) {
        equipmentRepair er  = (equipmentRepair) this.getObject(equipmentRepair.class, id);
        return er;
    }

    @Override
    public void erUp(equipmentRepair er) {
        this.updObject(er);
    }

    @Override
    public void erDel(String id) {
        this.executeSQL("delete from equipmentrepair where equipmentId in("+id+")");
    }

    @Override
    public void erAdd(equipmentRepair er) {
        this.addObject(er);
    }

}
