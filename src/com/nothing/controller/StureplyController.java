package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.StrreplyService;
import com.nothing.vo.Sdudent.Student;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("Stureply")
@Controller
public class StureplyController {

    @Resource
    StrreplyService service ;

    @RequestMapping("toStureply")
    public String toStureply(){
        return "SCourse/StuProject";
    }

    @ResponseBody
    @RequestMapping("list")
    public JSONObject list(HttpSession session){
        Student student = (Student) session.getAttribute("stuId");
        int i = student.getStudId();
        System.out.println("学生Id为"+i);
        List list = service.selectStrreplylist("select s.* ,e.empName as empName , stu.stuName as stuName , p.projectName as projectName from stureplyscore s \n" +
                "left join emp e using(empId) \n" +
                "left join student stu using(studId)\n" +
                "left join project p using(projectId) where studId = "+i);
        int count = service.SelcctStrreplycount("select count(*) from stureplyscore");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }
}
