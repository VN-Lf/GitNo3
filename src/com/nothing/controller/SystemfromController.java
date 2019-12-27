package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.SystemfromService;
import com.nothing.service.impl.SystemfromServiceimpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping("/System")
public class SystemfromController {
    @Resource
    SystemfromService serviceimpl;

    @RequestMapping(value = "/toSystem")
    public String toSystem(){
        return "Systemfrom/Systemmain";
    }

    @RequestMapping(value = "/tokaohe")
    public String tokaohe(){
        return "Systemfrom/kaohe";
    }


    @RequestMapping(value = "/kaohelist")
    public void kaohelist(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();
        List<Object> namelist = serviceimpl.kaohelist("select e.empName as name ,sum(m.Scores) as value from emp as e left join aduitlog as l on e.empId=l.empid  left join aduitmodel as m on l.aduitModelid=m.aduitModelid GROUP BY e.empName");

        List name=new ArrayList();
        List value=new ArrayList();

        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            name.add(map.get("name"));
        }
        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            if(map.get("value")==null){
                value.add(0);
            }else {
                value.add(map.get("value"));
            }
        }

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name",name);
        jsonObject.put("value",value);
        writer.print(jsonObject.toJSONString());
    }

    @RequestMapping(value = "/kaohedata")
    public String kaohedata(HttpServletResponse response,HttpServletRequest request) throws IOException {
        List deptname = serviceimpl.kaohelist("select * from dept");

        request.setAttribute("dept",deptname);
        return "Systemfrom/kaohedata";
    }

    @RequestMapping(value = "/kaohedatalist")
    @ResponseBody
    public JSONObject kaohedatalist(String empname,String Depid){
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

        List examlist = serviceimpl.kaohelist("select e.empId,e.empName as  name,p.postName,e.empSex,e.empPhone,sum(m.Scores)" +
                " as value  from emp as e left join post as p on e.empId=p.empId left join aduitlog as l on e.empId=l.empid " +
                " left join aduitmodel as m on l.aduitModelid=m.aduitModelid  where e.empDeptId like '%"+Depid+"%' " +
                "and e.empName like '"+yuJu+"' GROUP BY e.empName");

        JSONObject jsonObject=new JSONObject();
        int selectcount = serviceimpl.Selectcount("select count(empId) from emp");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);
        return jsonObject;
    }

    @RequestMapping(value = "/kaodata")
    public String kaodata(HttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        request.setAttribute("id",id);
        return "Systemfrom/kaodata";
    }


    @RequestMapping(value = "/kaodatalist")
    @ResponseBody
    public JSONObject kaodatalist(String id){
        List examlist = serviceimpl.kaohelist("select m.aduitName,e.empName,m.Scores,l.auditDate,l.auditPerson,m.Remark from aduitlog as l left join aduitmodel as m on l.aduitModelid=m.aduitModelid left join emp as e on e.empId=l.empid  where l.empId="+id+"");

        JSONObject jsonObject=new JSONObject();
        int selectcount = serviceimpl.Selectcount("select count(l.empid) from aduitlog as l left join aduitmodel as m on l.aduitModelid=m.aduitModelid left join emp as e on e.empId=l.empid  where l.empId="+id+"");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);
        return jsonObject;
    }



    @RequestMapping(value = "/toleave")
    public String toleave(){
        return "Systemfrom/leave";
    }


    @RequestMapping(value = "/leavedata")
    public String leavedata(HttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        request.setAttribute("month",month);
        return "Systemfrom/leavedata";
    }

    @RequestMapping(value = "/leavelist")
    public void leavelist(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();
        List<Object> namelist = serviceimpl.kaohelist("select e.empName,count(j.userId ) as count,sum(j.`day`) as day from jobs as j left join emp as  e on e.empId=j.userId where j.jobType='empact' GROUP BY e.empName\n");

        List name=new ArrayList();
        List count=new ArrayList();
        List day=new ArrayList();

        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            name.add(map.get("empName"));
        }
        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            count.add(map.get("count"));
        }

        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            day.add(map.get("day"));
        }

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name",name);
        jsonObject.put("count",count);
        jsonObject.put("day",day);
        writer.print(jsonObject.toJSONString());
    }


    @RequestMapping(value = "/leavedatalist")
    @ResponseBody
    public JSONObject leavedatalist(HttpServletResponse response,String empname ,String month) throws IOException {
        if(empname==null){
            empname="";
        }
        if(month==null){
            Calendar cal = Calendar.getInstance();
            month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        }
        String yuJu = "%";
        for(int i = 0; i < empname.length(); i++){
            char x = empname.charAt(i);
            yuJu += x+"%";
        }
        List<Object> namelist = serviceimpl.kaohelist("select j.jobId,e.empName,count(j.userId ) as count,sum(j.`day`) as day,sum(case when `day`=0 then TimeStampDiff(HOUR,j.goDate,j.endDate)  else 0 end) as time,j.userId from jobs as j left join emp as  e on e.empId=j.userId where MONTH(j.goDate) like '%"+month+"%' and e.empName like '"+yuJu+"' and j.jobType='empact' GROUP BY e.empName");

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",namelist);
        jsonObject.put("count",namelist.size());
        return jsonObject;
    }

    @RequestMapping(value = "/leadata")
    public String leadata(HttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        request.setAttribute("id",id);
        return "Systemfrom/leadata";
    }

    @RequestMapping(value = "/leadatalist")
    @ResponseBody
    public JSONObject leadatalist(String id){
        List examlist = serviceimpl.kaohelist("select e.empName,j.`day`,case when j.`day`=0 then TimeStampDiff(HOUR,j.goDate,j.endDate) else 0 end as time,j.goDate as starttime,j.endDate as endtime,j.remark,j.processFlag from jobs as j left join emp as  e on e.empId=j.userId where userId="+id+" and j.jobType='empact'");

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",examlist.size());
        return jsonObject;
    }


    @RequestMapping(value = "/toclock")
    public String toclock(){
        return "Systemfrom/clock";
    }


    @RequestMapping(value = "/clocklist")
    public void clocklist(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();
        List<Object> namelist = serviceimpl.kaohelist("select e.empName,count(d.empId) as count from attendance as d left join emp as e on e.empId=d.empId GROUP BY e.empName\n");

        List name=new ArrayList();
        List count=new ArrayList();

        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            name.add(map.get("empName"));
        }
        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            count.add(map.get("count"));
        }


        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name",name);
        jsonObject.put("count",count);
        writer.print(jsonObject.toJSONString());
    }


    @RequestMapping(value = "/clockdata")
    public String clockdata(HttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        request.setAttribute("month",month);
        return "Systemfrom/clockdata";
    }

    @RequestMapping(value = "/clockdatalist")
    @ResponseBody
    public JSONObject clockdatalist(HttpServletResponse response,String empname ,String month) throws IOException {
        if(empname==null){
            empname="";
        }
        if(month==null){
            Calendar cal = Calendar.getInstance();
            month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        }
        String yuJu = "%";
        for(int i = 0; i < empname.length(); i++){
            char x = empname.charAt(i);
            yuJu += x+"%";
        }
        List<Object> namelist = serviceimpl.kaohelist("select d.attId,e.empName,d.punckClockTime,d.cause,(select empName from emp where empId=d.auditor) as auditor ,count(d.empId) as count,d.examineExplain,d.examineTime,d.status  from attendance as d left join emp as e on e.empId=d.empId where MONTH(d.punckClockTime) like '%"+month+"%' and e.empName like '"+yuJu+"' GROUP BY d.attId");

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",namelist);
        jsonObject.put("count",namelist.size());
        return jsonObject;
    }

    @RequestMapping(value = "/tostuleave")
    public String tostuleave(){
        return "Systemfrom/stuleave";
    }


    @RequestMapping(value = "/stuleavelist")
    public void stuleavelist(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();
        List<Object> namelist = serviceimpl.kaohelist("select j.jobId,s.stuName,count(s.studId) as count,sum(j.`day`) as day from jobs as j left join student as  s on s.studId=j.userId where j.jobType='stuLeave'  GROUP BY  s.stuName");

        List name=new ArrayList();
        List count=new ArrayList();
        List day=new ArrayList();

        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            name.add(map.get("stuName"));
        }
        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            count.add(map.get("count"));
        }
        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            day.add(map.get("day"));
        }


        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name",name);
        jsonObject.put("count",count);
        jsonObject.put("day",day);
        writer.print(jsonObject.toJSONString());
    }


    @RequestMapping(value = "/stuleavedata")
    public String stuleavedata(HttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        request.setAttribute("month",month);
        return "Systemfrom/stuleavedata";
    }


    @RequestMapping(value = "/stuleavedatalist")
    @ResponseBody
    public JSONObject stuleavedatalist(HttpServletResponse response,String empname ,String month) throws IOException {
        if(empname==null){
            empname="";
        }
        if(month==null){
            Calendar cal = Calendar.getInstance();
            month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        }
        String yuJu = "%";
        for(int i = 0; i < empname.length(); i++){
            char x = empname.charAt(i);
            yuJu += x+"%";
        }
        List<Object> namelist = serviceimpl.kaohelist("select j.jobId,s.studId,s.stuName,count(j.userId ) as count,sum(j.`day`) as day from jobs as j left join student as  s on s.studId=j.userId where MONTH(j.goDate) like '%"+month+"%' and s.stuName like '%"+yuJu+"%' and j.jobType='stuLeave' GROUP BY s.stuName");

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",namelist);
        jsonObject.put("count",namelist.size());
        return jsonObject;
    }

    @RequestMapping(value = "/stuleadata")
    public String stuleadata(HttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        request.setAttribute("id",id);
        return "Systemfrom/stuleadata";
    }

    @RequestMapping(value = "/stuleadatalist")
    @ResponseBody
    public JSONObject stuleadatalist(String id){
        List examlist = serviceimpl.kaohelist("select s.stuName,j.`day`,j.goDate,j.endDate,j.remark,j.processFlag from jobs as j left join student as  s on s.studId=j.userId where s.studId="+id+" and j.jobType='stuLeave'");

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",examlist.size());
        return jsonObject;
    }


    @RequestMapping(value = "/todorm")
    public String todorm(){
        return "Systemfrom/dorm";
    }

    @RequestMapping(value = "/dormlist")
    public void dormlist(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();
        List<Object> namelist = serviceimpl.kaohelist("select addr,sum(count) as count from studenthour GROUP BY addr");

        List name=new ArrayList();
        List count=new ArrayList();

        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            name.add(map.get("addr"));
        }
        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            count.add(map.get("count"));
        }


        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name",name);
        jsonObject.put("count",count);
        writer.print(jsonObject.toJSONString());
    }


    @RequestMapping(value = "/dormdata")
    public String dormdata(HttpServletRequest request, HttpServletResponse response, String id) throws IOException {
        List<Object> namelist = serviceimpl.kaohelist("select DISTINCT addr from studenthour");

        List<Object> hourlist = serviceimpl.kaohelist("select hourName from studenthour");

        List name=new ArrayList();
        List hourname=new ArrayList();

        for(int i=0;i<namelist.size();i++){
            Map map=(HashMap)namelist.get(i);
            name.add(map.get("addr"));
        }
        for(int i=0;i<hourlist.size();i++){
            Map map=(HashMap)hourlist.get(i);
            hourname.add(map.get("hourName"));
        }
        request.setAttribute("addr",name);
        request.setAttribute("hourName",hourname);
        return "Systemfrom/dormdata";
    }

    @RequestMapping(value = "/dormdatalist")
    @ResponseBody
    public JSONObject dormdatalist(HttpServletResponse response,String addr ,String hourname) throws IOException {
        if(addr==null){
            addr="";
        }
        if(hourname==null){
            hourname="";
        }
        List<Object> namelist = serviceimpl.kaohelist("select *,(numberBeds-count) as kong from studenthour where addr like '%"+addr+"%' and hourName like '%"+hourname+"%'");

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",namelist);
        jsonObject.put("count",namelist.size());
        return jsonObject;
    }

}
