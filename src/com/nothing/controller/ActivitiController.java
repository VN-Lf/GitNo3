package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.ActivitiService;
import com.nothing.service.EmpService;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ActivitiController {
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private TaskService taskService;
    @Resource
    private ActivitiService actservice;
    @Resource
    private EmpService empService;
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
    public String apply(JobsVo job,String dept,String godate,String gotime,String enddate,String endtime){
        //保存单据
        String gotd = godate+" "+gotime;
        String endtd = enddate+" "+endtime;
        job.setGoDate(gotd);
        job.setEndDate(endtd);
        actservice.addJobs(job,dept);
        return "redirect:myJobList";
    }
    //删除流程
    @RequestMapping("/delProgressDefine")
    public String delProgressDefine(String id){
        repositoryService.deleteDeployment(id,true);
        return "redirect:list";
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
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Emp emp = (Emp)session.getAttribute("empId");
        String actorId = ""+emp.getEmpId();
        List<Task> list = taskService.createTaskQuery().taskAssignee(actorId).list();
        List mlist = new ArrayList();
        List empList = empService.selEmpAll("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId"); //查询所有员工
        int jj = 0;
        //将com中的emp id转换成用户名
        for (int i = 0;i < list.size(); i++){
            Map map = new HashMap();
            Task jvo = list.get(i);
            String shijian = formatter.format(jvo.getCreateTime());
            if(jvo.getName().equals("上级审批")){
                for(int j = 0;j < empList.size(); j++){
                    Map map1 = (Map)empList.get(j);
                    if(jvo.getAssignee().equals(""+map1.get("empId"))){
                        jvo.setAssignee(""+map1.get("empName"));
                        map.put("com",jvo);
                        map.put("sj",shijian);
                        mlist.add(jj,map);
                        break;
                    }
                }
                jj++;
            }
        }
        if(list.size() == 0){
            model.addAttribute("zhi",0);
        }else {
            model.addAttribute("zhi",1);
            model.addAttribute("taskList",mlist);
        }
        return "act/myTask";
    }
    @RequestMapping("/myTaskStu")
    public String LookMyTaskStu(HttpSession session,Model model){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Emp emp = (Emp)session.getAttribute("empId");
        String actorId = ""+emp.getEmpId();
        List<Task> list = taskService.createTaskQuery().taskAssignee(actorId).list();
        List empList = empService.selEmpAll("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId");
        List mlist = new ArrayList();
        int jj = 0;
        //将com中的emp id转换成用户名
        for (int i = 0;i < list.size(); i++){
            Map map = new HashMap();
            Task jvo = list.get(i);
            String shijian = formatter.format(jvo.getCreateTime());
            if(jvo.getName().equals("授课教师") || jvo.getName().equals("班主任") || jvo.getName().equals("校长")){
                for(int j = 0;j < empList.size(); j++){
                    Map map1 = (Map)empList.get(j);
                    if(jvo.getAssignee().equals(""+map1.get("empId"))){
                        jvo.setAssignee(""+map1.get("empName"));
                        map.put("com",jvo);
                        map.put("sj",shijian);
                        mlist.add(jj,map);
                        break;
                    }
                }
                jj++;
            }
        }
        if(list.size() == 0){
            model.addAttribute("zhi",0);
        }else {
            model.addAttribute("zhi",1);
            model.addAttribute("taskList",mlist);
        }
        return "act/myTask";
    }
    @RequestMapping("/tasksize")
    @ResponseBody
    public JSONObject taskSize(HttpSession session){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        JSONObject jsonObject = new JSONObject();
        Emp emp = (Emp)session.getAttribute("empId");
        String actorId = ""+emp.getEmpId();
        List<Task> list = taskService.createTaskQuery().taskAssignee(actorId).list();
        List mlist = new ArrayList();
        List empList = empService.selEmpAll("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId"); //查询所有员工
        //将com中的emp id转换成用户名
        for (int i = 0;i < list.size(); i++){
            Map map = new HashMap();
            Task jvo = list.get(i);
            String shijian = formatter.format(jvo.getCreateTime());
            for(int j = 0;j < empList.size(); j++){
                Map map1 = (Map)empList.get(j);
                if(jvo.getAssignee().equals(""+map1.get("empId"))){
                    jvo.setAssignee(""+map1.get("empName"));
                    break;
                }
            }

            list.set(i,jvo);
            map.put("name",jvo.getName());
            map.put("sj",shijian);
            mlist.add(i,map);
        }
        jsonObject.put("size", list.size());
        jsonObject.put("task", mlist);
        return jsonObject;
    }
    //执行任务
    @RequestMapping("/taskDetail")
    public String askDetail(String taskId,String instId,Model model){
        //获取jobID
        int jobId =  Integer.parseInt(taskService.getVariable(taskId, "jobId").toString());
        //根据单据ID查询对象
        JobsVo job = actservice.selJobById(jobId);
        Map rmap = actservice.zhixieTask(taskId,instId);

        //将job里的empid转换为员工姓名
        List elist = (List) rmap.get("emplist");
        for(int j = 0;j < elist.size(); j++){
            Map map = (Map)elist.get(j);
            if(job.getUserId().equals(""+map.get("empId"))){
                job.setUserId(""+map.get("empName"));
                break;
            }
        }
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
    public String complete(int jobId,String taskId,String flow,String comment,String jobType,HttpSession session){
        //获取用户名称
        Emp emp = (Emp)session.getAttribute("empId");
        String actorId = ""+emp.getEmpId();
        if("stuLeave".equals(jobType)){
            actservice.xiuGaiTaskStu(jobId,taskId,flow,comment,actorId);
        }else {
            actservice.xiuGaiTask(jobId,taskId,flow,comment,actorId);
        }


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
