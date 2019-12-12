package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.EmpHistory;
import com.nothing.vo.emp.Post;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("emp")
public class EmpController {
    @Resource
    private EmpService empService;

    @RequestMapping({"/empEducationList"})
    @ResponseBody
    public JSONObject getEducationList(String eid) {
        int id = Integer.parseInt(eid);
        List eduList = empService.selEmpEducation(id);
        int con = empService.getEmpEducationCount(id);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", eduList);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }
    //前往教育经历修改页面
    @RequestMapping({"/eduUpPage"})
    public String eduUp(String eid, HttpServletRequest req) {
        int id = Integer.parseInt(eid);
        EmpEducation edu = empService.getEdu(id);
        req.setAttribute("edu",edu);
        return "emp/eduUp";
    }
    //前往教育经历新增页面
    @RequestMapping({"/eduAddPage"})
    public String eduAddPage() {
        return "emp/eduAdd";
    }
    //教育经历修改操作
    @RequestMapping({"/eduUp"})
    @ResponseBody
    public void eduUp(EmpEducation edu, HttpServletRequest req) {
        empService.eduUp(edu);
        req.removeAttribute("edu");
    }
    //教育经历新增操作
    @RequestMapping({"/eduAdd"})
    @ResponseBody
    public void eduAdd(EmpEducation edu) {
        empService.eduAdd(edu);
    }
    //教育经历删除操作
    @RequestMapping({"/eduDel"})
    @ResponseBody
    public void eduDel(String id) {
        empService.eduDel(id);
    }
    @RequestMapping({"/empHis"})
    @ResponseBody
    public JSONObject getJobHis(String eid) {
        System.out.println(eid);
        int id = Integer.parseInt(eid);
        List jobHisList = empService.jobHis(id);
        int con = empService.jobHisCount(id);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", jobHisList);
        //System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }
    //前往工作经历新增页面
    @RequestMapping({"/jobAddPage"})
    public String jobAddPage() {
        return "emp/job/jobAdd";
    }
    //前往工作经历修改页面
    @RequestMapping({"/jobUpPage"})
    public String jobUp(String eid, HttpServletRequest req) {
        int id = Integer.parseInt(eid);
        //当前要修改的记录
        EmpHistory eh = empService.getJob(id);
        req.setAttribute("eh",eh);
        return "emp/job/jobUp";
    }
    //工作经历新增操作
    @RequestMapping({"/jobAdd"})
    @ResponseBody
    public void jobAdd(EmpHistory hs) {
        System.out.println(hs.toString());
        empService.jobAdd(hs);
    }
    //工作经历修改操作
    @RequestMapping({"/jobUp"})
    @ResponseBody
    public void jobUp(EmpHistory eh, HttpServletRequest req) {
        empService.jobUp(eh);
        req.removeAttribute("eh");
    }
    //工作经历删除操作
    @RequestMapping({"/jobDel"})
    @ResponseBody
    public void jobDel(String id) {
        empService.jobDel(id);
    }
}
