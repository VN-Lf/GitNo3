package com.nothing.service;

import com.nothing.vo.Edu.StuFall;

import java.util.List;

public interface SysSetService {
    public List getFallList();
    public StuFall getFall(int id);
    public void  fallUp(StuFall sf);
    public void  fallDel(String id);
    public int getFallCount();
}
