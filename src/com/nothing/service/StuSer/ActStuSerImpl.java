package com.nothing.service.StuSer;

import com.nothing.dao.BaseDao;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.JobsVo;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActStuSerImpl extends BaseDao implements ActStuSer{
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private TaskService taskService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private HistoryService historyService;
    @Resource
    private EmpService empService;
    @ Resource
    private  StuSer stuSer;
    @Override
    //申请单填写后
    public void addApply(JobsVo jobsVo)throws IndexOutOfBoundsException{
        System.out.println("liuchengliuchengliuchengliuchengcliucheng"+jobsVo.toString());
        jobsVo.setJobDate(new Date());//创建时间
        jobsVo.setProcessFlag(1);//状态1、审批中
        try {
            addObject(jobsVo);
        } catch (IndexOutOfBoundsException e){

        }

        //设置流程实例变量集合
        Map<String,Object> variables = new HashMap<>();
        variables.put("userId",jobsVo.getUserId());//学生id
        variables.put("day",jobsVo.getDay());//天数
        variables.put("jobId",jobsVo.getJobId());//单据ID

        //下一个执行 授课教师
        List<Map> list = stuSer.selectTeacherByStuId(jobsVo.getUserId());
        String js = list.get(0).get("empId").toString();
        variables.put("assignee",js);

        //启动实例（通过流程定义的key来启动一个实例）
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(jobsVo.getJobType(),variables);
        System.out.println("流程实例 "+processInstance.getId());
        //根据流程实例ID获取当前实例正在执行的任务
        Task task = taskService.createTaskQuery().processInstanceId(processInstance.getId()).orderByProcessInstanceId().desc().singleResult();
        System.out.println("任务ID： "+task.getId());
        //完成任务(通过任务ID完成该任务)
        taskService.complete(task.getId(),variables);
    }

    @Override
    public List stuMyJob(String userId){
        return listBySQL("select j.*,s.stuName from Jobs j left join student s on s.studId = j.userId where j.userId = "+userId);
    }

    @Override
    public int stuMyJobCount(String userId) {
        return selTotalRow("select count(*) from Jobs  where userId= "+userId);
    }


}
