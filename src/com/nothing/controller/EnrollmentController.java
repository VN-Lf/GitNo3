package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.StuSer.EnrSer;
import com.nothing.service.StuSer.StuSer;
import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Edu.EduMajor;
import com.nothing.vo.Sdudent.Enrollment;
import com.nothing.vo.Sdudent.EntryFinance;
import com.nothing.vo.emp.Emp;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.jar.JarEntry;

@Controller
@RequestMapping("enrStu")
public class EnrollmentController{

    @Resource
    StuSer stuSer;
    @Resource
    EnrSer enrSer;

    @RequestMapping("{ac}")
    public String toMain(@PathVariable("ac")String ac, HttpServletRequest request){
        if("main".equals(ac)){
            List majorList = stuSer.listObj(new EduMajor());
            List classTypeList = stuSer.listObj(new ClassType());
            List classList = stuSer.listObj(new ClassVo());
            request.setAttribute("majorList",majorList);
            request.setAttribute("classTypeList",classTypeList);
            request.setAttribute("classList",classList);
            return "student/enr";
        }
        return "";
    }

    @ResponseBody
    @RequestMapping("{ac}/toList")
    public JSONObject toList(@PathVariable("ac")String ac){
        JSONObject jsonObject = new JSONObject();
        if("main".equals(ac)){
            List list = enrSer.allEnr();
            jsonObject.put("code",0);
            jsonObject.put("msg","");
            jsonObject.put("data",list);
            jsonObject.put("count",list.size());
        }
        return jsonObject;

    }



    @RequestMapping("up")
    @ResponseBody
    public String update( Enrollment e, String paymentDH, String testDH, String startDH, HttpSession session) throws ParseException,NullPointerException{
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            System.out.println("ododododododododododoood"+e.getEnrollmentid());
            if(paymentDH==""||paymentDH==null){

            }else{
                Date pTime = formatter.parse(paymentDH);
                e.setPaymentTime(pTime);
            }
            if(testDH==""||paymentDH==null){

            }else{
                Date tTime = formatter.parse(testDH);
                e.setTestTime(tTime);
            }
            if(startDH==""||startDH==null){

            }else{
                Date sTime = formatter.parse(startDH);
                e.setStartTime(sTime);
            }


            e.setSigndate(new Date());
            //Emp emp = (Emp) session.getAttribute("empId");
            //e.setEmpId(e.getEmpId());
            System.out.println(e.toString());
            if(e.getEnrollmentid()==0||e.getEnrollmentid()==null||"".equals(e.getEnrollmentid())){
                try{
                    stuSer.addStu(e);
                }catch (IndexOutOfBoundsException eee){

                }
                return "";
            }else{
                System.out.println("xiugaixiugaixiugaixiugaixiugai");
                stuSer.updateStu(e);
            }


        return "";
    }


    @RequestMapping("toSelect/{ac}")
    @ResponseBody
    public String to(@PathVariable("ac")String ac,String id){
        if("toMoney".equals(ac)){
           List list =  enrSer.existsProMoney(id);
           if(list.size()>0){
               return "no";
           }
        }
        return "";
    }

    @RequestMapping("addPromTime")
    @ResponseBody
    public String addPromTime(String enId,String pmDH) throws ParseException {
        enrSer.updateProMoney(pmDH,enId);
        return " ";
    }

    @ResponseBody
    @RequestMapping("audit")
    public String toAudit(String eId,String reviewer){
        EntryFinance entryFinance = new EntryFinance();
        entryFinance.setEnrollmentId(Integer.parseInt(eId));
        entryFinance.setReviewer(reviewer);
        entryFinance.setEntryTime(new Date());
        stuSer.addStu(entryFinance);
        return "";
    }

    @ResponseBody
    @RequestMapping("addMoney")
    public String addMoney(String eeeId,String enrollMoney){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String time = formatter.format(new Date());
        enrSer.updateMoney(eeeId,enrollMoney,time);
        return "";
    }

    @RequestMapping("con")
    @ResponseBody
    public JSONObject con(String  stuSelectName, String  selectClassType, String  stuSelectTeacher, String stuSelecStuat){
        if("".equals(stuSelectName)||stuSelectName==null){
            stuSelectName="";
        }
        if("".equals(selectClassType)||selectClassType==null){
            selectClassType="";
        }
        if("".equals(stuSelectTeacher)||stuSelectTeacher==null){
            stuSelectTeacher="";
        }
        if("".equals(stuSelecStuat)||stuSelecStuat==null){
            stuSelecStuat="";
        }
        JSONObject jsonObject = new JSONObject();
        List list = enrSer.conList(stuSelectName,selectClassType,stuSelectTeacher,stuSelecStuat);
        jsonObject.put("code",0);
        jsonObject.put("msg","");
        jsonObject.put("data",list);
        jsonObject.put("count",list.size());
        return jsonObject;
    }


}
