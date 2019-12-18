package com.nothing.service.StuSer;

import java.util.List;

public interface StuScoSer{
    List toAll();
    int toTitle(Object o);
    List stuByClassId(String classId);
    int countStuByClassId(String classId);
    List isExistsTest(int tId ,int cId ,int typeId);
    List scoCon(String  stuSelectName, String stuSelectCla , String  stuSelectCour, String stuSelectTerm);
    int scoConCount(String  stuSelectName, String stuSelectCla , String  stuSelectCour, String stuSelectTerm);
    void delSco(String  id);
    List replyScore();
    List repCon(String stuSelectName, String stuSelectCla , String stuSelectPro);
    int repConCount(String stuSelectName, String stuSelectCla , String stuSelectPro);
    void delReply(String id);
    List stuReplyByClassId(String classId);
    int stuReplyByClassIdCount(String ClassId);
}
