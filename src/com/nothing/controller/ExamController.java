package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.Examservice;
import com.nothing.service.impl.Examserviceimpl;
import com.nothing.vo.Email.Email;
import com.nothing.vo.wintable.aduitLog;
import com.nothing.vo.wintable.aduitModel;
import com.nothing.vo.wintable.empAssessment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

//考核控制器
@Controller
@RequestMapping("/exam")
public class ExamController {
    @Resource
    Examservice examservice;
    @RequestMapping(value = "toexam")
    public String toexam(){
        return "exammian/exam";
    }

    @RequestMapping(value = "tokaohu")
    public String tokaohu(){
        return "exammian/kaohu";
    }

    @RequestMapping(value = "lookexam")
    public String lookexam(HttpServletRequest request){
        List deptname = examservice.examlist("select deptName from dept");
        List empname = examservice.examlist("select empName from emp");
        List aduitName = examservice.examlist("select aduitName from aduitmodel");
        List deptname1=new ArrayList();
        List empname1=new ArrayList();
        List aduitName1=new ArrayList();

        for(int i=0;i<deptname.size();i++){
            Map map= (Map) deptname.get(i);
            deptname1.add(map.get("deptName"));
        }

        for(int i=0;i<empname.size();i++){
            Map map= (Map) empname.get(i);
            empname1.add(map.get("empName"));
        }

        for(int i=0;i<aduitName.size();i++){
            Map map= (Map) aduitName.get(i);
            aduitName1.add(map.get("aduitName"));
        }

        request.setAttribute("dept",deptname1);
        request.setAttribute("emp",empname1);
        request.setAttribute("aduit",aduitName1);
        return "exammian/examemp";
    }

    @RequestMapping(value = "empexam")
    public String empexam(HttpServletRequest request){
        List examlist = examservice.examlist("select e.empName,c.classRemark from emp  as e left join classvo as c on e.empId=c.classTeacher");

        Set empname=new HashSet();
        Set classname=new HashSet();

        for(int i=0;i<examlist.size();i++){
            Map map= (Map) examlist.get(i);
            empname.add(map.get("empName"));
            classname.add(map.get("classRemark"));
        }
        request.setAttribute("empnamelist",empname);
        request.setAttribute("classnamelist",classname);
        return "exammian/empexam";
    }

    @RequestMapping(value = "/examlist")
    @ResponseBody
    public JSONObject examlist(){
        List examlist = examservice.examlist("select m.*,d.deptName from  aduitmodel   as m left join dept as d  on m.Depid=d.deptId");

        JSONObject jsonObject=new JSONObject();
        int selectcount = examservice.Selectcount("select count(aduitModelid) from aduitModel");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }


    @RequestMapping(value = "/empexamlist")
    @ResponseBody
    public JSONObject empexamlist(String empname,String  Depid,String starttime,String endtime){
        String Starttime=null;
        String Endtime=null;
        List examdate = examservice.examdate("select auditDate from aduitlog ORDER BY auditDate");
        List date=new ArrayList();
        for(int i=0;i<examdate.size();i++){
            Map map=(HashMap)examdate.get(i);
            date.add(map.get("auditDate"));
        }
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

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

        System.out.println("开始时间"+starttime);
        System.out.println("结束时间"+endtime);
        if(empname==null){
            empname="";
        }
        if(Depid==null){
            Depid="";
        }
        String yuJu = "%";
        for(int i = 0; i < empname.length(); i++){
            char x = empname.charAt(i);
            yuJu += x+"%";
        }
        List examlist = examservice.examlist("\n" +
                "select l.*,m.Remark,m.Scores,m.aduitName,e.empName from  aduitlog  as l left join aduitmodel as m  on l.aduitModelid=m.aduitModelid left join emp as e on l.empid=e.empId where e.empName like '"+yuJu+"' and m.Depid like '%"+Depid+"%' and l.auditDate between '"+starttime+"' and '"+endtime+"'");
        JSONObject jsonObject=new JSONObject();
        int selectcount = examservice.Selectcount("select count(aduitLogid) from aduitlog");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }

    @RequestMapping(value = "/updateexam")
    public String updateexam(aduitModel aduitModel){
        examservice.updateexam(aduitModel);
        return "exammian/exam";
    }

    @RequestMapping(value = "/addexam")
    public String addexam(aduitModel aduitModel){
        examservice.addexam(aduitModel);
        return "exammian/exam";
    }

