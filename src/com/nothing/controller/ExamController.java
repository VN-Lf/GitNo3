package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.Examservice;
import com.nothing.service.impl.Examserviceimpl;
import com.nothing.vo.Email.Email;
import com.nothing.vo.emp.Emp;
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
        List aduitName = examservice.examlist("select aduitName from aduitModel");
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
        List examlist = examservice.examlist("select empName,empId from emp where empId in(select DISTINCT classTeacher from classVo)");
        System.out.println(examlist);
        request.setAttribute("empnamelist",examlist);
        return "exammian/empexam";
    }

    @RequestMapping(value = "/examlist")
    @ResponseBody
    public JSONObject examlist(){
        List examlist = examservice.examlist("select m.*,d.deptName from  aduitModel as m left join dept as d  on m.Depid=d.deptId");

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
        List examdate = examservice.examdate("select auditDate from aduitLog ORDER BY auditDate");
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
                "select l.*,m.Remark,m.Scores,m.aduitName,e.empName from  aduitLog  as l left join aduitModel as m  on " +
                "l.aduitModelid=m.aduitModelid left join emp as e on l.empid=e.empId where e.empName like '"+yuJu+"' and m.Depid like '%"+Depid+"%' and l.auditDate between '"+starttime+"' and '"+endtime+"'");
        JSONObject jsonObject=new JSONObject();
        int selectcount = examservice.Selectcount("select count(aduitLogid) from aduitLog");
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
        List examlist = examservice.examlist("select * from empAssessment");

        JSONObject jsonObject=new JSONObject();
        int selectcount = examservice.Selectcount("select count(empAssessId) from empAssessment");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }

    @RequestMapping(value = "/addempexam")
    public String addempexam(String aduitName,String empname,HttpSession session){
        aduitLog aduitLog=new aduitLog();
        List aduitModellist = examservice.examlist("select * from aduitModel where aduitName='"+aduitName+"'");
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
        Emp emp = (Emp) session.getAttribute("empId");
        aduitLog.setAuditPerson(emp.getEmpName());
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
        examservice.alldelete("delete from aduitModel where aduitModelid in("+id+")");
        return "删除成功";
    }

    @RequestMapping("/alldeleteemp")
    @ResponseBody
    public String alldeleteemp(String id){
        id = id.substring(0,id.length()-1);
        examservice.alldelete("delete from empAssessment where empAssessId in("+id+")");
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
        examservice.alldelete("delete from aduitLog where aduitLogid in("+id+")");
        return "删除成功";
    }

    @RequestMapping(value = "/classlist")
    @ResponseBody
    public List examempname(String empname){
        List classlist = examservice.examlist1("select className from classVo where classTeacher = "+empname);

        return classlist;
    }

    @RequestMapping(value = "/addkaohu")
    public String addkaohu(String empName,String empId,String classname, HttpSession session,String date,String time){
        //添加一条考评
        String endtime = date+" "+time+":00";
        System.out.println(empName+"-------"+empId);
        List  existexam = examservice.examlist("select * from empAssessment where classId='"+classname+"' and empId='"+empId+"' and scores=0");
        if(existexam.size()==0){
            List examtype = examservice.examlist("select postName from post where empId="+empId);
            List examtype1=new ArrayList();
            for(int i=0;i<examtype.size();i++){
                Map map= (Map) examtype.get(i);
                examtype1.add(map.get("postName"));
            }

            empAssessment empAssessment=new empAssessment();
            empAssessment.setEmpName(empName);
            empAssessment.setEmpid(empId);
            empAssessment.setEndtime(endtime);
            empAssessment.setClassid(classname);
            empAssessment.setEmpexamid(String.valueOf(examtype1.get(0)));
            empAssessment.setScores(0);
            examservice.addexam(empAssessment);
            //给选中的班级发送邮寄
            Email email=new Email();
            List stuname = examservice.examlist("select studId,stuName from student where classId=(select classId from " +
                    "classVo where className='"+classname+"')");

            List empkaohuid = examservice.examlist("select empAssessId from empAssessment where classid='"+classname+"' and empId='"+empId+"'");
            List empkaohuid1=new ArrayList();
            for(int i=0;i<empkaohuid.size();i++){
                Map map= (Map) empkaohuid.get(i);
                empkaohuid1.add(map.get("empAssessId"));
            }

            List<Map> emptype =examservice.examlist("select postName from post where  empId ="+empId);
            String str = ""+emptype.get(0).get("postName");
            boolean status = str.contains("师");
            if(status){
                str = "老师";
            }else {
                str = "班主任";
            }
            Emp emp =(Emp) session.getAttribute("empId");
            email.setEmpId(emp.getEmpId()+"");
            email.setEmpName(emp.getEmpName());
            email.setContent("对"+empName+"老师进行考核,考核类型:"+str);
            email.setTopic("考核");
            email.setImage(String.valueOf(empkaohuid1.get(0)));
            email.setSendtime(new java.util.Date());
            email.setEndTime(endtime);
            email.setIsRead(2);
            session.setAttribute("kaohuempname",empName);
            for(int i=0;i<stuname.size();i++){
                Map map= (Map) stuname.get(i);
                email.setReceId(""+map.get("studId"));
                email.setReceName(""+map.get("stuName"));
                examservice.addexam(email);
            }
        }else {

        }
        return "redirect:empexam";
    }

    //结束考核，统计分数
    @RequestMapping("/endexam")
    @ResponseBody
    public String endexam(String empAssessId){
        List kaohuscore1 = examservice.examlist1("select sum(kaohuscore)/(count(studentname)/5) as kaohuscore from " +
                "emkaohu where empAssessId="+empAssessId+"");
        examservice.updateend("update empAssessment set scores ="+kaohuscore1.get(0)+" where empAssessId ="+empAssessId+"");
        return "考核结束";
    }
}
