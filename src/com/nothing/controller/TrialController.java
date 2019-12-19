package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.TrialService;
import com.nothing.vo.Edu.Course;
import com.nothing.vo.Edu.Trial;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Trial")
public class TrialController {

    @Resource
    TrialService service;
    @RequestMapping("toTrial")
    public String toTrial(HttpServletRequest request){
        //找出课程
        List list = service.Triallist("select * from course");
        request.setAttribute("tcourselist",list);
        //找出授课老师
        List l = service.Triallist("select * from emp");
        request.setAttribute("templist",l);
        return "course/Trial";
    }
    @RequestMapping("toTrials")
    public String toTrials(HttpServletRequest request){
        //找出课程
        List list = service.Triallist("select * from course");
        request.setAttribute("tcourselist",list);
        //找出授课老师
        List l = service.Triallist("select * from emp");
        request.setAttribute("templist",l);
        return "course/Trial";
    }

    @ResponseBody
    @RequestMapping("list")
    public JSONObject list(){

        List list = service.Triallist("select t.*,c.courseName as CourseName,e.empName  from trial t \n" +
                "left join course c  using(courseId)\n" +
                "left join emp e using(empId)");
        int count = service.Trialcount("select count(*) from trial");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }

    //添加的方法
    @RequestMapping("addTrial")
    public String addTrial(Trial trial,String trialDates) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = formatter.parse(String.valueOf(trialDates));
        //转换时间
        trial.setTrialDate(date1);
        service.addTrial(trial);
        return "redirect:toTrial";
    }
    //修改的方法
    @RequestMapping("updateTrial")
    public String updateTrial(HttpServletRequest request,HttpSession session, Trial trial, String trialDates) throws ParseException {
        /*if(trialDates == null){
            session.setAttribute("tianxdate","请填写时间");
            //找出课程
            List list = service.Triallist("select * from course");
            request.setAttribute("tcourselist",list);
            //找出授课老师
            List l = service.Triallist("select * from emp");
            request.setAttribute("templist",l);
            return "course/Trial";
        }*/
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = formatter.parse(String.valueOf(trialDates));
        //转换时间
        trial.setTrialDate(date1);
        service.updateTrial(trial);
        return "redirect:toTrial";
    }

    //删除的方法
    @RequestMapping("delTrial")
    public String delTrial(String id){
        id = id.substring(0,id.length()-1);
        service.delTrial(id);
        return "redirect:toTrial";
    }

}
