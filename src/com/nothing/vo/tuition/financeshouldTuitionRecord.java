package com.nothing.vo.tuition;

import javax.persistence.*;

@Entity
@Table(name = "financeshouldTuitionRecord")
public class financeshouldTuitionRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer financeId;      //主键，标识列，自动生成
    private String financedate;    //缴费日期/退款日期
    private Integer stuid;          //关联学生表的主键
    //标示那个学期的收费”第一学期”，”第二学期”，
    // ”第三学期”，”第四学期”，”第五学期”	,外键关联到学期表主键
    private Integer termId;
    private String receipt;         //支付方式
    private Integer financeType;    //1:缴费，2：退款
    private Float factMoney;        //实交金额(正)/退款金额(负)
    private Integer empid;          //(收款人)员工id关联员工表
    private String remark;          //说明
    private Integer Invalid;        //1:有效，2：作废
    private Integer tuitionTypeId;  //关联收费项

    public Integer getFinanceId() {
        return financeId;
    }

    public void setFinanceId(Integer financeId) {
        this.financeId = financeId;
    }

    public String getFinancedate() {
        return financedate;
    }

    public void setFinancedate(String financedate) {
        this.financedate = financedate;
    }

    public Integer getStuid() {
        return stuid;
    }

    public void setStuid(Integer stuid) {
        this.stuid = stuid;
    }

    public Integer getTermId() {
        return termId;
    }

    public void setTermId(Integer termId) {
        this.termId = termId;
    }

    public String getReceipt() {
        return receipt;
    }

    public void setReceipt(String receipt) {
        this.receipt = receipt;
    }

    public Integer getFinanceType() {
        return financeType;
    }

    public void setFinanceType(Integer financeType) {
        this.financeType = financeType;
    }

    public Float getFactMoney() {
        return factMoney;
    }

    public void setFactMoney(Float factMoney) {
        this.factMoney = factMoney;
    }

    public Integer getEmpid() {
        return empid;
    }

    public void setEmpid(Integer empid) {
        this.empid = empid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getInvalid() {
        return Invalid;
    }

    public void setInvalid(Integer invalid) {
        Invalid = invalid;
    }

    public Integer getTuitionTypeId() {
        return tuitionTypeId;
    }

    public void setTuitionTypeId(Integer tuitionTypeId) {
        this.tuitionTypeId = tuitionTypeId;
    }
}
