package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.feedbackService;
import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.feedback.feedback;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("feedback")
public class feedbackController {
    @Resource
    feedbackService service ;

    @RequestMapping("tofeedback")
    public String tofeedback(HttpServletRequest request){
        List list = service.selectfeedbacklist("select * from dept");
        request.setAttribute("Edeptlist",list);
        return "feedback/feedback";
    }
    @RequestMapping("toStufeedback")
    public String toStufeedback(HttpServletRequest request){
        List list = service.selectfeedbacklist("select * from dept");
        request.setAttribute("Edeptlist",list);
        return "feedback/StuFeedback";
    }


    //员工list
    @ResponseBody
    @RequestMapping("list")
    public JSONObject list(HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        int i = emp.getEmpId();
        List<Map> lists = service.selectfeedbacklist("select userId from feedback where empid = "+i+" and feedBackType = 1");
        String userid = (String) lists.get(0).get("userId");

        List<Map> list = service.selectfeedbacklist("select fe.* ,e.empName as empName ,d.deptName as deptName,(select empname from emp where empId = "+userid+") as username from feedback fe \n" +
                "left join emp e using(empId)\n" +
                "left join dept d using(deptId) where fe.empId = "+i+" and fe.feedBackType = 1");

        int count = service.Selcctfeedbackcount("select count(*) from feedback");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }

    //学生list
    @ResponseBody
    @RequestMapping("Stulist")
    public JSONObject Stulist(HttpSession session){
        Student student = (Student) session.getAttribute("stuId");
        int i = student.getStudId();

        List<Map> list = service.selectfeedbacklist("select fe.* ,e.empName as empName ,d.deptName as deptName from feedback fe \n" +
                "left join emp e using(empId)\n" +
                "left join dept d using(deptId) where fe.empId = "+i+" and fe.feedBackType = 2");

        int count = service.Selcctfeedbackcount("select count(*) from feedback");
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }

    //我的审批
    @ResponseBody
    @RequestMapping("mylist")
    public JSONObject mylist(HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        int i = emp.getEmpId();
        List<Map> list = service.selectfeedbacklist("select fe.* ,e.empName as empName ,d.deptName as deptName from feedback fe \n" +
                "left join emp e using(empId)\n" +
                "left join dept d using(deptId) where fe.userId =  '"+i+"'");

        int count = service.Selcctfeedbackcount("select count(*) from feedback");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }

    //查询要发送的人
    @ResponseBody
    @RequestMapping("selsendfeedback")
    public JSONObject selsendfeedback(String deptname){
        System.out.println(deptname);
        List list = service.selectfeedbacklist("select * from emp where empId in (select empId from post where deptId = '"+deptname+"')");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", list);
        return jsonObject;
    }

    //查询审核人姓名
    @ResponseBody
    @RequestMapping("selsendUsername")
    public JSONObject selsendUsername(String username){
        System.out.println(username);
        List list = service.selectfeedbacklist("select empname  from emp where empId = '"+username+"')");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", list);
        return jsonObject;
    }

    //员工填写问题
    @RequestMapping("addfeedback")
    public String addfeedback(int deptIds,String userIds,String remarks,HttpSession session,feedback feedback){
        System.out.println("教师问题反馈");
        Emp emp = (Emp) session.getAttribute("empId");
        feedback.setEmpId(String.valueOf(emp.getEmpId()));
        feedback.setEmpname(emp.getEmpName());
        feedback.setFeedbackTime(new Date());
        System.out.println("时间为"+feedback.getFeedbackTime());
        feedback.setStatus(1);
        //类型
        feedback.setFeedBackType(1);

        feedback.setRemark(remarks);
        feedback.setUserId(userIds);
        feedback.setDeptId(deptIds);

        service.addFeedback(feedback);
        return "redirect: tofeedback";
    }

    //学生填写问题
    @RequestMapping("addStufeedback")
    public String addStufeedback(int deptIds,String userIds,String remarks,HttpSession session,feedback feedback){
        System.out.println("学生问题反馈");
        Student student = (Student) session.getAttribute("stuId");
        feedback.setEmpId(String.valueOf(student.getStudId()));
        feedback.setEmpname(student.getStuName());
        feedback.setFeedbackTime(new Date());
        System.out.println("时间为"+feedback.getFeedbackTime());
        feedback.setStatus(1);
        //类型
        feedback.setFeedBackType(2);

        feedback.setRemark(remarks);
        feedback.setUserId(userIds);
        feedback.setDeptId(deptIds);

        service.addFeedback(feedback);
        return "redirect: toStufeedback";
    }

    //问题编辑
    @RequestMapping("updfeedback")
    public String updfeedback(feedback feedback,String opinion,String feedbackTimes) throws ParseException {
        feedback.setStatus(2);
        feedback.setOpinion(opinion);

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1 = formatter.parse(String.valueOf(feedbackTimes));
        feedback.setFeedbackTime(date1);

        System.out.println(feedback.getFeedbackId());
        System.out.println(feedback.getRemark());
        System.out.println(feedback.getOpinion());
        service.updateFeedback(feedback);
        return "redirect: tofeedback";
    }

    //问题删除
    @RequestMapping("delfeedback")
    public String delfeedback(String id){
        id = id.substring(0,id.length()-1);
        service.delFeedback(id);
        return "redirect: tofeedback";
    }
}
