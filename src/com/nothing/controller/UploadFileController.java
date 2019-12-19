package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.Examservice;
import com.nothing.service.impl.Examserviceimpl;
import com.nothing.vo.gongon.dataDoc;
import com.nothing.vo.wintable.aduitLog;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/upload")
public class UploadFileController {
    @Resource
    Examservice examserviceimpl;
    @RequestMapping(value = "/toupload")
    public String toupload() {
        return "uploadfile/uploadfile";
    }

    @RequestMapping(value = "/toaddupload")
    public String toaddupload() {
        return "uploadfile/adduploadfile";
    }

    @RequestMapping(value = "/uploadlist")
    @ResponseBody
    public JSONObject uploadlist() {
        List uploadlist = examserviceimpl.examlist("select * from datadoc");

        JSONObject jsonObject = new JSONObject();
        int selectcount = examserviceimpl.Selectcount("select count(docId) from datadoc");
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", uploadlist);
        jsonObject.put("count", selectcount);
        return jsonObject;
    }


    @RequestMapping(value = "/addupload")
    public String addupload(MultipartFile face, String remark, HttpServletRequest request) {
        dataDoc dataDoc = examserviceimpl.uploadfile(face, request);
        dataDoc.setRemark(remark);
        examserviceimpl.addupload(dataDoc);
        return "redirect:/upload/toupload";
    }

    @RequestMapping(value = "/filedelete")
    @ResponseBody
    public String filedelete(dataDoc dataDoc) {
        examserviceimpl.deleteexam(dataDoc);
        return "删除成功";
    }


    @RequestMapping("/allfiledelete")
    @ResponseBody
    public String allfiledelete(String id) {
        id = id.substring(0, id.length() - 1);
        examserviceimpl.alldelete("delete from datadoc where docId in(" + id + ")");
        return "删除成功";
    }

    @RequestMapping("/downfile")
    @ResponseBody
    public String downfile(String docId, HttpServletResponse response, HttpServletRequest request) throws IOException {
        List fileurl = examserviceimpl.fileurl("select url from datadoc where docId=" + docId);
        try {
            String filename = (String) fileurl.get(0);

            //获取文件根目录，不同框架获取的方式不一样，可自由切换
            String basePath = request.getSession().getServletContext().getRealPath("/");

            //获取文件名称（包括文件格式）
            String fileName = filename;

            //组合成完整的文件路径
            String targetPath = basePath + File.separator + fileName;


            System.out.println("文件名：" + fileName);
            System.out.println("文件路径：" + targetPath);

            //方法1：IO流实现下载的功能
            response.setCharacterEncoding("UTF-8"); //设置编码字符
            response.setContentType("application/octet-stream;charset=UTF-8"); //设置下载内容类型
            response.setHeader("Content-disposition", "attachment;filename=" + fileName);//设置下载的文件名称
            OutputStream out = response.getOutputStream();   //创建页面返回方式为输出流，会自动弹出下载框

            System.out.println("字符流");
            File file = new File(targetPath);  //创建文件
            FileInputStream fis = new FileInputStream(file);  //创建文件字节输入流
            BufferedInputStream bis = new BufferedInputStream(fis); //创建文件缓冲输入流
            byte[] buffer = new byte[bis.available()];//从输入流中读取不受阻塞
            bis.read(buffer);//读取数据文件
            bis.close();
            out.write(buffer);//输出数据文件
            out.flush();//释放缓存
            out.close();//关闭输出流
        }catch(Exception e) {
            e.printStackTrace();
            response.reset();
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().print("<div align=\"center\" style=\"font-size: 30px;font-family: serif;color: red;\">系统内部错误，下载未成功，请联系管理员！</div>"
                    + "<div>错误信息："+e.getMessage()+"</div>");
            response.getWriter().flush();
            response.getWriter().close();
        }

        return null;
    }
}
