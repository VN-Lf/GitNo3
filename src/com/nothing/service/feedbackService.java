package com.nothing.service;

import com.nothing.vo.checking.AttendanceVo;
import com.nothing.vo.feedback.feedback;

import java.util.List;

public interface feedbackService {
    //查询信息
    List selectfeedbacklist(String sql);
    //查询总行数
    int Selcctfeedbackcount(String sql);
    //添加问题的方法
    void addFeedback(feedback feedback);
    //修改的方法
    void updateFeedback(feedback feedback);
    //删除楼栋的方法
    void delFeedback(Object id);
}
