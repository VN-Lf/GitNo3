package com.nothing.vo.wintable;

import javax.persistence.*;
import java.util.Date;

/**
 * 谈心表
 */
@Entity
@Table(name = "chatRecord")
public class chatRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer chatid;
    private Integer sayface;        //学生表
    private Integer teacher;      //员工表
    private String addr;          //地址
    private String sayscon;      //内容
    private Date chatDate;          //时间

    public Integer getChatid() {
        return chatid;
    }

    public void setChatid(Integer chatid) {
        this.chatid = chatid;
    }

    public Integer getSayface() {
        return sayface;
    }

    public void setSayface(Integer sayface) {
        this.sayface = sayface;
    }

    public Integer getTeacher() {
        return teacher;
    }

    public void setTeacher(Integer teacher) {
        this.teacher = teacher;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getSayscon() {
        return sayscon;
    }

    public void setSayscon(String sayscon) {
        this.sayscon = sayscon;
    }

    public Date getChatDate() {
        return chatDate;
    }

    public void setChatDate(Date chatDate) {
        this.chatDate = chatDate;
    }

    @Override
    public String toString() {
        return "chatRecord{" +
                "chatid=" + chatid +
                ", sayface=" + sayface +
                ", teacher=" + teacher +
                ", addr='" + addr + '\'' +
                ", sayscon='" + sayscon + '\'' +
                ", chatDate=" + chatDate +
                '}';
    }
}
