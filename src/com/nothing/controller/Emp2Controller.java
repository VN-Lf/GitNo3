package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmpService;
import com.nothing.vo.charge.Notice;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;
import com.nothing.vo.emp.WeekArrange;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("emp")
public class Emp2Controller {
    @Resource
    private EmpService empService;

    @RequestMapping("/emplist")
    @ResponseBody
    public JSONObject EmpList() {
        List examlist = empService.selEmpAll("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId");
        int con = empService.selEmpCont("select count(empId) from emp");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", examlist);
        jsonObject.put("count", con);
        return jsonObject;
    }
    @RequestMapping("/emplistsx")
    @ResponseBody
    public JSONObject empkListSx(String emp,String dept,String phone,String zt) throws UnsupportedEncodingException {
        String sql = "select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId";
        String consql = "select count(e.empId) from emp e,post p,dept d";
        emp = new String(emp.getBytes("iso-8859-1"),"utf-8");
        emp = java.net.URLDecoder.decode(emp,"UTF-8");

        if(!emp.equals("")){
            String yuJu = "%";
            for(int i = 0; i < emp.length(); i++){
                char x = emp.charAt(i);
                yuJu += x+"%";
            }
            sql += " and e.empName like '"+yuJu+"'";
        }
        if(!dept.equals("")){
            sql += " and e.empDeptId ="+dept;
        }
        if(!phone.equals("")){
            String yuJu = "%";
            for(int i = 0; i < phone.length(); i++){
                char x = phone.charAt(i);
                yuJu += x+"%";
            }
            sql += " and e.empPhone like '"+yuJu+"'";
        }
        if(!zt.equals("")){
            sql += " and e.empLoginStatus ="+zt;
        }
        consql = consql + sql.substring(57);
        List examlist = empService.selEmpAll(sql);
        int con = empService.selEmpCont(consql);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", examlist);
        jsonObject.put("count", con);
        return jsonObject;
    }
    @RequestMapping("/notlist")
    @ResponseBody
    public JSONObject NoticeList(String type){
        List notlist = empService.selNoticeAll(type);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", notlist);
        return jsonObject;
    }

    @RequestMapping("/notadd")
    public String NotAdd(Notice notice,String time) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println("时间"+time);
        notice.setNoticeTime(simpleDateFormat.parse(time));
        System.out.println(notice.getContent()+notice.getTitle()+notice.getNoticeTime());
        System.out.println(notice.getNoticeType());
        empService.addNotice(notice,1);
        return "emp/noticelist";
    }
    //标记是否查看公告
    @RequestMapping("/martNotice")
    @ResponseBody
    public void martNotice(String eid,String nid){
        Notice notice = empService.chaNotice(nid);
        String emps = notice.getEmps();
        String[] split = emps.split(",");
        for (int i=0;i<split.length;i++){
            if (split[i].equals(eid)){
                return;
            }
        }
        if (emps==null){
            emps=eid+",";
        }else {
            emps+=eid+",";
        }

        notice.setEmps(emps);
        System.out.println(notice.toString());
        empService.addNotice(notice,2);
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
        id = id.substring(0, id.length() - 1);
        empService.delete(id);
        return "成功";
    }

    @RequestMapping("/toDelon")
    @ResponseBody
    public JSONObject toDelOn(String sid) {
        JSONObject jsonObject = new JSONObject();
        empService.delete(sid);
        jsonObject.put("msg", "you");
        return jsonObject;
    }

    @RequestMapping("/czpwd")
    public String czPwd(String sid) {
        empService.czPwd(sid);
        return "redirect:emplist";
    }
    @RequestMapping("/banemp")
    public String banEmp(String id,String zt) {
        empService.banEmp(id,zt);
        return "redirect:emplist";
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
    @RequestMapping("/notupdate")
    @ResponseBody
    public String notUpdate(String con,String ti,String id){
        Notice notice = empService.chaNotice(id);
        notice.setNoticeId(Integer.parseInt(id));
        notice.setTitle(ti);
        notice.setContent(con);
        empService.addNotice(notice,2);//2为修改
        return "修改成功";
    }
    @RequestMapping("/notdel")
    @ResponseBody
    public String notDel(String id){
        Notice notice = empService.chaNotice(id);
        notice.setNoticeId(Integer.parseInt(id));
        empService.addNotice(notice,3);//3为删除
        return "删除成功";
    }

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
    //值班部分
    @RequestMapping("/weeklist")
    @ResponseBody
    public JSONObject weekList() {
        List wlist = empService.weekList("select * from weekarrange");
        int con = empService.selEmpCont("select count(WeekArrangeId) from weekarrange");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", wlist);
        jsonObject.put("count", con);
        return jsonObject;
    }
    @RequestMapping("/weeklistsx")
    @ResponseBody
    public JSONObject weekListSx(String emp,String date) throws UnsupportedEncodingException {
        String sql = "select * from weekarrange";
        String consql = "select count(WeekArrangeId) from weekarrange";
        emp = new String(emp.getBytes("iso-8859-1"),"utf-8");
        emp = java.net.URLDecoder.decode(emp,"UTF-8");
        date = new String(date.getBytes("iso-8859-1"),"utf-8");
        date = java.net.URLDecoder.decode(date,"UTF-8");
        if(!emp.equals("")){
            sql += " where empId = '"+emp+"'";
            consql += " where empId = '"+emp+"'";
            if(!date.equals("")){
                sql += " and week = '"+date+"'";
                consql += " and week = '"+date+"'";
            }
        }else if(!date.equals("")){
            sql += " where week = '"+date+"'";
            consql += " where week = '"+date+"'";
            if(!emp.equals("")){
                sql += " and empId = '"+emp+"'";
                consql += " and empId = '"+emp+"'";
            }
        }

        List wlist = empService.weekList(sql);
        int con = empService.selEmpCont(consql);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", wlist);
        jsonObject.put("count", con);
        return jsonObject;
    }
    @RequestMapping("/weekadd")
    public String WeekAdd(WeekArrange war){
        empService.addWeek(war);
        return "emp/weeklist";
    }
    @RequestMapping("/weekdelete")
    @ResponseBody
    public JSONObject weekDelete(String id){
        JSONObject jsonObject = new JSONObject();
        empService.delWeek(id);
        jsonObject.put("msg","you");
        return jsonObject;
    }
    @RequestMapping("/weekup")
    public String DeptUpdate(WeekArrange week,String weekArrangeId){
        week.setWeekArrangeid(Integer.parseInt(weekArrangeId));
        empService.updateWeek(week);
        return "emp/weeklist";
    }
    @RequestMapping("/weekdelall")
    public String DeptDeleteAll(String id){
        empService.delWeekAll(id);
        return "emp/weeklist";
    }
}
