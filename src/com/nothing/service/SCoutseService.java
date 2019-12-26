package com.nothing.service;

import java.util.List;

public interface SCoutseService {
    //查询楼栋信息
    List selectScoutselist(String sql);
    //查询楼栋总行数
    int SelcctScoutsecount(String sql);
}
