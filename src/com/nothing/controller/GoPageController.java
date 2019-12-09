package com.nothing.controller;


import com.nothing.service.EmpService;
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
                session.setAttribute("color","gray");
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
}
