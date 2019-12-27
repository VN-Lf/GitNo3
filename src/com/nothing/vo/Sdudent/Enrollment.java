package com.nothing.vo.Sdudent;

import javax.persistence.*;
import javax.xml.crypto.Data;
import java.util.Date;

@Entity
@Table(name="Enrollment")
public class Enrollment{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =3000, allocationSize = 1)
    private    Integer         enrollmentId ;          //主键，标识列，自动生成
    private    String          stuName;//姓名
    private    String         cardId;//身份证
    private    String        stuSex;//性别
    private    String          stuPhone;//手机号
    private    String         stuQQ;//QQ号码
    private    String          school;//学校
    private   Integer          classId;//班级
    private    Float         amount;//预定报名费
    private    String         computer;//是否送电脑(是/否)
    private     Date        testTime;//试学时间
    private      Date          startTime;//入学时间
    private     Date            signdate; //录入时间
    private  Integer           empId;//员工id关联员工表
    private String              enterEmp; //招生老师
    private   Integer          status;//学生状态表
    private   String           remark;//备注
    private   Integer            classType;//班级类别,关联班级类别表
    private    Date         paymentTime;//缴预定报名费时间
    private   Double          score;//入学成绩
    private   float          enrollMoney;//发放金额
    private    Date         enrollMoneyTime;//发放时间
    private    String          reviewStatus;//预定报名费审核 是否通过
    private    String          negativeName;//该字段用于招生老师没有账号时使用字段
    private    Integer         majorId;//关联专业id

    @Override
    public String toString() {
        return "Enrollment{" +
                "enrollmentid=" + enrollmentId +
                ", stuName='" + stuName + '\'' +
                ", cardId='" + cardId + '\'' +
                ", stuSex='" + stuSex + '\'' +
                ", stuPhone='" + stuPhone + '\'' +
                ", stuQQ='" + stuQQ + '\'' +
                ", school='" + school + '\'' +
                ", classId=" + classId +
                ", amount=" + amount +
                ", computer='" + computer + '\'' +
                ", testTime=" + testTime +
                ", startTime=" + startTime +
                ", signdate=" + signdate +
                ", empId=" + empId +
                ", enterEmp='" + enterEmp + '\'' +
                ", status=" + status +
                ", remark='" + remark + '\'' +
                ", studType=" + classType +
                ", paymentTime=" + paymentTime +
                ", score=" + score +
                ", enrollMoney=" + enrollMoney +
                ", enrollMoneyTime=" + enrollMoneyTime +
                ", reviewStatus='" + reviewStatus + '\'' +
                ", negativeName='" + negativeName + '\'' +
                ", majorId=" + majorId +
                '}';
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getEnterEmp() {
        return enterEmp;
    }

    public void setEnterEmp(String enterEmp) {
        this.enterEmp = enterEmp;
    }

    public Integer getEnrollmentid() {
        return enrollmentId;
    }

    public void setEnrollmentid(Integer enrollmentid) {
        this.enrollmentId = enrollmentid;
    }

    public String getStudName() {
        return stuName;
    }

    public void setStudName(String studName) {
        this.stuName = studName;
    }

    public String getCardId() {
        return cardId;
    }

    public void setCardId(String cardId) {
        this.cardId = cardId;
    }

    public String getStuSex() {
        return stuSex;
    }

    public void setStuSex(String stuSex) {
        this.stuSex = stuSex;
    }

    public String getStuPhone() {
        return stuPhone;
    }

    public void setStuPhone(String stuPhone) {
        this.stuPhone = stuPhone;
    }

    public String getStuQQ() {
        return stuQQ;
    }

    public void setStuQQ(String stuQQ) {
        this.stuQQ = stuQQ;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public Integer getClassId() {
        return classId;
    }

    public void setClassId(Integer classId) {
        this.classId = classId;
    }

    public Float getAmount() {
        return amount;
    }

    public void setAmount(Float amount) {
        this.amount = amount;
    }

    public String getComputer() {
        return computer;
    }

    public void setComputer(String computer) {
        this.computer = computer;
    }

    public Date getTestTime() {
        return testTime;
    }

    public void setTestTime(Date testTime) {
        this.testTime = testTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getSigndate() {
        return signdate;
    }

    public void setSigndate(Date signdate) {
        this.signdate = signdate;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getClassType() {
        return classType;
    }

    public void setClassType(Integer classType) {
        this.classType = classType;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public float getEnrollMoney() {
        return enrollMoney;
    }

    public void setEnrollMoney(float enrollMoney) {
        this.enrollMoney = enrollMoney;
    }

    public Date getEnrollMoneyTime() {
        return enrollMoneyTime;
    }

    public void setEnrollMoneyTime(Date enrollMoneyTime) {
        this.enrollMoneyTime = enrollMoneyTime;
    }

    public String getReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(String reviewStatus) {
        this.reviewStatus = reviewStatus;
    }

    public String getNegativeName() {
        return negativeName;
    }

    public void setNegativeName(String negativeName) {
        this.negativeName = negativeName;
    }


    public Integer getMajorId() {
        return majorId;
    }

    public void setMajorId(Integer majorId) {
        this.majorId = majorId;
    }
}
