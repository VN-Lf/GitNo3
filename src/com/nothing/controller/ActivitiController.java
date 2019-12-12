package com.nothing.controller;

import com.nothing.service.ActivitiService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.JobsVo;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.List;
import java.util.Map;
//流程控制器
@Controller
public class ActivitiController {
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private TaskService taskService;
    @Resource
    private ActivitiService actservice;
    //前往流程列表
    @RequestMapping("/list")
    public String toActList(Model model){
        ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
        query.orderByProcessDefinitionVersion().desc();
        List<ProcessDefinition> list = query.list();
        if(list.size() == 0){
            model.addAttribute("zhi",0);
        }else {
            model.addAttribute("zhi",1);
            model.addAttribute("processList",list);
        }
        return "act/actlist";
    }

    @RequestMapping("/upact")
    public String upLiuCheng(MultipartFile pdFile){
        actservice.upLiuCheng(pdFile);
        return "redirect:list";
    }

    @RequestMapping("/addjia")
    public String toQingjia(){
        return "act/qingjia";
    }

    @RequestMapping("/apply")
    public String apply(JobsVo job,String dept){
        //保存单据
        actservice.addJobs(job,dept);
        return "redirect:myJobList";
    }
    //删除流程
    @RequestMapping("/delProgressDefine")
    public String delProgressDefine(String id){
        repositoryService.deleteDeployment(id,true);
        return "redirect:chaAllLiu";
    }
    //下载流程图
    @RequestMapping("/toExport")
    public String toExport(String id,HttpServletResponse resp){
        actservice.xiaZaiLiu(id,resp);
        return null;
    }
    //查看流程图
    @RequestMapping("/viewProcessImage")
    public String viewProcessImage(String did, String imageName, HttpServletResponse resp){
        actservice.lookLiuTu(did,imageName,resp);
        return null;
    }
    //查看我的发起事务列表
    @RequestMapping("/myJobList")
    public String myJobList(HttpSession session, Model model){
        Emp emp = (Emp)session.getAttribute("empId");
        String actorId = ""+emp.getEmpId();
        List<JobsVo> list = actservice.selJob(actorId);
        if(list.size() == 0){
            model.addAttribute("zhi",0);
        }else {
            model.addAttribute("zhi",1);
            model.addAttribute("jobList",list);
        }
        return "act/myjob";
    }
    //查看进度
    @RequestMapping("/lookMyJob")
    public String LookMyJob(String jobId,Model model,String instId){
        Map rmap = actservice.lookLiuCheng(jobId,instId);

        model.addAttribute("pd",rmap.get("pd"));
        model.addAttribute("mapList",rmap.get("maplist"));
        return "act/image";
    }

    //查看我的任务
    @RequestMapping("/myTask")
    public String LookMyTask(HttpSession session,Model model){
        Emp emp = (Emp)session.getAttribute("empId");
        String actorId = ""+emp.getEmpId();
        List<Task> list = taskService.createTaskQuery().taskAssignee(actorId).list();
        if(list.size() == 0){
            model.addAttribute("zhi",0);
        }else {
            model.addAttribute("zhi",1);
            model.addAttribute("taskList",list);
        }
        return "act/myTask";
    }
    //执行任务
    @RequestMapping("/taskDetail")
    public String askDetail(String taskId,String instId,Model model){
        //获取jobID
        int jobId =  Integer.parseInt(taskService.getVariable(taskId, "jobId").toString());
        //根据单据ID查询对象
        JobsVo job = actservice.selJobById(jobId);
        Map rmap = actservice.zhixieTask(taskId,instId);

        model.addAttribute("taskId",taskId);
        model.addAttribute("job",job);

        if("0".equals(rmap.get("zhi"))){
            model.addAttribute("zhi",0);
        }else {
            model.addAttribute("zhi",1);
            model.addAttribute("commentList",rmap.get("commentList"));
        }

        return "act/adult";
    }
    //执行审批的内容
    @RequestMapping("/complete")
    public String complete(int jobId,String taskId,String flow,String comment,HttpSession session){
        //获取用户名称
        Emp emp = (Emp)session.getAttribute("empId");
        String actorId = ""+emp.getEmpId();
        System.out.println(jobId+":flow:"+flow);
        actservice.xiuGaiTask(jobId,taskId,flow,comment,actorId);

        return "redirect:myTask";
    }
    @RequestMapping("/lookComment")
    public String lookComment(int jobId,Model model) throws ParseException {
        //获取流程实例id （查询历史批注）
        List commentList = actservice.lookMyBeiZhu(jobId);

        if(commentList.size() == 0){
            model.addAttribute("zhi",0);
        }else {
            model.addAttribute("zhi",1);
            model.addAttribute("commentList",commentList);
        }
        return "act/comment";
    }
}
