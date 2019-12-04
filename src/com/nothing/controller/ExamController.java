package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.impl.Examserviceimpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/exam")
public class ExamController {
    @Resource
    Examserviceimpl examserviceimpl;
    @RequestMapping(value = "toexam")
    public String toexam(){
        return "exam";
    }

    @RequestMapping(value = "/examlist")
    @ResponseBody
    public JSONObject examlist(){
        List examlist = examserviceimpl.examlist("select * from aduitmodel");
        JSONObject jsonObject=new JSONObject();
        int selectcount = examserviceimpl.selectcount();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }
}
