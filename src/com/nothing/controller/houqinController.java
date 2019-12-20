package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.houqin.equipmentRepair;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.nothing.service.houqinService;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("houqin")
public class houqinController {
    @Resource
    houqinService hs;
    @RequestMapping("/repairList")
    @ResponseBody
    public JSONObject repairList(){
        List list = hs.repairList();
        int count = hs.getCount();

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",count);
        return jsonObject;
    }
    //前往报修信息新增页面
    @RequestMapping({"/repAddPage"})
    public String repAddPage() {
        return "houqin/repAdd";
    }
    //报修管理
    @RequestMapping("/toRepairListPage")
    public String toRepairListPage(){
        return "houqin/repairList";
    }
    //前往报修信息修改页面
    @RequestMapping({"/repUpPage"})
    public String repUp(String rid, HttpServletRequest req) throws ParseException {
        int id = Integer.parseInt(rid);
        //当前要修改的记录
        equipmentRepair er = hs.getEr(id);
        req.setAttribute("er",er);
        return "houqin/repUp";
    }
    //报修信息新增操作
    @RequestMapping({"/repAdd"})
    @ResponseBody
    public void repAdd(equipmentRepair er, HttpSession session) throws ParseException {
        Emp e = (Emp) session.getAttribute("empId");
        er.setStatus(0);//0未完成，1完成
        er.setStartTime(new Date());
        er.setUserType(2);//1学生，2员工
        er.setClasses(e.getEmpDeptId());
        er.setStudent(e.getEmpId());
        hs.erAdd(er);
    }
    //报修信息修改操作
    @RequestMapping({"/repUp"})
    @ResponseBody
    public void repUp(equipmentRepair er,String start,String end, HttpServletRequest req) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        er.setStartTime(simpleDateFormat.parse(start));
        er.setEedTime(simpleDateFormat.parse(end));
        hs.erUp(er);
        System.out.println(er.toString());
        req.removeAttribute("er");
    }
    //报修信息删除操作
    @RequestMapping({"/repDel"})
    @ResponseBody
    public void repDel(String id) {
        hs.erDel(id);
    }
}
