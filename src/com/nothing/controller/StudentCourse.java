package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.SCoutseService;
import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.emp.Emp;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("scourse")
public class StudentCourse {

    @Resource
    SCoutseService service ;

    @RequestMapping("toScourse")
    public String toScourse(){
        return "SCourse/StudentsCoutse";
    }

    @ResponseBody
    @RequestMapping("list")
    public JSONObject list(HttpSession session){
        Student student = (Student) session.getAttribute("stuId");
        int i = student.getStudId();
        System.out.println("学生Id为"+i);
        List list = service.selectScoutselist("select ssc.*,e.empName as empName,cou.courseName as courseName,te.termName as termName,s.stuName as stuName from studentscore ssc left join emp e using(empId) left join course  cou using(courseId) left join term te using(termId) left join student s using(studId) where studId = " +i);
        int count = service.SelcctScoutsecount("select count(*) from studentscore");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }
}
