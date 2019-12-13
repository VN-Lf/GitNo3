package com.nothing.service;

import com.nothing.vo.emp.JobsVo;
import org.activiti.engine.task.Comment;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.List;
import java.util.Map;
//liuc
public interface ActivitiService {
    void upLiuCheng(MultipartFile pdFile); //上传流程图
    void xiaZaiLiu(String id, HttpServletResponse resp);//下载流程图
    void addJobs(JobsVo job,String dept);           //创建一个流程
    void lookLiuTu(String did, String imageName, HttpServletResponse resp);//查看流程图
    List<JobsVo> selJob(String actorId);    //查找我的流程
    Map lookLiuCheng(String jobId, String instId); //查看流程
    Map zhixieTask(String taskId,String instId);    //执行任务
    JobsVo selJobById(int id);                      //根据id查一个流程
    void updJob(JobsVo jobsVo);                     //修改流程
    void xiuGaiTask(int jobId,String taskId,String flow,String comment,String userId);//修改任务
    List lookMyBeiZhu(int id) throws ParseException;             //查看备注
    int sqlZhixin(String deptid);                 //传入部门id查主任
    List chuliComm(List<Comment> commentList,List empList);//处理list集合 empid转换姓名 时间转换
}
