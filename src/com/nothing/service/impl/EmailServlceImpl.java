package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.EmailService;
import com.nothing.vo.Email.Email;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class EmailServlceImpl extends BaseDao implements EmailService {
    //查询楼栋信息
    @Override
    public List selectEmaillist(String sql) {
        return listBySQL(sql);
    }
    //查询总行数
    @Override
    public int SelcctEmailcount(String sql) {
        return selTotalRow(sql);
    }
    //根据Id查找内容
    @Override
    public Object SelectEmailContent(Email email, Integer id) {
        return getObject(email.getClass(),id);
    }
    @Override
    public void delEmail(Object id) {
        executeSQL("delete from myemail where emailId in ("+id+")");
    }

    //添加邮件的方法
    @Override
    public void addEmail(Email email) {

        addObject(email);
    }
    //修改email为已读
    @Override
    public void updateEmailIsRead(String sql) {
        executeSQL(sql);
    }

    @Override
    public Email Emailfile(MultipartFile face, HttpServletRequest request) {
        //        文件上传对象
        Email email = new Email();

        String filename = face.getOriginalFilename();
        System.out.println("文件名:"+filename);

        email.setOldFileName(filename);

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

        email.setImage("upload\\"+calendar.get(Calendar.YEAR)+mm+calendar.get(Calendar.DAY_OF_MONTH)+"\\"+s+ imgname);

        return email;
    }
}
