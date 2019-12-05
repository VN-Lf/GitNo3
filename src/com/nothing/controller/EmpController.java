package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.EmpEducation;
import com.nothing.vo.emp.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("emp")
public class EmpController {
    @Resource
    private EmpService empService;

    @RequestMapping(value = "/emplist")
    @ResponseBody
    public JSONObject EmpList(){
        List examlist = empService.selEmpAll();
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",examlist);
        jsonObject.put("count",11);

        return jsonObject;
    }

    @RequestMapping(value = "/empadd")
    public void EmpList(Emp emp,EmpEducation empEducation,Post post,String ruzhitime,String birthday) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        emp.setEmpBirthday(simpleDateFormat.parse(birthday));
        emp.setEmpFireday(simpleDateFormat.parse(ruzhitime));

        System.out.println("员工："+emp);
        System.out.println(ruzhitime+"学历："+empEducation);
        System.out.println(birthday+"职务："+post.getPostName());

        empService.addEmp(emp,empEducation,post);
    }


    @RequestMapping("toDel")
    @ResponseBody
    public String toDel(String id){
        System.out.println("进来"+id);
        id = id.substring(0,id.length()-1);
        empService.delete(id);
        return "成功";
    }
}
