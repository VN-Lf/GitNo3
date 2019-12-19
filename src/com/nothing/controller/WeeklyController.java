package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.WeeklyService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpWeekPaper;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("Weekly")
public class WeeklyController {
    //周报管理
    @Resource
    WeeklyService service;
    //去我的周报页面
    @RequestMapping("toWeekly")
    public String toWeekly(HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        System.out.println("当前登录id为 ："+emp.getEmpId());
        return "weekly/WeeklyNewspaper";
    }

    //去周报汇总页面
    @RequestMapping("toWeeklyCollect")
    public String toWeeklyCollect(HttpSession session){
        return "weekly/WeeklyMain";
    }
    //根据账号获取周报
    @ResponseBody
    @RequestMapping("list")
    public JSONObject list(HttpSession session) {
        System.out.println("进来了");

        Emp emp = (Emp) session.getAttribute("empId");
        int empid = emp.getEmpId();
        List<Map> list = service.selectWeeklylist("select *,e.empName as empNames from empweekpaper w left join emp e  using(empId) where w.empId = "+empid);
        int count = service.SelcctWeeklycount("select count(*) from empweekpaper");


        System.out.println(list.toString());
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }

    //获取全部周报
    @ResponseBody
    @RequestMapping("listcollect")
    public JSONObject listcollect(HttpSession session) {
        List list = service.selectWeeklylist("select *,e.empName as empNames from empweekpaper w left join emp e  using(empId)");
        int count = service.SelcctWeeklycount("select count(*) from empweekpaper");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }
    //添加周报的方法
    @RequestMapping("Weeklyadd")
    public String Weeklyadd(EmpWeekPaper weekPaper,HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        weekPaper.setEmpId(emp.getEmpId());
        weekPaper.setWeekCycle(new Date());
        service.WeeklyAdd(weekPaper);
        return "redirect:toWeekly";
    }
    //修改的方法
    @RequestMapping("Weeklyupdate")
    public String Weeklyupdate(EmpWeekPaper weekPaper,String weekCycleD) throws ParseException {
        /*Date date = new Date();
        String weekCycleD = String.valueOf(date);
        System.out.println(weekCycleD);*/
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = formatter.parse(String.valueOf(weekCycleD));
        /*System.out.println(date1);
        Date date2 = new Date();
        date2.setTime(Long.parseLong(date1));*/
        weekPaper.setWeekCycle(date1);
        System.out.println(date1);
        System.out.println("修改时间" + weekPaper.getWeekCycle());
        System.out.println("进来了周报修改");
        System.out.println("进来了新增"+weekPaper.getWeekPaperId());
        System.out.println(weekPaper.getWeekCycle());
        System.out.println(weekPaper.getWeekDescription());
        System.out.println(weekPaper.getWeekNextPlan());
        System.out.println(weekPaper.getWeekOption());
        System.out.println(weekPaper.getWeekPaperId());
        System.out.println(weekPaper.getWeekStudentQuestion());
        System.out.println(weekPaper.getWeekTerm());
        service.WeeklyUpdate(weekPaper);
        return "redirect:toWeekly";
    }


    //删除的方法
    @RequestMapping("WeeklyDelete")
    public String WeeklyDelete(String id){
        id = id.substring(0,id.length()-1);
        service.WeeklyDelete(id);
        return "redirect:toWeekly";
    }

    //周报汇总的搜索框的条件
    @RequestMapping(value = "/empWeeklist")
    @ResponseBody
    public JSONObject empexamlist(HttpServletRequest request, HttpServletResponse response,String empname, String starttime, String endtime) throws UnsupportedEncodingException {

        String empnames = empname;
        empnames = new String(empnames.getBytes("iso-8859-1"),"utf-8");
        empnames = java.net.URLDecoder.decode(empnames,"UTF-8");

        System.out.println("姓名："+empnames);
        String Starttime=null;
        String Endtime=null;
        List examdate = service.WeeklySerletData("select weekCycle from empweekpaper ORDER BY weekCycle");
        List date=new ArrayList();
        for(int i=0;i<examdate.size();i++){
            Map map=(HashMap)examdate.get(i);
            date.add(map.get("weekCycle"));
        }

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

        for(int i=0;i<date.size();i++) {
            Starttime = sdf.format(date.get(0));
            Endtime =sdf.format(date.get(date.size()-1));
        }

        if(starttime==null || starttime.equals("")){
            starttime=Starttime;
        }
        if(endtime==null || endtime.equals("")){
            endtime=Endtime;
        }
        if(empnames==null){
            empnames="";
        }
        /*if(Depid==null){
            Depid="";
        }*/
        List examlist = service.selectWeeklylist("select wr.*,e.empName as empNames from empweekpaper wr left join emp e  using(empId) where  e.empName like '%"+empnames+ "%' and wr.weekCycle between '"+starttime+"' and '"+endtime+"'");
        JSONObject jsonObject=new JSONObject();
        int selectcount = service.SelcctWeeklycount("select count(*) from empweekpaper");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }

    //周报汇总的搜索框的条件
    @RequestMapping(value = "/MyWeeklist")
    @ResponseBody
    public JSONObject MyWeeklist( String starttime, String endtime) throws UnsupportedEncodingException {

        String Starttime=null;
        String Endtime=null;
        List examdate = service.WeeklySerletData("select weekCycle from empweekpaper ORDER BY weekCycle");
        List date=new ArrayList();
        for(int i=0;i<examdate.size();i++){
            Map map=(HashMap)examdate.get(i);
            date.add(map.get("weekCycle"));
        }

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

        for(int i=0;i<date.size();i++) {
            Starttime = sdf.format(date.get(0));
            Endtime =sdf.format(date.get(date.size()-1));
        }

        if(starttime==null || starttime.equals("")){
            starttime=Starttime;
        }
        if(endtime==null || endtime.equals("")){
            endtime=Endtime;
        }
        /*if(empnames==null){
            empnames="";
        }*/
        /*if(Depid==null){
            Depid="";
        }*/
        List examlist = service.selectWeeklylist("select wr.*,e.empName as empNames from empweekpaper wr left join emp e  using(empId) where  wr.weekCycle between '"+starttime+"' and '"+endtime+"'");
        JSONObject jsonObject=new JSONObject();
        int selectcount = service.SelcctWeeklycount("select count(*) from empweekpaper");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }

}
