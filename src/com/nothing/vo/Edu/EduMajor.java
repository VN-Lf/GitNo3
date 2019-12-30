package com.nothing.vo.Edu;


import javax.persistence.*;
//
//专业设置表
@Entity
@Table(name="eduMajor")
public class EduMajor {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue = 400, allocationSize = 1)
    private Integer majorId;//主键
    private String majorName;
    private Integer deptId;
    private String majorRemark;

    public Integer getMajorId() {
        return majorId;
    }

    public void setMajorId(Integer majorId) {
        this.majorId = majorId;
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getMajorRemark() {
        return majorRemark;
    }

    public void setMajorRemark(String majorRemark) {
        this.majorRemark = majorRemark;
    }
}
