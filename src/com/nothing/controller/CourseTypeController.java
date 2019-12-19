package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.courseTypeService;
import com.nothing.vo.Edu.CourseType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@RequestMapping("course")
@Controller
public class CourseTypeController {
    @Resource
    courseTypeService service;

    @RequestMapping("toCourseType")
    public String toCourseType(){
        return "course/CourseType";
    }

    @RequestMapping("list")
    @ResponseBody
    public JSONObject list(){
        List list = service.selectCourselist("select * from CourseType");
        int count = service.SelcctCoursecount("select count(*) from CourseType");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }
    //添加的方法
    @RequestMapping("addCourseType")
    public String addCourseType(CourseType courseType){
        System.out.println(courseType.getCourseTypeName());
        System.out.println(courseType.getCourseTypeId());
        System.out.println(courseType.getCourseRemark());
        System.out.println("进来了添加");
        service.addCourse(courseType);
        return "redirect:toCourseType";
    }
    //修改的方法
    @RequestMapping("UpdateCourseType")
    public String UpdateCourseType(CourseType courseType){
        service.upateCourse(courseType);
        return "redirect:toCourseType";
    }
    //删除的方法
    @RequestMapping("courseTypedel")
    public String courseTypedel(String id ){
        System.out.println("进来了删除：id"+id);
        id = id.substring(0,id.length()-1);
        service.delCourse(id);
        return "redirect:toCourseType";
    }
}
