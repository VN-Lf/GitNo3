package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.Examservice;
import com.nothing.service.impl.Examserviceimpl;
import com.nothing.vo.wintable.aduitLog;
import com.nothing.vo.wintable.aduitModel;
import com.nothing.vo.wintable.empAssessment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping(value = "lookexam")
    public String lookexam(){
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
        int selectcount = examservice.selectcount("select count(aduitModelid) from aduitModel");
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
        if(empname==null){
            empname="";
        }
        if(Depid==null){
            Depid="";
        }
        List examlist = examservice.examlist("\n" +
                "select l.*,m.Remark,m.Scores,m.aduitName,e.empName from  aduitlog  as l left join aduitmodel as m  on l.aduitModelid=m.aduitModelid left join emp as e on l.empid=e.empId where e.empName like '%"+empname+"%' and m.Depid like '%"+Depid+"%' and l.auditDate between '"+starttime+"' and '"+endtime+"'");
        JSONObject jsonObject=new JSONObject();
        int selectcount = examservice.selectcount("select count(aduitLogid) from aduitlog");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }

    @RequestMapping(value = "/updateexam")
    public String updateexam(aduitModel aduitModel){
        examservice.updateexam(aduitModel);
        return "exammian/exam";
    }


    @RequestMapping(value = "/emplistexam")
    @ResponseBody
    public JSONObject emplistexam(){
        List examlist = examservice.examlist("select e.empAssessId,c.classRemark,ex.empexamname,em.empName,e.scores from empassessment as e left join classvo as c on c.classId=e.classid left join empexam as ex on ex.empexamid=e.empexamid left join emp as em on em.empId=e.empid");

        JSONObject jsonObject=new JSONObject();
        int selectcount = examservice.selectcount("select count(empAssessId) from empassessment");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
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


}
