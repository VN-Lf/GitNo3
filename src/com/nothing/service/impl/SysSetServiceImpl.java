package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.SysSetService;
import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.EduMajor;
import com.nothing.vo.Edu.StuFall;
import com.nothing.vo.Edu.Term;
import com.nothing.vo.charge.tuitionType;
import com.nothing.vo.dep.dep;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SysSetServiceImpl extends BaseDao implements SysSetService {
    @Override
    public List getFallList() {
        return this.listBySQL("select * from StuFall");
    }

    @Override
    public List getCTList() {
        return this.listBySQL("select * from classtype");
    }

    @Override
    public List getTTTList() {
        return this.listBySQL("select * from tuitionType");
    }

    @Override
    public List getTermList() {
        return this.listBySQL("select * from term");
    }

    @Override
    public List getEduMajorList() {
        return this.listBySQL("select * from eduMajor");
    }

    @Override
    public List getDeptList() {
        return this.listBySQL("select * from dep");
    }

    @Override
    public StuFall getFall(int id) {
        return (StuFall) this.getObject(StuFall.class,id);
    }

    @Override
    public ClassType getCT(int id) {
        return (ClassType) this.getObject(ClassType.class,id);
    }

    @Override
    public tuitionType getTTT(int id) {
        return (tuitionType) this.getObject(tuitionType.class,id);
    }

    @Override
    public EduMajor getEduMajor(int id) {
        return (EduMajor) this.getObject(EduMajor.class,id);
    }

    @Override
    public dep getDept(int id) {
        return (dep) this.getObject(dep.class,id);
    }

    @Override
    public Term getTerm(int id) {
        return (Term) this.getObject(Term.class,id);
    }

    @Override
    public void fallAdd(StuFall sf) {
        this.addObject(sf);
    }

    @Override
    public void CTAdd(ClassType ct) {
        this.addObject(ct);
    }

    @Override
    public void TTTAdd(tuitionType ttt) {
        this.addObject(ttt);
    }

    @Override
    public void termAdd(Term t) {
        this.addObject(t);
    }

    @Override
    public void EduMajorAdd(EduMajor em) {
        this.addObject(em);
    }

    @Override
    public void deptAdd(dep dep) {
        this.addObject(dep);
    }

    @Override
    public void fallUp(StuFall sf) {
        this.updObject(sf);
    }

    @Override
    public void CTUp(ClassType ct) {
        this.updObject(ct);
    }

    @Override
    public void TTTUp(tuitionType ttt) {
        this.updObject(ttt);
    }

    @Override
    public void termUp(Term t) {
        this.updObject(t);
    }

    @Override
    public void EduMajorUp(EduMajor em) {
        this.updObject(em);
    }

    @Override
    public void deptUp(dep dep) {
        this.updObject(dep);
    }

    @Override
    public void fallDel(String id) {
        this.executeSQL("delete from StuFall where fallId in("+id+")");
    }

    @Override
    public void CTDel(String id) {
        this.executeSQL("delete from classtype where classType in("+id+")");
    }

    @Override
    public void TTTDel(String id) {
        this.executeSQL("delete from tuitionType where tuitionTypeId in("+id+")");

    }

    @Override
    public void termDel(String id) {
        this.executeSQL("delete from term where tuitionTypeId in("+id+")");
    }

    @Override
    public void EduMajorDel(String id) {
        this.executeSQL("delete from eduMajor where MajorId in("+id+")");
    }

    @Override
    public void deptDel(String id) {
        this.executeSQL("delete from dep where depId in("+id+")");
    }

    @Override
    public int getFallCount() {
        return this.selTotalRow("select count(*) from StuFall");
    }

    @Override
    public int getCTCount() {
        return this.selTotalRow("select count(*) from classtype");
    }

    @Override
    public int getTTTCount() {
        return this.selTotalRow("select count(*) from tuitionType");
    }

    @Override
    public int getTermCount() {
        return this.selTotalRow("select count(*) from tuitionType");
    }

    @Override
    public int getDeptCount() {
        return this.selTotalRow("select count(*) from dep");
    }

    @Override
    public int getEduMajorCount() {
        return this.selTotalRow("select count(*) from eduMajor");
    }
}
