package com.nothing.vo.houqin;

import com.alibaba.fastjson.annotation.JSONField;

import javax.persistence.*;
import java.util.Date;
/**
 * 学生申请设备维修表
 */
@Entity
@Table(name = "equipmentRepair")
public class equipmentRepair {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer equipmentId; //主键
    private String equipmentType;//维修设备名称
    private Integer status;      //维修状态0未完成,1已完成
    private Integer classes;     //班级
    private Integer student;     //学生申请人
    private String remark;       //备注
    private Integer userType;   //1学生 2老师
    private String startTime;     //开始时间
    private String eedTime;       //结束

    public Integer getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(Integer equipmentId) {
        this.equipmentId = equipmentId;
    }

    public String getEquipmentType() {
        return equipmentType;
    }

    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getClasses() {
        return classes;
    }

    public void setClasses(Integer classes) {
        this.classes = classes;
    }

    public Integer getStudent() {
        return student;
    }

    public void setStudent(Integer student) {
        this.student = student;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEedTime() {
        return eedTime;
    }

    public void setEedTime(String eedTime) {
        this.eedTime = eedTime;
    }

    @Override
    public String toString() {
        return "equipmentRepair{" +
                "equipmentId=" + equipmentId +
                ", equipmentType='" + equipmentType + '\'' +
                ", status=" + status +
                ", classes=" + classes +
                ", student=" + student +
                ", remark='" + remark + '\'' +
                ", userType=" + userType +
                ", startTime=" + startTime +
                ", eedTime=" + eedTime +
                '}';
    }
}
