package com.nothing.controller;

import com.nothing.vo.emp.EmpEducation;
import com.sun.deploy.net.HttpResponse;
import org.hibernate.Session;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *转跳页面总控制器 登录判断
 */
@Controller
@RequestMapping("to")
public class GoPageController {
    //前往主界面
    @RequestMapping("/home")
    public String toHome(HttpSession session,String color) {
        if(session.getAttribute("empId") == null){
            return "login";
        }else {
            if(color == null || "null".equals(color)){
                SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");//设置日期格式
                String time = df.format(new Date()).substring(0,2);
                if(Integer.parseInt(time) > 18 || Integer.parseInt(time) < 6){
                    session.setAttribute("color","dark-hive");
                }else {
                    session.setAttribute("color","gray");
                }
            }else {
                session.setAttribute("color",color);
            }
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
    //前往员工资料
    @RequestMapping("/tonotice")
    public String toNotice(){
        return "emp/noticelist";
    }
    //前往子表信息
    @RequestMapping({"/empEdu"})
    public String toEmpEducation(String id, HttpSession session) {
        int eid = Integer.parseInt(id);
        session.setAttribute("currActEmpId",eid);
        return "emp/educationList";
    }
}
