package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.FinanceService;
import com.nothing.vo.tuition.financeshouldTuitionRecord;
import org.springframework.stereotype.Service;

import javax.persistence.Id;
import java.util.List;
@Service
public class FinanceServiceImpl extends BaseDao implements FinanceService {
    @Override
    public List tuitionList() {
        List list = listBySQL("select  f.*,e1.empName,stu.stuName,t.typeName,t2.termName from financeshouldTuitionRecord as f LEFT JOIN term as t2 on f.termId=t2.termId left join student  as stu on f.stuid=stu.studId left join emp as e1 on f.empid=e1.empId LEFT JOIN tuitiontype as t on f.tuitionTypeId=t.tuitionTypeId");
        return list;
    }

    @Override
    public List stList(int sid) {
        List list = listBySQL("select  f.*,e1.empName,stu.stuName,t.typeName,t2.termName from financeshouldTuitionRecord as f LEFT JOIN term as t2 on f.termId=t2.termId left join student  as stu on f.stuid=stu.studId left join emp as e1 on f.empid=e1.empId LEFT JOIN tuitiontype as t on f.tuitionTypeId=t.tuitionTypeId LEFT JOIN term as t3 on t3.termId= f.termId where stuid ="+sid);
        return list;
    }


    @Override
    public int getTuitionCount() {
        int con = selTotalRow("select count(*) from financeshouldTuitionRecord");
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
        return this.listBySQL("select * from classVo");
    }

    @Override
    public List getS(int id) {
        return this.listBySQL("select * from student where classId="+id);
    }

    @Override
    public List pageList(int page, int size) {
        return this.pageBySQL("select  f.*,e1.empName,stu.stuName,t.typeName,t2.termName from financeshouldTuitionRecord as f LEFT JOIN term as t2 on f.termId=t2.termId left join student  as stu on f.stuid=stu.studId left join emp as e1 on f.empid=e1.empId LEFT JOIN tuitiontype as t on f.tuitionTypeId=t.tuitionTypeId",page,size);
    }
}
