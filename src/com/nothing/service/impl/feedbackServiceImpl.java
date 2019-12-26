package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.feedbackService;
import com.nothing.vo.feedback.feedback;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class feedbackServiceImpl extends BaseDao implements feedbackService {

    @Override
    public List selectfeedbacklist(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int Selcctfeedbackcount(String sql) {
        return this.selTotalRow(sql);
    }

    @Override
    public void addFeedback(feedback feedback) {
        addObject(feedback);
    }

    @Override
    public void updateFeedback(feedback feedback) {
        updObject(feedback);
    }

    @Override
    public void delFeedback(Object id) {
        executeSQL("delete from feedback where feedbackId in ("+id+")");
    }
}
