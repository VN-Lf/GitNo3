package com.nothing.controller;


import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmpService;
import com.nothing.service.GoPageService;
import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
    @Resource
    EmpService empService;
    //前往主界面
    @RequestMapping("/home")
    public String toHome(HttpSession session,String color) {
        if(session.getAttribute("empId") != null){
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
        }else if(session.getAttribute("stuId") != null) {
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
            return "homeStu";
        }else {
            return "login";
        }
    }
    @RequestMapping("/tologin")
    public String toLogin(){
        return "login";
    }
    //登录判断
    @RequestMapping("/login")
    public String login(HttpServletRequest request,HttpSession session, String zhanghao,String pwd,String type){
        if("emp".equals(type)){
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
            if(0 == emp.getEmpLoginStatus()){
                String s = "该用户已被封禁";
                request.getSession().setAttribute("mes",s);
                return "redirect:tologin";
            }else {
                Post post = empService.sqlPostVo(""+emp.getEmpId());
                session.setAttribute("empId",emp);
                session.setAttribute("post",post);
                return "redirect:home";
            }
        }else if("stu".equals(type)){
            System.out.println(zhanghao+"|"+pwd);
            List<Map> list = service.selectGoPage("SELECT studId from student where stuPhone = '"+zhanghao+ "' and stuPsw = '"+pwd+"'");
            if(list.size()==0 ){
                String s = "账号或密码错误";
                request.getSession().setAttribute("mes",s);
                return "redirect:tologin";
            }
            Integer i = 0;
            for(int j=0;j<list.size();j++){
                i= (int) list.get(j).get("studId");
            }

            Student stu = new Student();
            stu = (Student) service.selectEmpGoPage(stu,i);
            session.setAttribute("stuId",stu);
            return "redirect:home";
        }else {
            String s = "登入姿势错误";
            request.getSession().setAttribute("mes",s);
            return "redirect:tologin";
        }
    }
    //退出登录
    @RequestMapping("/end")
    public void End(HttpSession session){
        System.out.println(session.getAttribute("studId"));
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
    //前往查看公告
    @RequestMapping("/toMyNotice")
    public String toMyNotice(){
        return "emp/myNotice";
    }
    //前往子表信息
    @RequestMapping({"/empEdu"})
    public String toEmpEducation(String id, HttpSession session) {
        int eid = Integer.parseInt(id);
        session.setAttribute("currActEmpId",eid);
        return "emp/ortherInf";
    }
    //前往值班列表
    @RequestMapping("/weeklist")
    public String toWeeklist(){
        return "emp/weeklist";
    }
    //动态查找部门
    @RequestMapping("/deptlist")
    @ResponseBody
    public JSONObject deptList() {
        List wlist = service.deptList();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", wlist);
        return jsonObject;
    }
    //查找员工下拉框
    @RequestMapping("/listemp")
    @ResponseBody
    public JSONObject ListEmp() {
        List elist = service.empList();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", elist);
        return jsonObject;
    }
}
