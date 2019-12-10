package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;
import org.springframework.stereotype.Controller;
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
        System.out.println(eid);
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
    @RequestMapping({"/eduUp"})
    public void eduUp(EmpEducation edu, HttpServletRequest req) {
        empService.eduUp(edu);
        req.removeAttribute("edu");
    }

    @RequestMapping({"/eduAdd"})
    public void eduAdd(EmpEducation edu, HttpServletRequest req) {
        empService.eduAdd(edu);
        req.removeAttribute("edu");
    }
    @RequestMapping({"/eduDel"})
    public void eduDel(String id) {
        empService.eduDel(id);
    }
}
