package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.TuitionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@RequestMapping("Tuition")
@Controller
public class TuitionController {

    @Resource
    TuitionService service;

    @RequestMapping("toTuition")
    public String toTuition(){
        return "TuitionManagement/Tuition";
    }

    @ResponseBody
    @RequestMapping("list")
    public JSONObject list (){
        List list = service.selectTuition("select * from financeshouldtuitionrecord");
        int count = service.SelcctTuitioncount("select count(*) from studenthour");


        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }
    //删除的方法
    @RequestMapping("Tuitiondelete")
    public String Tuitiondelete(String id ){
        System.out.println("进来了删除：id"+id);
        id = id.substring(0,id.length()-1);
        service.deleteTuition(id);
        return "redirect:toTuition";
    }
}
