package com.nothing.vo.Edu;

import javax.persistence.*;

//学年表
@Entity
@Table(name="StuFall")
public class StuFall{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =500, allocationSize = 1)
    private Integer fallId ;//学年id
    private String fallLevel;
    private String fallRemark;

    public Integer getFallId() {
        return fallId;
    }

    public void setFallId(Integer fallId) {
        this.fallId = fallId;
    }

    public String getFallLevel() {
        return fallLevel;
    }

    public void setFallLevel(String fallLevel) {
        this.fallLevel = fallLevel;
    }

    public String getFallRemark() {
        return fallRemark;
    }

    public void setFallRemark(String fallRemark) {
        this.fallRemark = fallRemark;
    }
}
