package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmpService;
import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.emp.*;
import com.nothing.vo.wintable.chatRecord;
import org.hibernate.annotations.Check;
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
        return "emp/edu/eduUp";
    }
    //前往教育经历新增页面
    @RequestMapping({"/eduAddPage"})
    public String eduAddPage() {
        return "emp/edu/eduAdd";
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
    //工作经历表数据
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

    //家庭信息表数据
    @RequestMapping({"/famInf"})
    @ResponseBody
    public JSONObject getfamInf(String eid) {
        int id = Integer.parseInt(eid);
        List famInfList = empService.famInf(id);
        int con = empService.famInfCount(id);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", famInfList);
        return jsonObject;
    }
    //前往家庭信息新增页面
    @RequestMapping({"/famAddPage"})
    public String famAddPage() {
        return "emp/fam/famAdd";
    }
    //前往家庭信息修改页面
    @RequestMapping({"/famUpPage"})
    public String famUp(String eid, HttpServletRequest req) {
        int id = Integer.parseInt(eid);
        //当前要修改的记录
        EmpFamilyImf efi = empService.getFam(id);
        System.out.println(efi.toString());
        req.setAttribute("efi",efi);
        return "emp/fam/famUp";
    }
    //家庭信息新增操作
    @RequestMapping({"/famAdd"})
    @ResponseBody
    public void famAdd(EmpFamilyImf efi) {
        empService.famAdd(efi);
    }
    //家庭信息修改操作
    @RequestMapping({"/famUp"})
    @ResponseBody
    public void famUp(EmpFamilyImf efi, HttpServletRequest req) {
        empService.famUp(efi);
        req.removeAttribute("efi");
    }
    //家庭信息删除操作
    @RequestMapping({"/famDel"})
    @ResponseBody
    public void famDel(String id) {
        empService.famDel(id);
    }

    //谈心记录
    @RequestMapping("/tochatList")
    public String tochatList(){return "emp/chat/chatRecordList";}
    //谈心记录数据
    @RequestMapping("/chatList")
    @ResponseBody
    public JSONObject chatList(){
        List jobHisList = empService.chatList();
        int con = empService.chatCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", jobHisList);
        return jsonObject;
    }
    @RequestMapping("/toChatUp")
    public String toChatUp(String cid,HttpServletRequest req){
        List chat = empService.getChat(Integer.parseInt(cid));
        req.setAttribute("chat",chat);
        return "emp/chat/chatUp";
    }
    @RequestMapping("/toChatAdd")
    public String chatAdd(){
        return "emp/chat/chatAdd";
    }
    //谈心记录删除操作
    @RequestMapping({"/chatDel"})
    @ResponseBody
    public void chatDel(String id) {
        empService.chatDel(id);
    }
    //谈心记录新增操作
    @RequestMapping({"/chatAdd"})
    @ResponseBody
    public void chatAdd(chatRecord cr,String face, String date) throws ParseException {
        Student student = empService.getStu(face);
        if (student!=null){
            cr.setSayface(student.getStudId());
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date1 = formatter.parse(String.valueOf(date));
            cr.setChatDate(date1);
            empService.chatAdd(cr);
        }
    }
    //谈心记录修改操作
    @RequestMapping({"/chatUp"})
    @ResponseBody
    public void chatUp(chatRecord cr,String cid,String face, String date) throws ParseException {
        Student student = empService.getStu(face);
        if (student!=null){
            cr.setChatid(Integer.parseInt(cid));
            cr.setSayface(student.getStudId());
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date1 = formatter.parse(String.valueOf(date));
            cr.setChatDate(date1);
            System.out.println(cr.toString());
            empService.chatUp(cr);
        }
    }

    @RequestMapping("/checkStudent")
    @ResponseBody
    public JSONObject checkStudent(String name){
        JSONObject jsonObject = new JSONObject();
        Student student = empService.getStu(name);
        if (student==null){
            jsonObject.put("result","查无此人！");
        }
        return jsonObject;

    }
}

