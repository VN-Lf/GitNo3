package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.DormitoryService;

import java.sql.*;
import java.util.List;

import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.sushe.studentHour;
import org.springframework.stereotype.Service;

@Service
public class DormitoryServiceImpl extends BaseDao implements DormitoryService {

    static String driver = "com.mysql.jdbc.Driver";
    static String url = "jdbc:mysql://localhost:3306/gitxm?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&useSSL=false";
    static String username = "root";
    static String password = "123456";

    //查询出宿舍信息
    @Override
    public List selectDormitorylists(String sql) {
        return listBySQL(sql);

    }

    public List selectDormitorylist(int page, int rows) {
        return this.pageByHql("select * from studentHour", page, rows);
    }
    //查询出宿舍总数
    public int SelcctDormitorycount(String sql) {
        return this.selTotalRow(sql);
    }

    //添加的方法
    @Override
    public void addDormitory(studentHour studentHour) {
        addObject(studentHour);
    }

    @Override
    public void updateDormitory(studentHour studentHour) {
        updObject(studentHour);
    }

    //修改学生
    @Override
    public void updateStudentwtf(String id, int sushe) {
        Connection conn = null;
        //加载驱动
        try {
            Class.forName(driver);
            //获取连接
            conn = DriverManager.getConnection(url,username,password);
            PreparedStatement ps ;
            String sql ="update student set stuHours = ? where studId = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sushe);
            ps.setString(2, id);
            ps.executeUpdate();

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delDormitory(Object id) {
        executeSQL("delete from studentHour where stuHours in ("+id+")");
    }

}