package com.nothing.service;

import java.util.List;

public interface Examservice {
    List examlist(String sql);

    List empexamlist(String sql);

    int selectcount(String sql);

    void updateexam(Object obj);

    void deleteexam(Object obj);

    void alldelete(String sql);

    List examdate(String sql);
}
