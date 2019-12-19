package com.nothing.service;

import com.nothing.vo.gongon.dataDoc;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface Examservice {
    //服务方法
    List examlist(String sql);

    List examlist1(String sql);

    List empexamlist(String sql);

    void addexam(Object obj);

    int Selectcount(String sql);

    void updateexam(Object obj);

    void deleteexam(Object obj);

    void alldelete(String sql);

    List examdate(String sql);

    void addupload(Object obj);

    dataDoc uploadfile(MultipartFile face, HttpServletRequest request);

    List fileurl(String sql);
}
