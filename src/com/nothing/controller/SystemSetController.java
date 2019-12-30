package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.SysSetService;
import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.EduMajor;
import com.nothing.vo.Edu.StuFall;
import com.nothing.vo.Edu.Term;
import com.nothing.vo.charge.tuitionType;
import com.nothing.vo.dep.dep;
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
    @RequestMapping("/toTTType")
    public String toTTType(){
        return "systemSet/tuitionType/tttList";
    }
    @RequestMapping("/toTerm")
    public String toTerm(){
        return "systemSet/term/termList";
    }
    @RequestMapping("/toMajor")
    public String toEduMajor(){
        return "systemSet/major/majorList";
    }
    @RequestMapping("/toDept")
    public String toDept(){
        return "systemSet/dept/deptList";
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
    @RequestMapping("/termList")
    @ResponseBody
    public JSONObject termList(){
        List t = sss.getTermList();
        int con = sss.getTermCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", t);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }
    @RequestMapping("/majorList")
    @ResponseBody
    public JSONObject majorList(){
        List t = sss.getEduMajorList();
        int con = sss.getEduMajorCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", t);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }
    @RequestMapping("/deptList")
    @ResponseBody
    public JSONObject deptList(){
        List t = sss.getDeptList();
        int con = sss.getDeptCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", t);
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
    @RequestMapping("/toTermAdd")
    public String toTermAdd(){
        return "systemSet/term/termAdd";
    }
    @RequestMapping("/toMajorAdd")
    public String toMajorAdd(HttpServletRequest request){
        List dept = sss.getDeptList();
        request.setAttribute("deptName",dept);
        return "systemSet/major/majorAdd";
    }
    @RequestMapping("/toDeptAdd")
    public String toDeptAdd(){
        return "systemSet/dept/deptAdd";
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
    @RequestMapping("/termAdd")
    @ResponseBody
    public void termAdd(Term tt){
        sss.termAdd(tt);
    }
    @RequestMapping("/majorAdd")
    @ResponseBody
    public void majorAdd(EduMajor em){
        sss.EduMajorAdd(em);
    }
    @RequestMapping("/deptAdd")
    @ResponseBody
    public void deptAdd(dep dep){
        sss.deptAdd(dep);
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
    @RequestMapping("/toTermUp")
    public String toTermUp(int id, HttpServletRequest req){
        Term t = sss.getTerm(id);
        req.setAttribute("t",t);
        return "systemSet/term/termUp";
    }
    @RequestMapping("/toMajorUp")
    public String toMajorUp(int id, HttpServletRequest req){
        EduMajor em = sss.getEduMajor(id);
        req.setAttribute("em",em);
        List dept = sss.getDeptList();
        req.setAttribute("deptName",dept);
        return "systemSet/major/majorUp";
    }
    @RequestMapping("/toDeptUp")
    public String toDeptUp(int id, HttpServletRequest req){
        dep em = sss.getDept(id);
        req.setAttribute("dept",em);
        return "systemSet/dept/deptUp";
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
    @RequestMapping("/termUp")
    @ResponseBody
    public void termUp(Term t){
        sss.termUp(t);
    }
    @RequestMapping("/majorUp")
    @ResponseBody
    public void majorUp(EduMajor em){
        sss.EduMajorUp(em);
    }
    @ResponseBody
    public void deptUp(dep em){
        sss.deptUp(em);
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
    @RequestMapping("/termDel")
    @ResponseBody
    public void termDel(String id){
        sss.termDel(id);
    }
    @RequestMapping("/majorDel")
    @ResponseBody
    public void majorDel(String id){
        sss.EduMajorDel(id);
    }
    @RequestMapping("/deptDel")
    @ResponseBody
    public void deptDel(String id){
        sss.deptDel(id);
    }
}
