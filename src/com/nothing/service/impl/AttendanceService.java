package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.vo.checking.AttendanceVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttendanceService extends BaseDao implements com.nothing.service.AttendanceService{
    @Override
    public List selectAttendanlist(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int SelcctAttendancount(String sql) {
        return this.selTotalRow(sql);
    }

    @Override
    public void AddAttrndan(AttendanceVo attendanceVo) {
        addObject(attendanceVo);
    }

    @Override
    public void updateAttendance(AttendanceVo attendanceVo) {
        updObject(attendanceVo);
    }

    @Override
    public void delBuilding(Object id) {
        executeSQL("delete from attendance where attId in ("+id+")");
    }
}
