package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class EroSerImpl extends BaseDao implements EnrSer{
    @Override
    public List allEnr(){
        return listBySQL("SElECT\n" +
                "\ten.*,\n" +
                "\tempName,\n" +
                "\tclassTypeName,\n" +
                "\tMajorName,\n" +
                "\tclassName,\n" +
                "\tentryTime,\n" +
                "\treviewer\n" +
                "FROM\n" +
                "\tEnrollment en\n" +
                "\tLEFT JOIN emp e USING ( empId )\n" +
                "\tLEFT JOIN classType c USING ( classType )\n" +
                "\tLEFT JOIN EduMajor ma USING ( MajorId )\n" +
                "\tLEFT JOIN classvo USING ( classId )\n" +
                "\tleft join EntryFinance\t  enf using(enrollmentId)");
    }

    @Override
    public List existsProMoney(String id){
        return listBySQL("select * from enrollment where  paymentTime is not null and enrollmentid in ("+id+")");
    }

    @Override
    public void updateProMoney(String time,String id){
        executeSQL("update enrollment set paymentTime = '"+time+"' where  enrollmentid in ("+id+")");
    }

    @Override
    public List conList(String stuSelectName, String selectClassType, String stuSelectTeacher, String stuSelecStuat){
        return listBySQL("SElECT\n" +
                "\ten.*,\n" +
                "\tempName,\n" +
                "\tclassTypeName,\n" +
                "\tMajorName,\n" +
                "\tclassName,\n" +
                "\tentryTime,\n" +
                "\treviewer\n" +
                "FROM\n" +
                "\tEnrollment en\n" +
                "\tLEFT JOIN emp e USING ( empId )\n" +
                "\tLEFT JOIN classType c USING ( classType )\n" +
                "\tLEFT JOIN EduMajor ma USING ( MajorId )\n" +
                "\tLEFT JOIN classvo USING ( classId )\n" +
                "\tleft join EntryFinance\t  enf using(enrollmentId)\n" +
                "\twhere \n" +
                "\tstuName like '%"+stuSelectName+"%'\n" +
                "\tand classTypeName like '%"+selectClassType+"%'\n" +
                "\tand status = "+stuSelecStuat+"\n" +
                "\tand enterEmp like '%"+stuSelectTeacher+"%'\n");
    }

    @Override
    public void updateStatus(String id) {
        executeSQL("update Enrollment set status = 4 where enrollmentId = "+id);
    }

    @Override
    public void updateMoney(String id, String money,String time) {
        executeSQL("update enrollment set enrollMoney = "+id+" ,enrollMoneyTime = '"+time+"' where enrollmentid = "+id);
    }
}