    @RequestMapping(value = "/emplistexam")
    @ResponseBody
    public JSONObject emplistexam(){
        List examlist = examservice.examlist("select e.empAssessId,c.className,ex.empexamname,em.empName,e.scores from empassessment as e left join classvo as c on c.classId=e.classid left join empexam as ex on ex.empexamid=e.empexamid left join emp as em on em.empId=e.empid");

        JSONObject jsonObject=new JSONObject();
        int selectcount = examservice.Selectcount("select count(empAssessId) from empassessment");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }

    @RequestMapping(value = "/addempexam")
    public String addempexam(String aduitName,String empname){
        aduitLog aduitLog=new aduitLog();
        List aduitModellist = examservice.examlist("select * from aduitmodel where aduitName='"+aduitName+"'");
        List empId = examservice.examlist("select empId from emp where empName='"+empname+"'");


        List aduitModel=new ArrayList();
        List empid=new ArrayList();


        for(int i=0;i<aduitModellist.size();i++){
            Map map= (Map) aduitModellist.get(i);
            aduitModel.add(map.get("aduitModelid"));
        }


        for(int i=0;i<empId.size();i++){
            Map map= (Map) empId.get(i);
            empid.add(map.get("empId"));
        }

        aduitLog.setAduitModelid(String.valueOf(aduitModel.get(0)));
        aduitLog.setEmpid((Integer) empid.get(0));
        aduitLog.setAuditDate(new java.sql.Date(new java.util.Date().getTime()));
        aduitLog.setAuditPerson("陈老板");
        examservice.addexam(aduitLog);
        return "redirect:lookexam";
    }


    @RequestMapping(value = "/deleteexam")
    @ResponseBody
    public String deleteexam(aduitModel aduitModel){
        examservice.deleteexam(aduitModel);
        return "删除成功";
    }

    @RequestMapping(value = "/deleteemp")
    @ResponseBody
    public String deleteemp(empAssessment empAssessment){
        examservice.deleteexam(empAssessment);
        return "删除成功";
    }

    @RequestMapping("/alldelete")
    @ResponseBody
    public String alldelete(String id){
        id = id.substring(0,id.length()-1);
        examservice.alldelete("delete from aduitmodel where aduitModelid in("+id+")");
        return "删除成功";
    }

    @RequestMapping("/alldeleteemp")
    @ResponseBody
    public String alldeleteemp(String id){
        id = id.substring(0,id.length()-1);
        examservice.alldelete("delete from empassessment where empAssessId in("+id+")");
        return "删除成功";
    }



    @RequestMapping(value = "/empdeleteexam")
    @ResponseBody
    public String empdeleteexam(aduitLog aduitLog){
        examservice.deleteexam(aduitLog);
        return "删除成功";
    }

    @RequestMapping("/empalldelete")
    @ResponseBody
    public String empalldelete(String id){
        id = id.substring(0,id.length()-1);
        examservice.alldelete("delete from aduitlog where aduitLogid in("+id+")");
        return "删除成功";
    }

    @RequestMapping(value = "/classlist")
    @ResponseBody
    public List examempname(String empname,HttpServletRequest request){
        List classlist = examservice.examlist1("select classRemark from classvo where classTeacher in (select empId from emp where empName='" + empname + "') or classAdviser in(select empId from emp where empName='" + empname + "')");

        return classlist;
    }

    @RequestMapping(value = "/addkaohu")
    @ResponseBody
    public void addkaohu(String empname, String classname, HttpSession session){
        Email email=new Email();
        List stuname = examservice.examlist("\n" +
                "select stuName from student where classId=(select classId from classvo where className='"+classname+"')");

        List stuname1=new ArrayList();

        for(int i=0;i<stuname.size();i++){
            Map map= (Map) stuname.get(i);
            stuname1.add(map.get("stuName"));
        }

        List emptype =examservice.examlist("select postName from post where  empId =(select empId from emp where empName='"+empname+"')");



        List emptype1=new ArrayList();

        for(int i=0;i<emptype.size();i++){
            Map map= (Map) emptype.get(i);
            emptype1.add(map.get("postName"));
        }

        email.setEmpId("刘飞");
        email.setContent("对"+empname+"老师进行考核,考核类型:"+emptype1.get(0));
        email.setTopic("考核");
        email.setSendtime(new java.util.Date());
        email.setIsRead(2);

        session.setAttribute("kaohuempname",empname);

        for(int i=0;i<stuname1.size();i++){
            email.setReceId(String.valueOf(stuname1.get(i)));
            examservice.addexam(email);

        }
    }
}
