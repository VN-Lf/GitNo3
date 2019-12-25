package com.nothing.service;

import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Edu.StuFall;

import java.util.List;

public interface SysSetService {
    public List getFallList();
    public List getCTList();
    public StuFall getFall(int id);
    public ClassType getCT(int id);

    public void  fallAdd(StuFall sf);
    public void  CTAdd(ClassType sf);

    public void  fallUp(StuFall sf);
    public void  CTUp(ClassType sf);

    public void  fallDel(String id);
    public void  CTDel(String id);

    public int getFallCount();
    public int getCTCount();
}
