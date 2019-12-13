package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.StuSer.StuSer;
import com.nothing.vo.Edu.*;
import com.nothing.vo.Sdudent.*;
import com.nothing.vo.emp.Dept;
import com.nothing.vo.sushe.studentFloor;
import com.nothing.vo.sushe.studentHour;
import com.nothing.vo.wintable.holidayStudent;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.jar.JarEntry;
//多表查询的条数问题//////
@Controller
@RequestMapping("/stu")
public class StudentControl{
    @Resource
    StuSer stuSer;

    @RequestMapping("{ac}")
    public String toStuMain(@PathVariable("ac")String ac ,HttpServletRequest request){
        if("home".equals(ac)){
            List classList = stuSer.listObj(new ClassVo());
            List floorList = stuSer.listObj(new studentFloor());
            List hoursList = stuSer.listO(new studentHour());
            request.setAttribute("classList",classList);
            request.setAttribute("foolList",floorList);
            request.setAttribute("hoursList",hoursList);
            return "student/stuMain";
        }else if("claMian".equals(ac)){
            List bzrList= stuSer.classTeacher("班主任");
            List  jsList= stuSer.classTeacher("授课教师");
            List dept  = stuSer.listO(new Dept());
            List term = stuSer.listO(new Term());
            List  fall  = stuSer.listO(new StuFall());
            List  classType = stuSer.listO(new ClassType());
            List  majorList = stuSer.listO(new EduMajor());
            request.setAttribute("bzrList",bzrList);
            request.setAttribute("jsList",jsList);
            request.setAttribute("dept",dept);
            request.setAttribute("term",term);
            request.setAttribute("fall",fall);
            request.setAttribute("classType",classType);
            request.setAttribute("majorList",majorList);
            return "student/stuClass";
        }
        return "";
    }

