package com.nothing.vo.charge;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "notice ")
public class Notice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =100, allocationSize = 1)
    private Integer noticeId;
    private String  title; //标题
    private String content; //内容
    private Integer noticeType;   // 1 所有人 2员工 3学生 4班级
    private String empName;//发布人
    private Date noticeTime;
    private String emps;//已读员工
    private String students;//已读学生

    public Integer getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(Integer noticeId) {
        this.noticeId = noticeId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getNoticeType() {
        return noticeType;
    }

    public void setNoticeType(Integer noticeType) {
        this.noticeType = noticeType;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public Date getNoticeTime() {
        return noticeTime;
    }

    public void setNoticeTime(Date noticeTime) {
        this.noticeTime = noticeTime;
    }

    public String getEmps() {
        return emps;
    }

    public void setEmps(String emps) {
        this.emps = emps;
    }

    public String getStudents() {
        return students;
    }

    public void setStudents(String students) {
        this.students = students;
    }

    @Override
    public String toString() {
        return "Notice{" +
                "noticeId=" + noticeId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", noticeType=" + noticeType +
                ", empName='" + empName + '\'' +
                ", noticeTime=" + noticeTime +
                ", emps='" + emps + '\'' +
                ", students='" + students + '\'' +
                '}';
    }
}
