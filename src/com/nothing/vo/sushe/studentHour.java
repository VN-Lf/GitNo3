package com.nothing.vo.sushe;

import javax.persistence.*;

@Entity//
@Table(name = "studentHour")
public class studentHour {//楼栋维护
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer stuHours;
    private String hourName;//宿舍房号
    private String addr;//地址
    private Integer count;//宿舍人数
    private Integer floorId;//楼栋外键
    private Integer numberBeds;//床位数
    private Integer hourIddsc;//序号

    public Integer getStuHours() {
        return stuHours;
    }

    public void setStuHours(Integer stuHours) {
        this.stuHours = stuHours;
    }

    public String getHourName() {
        return hourName;
    }

    public void setHourName(String hourName) {
        this.hourName = hourName;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getFloorId() {
        return floorId;
    }

    public void setFloorId(Integer floorId) {
        this.floorId = floorId;
    }

    public Integer getNumberBeds() {
        return numberBeds;
    }

    public void setNumberBeds(Integer numberBeds) {
        this.numberBeds = numberBeds;
    }

    public Integer getHourIddsc() {
        return hourIddsc;
    }

    public void setHourIddsc(Integer hourIddsc) {
        this.hourIddsc = hourIddsc;
    }
}
