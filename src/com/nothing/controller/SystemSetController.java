package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.SysSetService;
import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.StuFall;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
        return "systemSet/fall/fallList";
    }
    @RequestMapping("/toCTList")
    public String toClaTypeList(){
        return "systemSet/class/claTypeList";
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
    @RequestMapping("/CTList")
    @ResponseBody
    public JSONObject CTList(){
        List ctl = sss.getCTList();
        int con = sss.getCTCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", ctl);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }

    @RequestMapping("/toFallAdd")
    public String toFallAdd(){
        return "systemSet/fall/fallAdd";
    }
    @RequestMapping("/toCTAdd")
    public String toCTAdd(){
        return "systemSet/class/claTypeAdd";
    }
    @RequestMapping("/fallAdd")
    @ResponseBody
    public void fallAdd(StuFall sf){
        System.out.println(sf.toString());
        sss.fallAdd(sf);
    }
    @RequestMapping("/CTAdd")
    @ResponseBody
    public void CTAdd(ClassType ct){
        sss.CTAdd(ct);
    }

    @RequestMapping("/toFallUp")
    public String toFallUp(int id, HttpServletRequest req){
        StuFall sf = sss.getFall(id);
        req.setAttribute("sf",sf);
        return "systemSet/fall/fallUp";
    }
    @RequestMapping("/toCTUp")
    public String toCTUp(int id, HttpServletRequest req){
        ClassType ct = sss.getCT(id);
        req.setAttribute("ct",ct);
        return "systemSet/class/claTypeUp";
    }

    @RequestMapping("/fallUp")
    @ResponseBody
    public void fallUp(StuFall sf){
        sss.fallUp(sf);
    }
    @RequestMapping("/CTUp")
    @ResponseBody
    public void CTUp(ClassType CT){
        sss.CTUp(CT);
    }

    @RequestMapping("/fallDel")
    @ResponseBody
    public void fallDel(String id){
        sss.fallDel(id);
    }
    @RequestMapping("/CTDel")
    @ResponseBody
    public void CTDel(String id){
        sss.CTDel(id);
    }
}
