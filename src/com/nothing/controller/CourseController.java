package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.courseService;
import com.nothing.vo.Edu.Course;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("courseManage")
public class CourseController {

    @Resource
    courseService service;

    @RequestMapping("toCourse")
    public String toCourse(HttpServletRequest request){
        List list = service.Courselist("SELECT * FROM courseType ");
        request.setAttribute("courseList",list);
        return "course/Course";
    }

    @RequestMapping("list")
    @ResponseBody
    public JSONObject list(){
        List list = service.Courselist("select c.*,ct.courseTypeName as typeName from course c left join courseType ct  using(courseTypeId)");
        int count = service.Coursecount("select count(*) from course");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }

    //添加的方法
    @RequestMapping("addCourse")
    public String addCourse(Course course){
        service.addCourse(course);
        return "redirect:toCourse";
    }
    //修改的方法
    @RequestMapping("updateCourse")
    public String updateCourse(Course course){
        service.updateCourse(course);
        return "redirect:toCourse";
    }

    //删除的方法
    @RequestMapping("delCourse")
    public String delCourse(String id){
        id = id.substring(0,id.length()-1);
        service.delCourse(id);
        return "redirect:toCourse";
    }


}
