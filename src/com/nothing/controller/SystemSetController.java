package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.SysSetService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("sys")
public class SystemSetController {
    @Resource
    SysSetService sss;
    @RequestMapping("/toSetList")
    public String toSetList(){
        return "systemSet/setList";
    }
    @RequestMapping("/toFallList")
    public String toFallList(){
        return "systemSet/fallList";
    }
    @RequestMapping("/fallList")
    @ResponseBody
    public JSONObject fallList(){
        List fallList = sss.getFallList();
        int con = sss.getFallCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", fallList);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }

    @RequestMapping("/fallDel")
    @ResponseBody
    public void fallDel(String id){
        sss.fallDel(id);
    }
}
