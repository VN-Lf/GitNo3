package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.ActivitiService;
import com.nothing.service.EmpService;
import com.nothing.service.StuSer.ActStuSer;
import com.nothing.service.StuSer.StuSer;
import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.JobsVo;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.task.Comment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
///
@Controller
@RequestMapping("actStu")
public class StuHolidayController{
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private TaskService taskService;
    @Resource
    private ActivitiService actservice;
    @Resource
    private EmpService empService;
    @Resource
    private ActStuSer actStuSer;
    @Resource
    private HistoryService historyService;
    @Resource
    StuSer stuSer;

    @RequestMapping("toApply")
    public String toApplyPage(){
        return "actStu/stuholidayApply";
    }

    //提交请假申请
    @RequestMapping("apply")
    public String toApply(JobsVo jobsVo) throws ParseException{
        try {
            actStuSer.addApply(jobsVo);
        } catch (IndexOutOfBoundsException e){

        }

        return "actStu/stuActMyJob";
    }

    @RequestMapping("toMyJob")
    public String toMyJobPage(){
        return "actStu/stuActMyJob";
    }

    //查看我的发起事务列表
    @ResponseBody
    @RequestMapping("myJobList")
    public JSONObject myJobList(HttpSession session){
        JSONObject jsonObject =  new JSONObject();
        Student s  = (Student) session.getAttribute("stuId");
        List  list = actStuSer.stuMyJob(s.getStudId().toString());
        int title = actStuSer.stuMyJobCount(s.getStudId().toString());
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        return jsonObject;
    }

    //我的请假单中查看备注
    @ResponseBody
    @RequestMapping("lookComment")
    public JSONObject lookComment(int jobId) throws ParseException{
        //通过jobId查询历史变量对象
               JSONObject jsonObject = new JSONObject();
                //通过jobID查询历史变量对象
                HistoricVariableInstance hvi = historyService.createHistoricVariableInstanceQuery().variableValueEquals("jobId", jobId).singleResult();
                //获取流程实例id （查询历史批注）
                List<Comment>  commentList =new ArrayList<>();
                    System.out.println("hvi:"+hvi);
                    try{ commentList =taskService.getProcessInstanceComments(hvi.getProcessInstanceId());
                    }catch (NullPointerException e){

                    }
                    List list=new ArrayList();
                    for(Comment comment:commentList){
                        Map dataMap=new HashMap();
                        Emp emp   = (Emp) stuSer.findO(new Emp(),Integer.parseInt(comment.getUserId()));
                        dataMap.put("empName",emp.getEmpName());
                        dataMap.put("fullMessage",comment.getFullMessage());
                        dataMap.put("sj",comment.getTime());
                        list.add(dataMap);
                        }
                jsonObject.put("code",0);
                jsonObject.put("msg","");
                jsonObject.put("data",list);
                jsonObject.put("count",list.size());
                return jsonObject;
    }
}
