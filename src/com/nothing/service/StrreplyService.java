package com.nothing.service;

import java.util.List;

public interface StrreplyService {

    //查询楼栋信息
    List selectStrreplylist(String sql);
    //查询楼栋总行数
    int SelcctStrreplycount(String sql);
}
