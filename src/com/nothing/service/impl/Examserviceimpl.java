package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.Examservice;
import com.nothing.vo.gongon.dataDoc;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
    public class Examserviceimpl extends  BaseDao implements Examservice{

    @Override
    public List examlist(String sql) {
        List list = listBySQL(sql);
        return list;
    }

    @Override
    public List examlist1(String sql) {
        List list = listBySQL2(sql);
        return list;
    }

    @Override
    public List empexamlist(String sql) {
        List list = listBySQL(sql);
        return list;
    }

    @Override
    public void addexam(Object obj) {
        addObject(obj);
    }

    @Override
    public int Selectcount(String sql) {
        int count= selectcount(sql);
        return count;
    }

    @Override
    public void updateexam(Object obj) {
        updObject(obj);
    }

    @Override
    public void updateend(String sql) {
        executeSQL(sql);
    }

    @Override
    public void deleteexam(Object obj) {
        delObject(obj);
    }

    @Override
    public void alldelete(String sql) {
        executeSQL(sql);
    }

    @Override
    public List examdate(String sql) {
        List list = listBySQL(sql);
        return list;
    }

    @Override
    public void addupload(Object obj) {
        addObject(obj);
    }

    @Override
    public dataDoc uploadfile(MultipartFile face, HttpServletRequest request) {
//        文件上传对象
        dataDoc dataDoc=new dataDoc();

        String filename = face.getOriginalFilename();
        System.out.println("文件名:"+filename);

        dataDoc.setDataName(filename);
        dataDoc.setEmpid(2);
        dataDoc.setOptime(new Date());

        String imgname = filename.substring(filename.indexOf("."));//文件后缀名
        System.out.println("文件后缀名:"+imgname);

        String realPath = request.getServletContext().getRealPath("\\");//获取项目绝对路径

        System.out.println("项目绝对路径:"+realPath);


        //获取时间
        Calendar calendar = Calendar.getInstance();
        int month=calendar.get(Calendar.MONTH)+1;
        String mm = String.valueOf(month);
        if(month<10){
            mm="0"+mm;
        }
        realPath=realPath+"upload\\"+calendar.get(Calendar.YEAR)+mm+calendar.get(Calendar.DAY_OF_MONTH);

        System.out.println("图片保存路径:"+realPath);

        File file=new File(realPath);
        if(!file.exists()){
            file.mkdirs();
        }

        //设置新新文件名
        String s = UUID.randomUUID().toString();

        String filepath = realPath + "\\" + s + imgname;

        File file1=new File(filepath);
        try {
            face.transferTo(file1);
        } catch (IOException e) {
            e.printStackTrace();
        }

        dataDoc.setUrl("upload\\"+calendar.get(Calendar.YEAR)+mm+calendar.get(Calendar.DAY_OF_MONTH)+"\\"+s+ imgname);

        return dataDoc;
    }

    @Override
    public List fileurl(String sql) {
        List list = listBySQL2(sql);
        return list;
    }
}
