package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.courseTypeService;
import com.nothing.vo.Edu.CourseType;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseTypeServiceImpl extends BaseDao implements courseTypeService {

    @Override
    public List selectCourselist(String sql) {
        return listBySQL(sql);
    }

    @Override
    public int SelcctCoursecount(String sql) {
        return selTotalRow(sql);
    }

    @Override
    public void addCourse(CourseType courseType) {
        addObject(courseType);
    }

    @Override
    public void delCourse(String id) {
        executeSQL("delete from courseType where courseTypeId in ("+id+")");
    }

    @Override
    public void upateCourse(CourseType courseType) {
        updObject(courseType);
    }


}
