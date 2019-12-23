
package com.nothing.vo.Sdudent;
import javax.persistence.*;
////
@Entity
@Table(name="StudentProject")
public class StudentProject{

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =3000, allocationSize = 1)
    private Integer projectId;//答辩项目id
    private String proName;//项目名称

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    @Override
    public String toString() {
        return "ReplyScoreVo{" +
                "projectId=" + projectId +
                ", proName='" + proName + '\'' +
                '}';
    }
}


