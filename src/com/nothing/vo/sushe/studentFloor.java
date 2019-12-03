package com.nothing.vo.sushe;

import org.springframework.stereotype.Repository;

import javax.persistence.*;

@Entity
@Table(name = "studentFloor")
public class studentFloor {//宿舍资料
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer floorId;//楼栋id
    private String floorName;//楼栋名称

    public Integer getFloorId() {
        return floorId;
    }

    public void setFloorId(Integer floorId) {
        this.floorId = floorId;
    }

    public String getFloorName() {
        return floorName;
    }

    public void setFloorName(String floorName) {
        this.floorName = floorName;
    }
}
