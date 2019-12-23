package com.nothing.service.StuSer;

import com.nothing.vo.emp.JobsVo;

import java.util.List;
//
public interface ActStuSer{
    void addApply(JobsVo jobsVo);
    List stuMyJob(String userId);
    int stuMyJobCount(String userId);
}
