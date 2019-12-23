package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.FinanceService;
import com.nothing.vo.tuition.financeshouldTuitionRecord;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class FinanceServiceImpl extends BaseDao implements FinanceService {
    @Override
    public List tuitionList() {
        List list = listBySQL("select  f.*,e1.empName,stu.stuName,t.typeName,t2.termName from financeshouldtuitionrecord as f left join student  as stu on f.stuid=stu.studId left join emp as e1 on f.empid=e1.empId LEFT JOIN tuitiontype as t on f.tuitionTypeId=t.tuitionTypeId LEFT JOIN term as t2 on f.termId=t2.termId");
        return list;
    }

    @Override
    public int getTuitionCount() {
        int con = selTotalRow("select count(*) from financeshouldtuitionrecord");
        return con;
    }

    @Override
    public financeshouldTuitionRecord getf(int id) {
        return (financeshouldTuitionRecord) this.getObject(financeshouldTuitionRecord.class,id);
    }

    @Override
    public void tiotionAdd(financeshouldTuitionRecord ft) {
        this.addObject(ft);

    }

    @Override
    public void tuitionUp(financeshouldTuitionRecord ft) {
        this.updObject(ft);
    }

    @Override
    public List getC() {
        return this.listBySQL("select * from classvo");
    }

    @Override
    public List getS() {
        return this.listBySQL("select * from student");
    }
}
