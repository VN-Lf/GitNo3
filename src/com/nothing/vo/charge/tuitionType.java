package com.nothing.vo.charge;

import javax.persistence.*;

@Entity
@Table(name = "tuitionType ")
public class tuitionType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer tuitionTypeId;
    private String  typeName;
    private String typeMoney;
    private  String remark;

    public Integer getTuitionTypeId() {
        return tuitionTypeId;
    }

    public void setTuitionTypeId(Integer tuitionTypeId) {
        this.tuitionTypeId = tuitionTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeMoney() {
        return typeMoney;
    }

    public void setTypeMoney(String typeMoney) {
        this.typeMoney = typeMoney;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
