package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.impl.Examserviceimpl;
import com.nothing.vo.wintable.aduitLog;
import com.nothing.vo.wintable.aduitModel;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

//考核控制器
@Controller
@RequestMapping("/exam")
public class ExamController {
    @Resource
    Examserviceimpl examserviceimpl;
    @RequestMapping(value = "toexam")
    public String toexam(){
        return "exammian/exam";
    }

    @RequestMapping(value = "lookexam")
    public String lookexam(){
        return "exammian/examemp";
    }

    @RequestMapping(value = "/examlist")
    @ResponseBody
    public JSONObject examlist(){
        List examlist = examserviceimpl.examlist("select * from aduitmodel");
        JSONObject jsonObject=new JSONObject();
        int selectcount = examserviceimpl.selectcount("select count(aduitModelid) from aduitModel");
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
        List examdate = examserviceimpl.examdate("select auditDate from aduitlog ORDER BY auditDate");
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
        System.out.println("最小时间"+Starttime);
        System.out.println("最大时间"+Endtime);

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
        System.out.println("开始时间"+starttime);
        System.out.println("结束时间"+endtime);
        List examlist = examserviceimpl.examlist("\n" +
                "select l.*,m.Remark,m.Scores,m.aduitName from  aduitlog  as l left join aduitmodel as m  on l.aduitModelid=m.aduitModelid where l.empid like '%"+empname+"%' and m.Depid like '%"+Depid+"%' and l.auditDate between '"+starttime+"' and '"+endtime+"'");
        JSONObject jsonObject=new JSONObject();
        int selectcount = examserviceimpl.selectcount("select count(aduitLogid) from aduitlog");
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",selectcount);

        return jsonObject;
    }

    @RequestMapping(value = "/updateexam")
    public String updateexam(aduitModel aduitModel){
        examserviceimpl.updateexam(aduitModel);
        return "exammian/exam";
    }

    @RequestMapping(value = "/deleteexam")
    @ResponseBody
    public String deleteexam(aduitModel aduitModel){
        examserviceimpl.deleteexam(aduitModel);
        return "删除成功";
    }

    @RequestMapping("/alldelete")
    @ResponseBody
    public String alldelete(String id){
        id = id.substring(0,id.length()-1);
        examserviceimpl.alldelete("delete from aduitmodel where aduitModelid in("+id+")");
        return "删除成功";
    }



    @RequestMapping(value = "/empdeleteexam")
    @ResponseBody
    public String empdeleteexam(aduitLog aduitLog){
        examserviceimpl.deleteexam(aduitLog);
        return "删除成功";
    }

    @RequestMapping("/empalldelete")
    @ResponseBody
    public String empalldelete(String id){
        id = id.substring(0,id.length()-1);
        examserviceimpl.alldelete("delete from aduitlog where aduitLogid in("+id+")");
        return "删除成功";
    }
}
