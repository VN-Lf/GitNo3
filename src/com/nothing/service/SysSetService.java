package com.nothing.service;

import com.nothing.vo.Edu.*;
import com.nothing.vo.charge.tuitionType;
import com.nothing.vo.dep.dep;

import java.util.List;

public interface SysSetService {
    public List getFallList();
    public List getCTList();
    public List getTTTList();
    public List getTermList();
    public List getEduMajorList();
    public List getDeptList();

    public StuFall getFall(int id);
    public ClassType getCT(int id);
    public tuitionType getTTT(int id);
    public Term getTerm(int id);
    public EduMajor getEduMajor(int id);
    public dep getDept(int id);

    public void  fallAdd(StuFall sf);
    public void  CTAdd(ClassType sf);
    public void  TTTAdd(tuitionType ttt);
    public void  termAdd(Term t);
    public void  EduMajorAdd(EduMajor em);
    public void  deptAdd(dep dep);

    public void  fallUp(StuFall sf);
    public void  CTUp(ClassType sf);
    public void  TTTUp(tuitionType ttt);
    public void  termUp(Term t);
    public void  EduMajorUp(EduMajor em);
    public void  deptUp(dep dep);


    public void  fallDel(String id);
    public void  CTDel(String id);
    public void  TTTDel(String id);
    public void  termDel(String id);
    public void  EduMajorDel(String id);
    public void  deptDel(String id);

    public int getFallCount();
    public int getCTCount();
    public int getTTTCount();
    public int getTermCount();
    public int getEduMajorCount();
    public int getDeptCount();
}
