package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.AttendanceService;
import com.nothing.vo.checking.AttendanceVo;
import com.nothing.vo.emp.Emp;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("attedance")
public class AttedanceContriller {

    @Resource
    AttendanceService service;

    @RequestMapping("toAttedance")
    public String toAttedance(){
        return "Attend/Attendance";
    }

    @RequestMapping("toSupAttedance")
    public String toSupAttedance(){
        return "Attend/SupAttendance";
    }

    @ResponseBody
    @RequestMapping("list")
    public JSONObject list(HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        int i = emp.getEmpId();
        List list = service.selectAttendanlist("select att.* ,e.empName as empname,(select empName from emp where empId = att.auditor ) as audName from attendance att left join emp e using(empId) where att.empid = "+i);
        int count = service.SelcctAttendancount("select count(*) from attendance");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }

    @ResponseBody
    @RequestMapping("lists")
    public JSONObject lists(HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        int i = emp.getEmpId();
        List<Map> list = service.selectAttendanlist("select att.* ,e.empName as empname,(select empName from emp where empId = att.auditor ) as audName from attendance att left join emp e using(empId) where att.auditor = "+i);
        int count = service.SelcctAttendancount("select count(*) from attendance");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }

    //添加考勤的方法
    @RequestMapping("AddAttedance")
    public String AddAttedance(HttpSession session,AttendanceVo attendanceVo,String punckClockTimes,String applyTimes) throws ParseException {
        Emp emp = (Emp) session.getAttribute("empId");
        int i = emp.getEmpId();
        attendanceVo.setEmpId(i);
        String name = emp.getEmpName();
        List<Map> namelist  = service.selectAttendanlist("select postName from post where empId = " + i);
        String postname = (String) namelist.get(0).get("postName");
        System.out.println("所在的部门为"+postname);
        String superiorname = "";
        if(postname.equals("部长")){
            superiorname = "校长";
            List<Map> maxid = service.selectAttendanlist("select empId from post where postName like '%校长%'");
            i = (int) maxid.get(0).get("empId");
            System.out.println("校长的id为"+i);
        }else{
            superiorname = "部长";
        }

        List<Map> emplistid = service.selectAttendanlist("select empId from post where postName like '%"+superiorname+" %'and deptId in(select deptId from post where empId = "+i+" )");
        /*int empid = (int) emplistid.get(0).get("empId");
        System.out.println("他上级的id为" + empid);*/
        if(emplistid.size() == 0 ){
            System.out.println("没有上级");
            superiorname = "校长";
            List<Map> maxid = service.selectAttendanlist("select empId from post where postName like '%校长%'");
            i = (int) maxid.get(0).get("empId");
            System.out.println("校长的id为"+i);
        }
        //获取到他的审核人
        List<Map>  list =  service.selectAttendanlist("select * from emp where empId  IN (\n" +
                "select empId from post where postName like '%"+superiorname+"%' and deptId in\n" +
                "\t(select deptId from post where empId ="+i+") \n" +
                ")");
        int shempid = (int) list.get(0).get("empId");
        System.out.println(shempid);
        attendanceVo.setAuditor(String.valueOf(shempid));
        //转换时间
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = formatter.parse(String.valueOf(punckClockTimes));
        attendanceVo.setPunckClockTime(date1);

        String apply = punckClockTimes + applyTimes;
        System.out.println("未打卡的时间"+apply);
        SimpleDateFormat formatters = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = formatters.parse(String.valueOf(apply));
        attendanceVo.setApplyTime(date);

        attendanceVo.setStatus(2);
        service.AddAttrndan(attendanceVo);
        return "redirect:toAttedance";
    }
    //提交审核同意
    @RequestMapping("updAttedance")
    public String updAttedance(String punckClockTimes, String applyTimes ,AttendanceVo attendanceVo ,String examineTimes,int yesno) throws ParseException {

        System.out.println("update "+punckClockTimes);
        System.out.println("update "+applyTimes);
        System.out.println("update "+examineTimes);
        System.out.println("update "+yesno);

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1 = formatter.parse(String.valueOf(punckClockTimes));
        attendanceVo.setPunckClockTime(date1);

        SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date11 = formatter1.parse(String.valueOf(applyTimes));
        attendanceVo.setApplyTime(date11);

        SimpleDateFormat formatter22 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date122 = formatter22.parse(String.valueOf(examineTimes));
        attendanceVo.setExamineTime(date122);
        attendanceVo.setStatus(1);

        if(yesno == 2){
            System.out.println("拒绝");
            attendanceVo.setStatus(3);
        }

        service.updateAttendance(attendanceVo);
        return "redirect:toAttedance";
    }
    //删除的方法
    @RequestMapping("Buildingdelete")
    public String Attedancedelete(String id ){
        System.out.println("进来了删除：id"+id);
        id = id.substring(0,id.length()-1);
        service.delBuilding(id);
        return "redirect:toAttedance";
    }



}
