<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/4
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../index.jsp"%>
<html>
<head>
    <title>报修列表</title>
</head>
<body>
    <table id="demo" lay-filter="test"></table>
</body>
<script>

    layui.use(['util','table'], function(){
        var table = layui.table;

        var util = layui.util;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '${pageContext.request.contextPath}/houqin/repairList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'equipmentId', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'equipmentType', title: '保修事项', width:100}
                ,{field: 'status', title: '修理状态', width:100}
                ,{field: 'classes', title: '班级', width:100}
                ,{field: 'student', title: '学生', width:100}
                ,{field: 'remark', title: '备注', width:100}
                ,{field: 'userType', title: '报修身份', width:100}
                ,{field: 'startTime', title: '保修时间', width:150, sort: true,templet: function(d){return dateFormat(d.startTime)}}
                ,{field: 'eedTime', title: '完成时间', width: 150, sort: true,templet: function(d){return dateFormat(d.eedTime)}}
            ]]
        });
    });

    /*
     * 时间格式化工具
     * 把Long类型的1527672756454日期还原yyyy-MM-dd格式日期
     */
    function dateFormat(longTypeDate){
        var dateTypeDate = "";
        var date = new Date();
        date.setTime(longTypeDate);
        dateTypeDate += date.getFullYear();   //年
        dateTypeDate += "-" + getMonth(date); //月
        dateTypeDate += "-" + getDay(date);   //日
        return dateTypeDate;
    }
    //返回 01-12 的月份值
    function getMonth(date){
        var month = "";
        month = date.getMonth() + 1; //getMonth()得到的月份是0-11
        if(month<10){
            month = "0" + month;
        }
        return month;
    }
    //返回01-30的日期
    function getDay(date){
        var day = "";
        day = date.getDate();
        if(day<10){
            day = "0" + day;
        }
        return day;
    }
    //小时
    function getHours(date){
        var hours = "";
        hours = date.getHours();
        if(hours<10){
            hours = "0" + hours;
        }
        return hours;
    }
    //分
    function getMinutes(date){
        var minute = "";
        minute = date.getMinutes();
        if(minute<10){
            minute = "0" + minute;
        }
        return minute;
    }
    //秒
    function getSeconds(date) {
        var second = "";
        second = date.getSeconds();
        if (second < 10) {
            second = "0" + second;
        }
        return second;
    }
</script>
</html>
