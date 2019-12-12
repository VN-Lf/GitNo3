package com.nothing.vo.dep;





import javax.persistence.*;

@Entity
@Table(name ="dep")
public class dep {  //部门设置
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =0, allocationSize = 1)
    private Integer depId;
    private String depName; //部门名称
    private Integer parentId;//父部门名称
    private String chairman;    //部门负责人
    private String  remark; //备注
    private Integer personnel;//是否为人事部

    public Integer getDepId() {
        return depId;
    }

    public void setDepId(Integer depId) {
        this.depId = depId;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getChairman() {
        return chairman;
    }

    public void setChairman(String chairman) {
        this.chairman = chairman;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getPersonnel() {
        return personnel;
    }

    public void setPersonnel(Integer personnel) {
        this.personnel = personnel;
    }
}
