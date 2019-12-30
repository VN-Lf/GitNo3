package com.nothing.service.StuSer;

import java.util.List;

public interface EnrSer {
    List allEnr();
    List existsProMoney(String id);
    void updateProMoney(String time,String id);
    List conList(String  stuSelectName, String  selectClassType, String  stuSelectTeacher, String stuSelecStuat);
    void updateStatus(String id);
    void updateMoney(String id,String money,String  time);
}
