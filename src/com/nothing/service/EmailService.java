package com.nothing.service;

import com.nothing.vo.Email.Email;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface EmailService {
    //查询出email数据
    List selectEmaillist(String sql);
    //查询email总行数
    int SelcctEmailcount(String sql);
    //根据Id查找内容
    Object SelectEmailContent(Email email, Integer id);
    //删除Email的方法.
    void delEmail(Object id);
    //添加Email的方法
    void addEmail(Email email);
    //修改Email为已读
    void updateEmailIsRead(String sql);
    //添加文件的方法
    Email Emailfile(MultipartFile face, HttpServletRequest request);
}
