package com.nothing.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.nothing.service.StuSer.EnrSer;
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

@Controller
@RequestMapping("/stu")
public class StudentControl{
    @Resource
    StuSer stuSer;
    @Resource
    EnrSer enrSer;

    @RequestMapping("{ac}")
    public String toStuMain(@PathVariable("ac")String ac ,HttpServletRequest request){
        List hoursList = stuSer.listObj(new studentHour());
        List classList = stuSer.listObj(new ClassVo());
        List floorList = stuSer.listObj(new studentFloor());
        List bzrList= stuSer.classTeacher("班主任");
        List  jsList= stuSer.classTeacher("授课教师");
        List deptList  = stuSer.listObj(new Dept());
        List termList = stuSer.listObj(new Term());//学期
        List  fallList  = stuSer.listObj(new StuFall());//学年
        List  classTypeList = stuSer.listObj(new ClassType());
        List  majorList = stuSer.listObj(new EduMajor());//专业
        if("home".equals(ac)){
            request.setAttribute("classList",classList);
            request.setAttribute("foolList",floorList);
            request.setAttribute("hoursList",hoursList);
            return "student/stuMain";
        }else if("claMian".equals(ac)){
            request.setAttribute("bzrList",bzrList);
            request.setAttribute("jsList",jsList);
            request.setAttribute("dept",deptList);
            request.setAttribute("term",termList);
            request.setAttribute("fall",fallList);
            request.setAttribute("classType",classTypeList);
            request.setAttribute("majorList",majorList);
            return "student/stuClass";
        }else if("allotStu".equals(ac)){
            request.setAttribute("classType",classTypeList);
            return "student/stuAllotClass";
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
        }else if("allotStu".equals(ac)){
            list = stuSer.allotStu();
            title =list.size();
        }else if("course".equals(ac)){
            list = stuSer.listObj(new Course());
            title = stuSer.allTitle(new Course());
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
        if(stuSelectPhone==null||"".equals(stuSelectPhone)){
            stuSelectPhone ="";
        }
        if(stuSelectName==null||"".equals(stuSelectName)){
            stuSelectName="";
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
        if(claSelectName==null||"".equals(claSelectName)){
            claSelectName ="";
        }
        if(claSelectAdviser==null||"".equals(claSelectAdviser)){
            claSelectAdviser="";
        }
        if(claSelectTeacher==null||"".equals(claSelectTeacher)){
            claSelectTeacher="";
        }
        if(claSelectTerm==null||"".equals(claSelectTerm)){
            claSelectTerm="";
        }
        if(claSelectType==null||"".equals(claSelectType)){
            claSelectType ="";
        }
        if(claSelectFall==null||"".equals(claSelectFall)){
            claSelectFall="";
        }
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
            stuSer.deleteStu(id,new StudentScore());
            stuSer.deleteStu(id,new StuReplyScore());
            stuSer.delJobByStuId(id);
        }else if("fal".equals(ac)){
            stuSer.delFal(id);
        }else if("edu".equals(ac)){
            stuSer.delEdu(id);
        }else if("cla".equals(ac)){
            stuSer.delCla(id);
            stuSer.delClaStu(id);
        }
        return "成功";
    }
    @RequestMapping("toAdd")
    public String toAdd(HttpServletRequest request,String stuId){
        List hoursList = stuSer.listObj(new studentHour());
        List classList = stuSer.listObj(new ClassVo());
        List floorList = stuSer.listObj(new studentFloor());
        request.setAttribute("foolList",floorList);
        request.setAttribute("classList",classList);
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

    @RequestMapping("update/{ac}")
    public String add(Student student,String enterDate,String birthday,@PathVariable("ac")String ac) throws ParseException{
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date enterD = formatter.parse(enterDate);
        Date birD = formatter.parse(birthday);
        student.setStuBirthday(birD);
        student.setStuEnterTime(enterD);
             if("add".equals(ac)){
                 try{
                     stuSer.addStu(student);
                 }catch (IndexOutOfBoundsException e){

                 }
             }else if("up".equals(ac)){
                 stuSer.updateStu(student);
             }

            return "redirect: /stu/home";
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
            title = stuSer.toStuAdditionCount(new StuFimaly(),studId);
        }else if("stuEdu".equals(ac)){
            list = stuSer.toStuAddition(new StuEdu(),studId);
            title = stuSer.toStuAdditionCount(new StuEdu(),studId);
        }else if("stuHol".equals(ac)){
            list = stuSer.stuHol(studId);
            title = stuSer.stuHolCount(studId);
        }else if("stuReply".equals(ac)){
            list = stuSer.stuRep(studId);
            title = stuSer.stuRepCount(studId);
        }else if("stuByClass".equals(ac)){
            //根据班级找到所有学生
            list = stuSer.stuByClaId(studId);
            title = stuSer.stuByClaIdCount(studId);
        }else if("stuScore".equals(ac)){
            list = stuSer.stuScore(studId);
            title = stuSer.stuScoreCount(studId);
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
            try{
                stuSer.addStu(stuFimaly);
            }catch (IndexOutOfBoundsException e){

            }
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
        if(stuEdu.getEduId()!=0){
            stuSer.updateStu(stuEdu);
        }else{
            try{
                stuSer.addStu(stuEdu);
            }catch (IndexOutOfBoundsException e){

            }

        }
        return "成功";
    }

    @RequestMapping("toStuCla")
    @ResponseBody
    public String  toStuCla(ClassVo classVo){
        if(classVo.getClassId()==0){
            try{
                stuSer.addStu(classVo);
            }catch (IndexOutOfBoundsException e){

            }

        }
        stuSer.updateStu(classVo);
        return "成功";
    }


    @RequestMapping("clatree")
    @ResponseBody
    public JSONArray toClaTree(){
        JSONArray jsonArray =  new JSONArray();
        List<Map> fallList2  = stuSer.ooo(new StuFall());
        for (Map f: fallList2){
            JSONObject fall = new JSONObject();
            fall.put("id",f.get("fallId"));
            fall.put("title",f.get("fallLevel"));
            System.out.println("sjsjsisjsjxisxs"+fall.toString());
            List<Map> classByFallList = stuSer.classByFall(f.get("fallId").toString());
            JSONArray classVoList = new JSONArray();
            for(Map c:classByFallList){
                JSONObject classObj = new JSONObject();
                classObj.put("id",c.get("classId"));
                classObj.put("title",c.get("className"));
                classVoList.add(classObj);
            }
            fall.put("children",classVoList);
            jsonArray.add(fall);
        }
        System.out.println(jsonArray.toJSONString());
        return jsonArray;
    }

    //给学生分配班级
    @RequestMapping("toClassAddStu")
    @ResponseBody
    public String toClassAddStu(String all,String cid){
        JSONArray jsonArray = JSONArray.parseArray(all);
        try {
            for(int i = 0;i<jsonArray.size();i++){
                try {
                    Student s = new Student();
                    Map o = (Map) jsonArray.get(i);
                    s.setStuName(o.get("stuName").toString());
                    s.setCardId(o.get("cardId").toString());
                    s.setStuStu((Integer) o.get("status"));
                    s.setStuPhone(o.get("stuPhone").toString());
                    s.setStuHisSchool(o.get("school").toString());
                    s.setStuSex(o.get("stuSex").toString());
                    s.setInterTecher(o.get("enterEmp").toString());
                    s.setScore((Integer)o.get("score"));
                    s.setIsComputer(o.get("computer").toString());
                    s.setClassId(Integer.parseInt(cid));
                    stuSer.addStu(s);
                    enrSer.updateStatus(o.get("enrollmentid").toString());
                }  catch (IndexOutOfBoundsException e){

                }
            }

        }catch (NullPointerException ee){

        }

        return "";
    }


    @RequestMapping("allotCon")
    @ResponseBody
    public JSONObject allotCon(String stuSelectName , String stuSelectPhone, String claSelectType){
        if("".equals(stuSelectName)||stuSelectName==null){
            stuSelectName="";
        }
        if("".equals(stuSelectPhone)||stuSelectPhone==null){
            stuSelectPhone="";
        }
        if("".equals(claSelectType)||claSelectType==null){
            claSelectType="";
        }
        List list = stuSer.allotCon(stuSelectName,stuSelectPhone,claSelectType);
        JSONObject jsonObject =  new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",list.size());
        return jsonObject;
    }

}
