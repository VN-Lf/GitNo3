package com.nothing.vo.charge;

import javax.persistence.*;

@Entity
@Table(name = "Notice ")
public class Notice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =100, allocationSize = 1)
    private Integer noticeId;
    private String  title; //标题
    private String content; //内容
    private Integer noticeType;   // 1 所有人 2员工 3学生 4班级
    private String empName;//发布人

}
