package com.nothing.controller;


import com.nothing.service.EmpService;
import com.nothing.vo.emp.EmpEducation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *转跳页面总控制器 登录判断
 */
@Controller
@RequestMapping("to")
public class GoPageController {
    @Resource
    EmpService es;
    //前往主界面
    @RequestMapping("/home")
    public String toHome(HttpSession session){
        if(session.getAttribute("empId") == null){
            return "login";
        }else {
            return "home";
        }
    }
    @RequestMapping("/tologin")
    public String toLogin(){
        return "login";
    }
    //登录
    @RequestMapping("/login")
    public String login(HttpSession session, String zhanghao,String pwd){
        System.out.println(pwd+"密码|用户："+zhanghao);
        session.setAttribute("empId",zhanghao);
        return "redirect:home";
    }
    //退出登录
    @RequestMapping("/end")
    public void End(HttpSession session){
        session.invalidate();
        System.out.println(session.getAttribute("empId"));
    }
    //前往员工资料
    @RequestMapping("/toempzl")
    public String toEmpzl(){
        return "emp/emplist";
    }
    //前往添加员工页
    @RequestMapping("/empadd")
    public String toEmpAdd(){
        return "emp/empadd";
    }
    //前往员工修改页
    @RequestMapping("/empup")
    public String toEmpUpdate(String id){
        System.out.println("id:"+id);
        return "emp/empupdate";
    }
    //前往教育经历
    @RequestMapping({"/empEdu"})
    public String toEmpEducation(String id, HttpServletRequest request) {
        int eid = Integer.parseInt(id);
        request.setAttribute("currActEmpId",eid);
        return "emp/educationList";
    }
    //前往教育经历修改
    @RequestMapping({"/eduUpPage"})
    public String eduUp(String eid, HttpServletRequest req) {
        int id = Integer.parseInt(eid);
        EmpEducation edu = es.getEdu(id);
        req.setAttribute("edu",edu);
        return "emp/eduUp";
    }

    //报修列表
    @RequestMapping("/toRepairListPage")
    public String toRepair(){
        return "houqin/repairList";
    }
}
