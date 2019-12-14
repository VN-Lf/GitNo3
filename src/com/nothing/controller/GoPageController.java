package com.nothing.controller;


import com.nothing.service.GoPageService;
import com.nothing.vo.emp.Emp;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 *转跳页面总控制器 登录判断
 */
@Controller
@RequestMapping("/to")
public class GoPageController {
    @Resource
    GoPageService service;
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
    //登录判断
    @RequestMapping("/login")
    public String login(HttpServletRequest request,HttpSession session, String zhanghao,String pwd){
        System.out.println(pwd+"密码|用户："+zhanghao);
        pwd = pwd.substring(0,pwd.length()-1);
        List<Map> list = service.selectGoPage("SELECT empId from emp where empPhone = '"+zhanghao+ "' and empLogPsw = '"+pwd+"'");
        if(list.size()==0 ){
            String s = "账号或密码错误";
            request.getSession().setAttribute("mes",s);
            return "redirect:tologin";
        }
        Integer i = 0;
        for(int j=0;j<list.size();j++){
            i= (int) list.get(j).get("empId");
            System.out.println(i);
        }

        Emp emp = new Emp();
        emp = (Emp) service.selectEmpGoPage(emp,i);

        session.setAttribute("empId",emp);
        return "redirect:home";
    }
    //退出登录
    @RequestMapping("/end")
    public void End(HttpSession session){
        System.out.println(session.getAttribute("empId"));
        session.invalidate();
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
    //前往公告列表
    @RequestMapping("/tonotice")
    public String toNotice(){
        return "emp/noticelist";
    }
    //前往员工子表信息
    @RequestMapping({"/ortherInf"})
    public String toEmpEducation(String id, HttpSession session) {
        int eid = Integer.parseInt(id);
        session.setAttribute("currActEmpId",eid);
        return "emp/ortherInf";
    }
    @RequestMapping("/toRepairListPage")
    public String toRepairListPage(){
        return "houqin/repairList";
    }
    //报修操作页
    @RequestMapping("/toRepairActPage")
    public String toRepairActPage(){
        return "houqin/rep";
    }
}
