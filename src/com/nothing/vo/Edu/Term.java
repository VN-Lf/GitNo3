package com.nothing.vo.Edu;

import javax.persistence.*;
//
//学期表
@Table(name="Term")
@Entity
public class Term {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =600, allocationSize = 1)
    private Integer termId;//学期id
    private String termName;
    private String termRemark;

    public Integer getTermId() {
        return termId;
    }

    public void setTermId(Integer termId) {
        this.termId = termId;
    }

    public String getTermName() {
        return termName;
    }

    public void setTermName(String termName) {
        this.termName = termName;
    }

    public String getTermRemark() {
        return termRemark;
    }

    public void setTermRemark(String termRemark) {
        this.termRemark = termRemark;
    }
}
