package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.courseService;
import com.nothing.vo.Edu.Course;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class courseServiceImpl extends BaseDao implements courseService {

    @Override
    public List Courselist(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int Coursecount(String sql) {
        return selTotalRow(sql);
    }

    @Override
    public void addCourse(Course course) {
        addObject(course);
    }

    @Override
    public void updateCourse(Course course) {
        updObject(course);
    }

    @Override
    public void delCourse(String id) {
        executeSQL("delete from course where courseId in ("+id+")");
    }
}
