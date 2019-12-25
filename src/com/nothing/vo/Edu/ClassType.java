package com.nothing.vo.Edu;

import javax.persistence.*;
//
@Entity
@Table(name="classtype")
public class ClassType {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =100, allocationSize = 1)
    private  Integer classType;
    private  String classTypeName;

    public Integer getClassType() {
        return classType;
    }

    public void setClassType(Integer classType) {
        this.classType = classType;
    }

    public String getClassTypeName() {
        return classTypeName;
    }

    public void setClassTypeName(String classTypeName) {
        this.classTypeName = classTypeName;
    }
}
