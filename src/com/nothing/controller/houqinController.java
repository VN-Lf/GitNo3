package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import com.nothing.service.houqinService;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("houqin")
public class houqinController {
    @Resource
    houqinService hs;
    @RequestMapping("/toRepairListPage")
    public String toRepair(){
        return "houqin/repairList";
    }
    @RequestMapping("/repairList")
    @ResponseBody
    public JSONObject repairList(){
        List list = hs.repairList("select * from equipmentrepair");
        int count = hs.getCount("select count(equipmentId) from equipmentrepair");

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",count);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }
}
