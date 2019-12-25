package com.nothing.service;

import com.nothing.vo.tuition.financeshouldTuitionRecord;

import java.util.List;

public interface FinanceService {
    //获取学费列表
    List tuitionList();
    int getTuitionCount();
    financeshouldTuitionRecord getf(int id);
    void tiotionAdd(financeshouldTuitionRecord ft);
    void tuitionUp(financeshouldTuitionRecord ft);
    List getC();
    List getS(int id);
    List pageList(int page,int size);
}