    @RequestMapping("{ac}/toList")
    @ResponseBody
    public JSONObject toList(@PathVariable("ac")String ac){
        List<Map> list = new ArrayList();
        int title  = 0;
        if("student".equals(ac)){
            list = stuSer.toStuList();
            title = stuSer.allTitle(new Student());
        }else if("cla".equals(ac)){
            list = stuSer.classList();
            title = stuSer.allTitle(new ClassVo());
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        System.out.println("学生"+jsonObject.toJSONString());
        return jsonObject;
    }

    @RequestMapping("con")
    @ResponseBody
    public JSONObject toConStuList(String stuSelectName,String  stuSelectPhone,String stuSelectCla,String stuSelectFloor){
        System.out.println("ajshwkjdhwekjhwkjhkjwehdjkwehdkjwed"+stuSelectName+ stuSelectPhone +stuSelectCla +stuSelectFloor);
        if(stuSelectCla==null||"".equals(stuSelectCla)){
            stuSelectCla ="";
        }
        if(stuSelectFloor==null||"".equals(stuSelectFloor)){
            stuSelectFloor="";
        }
        List<Map> list = stuSer.toStuConList(stuSelectName,stuSelectPhone,stuSelectCla,stuSelectFloor);
        int title = stuSer.conStu( stuSelectName ,stuSelectPhone, stuSelectCla, stuSelectFloor);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        return jsonObject;
    }

    @RequestMapping("classCon")
    @ResponseBody
    public JSONObject toClaCon(String claSelectName , String claSelectAdviser, String claSelectTeacher, String claSelectTerm , String claSelectType , String claSelectFall){
        System.out.println("zheehejjedhekjdhekjdhej+++++++++++"+claSelectName+claSelectAdviser+claSelectTeacher+claSelectTerm+claSelectType+claSelectFall);
        JSONObject jsonObject = new JSONObject();
        List list = stuSer.conClas(claSelectName, claSelectAdviser, claSelectTeacher ,claSelectTerm ,claSelectType, claSelectFall);
        int title = stuSer.countClaCon(claSelectName, claSelectAdviser, claSelectTeacher ,claSelectTerm ,claSelectType, claSelectFall);
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        return jsonObject;
    }

    @RequestMapping("toDel/{ac}")
    @ResponseBody
    public String toDel(String id,@PathVariable("ac")String ac){
        System.out.println("删除"+ac);
        id = id.substring(0,id.length()-1);
        if("main".equals(ac)){
            stuSer.deleteStu(id,new Student());
            stuSer.deleteStu(id,new StuEdu());
            stuSer.deleteStu(id,new StuFimaly());
        }else if("fal".equals(ac)){
            stuSer.delFal(id);
        }else if("edu".equals(ac)){
            stuSer.delEdu(id);
        }else if("hap".equals(ac)){
            stuSer.delHap(id);
        }else if("cla".equals(ac)){
            stuSer.delCla(id);
            stuSer.delClaStu(id);
        }
        return "成功";
    }
    @RequestMapping("toAdd")
    public String toAdd(HttpServletRequest request,String stuId){
        List classVoList = stuSer.listObj(new ClassVo());
        List foolList = stuSer.listObj(new studentFloor());
        List hoursList = stuSer.listO(new studentHour());
        request.setAttribute("foolList",foolList);
        request.setAttribute("classList",classVoList);
        request.setAttribute("hoursList",hoursList);
        System.out.println("zhlililili"+stuId);
        if(stuId.equals("0")){
            return "student/stuAdd";
        }
            Student s = (Student) stuSer.findO(new Student(),Integer.valueOf(stuId));
            ClassVo  className = (ClassVo) stuSer.findO(new ClassVo(),s.getClassId());
            studentFloor studentFloor = (studentFloor) stuSer.findO(new studentFloor(),s.getFloorId());
            request.setAttribute("stuCla",className);
            request.setAttribute("stuFl",studentFloor);
            request.setAttribute("stu",s);
            return "student/stuUpdate";
        }

    @RequestMapping("add")
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


    @RequestMapping("{ac}/select")
    @ResponseBody
    public JSONObject toStuAc(String  studId,@PathVariable("ac")String ac){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        List<Map> list = new ArrayList();
        int title = 0;
        if("stuFal".equals(ac)){
            list = stuSer.toStuAddition(new StuFimaly(),studId);
            title = stuSer.allTitle(new StuFimaly());
        }else if("stuEdu".equals(ac)){
            list = stuSer.toStuAddition(new StuEdu(),studId);
            title = stuSer.allTitle(new StuEdu());
        }else if("stuHap".equals(ac)){
            list = stuSer.stuHap(studId);
            title = stuSer.allTitle(new StuHappening());
        }else if("stuReply".equals(ac)){
            list = stuSer.stuRep(studId);
            title = stuSer.allTitle(new StuReplyScore());

        }
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        return jsonObject;
    }

    @RequestMapping("toStuFal")
    public String toStuFal(StuFimaly stuFimaly,String studId){
        System.out.println("家庭表fffid"+"-----"+stuFimaly.getStuFamilyid());
        stuFimaly.setStudId(Integer.valueOf(studId));
        if(stuFimaly.getStuFamilyid()!=0){
            stuSer.updateStu(stuFimaly);
        }else{
            stuSer.addStu(stuFimaly);
        }
        return "成功";
    }

    @RequestMapping("toStuEdu")
    public String toStuEdu(StuEdu stuEdu,String studId,String beginDH,String endDH,String hapEmpID) throws ParseException{
        stuEdu.setStudId(studId);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date bd = formatter.parse(beginDH);
        Date ed = formatter.parse(endDH);
        stuEdu.setBeginDate(bd);
        stuEdu.setEndDate(ed);
        System.out.println("这个好的好的获得活的"+stuEdu.getEduId());
        if(stuEdu.getEduId()!=0){
            stuSer.updateStu(stuEdu);
        }else{
            stuSer.addStu(stuEdu);
        }
        return "成功";
    }
    @RequestMapping("toStuHap")
    public String toStuHap(StuHappening stuHappening,String hapEmpID,String studId){
            stuHappening.setEmpId(hapEmpID);
            System.out.println("进啦啊~"+stuHappening.toString()+"studId"+studId);
        return "成功";
    }


    @RequestMapping("toStuClss")
    @ResponseBody
    public String toStuClss(ClassVo classVo){
        stuSer.addStu(classVo);
        return "成功";
    }


    @RequestMapping("toStuCla")
    @ResponseBody
    public String  toStuCla(ClassVo classVo){
        System.out.println("classId++++++++++++++++++++++++++"+classVo.getClassId());
        if(classVo.getClassId()==0){
            stuSer.addStu(classVo);

        }
        stuSer.updateStu(classVo);
        return "成功";
    }

}
