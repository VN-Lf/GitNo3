package com.nothing.vo.emp;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name ="jobs")
public class JobsVo implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int jobId;   //主键
	private String jobType;//申请类型 qingjia    baoxiao
	private String jobName;//申请类型名称 请假单  报销单
	private int day; //天数
	private float money;//金额
	private Date jobDate;//申请日期
	private int processFlag;//状态:1、审核中 //2、审批通过
	private String userId;//用户名称
	private String remark;//申请说明

	@Override
	public String toString() {
		return "JobsVo{" +
				"jobId=" + jobId +
				", jobType='" + jobType + '\'' +
				", jobName='" + jobName + '\'' +
				", day=" + day +
				", money=" + money +
				", jobDate=" + jobDate +
				", processFlag=" + processFlag +
				", userId='" + userId + '\'' +
				", remark='" + remark + '\'' +
				'}';
	}

	public int getJobId() {
		return jobId;
	}
	public void setJobId(int jobId) {
		this.jobId = jobId;
	}
	public String getJobType() {
		return jobType;
	}
	public void setJobType(String jobType) {
		this.jobType = jobType;
	}
	public String getJobName() {
		return jobName;
	}
	public void setJobName(String jobName) {
		this.jobName = jobName;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public float getMoney() {
		return money;
	}
	public void setMoney(float money) {
		this.money = money;
	}
	public Date getJobDate() {
		return jobDate;
	}
	public void setJobDate(Date jobDate) {
		this.jobDate = jobDate;
	}
	public int getProcessFlag() {
		return processFlag;
	}
	public void setProcessFlag(int processFlag) {
		this.processFlag = processFlag;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

}
