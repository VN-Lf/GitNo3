package com.nothing.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.nothing.service.StuSer.StuScoSer;
import com.nothing.service.StuSer.StuSer;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Edu.Course;
import com.nothing.vo.Edu.Term;
import com.nothing.vo.Sdudent.StuReplyScore;
import com.nothing.vo.Sdudent.StudentProject;
import com.nothing.vo.Sdudent.StudentScore;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.Project;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sco")
public class ScoreController{
    @Resource
    StuSer stuSer;
    @Resource
    StuScoSer stuScoSer;
    @RequestMapping("{ac}")
    public String toMain(HttpServletRequest request,@PathVariable("ac")String ac){
            List classList = stuSer.listObj(new ClassVo());
            request.setAttribute("classList",classList);
            if("main".equals(ac)){
                List termList = stuSer.listObj(new Term());//学期
                List courseList = stuSer.listObj(new Course());
                request.setAttribute("termList",termList);
                request.setAttribute("courseList",courseList);
                return "student/score";
            }else if("reply".equals(ac)){
                List projectList = stuSer.listObj(new Project());
                System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaa"+projectList.size());
                request.setAttribute("projectList",projectList);
                return "student/replyScore";
            }
            return "";
    }


    @RequestMapping("{ac}/toList")
    @ResponseBody
    public JSONObject toList(@PathVariable("ac")String ac){
        JSONObject jsonObject = new JSONObject();
        List list = new ArrayList();
        int title = 0;
        if("main".equals(ac)){
            list = stuScoSer.toAll();
            title = stuScoSer.toTitle(new StudentScore());
        }else if("reply".equals(ac)){
            list = stuScoSer.replyScore();
            title = stuScoSer.toTitle(new StuReplyScore());
        }
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping("toScoreMa")
    public String   toScore(StudentScore studentScore, int classId){
        int tId = studentScore.getTermId();
        int cId = studentScore.getCourseId();
        int typeId = studentScore.getTestType();
        List list = stuScoSer.isExistsTest(tId,cId,typeId,classId);
        if (list.size()>0){
            return "no";
        }
        return "yes";
    }

    @RequestMapping("toClassScoByCid")
    public String toClassScoByCid( String testDH, String classId,StudentScore studentScore,HttpServletRequest request) throws ParseException{
        System.out.println("aaaaaaaaaaa"+studentScore.toString());
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date testD = formatter.parse(testDH);
        studentScore.setScoreTime(testD);
        ClassVo classVo = (ClassVo) stuSer.findO(new ClassVo(), Integer.parseInt(classId));
        Term term = (Term)stuSer.findO(new Term(),studentScore.getTermId());
        Course course =(Course) stuSer.findO(new Course(),studentScore.getCourseId());

        request.setAttribute("time",testDH);
        request.setAttribute("cla",classVo);
        request.setAttribute("term",term);
        request.setAttribute("courseList",course);
        request.setAttribute("studentScore",studentScore);
        return "student/classScore";
    }

    @RequestMapping("toClassRepScoByCid")
    public String toClassRepScoByCid(String classId,String projectId,HttpServletRequest request){
        ClassVo classVo = (ClassVo) stuSer.findO(new ClassVo(), Integer.parseInt(classId));
        Project project = (Project)stuSer.findO(new Project(), Integer.parseInt(projectId));
        request.setAttribute("cla",classVo);
        request.setAttribute("pro",project);
        return "student/classReplyScore";
    }

    @ResponseBody
    @RequestMapping("toReplyMa")
    public String toReply(String classId,String projectId){
       List list = stuScoSer.isExistsTestReply(classId,projectId);
        if (list.size()>0){
            return "no";
        }
        return "yes";
    }


    //根据classID查出所有此班的学生输入成绩
    @RequestMapping("{ac}/classSco")
    @ResponseBody
    public JSONObject toClassSco(String classId,@PathVariable("ac")String ac){
        List list = new ArrayList();
        int title = 0;
        JSONObject jsonObject = new JSONObject();
        if("score".equals(ac)){
            list = stuScoSer.stuByClassId(classId);
            title = stuScoSer.countStuByClassId(classId);
            jsonObject.put("code",0);
            jsonObject.put("msg","");
            jsonObject.put("data",list);
            jsonObject.put("count",title);
        }else if("reply".equals(ac)){
            list = stuScoSer.stuReplyByClassId(classId);
            title = stuScoSer.stuReplyByClassIdCount(classId);
            jsonObject.put("code",0);
            jsonObject.put("msg","");
            jsonObject.put("data",list);
            jsonObject.put("count",title);
        }
        return jsonObject;
    }

    @RequestMapping("toAddScore")
    @ResponseBody
    public String toAddScore(String tableList, StudentScore studentScore, String testDH, HttpSession session) throws ParseException{
        Emp e = (Emp)session.getAttribute("empId");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date testD = formatter.parse(testDH);
        studentScore.setScoreTime(testD);
        JSONArray jsonArray = JSONArray.parseArray(tableList);
        System.out.println(jsonArray);
        for(int i = 0;i<jsonArray.size();i++){
            StudentScore s = new StudentScore();
            Map o = (Map)jsonArray.get(i);
            System.out.println("成绩成绩成绩"+o.get("chengji"));
            s.setScore(Integer.parseInt(o.get("chengji").toString()));
            s.setStudId(Integer.parseInt(o.get("studId").toString()));
            if(null==o.get("chengji2")){
                s.setBukao(0);
            }else{
                s.setBukao(Integer.parseInt(o.get("chengji2").toString()));
            }
            s.setCourseId(studentScore.getCourseId());
            s.setTermId( studentScore.getTermId());
            s.setTestType(studentScore.getTestType());
            s.setScoreTime(testD);
            s.setEmpId(e.getEmpId());
            System.out.println("循环内的考试对象"+s.toString());
            stuSer.addStu(s);
        }
        return "yes";
    }

    @RequestMapping("toAddReplyScore")
    public String toAddReplyScore(String tableList,String projectId,HttpSession session){
        Emp e = (Emp)session.getAttribute("empId");
        JSONArray jsonArray = JSONArray.parseArray(tableList);
        for(int i = 0;i<jsonArray.size();i++){
            StuReplyScore s = new StuReplyScore();
            Map o = (Map)jsonArray.get(i);
            s.setScore1(Float.valueOf(o.get("s1").toString()));
            s.setScore2(Float.valueOf(o.get("s2").toString()));
            s.setScore3(Float.valueOf(o.get("s3").toString()));
            s.setScore4(Float.valueOf(o.get("s4").toString()));
            s.setScore5(Float.valueOf(o.get("s5").toString()));
            s.setScore6(Float.valueOf(o.get("s6").toString()));
            s.setScore7(Float.valueOf(o.get("s7").toString()));
            s.setStudId(Integer.parseInt(o.get("sid").toString()));
            s.setProjectId(Integer.parseInt(projectId));
            s.setReplyScoreRemark(o.get("rs").toString());
            s.setEmpId(e.getEmpId());
            System.out.println("循环内的考试对象"+s.toString());
            stuSer.addStu(s);
        }
        return "yes";
    }


    //条件查询考试成绩
    @RequestMapping("scoCon")
    @ResponseBody
    public JSONObject  scoCon(String  stuSelectName, String stuSelectCla , String  stuSelectCour, String stuSelectTerm){
        JSONObject jsonObject = new JSONObject();
        List list = stuScoSer.scoCon(stuSelectName,stuSelectCla,stuSelectCour,stuSelectTerm);
        int title = stuScoSer.scoConCount(stuSelectName,stuSelectCla,stuSelectCour,stuSelectTerm);
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        return jsonObject;
    }

    //删除
    @ResponseBody
    @RequestMapping("{ac}/del")
    public String del(String id,@PathVariable("ac")String ac){
        id = id.substring(0,id.length()-1);
        if("score".equals(ac)){
            stuScoSer.delSco(id);
        }else if("reply".equals(ac)){
            stuScoSer.delReply(id);
        }
        return "chenggong";
    }


    //条件筛选答辩成绩
    @RequestMapping("repCon")
    @ResponseBody
    public JSONObject repCon(String stuSelectName, String stuSelectCla , String stuSelectPro){
        JSONObject jsonObject = new JSONObject();
        List list = stuScoSer.repCon(stuSelectName,stuSelectCla,stuSelectPro);
        int title= stuScoSer.repConCount(stuSelectName,stuSelectCla,stuSelectPro);
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",title);
        return jsonObject;
    }
}
