package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

//控制器
@Controller
@RequestMapping("emp")
public class EmpController {
    @Resource
    private EmpService empService;

    @RequestMapping("/emplist")
    @ResponseBody
    public JSONObject EmpList() {
        List examlist = empService.selEmpAll();
        int con = empService.selEmpCont();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", examlist);
        jsonObject.put("count", con);
        return jsonObject;
    }

    @RequestMapping("/empadd")
    public void EmpList(Emp emp, EmpEducation empEducation, Post post, String ruzhitime, String birthday) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(!"".equals(birthday)){
            emp.setEmpBirthday(simpleDateFormat.parse(birthday));
        }
        if(!"".equals(ruzhitime)){
            emp.setEmpFireday(simpleDateFormat.parse(ruzhitime));
        }
        System.out.println("员工：" + emp);
        System.out.println(ruzhitime + "学历：" + empEducation);
        System.out.println(birthday + "职务：" + post.getPostName());
        empService.addEmp(emp, empEducation, post);
    }

    @RequestMapping("/toDel")
    public String toDel(String id) {
        System.out.println("进来" + id);
        id = id.substring(0, id.length() - 1);
        empService.delete(id);
        return "成功";
    }

    @RequestMapping("/toDelon")
    public void toDelOn(String sid,HttpServletResponse resp) throws IOException {
        System.out.println("进来" + sid);
        PrintWriter pw = resp.getWriter();
        empService.delete(sid);
        pw.write("true");
        pw.flush();
        pw.close();
    }

    @RequestMapping("/czpwd")
    public void czPwd(String sid,HttpServletResponse resp) throws IOException {
        PrintWriter pw = resp.getWriter();
        empService.czPwd(sid);
        pw.write("true");
        pw.flush();
        pw.close();
    }

    @RequestMapping("/empup")
    public String sqlEmp(String id,HttpServletRequest req){
        Emp emp = empService.sqlEmpVo(id);
        Post post = empService.sqlPostVo(id);
        EmpEducation emdu = empService.sqlEduVo(id);
        System.out.println("postName:"+post.getPostName());
        req.setAttribute("emp",emp);
        req.setAttribute("postvo",post);
        req.setAttribute("emdutvo",emdu);
        return  "emp/empupdate";
    }
    /*@RequestMapping("/empup")
    public ModelAndView EmpUp(String id,ModelAndView mv){
        Emp emp = empService.sqlEmpVo(id);
        Post post = empService.sqlPostVo(id);
        EmpEducation emdu = empService.sqlEduVo(id);
        mv.addObject("empvo",emp);
        mv.addObject("postvo",post);
        mv.addObject("emdvo",emdu);
        mv.setViewName("emp/empupdate");
        System.out.println("major:"+emdu.getEmpEduMajor()+"school:"+emdu.getEmpUniversity());
        return mv;
    }*/

    @RequestMapping("/update")
    public void EmpUpdate(Emp emp, EmpEducation Edu, Post post, String ruzhitime, String birthday) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(!"".equals(birthday)){
            emp.setEmpBirthday(simpleDateFormat.parse(birthday));
        }
        if(!"".equals(ruzhitime)){
            emp.setEmpFireday(simpleDateFormat.parse(ruzhitime));
        }
        System.out.println("empid：" + emp.getEmpId()+"eduid:"+Edu.getEmpEduId()+"postid:"+post.getPostId());
        empService.empUpdate(emp, Edu, post);
    }


    /*@RequestMapping({"/empEducationList"})
    @ResponseBody
    public JSONObject getEducationList(String eid) {
        int id = Integer.parseInt(eid);
        List eduList = this.empService.selEmpEducation(id);
        this.empService.getEmpEducationCount(id);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", eduList);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }*/
}
