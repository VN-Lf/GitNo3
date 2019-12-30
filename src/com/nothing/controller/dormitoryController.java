package com.nothing.controller;


import com.alibaba.fastjson.JSONObject;
import com.nothing.service.DormitoryService;
import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.sushe.studentHour;
import org.activiti.engine.repository.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("dormitory")
//宿舍管理
public class dormitoryController {
    @Resource
    DormitoryService service;

    //去宿舍页面
    @RequestMapping("todormitory")
    public String todormitory(HttpServletRequest request) {
        List<Map> list = service.selectDormitorylists("select * from studentFloor");
        request.setAttribute("dlist",list);
        return "DormitoryManagement/Dormitiry";
    }
    //去宿舍页面
    @RequestMapping("toDomSelStu/{ac}")
    public String toDomSelStu(HttpServletRequest request,@PathVariable("ac")String ac) {
        if("".equals(ac)){
        }
        int name = Integer.parseInt(ac);
        System.out.println("宿舍Id为"+name);
        request.setAttribute("deptname",name);
        //查询出所有的班级
        List list = service.selectDormitorylists("select * from classvo ");
        request.setAttribute("Edeptlist",list);
        return "DormitoryManagement/DomitirySelStu";
    }

    //查询要发送的人
    @ResponseBody
    @RequestMapping("domselsen")
    public JSONObject selsendEmail(String deptname){
        System.out.println(deptname);
        List list = service.selectDormitorylists("select * from student where classId in( '"+deptname+"')");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", list);
        return jsonObject;
    }
    //查看方法
    @ResponseBody
    @RequestMapping("list")
    public JSONObject list() {
        List list = service.selectDormitorylists("select * from studentHour ");
        int count = service.SelcctDormitorycount("select count(*) from studentHour");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }

    //查看宿舍学生方法
    @ResponseBody
    @RequestMapping("stulist/{deptname}")
    public JSONObject stulist(@PathVariable("deptname") String deptname) {
        System.out.println("查看Id为"+deptname);
        /*List list = service.selectDormitorylists("select  s.* ,sh.hourName as HourName from student s left join studenthour  sh using(stuHours) where sh.stuHours like '"+deptname+"'");*/
        List list = service.selectDormitorylists("select  s.* ,sh.hourName as HourName,cl.className as className from student s left join studenthour  sh using(stuHours) left join classvo cl using(classId) where sh.stuHours like '"+deptname+"'");
        int count = service.SelcctDormitorycount("select count(*) from studentHour");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }
    //宿舍添加
    @RequestMapping("dormadd")
    public String dormadd(studentHour studentHour ,HttpServletRequest request) {
        System.out.println("进来了新增"+studentHour.getNumberBeds());
        System.out.println(studentHour.getCount());
        List<Map> list = service.selectDormitorylists("select floorId from studentfloor where floorName like '"+studentHour.getAddr()+"'");
        int id = (int) list.get(0).get("floorId");
        studentHour.setFloorId(id);

        String addr = studentHour.getAddr();
        String hname = addr+studentHour.getHourName();
        System.out.println("宿舍"+hname);

        studentHour.setHourName(hname);
        System.out.println(studentHour.getFloorId());
        System.out.println(studentHour.getStuHours());
        System.out.println(studentHour.getHourIddsc());
        String ADDR = studentHour.getAddr();
        String hname = ADDR + studentHour.getHourName();
        studentHour.setHourName(hname);
        System.out.println(studentHour.getHourName());
        service.addDormitory(studentHour);
        return "redirect:todormitory";
    }

    //宿舍修改修改
    @RequestMapping("dormupdate")
    public String dormupdate(studentHour studentHour ,HttpServletRequest request) {
        System.out.println("fajfajflkaj"+studentHour.getNumberBeds());
        service.updateDormitory(studentHour);
        return "redirect:todormitory";
    }

    //学生信息修改
    @RequestMapping("dormStu/{ac}")
    public String dormStu(Student student , String receId, String receName ,HttpServletRequest request,@PathVariable("ac") String deptname) {
        System.out.println("学生Id为"+receId);
        System.out.println(receName);
        System.out.println("他的宿舍为："+deptname);
        String id = receId.substring(0,receId.length()-1);
        String param[] = id.split("[,]");
        for(int i=0;i<param.length;i++){
            int s = Integer.parseInt(param[i]);
            service.updateStudentwtf(String.valueOf(s),Integer.parseInt(deptname));
        }
       /* service.updateStudentwtf(id,Integer.parseInt(deptname));*/
       /* service.updateStudent(student);*/
        return "redirect:todormitory";
    }
    //删除的方法
    @RequestMapping("dormitorydelete")
    public String dormitorydelete(String id ){
        System.out.println("进来了删除：id"+id);
        id = id.substring(0,id.length()-1);
        service.delDormitory(id);
        return "redirect:todormitory";
    }


}
