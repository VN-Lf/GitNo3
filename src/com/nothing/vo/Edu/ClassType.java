package com.nothing.vo.Edu;

import javax.persistence.*;

@Entity
@Table(name="ClassType")
public class ClassType {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =200, allocationSize = 1)

    private Integer calssTypeId;
    private  String calssTypename;//班级类别名称

    public Integer getCalssTypeId() {
        return calssTypeId;
    }

    public void setCalssTypeId(Integer calssTypeId) {
        this.calssTypeId = calssTypeId;
    }

    public String getCalssTypename() {
        return calssTypename;
    }

    public void setCalssTypename(String calssTypename) {
        this.calssTypename = calssTypename;
    }
}
