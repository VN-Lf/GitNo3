package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.TuitionService;
import com.nothing.vo.emp.Dept;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@RequestMapping("Tuition")
@Controller
public class TuitionController {

    @Resource
    TuitionService service;

    @RequestMapping("/toTuition")
    public String toTuition(){
        return "TuitionManagement/Tuition";
    }

    @ResponseBody
    @RequestMapping("list")
    public JSONObject list (){
        List list = service.selectTuition("select * from financeshouldtuitionrecord");
        int count = service.SelcctTuitioncount("select count(*) from studenthour");


        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);
        return json;
    }
    @RequestMapping("/deptlist")
    @ResponseBody
    public JSONObject DeptList() {
        List deptlist = service.selectTuition("select * from dept");
        int con = service.SelcctTuitioncount("select count(*) from dept");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", deptlist);
        jsonObject.put("count", con);
        return jsonObject;
    }
    //删除的方法
    @RequestMapping("/Tuitiondelete")
    public String Tuitiondelete(String id ){
        System.out.println("进来了删除：id"+id);
        id = id.substring(0,id.length()-1);
        service.deleteTuition(id);
        return "redirect:toTuition";
    }

    //部门管理
    @RequestMapping("/todept")
    public String toDeptG(){
        return "TuitionManagement/deptguan";
    }

    @RequestMapping("/deptdelete")
    @ResponseBody
    public JSONObject deptDelete(String id){
        System.out.println("进来了删除：id"+id);
        JSONObject jsonObject = new JSONObject();
        List deptlist = service.selectTuition("select empId,empName from emp where empDeptId ="+id);
        String empname = "";
        if(deptlist.size() != 0){
            for(int i = 0;i < deptlist.size(); i++){
                Map map = (Map)deptlist.get(i);
                empname = empname+map.get("empName")+",";
            }

            jsonObject.put("msg", "you");
            jsonObject.put("data", empname);
        }else {
            jsonObject.put("msg", "kon");
            service.deleteDept(id);
        }
        return jsonObject;
    }
    @RequestMapping("/deptadd")
    public String DeptAdd(Dept dept){
        service.addDept(dept);
        return "TuitionManagement/deptguan";
    }
    @RequestMapping("/deldeptall")
    public String DeptDeleteAll(String id ){
        System.out.println("iss:"+id);
        id = id.substring(0,id.length()-1);
        service.deleteDeptAll(id);
        return "TuitionManagement/deptguan";
    }
    //前往部门修改页
    @RequestMapping("/deptxiu")
    public String toDeptXiu(String id,HttpServletRequest req){
        Dept dept = service.sqlDeptById(id);
        req.setAttribute("dept",dept);
        return "TuitionManagement/deptxiu";
    }

    @RequestMapping("/deptup")
    public String DeptUpdate(Dept dept){
        service.updateDept(dept);
        return "修改成功";
    }
}
