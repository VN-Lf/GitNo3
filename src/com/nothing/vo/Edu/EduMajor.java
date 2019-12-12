package com.nothing.vo.Edu;


import javax.persistence.*;
//
//专业设置表
public class EduMajor {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =400, allocationSize = 1)
    private Integer MajorId;//主键
    private String MajorName;
    private Integer deptId;
    private String MajorRemark;

    public Integer getMajorId() {
        return MajorId;
    }

    public void setMajorId(Integer majorId) {
        MajorId = majorId;
    }

    public String getMajorName() {
        return MajorName;
    }

    public void setMajorName(String majorName) {
        MajorName = majorName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getMajorRemark() {
        return MajorRemark;
    }

    public void setMajorRemark(String majorRemark) {
        MajorRemark = majorRemark;
    }
}
