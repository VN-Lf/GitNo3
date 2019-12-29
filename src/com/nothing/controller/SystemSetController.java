package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.SysSetService;
import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.StuFall;
import com.nothing.vo.charge.tuitionType;
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
    @RequestMapping("/toTTTList")
    public String toTtType(){
        return "systemSet/tuitionType/tttList";
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
    @RequestMapping("/tttList")
    @ResponseBody
    public JSONObject tttList(){
        List ttt = sss.getTTTList();
        int con = sss.getTTTCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", ttt);
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
    @RequestMapping("/toTTTAdd")
    public String toTTTAdd(){
        return "systemSet/tuitionType/tttAdd";
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
    @RequestMapping("/tttAdd")
    @ResponseBody
    public void tttAdd(tuitionType tt){
        sss.TTTAdd(tt);
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
    @RequestMapping("/toTTTUp")
    public String toTTTUp(int id, HttpServletRequest req){
        tuitionType ttt = sss.getTTT(id);
        req.setAttribute("ttt",ttt);
        return "systemSet/tuitionType/tttUp";
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
    @RequestMapping("/tttUp")
    @ResponseBody
    public void tttUp(tuitionType ttt){
        sss.TTTUp(ttt);
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
    @RequestMapping("/tttDel")
    @ResponseBody
    public void tttDel(String id){
        sss.TTTDel(id);
    }
}
