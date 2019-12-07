package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.StuSer.StuSer;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Sdudent.*;
import com.nothing.vo.sushe.studentFloor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.jar.JarEntry;

@Controller
@RequestMapping("/stu")
public class StudentControl{
    @Resource
    StuSer stuSer;

    @RequestMapping("/home")
    public String toStuMain(){
        return "student/stuMain";
    }

    @RequestMapping("/toList")
    @ResponseBody
    public JSONObject toList(){
        List<Map> list = stuSer.toStuList(new Student());
        int title = stuSer.allTitle(new Student());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        System.out.println("学生"+jsonObject.toJSONString());
        return jsonObject;
    }

    @RequestMapping("toDel")
    @ResponseBody
    public String toDel(String id){
        System.out.println("进来"+id);
        id = id.substring(0,id.length()-1);
        stuSer.deleteStu(id);
        return "成功";
    }
    @RequestMapping("/toAdd")
    public String toAdd(HttpServletRequest request,String stuId){
        List classVoList = stuSer.listObj(new ClassVo());
        List foolList = stuSer.listObj(new studentFloor());
        request.setAttribute("foolList",foolList);
        request.setAttribute("classList",classVoList);
        System.out.println("zhlililili"+stuId);
        if(stuId.equals("0")){
            return "student/stuAdd";
        }
            Student s = (Student) stuSer.findO(new Student(),Integer.valueOf(stuId));
            request.setAttribute("stu",s);
            return "student/stuUpdate";

    }

    @RequestMapping("/add")
    public String add(Student student,String enterDate,String birthday) throws ParseException{
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date enterD = formatter.parse(enterDate);
        Date birD = formatter.parse(birthday);
        student.setStuBirthday(birD);
        student.setStuEnterTime(enterD);
        if(student.getStudId()!=0||student.getStudId()!=null){
            stuSer.updateStu(student);
            return "成功";
        }
        stuSer.addStu(student);
        return "成功";
    }


    @RequestMapping("stuFal")
    @ResponseBody
    public JSONObject toStuFal(int studId){
        JSONObject jsonObject = new JSONObject();
        List<Map> list = stuSer.toStuAddition(new StuFimaly(),studId);
        int title = stuSer.allTitle(new StuFimaly());
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        System.out.println("学生家庭"+jsonObject.toJSONString());
        return jsonObject;
    }



    @RequestMapping("stuEdu")
    @ResponseBody
    public JSONObject toStuEdu(int studId){
        JSONObject jsonObject = new JSONObject();
        List<Map> list = stuSer.toStuAddition(new StuEdu(),studId);
        int title = stuSer.allTitle(new StuEdu());
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        System.out.println("学生教育"+jsonObject.toJSONString());
        return jsonObject;
    }


    @RequestMapping("stuHap")
    @ResponseBody
    public JSONObject toStuHap(int studId){
        JSONObject jsonObject = new JSONObject();
        List<Map> list = stuSer.toStuAddition(new StuHappening(),studId);
        int title = stuSer.allTitle(new StuHappening());
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        System.out.println("学生事件"+jsonObject.toJSONString());
        return jsonObject;
    }


    @RequestMapping("stuReply")
    @ResponseBody
    public JSONObject toStuReply(int studId){
        JSONObject jsonObject = new JSONObject();
        List<Map> list = stuSer.toStuAddition(new StuReplyScore(),studId);
        int title = stuSer.allTitle(new StuReplyScore());
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        System.out.println("学生答辩"+jsonObject.toJSONString());
        return jsonObject;
    }
}
