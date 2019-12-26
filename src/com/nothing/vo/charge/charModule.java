package com.nothing.vo.charge;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "charModule")
public class charModule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =100, allocationSize = 1)
    private Integer charId;
    private String  empId;
    private String  empName;
    private String  deptId;
    private Integer updateEmp;//针对员工增删查改
    private Integer updateStu; //1有权限 0无 学生增删查改
    private Integer actEmp;//审批请假单
    private Integer weekEmp;//审批同部门周报 部门管理
    private Integer attkEmp;//未打卡审批
    private Integer weixiu;//维修权限 公告
    private Integer kaoheEmp;//巡查员
    private Integer stuBze;//学生班主任 管理楼栋等
    private Integer stuJs;//学生老师 录入成绩等 谈心
    private Integer stuMoney;//学费
    private Integer kecheng;//教务类 课程管理
    private Integer zhiban;//值班管理
    private Integer fanKui;//问题反馈处理
    private Integer zhaosheng;//招生权限
    private Integer boss;//上级 0校长 1部长


    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public Integer getCharId() {
        return charId;
    }

    public void setCharId(Integer charId) {
        this.charId = charId;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public Integer getUpdateEmp() {
        return updateEmp;
    }

    public void setUpdateEmp(Integer updateEmp) {
        this.updateEmp = updateEmp;
    }

    public Integer getUpdateStu() {
        return updateStu;
    }

    public void setUpdateStu(Integer updateStu) {
        this.updateStu = updateStu;
    }

    public Integer getActEmp() {
        return actEmp;
    }

    public void setActEmp(Integer actEmp) {
        this.actEmp = actEmp;
    }

    public Integer getWeekEmp() {
        return weekEmp;
    }

    public void setWeekEmp(Integer weekEmp) {
        this.weekEmp = weekEmp;
    }

    public Integer getAttkEmp() {
        return attkEmp;
    }

    public void setAttkEmp(Integer attkEmp) {
        this.attkEmp = attkEmp;
    }

    public Integer getWeixiu() {
        return weixiu;
    }

    public void setWeixiu(Integer weixiu) {
        this.weixiu = weixiu;
    }

    public Integer getKaoheEmp() {
        return kaoheEmp;
    }

    public void setKaoheEmp(Integer kaoheEmp) {
        this.kaoheEmp = kaoheEmp;
    }

    public Integer getStuBze() {
        return stuBze;
    }

    public void setStuBze(Integer stuBze) {
        this.stuBze = stuBze;
    }

    public Integer getStuJs() {
        return stuJs;
    }

    public void setStuJs(Integer stuJs) {
        this.stuJs = stuJs;
    }

    public Integer getStuMoney() {
        return stuMoney;
    }

    public void setStuMoney(Integer stuMoney) {
        this.stuMoney = stuMoney;
    }

    public Integer getKecheng() {
        return kecheng;
    }

    public void setKecheng(Integer kecheng) {
        this.kecheng = kecheng;
    }

    public Integer getZhiban() {
        return zhiban;
    }

    public void setZhiban(Integer zhiban) {
        this.zhiban = zhiban;
    }

    public Integer getFanKui() {
        return fanKui;
    }

    public void setFanKui(Integer fanKui) {
        this.fanKui = fanKui;
    }

    public Integer getZhaosheng() {
        return zhaosheng;
    }

    public void setZhaosheng(Integer zhaosheng) {
        this.zhaosheng = zhaosheng;
    }

    public Integer getBoss() {
        return boss;
    }

    public void setBoss(Integer boss) {
        this.boss = boss;
    }
}
