package com.nothing.vo.Sdudent;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="EntryFinance")
public class EntryFinance {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =3000, allocationSize = 1)
    private Integer    entryId;
    private Date entryTime;
    private Integer enrollmentId;
    private String  reviewer;

    public Integer getEntryId(){
        return entryId;
    }

    public void setEntryId(Integer entryId) {
        this.entryId = entryId;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public Integer getEnrollmentId() {
        return enrollmentId;
    }

    public void setEnrollmentId(Integer enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }


    @Override
    public String toString() {
        return "EntryFinance{" +
                "entryId=" + entryId +
                ", entryTime=" + entryTime +
                ", enrollmentId=" + enrollmentId +
                ", reviewer='" + reviewer + '\'' +
                '}';
    }
}
