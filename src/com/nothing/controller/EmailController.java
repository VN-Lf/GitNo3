package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.EmailService;
import com.nothing.vo.Email.Email;
import com.nothing.vo.emp.Emp;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("email")
public class EmailController {

    @Resource
    EmailService service;

    //去邮件界面
    @RequestMapping("toemail")
    public String toEmail(){
        return "MyEmail/myEmail";
    }
    //去邮件新增界面
    @RequestMapping("toemailadd")
    public String toemailadd(HttpServletRequest request){
        List list = service.selectEmaillist("select * from dept");
        request.setAttribute("Edeptlist",list);
        return "MyEmail/Emailadd";
    }

    //去邮件查看界面
    @RequestMapping("toemailServlet")
    public String toemailServlet(HttpServletRequest request, int emailId){
        int eId = emailId;
        System.out.println("查看邮件的Id为"+eId);
        //修改邮件为已读
        service.updateEmailIsRead("update myemail set isRead = '1' where emailId = '"+eId+"'");
        Email email = new Email();
        email = (Email) service.SelectEmailContent(email, eId);
        request.setAttribute("emalilist",email);
        return "MyEmail/SelectEmail";
    }

    //再次发送Email
    @RequestMapping("againEmail")
    public String againEmail(HttpServletRequest request, int emailId){
        int eId = emailId;
        System.out.println("再次发送邮件的Id为"+eId);
        Email email = new Email();
        //查询出部门
        List list = service.selectEmaillist("select * from dept");
        request.setAttribute("againEdeptlist",list);
        email = (Email) service.SelectEmailContent(email, eId);
        request.setAttribute("againEmail",email);
        return "MyEmail/againEmail";
    }
    //我收到的邮件
    @ResponseBody
    @RequestMapping("obtainEmail")
    public JSONObject obtain(HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        String name = emp.getEmpName();
        System.out.println(name+" 的邮件");
        List list = service.selectEmaillist("select * from myemail where receId = '"+name+"'");
        int count = service.SelcctEmailcount("select count(*) from myemail where receId = '"+name+"'");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }

    //我发送的邮件
    @ResponseBody
    @RequestMapping("SendEmail")
    public JSONObject SendEmail(HttpSession session){
        Emp emp = (Emp) session.getAttribute("empId");
        String name = emp.getEmpName();
        System.out.println(name+"发送的");
        List list = service.selectEmaillist("select * from myemail where empId = '"+name+"'");
        int count = service.SelcctEmailcount("select count(*) from myemail where receId = '"+name+"'");

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }
    //发送邮件的方法
    @RequestMapping("sendEmail")
    public String sendEmail(String topic, String receId,String content, HttpSession session, MultipartFile face,HttpServletRequest request){
        receId = receId.substring(0,receId.length()-1);

        System.out.println(receId.length());
        System.out.println("进来了发送邮件");

        String param[] = receId.split("[,]");
        Email email = new Email();
        for(int i=0;i<param.length;i++){
            String num = param[i];
            System.out.println("num :"+num);
            for(int j=1;j<=i;j++){
                System.out.println("param j :"+param[j]);
               if(num == param[j]){
                   session.setAttribute("Repeat","提交失败,数据冲突!");
                   System.out.println("提交失败,数据冲突");
                   return "redirect:toemail";
               }
            }
        }
        for(int i=0;i<param.length;i++){

            Emp emp = (Emp) session.getAttribute("empId");
            String empid = emp.getEmpName();
            //添加file文件的方法
            if(face!=null){
                email = service.Emailfile(face,request);
            }
            //截取字符串
            String deptreceid = param[i];
            System.out.println("当前的插入的值为：" +deptreceid);
            email.setReceId(deptreceid);

            email.setTopic(topic);
            email.setContent(content);
            email.setEmpId(empid);
            email.setSendtime(new Date());
            email.setIsRead(1);
            service.addEmail(email);
        }

        return "redirect:toemail";
    }

    //查询要发送的人
    @ResponseBody
    @RequestMapping("selsendEmail")
    public JSONObject selsendEmail(String deptname){
        System.out.println(deptname);
        List list = service.selectEmaillist("select * from emp where empId in (select empId from post where deptId = '"+deptname+"')");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", list);
        return jsonObject;
    }
    //删除的方法
    @RequestMapping("deleteEmail")
    public  String deleteEmail(String id){
        System.out.println("进来了删除：id"+id);
        id = id.substring(0,id.length()-1);
        service.delEmail(id);
        return "redirect:toemail";
    }
}
