<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/24
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>员工考核详情</title>
</head>
<body>
<div data-options="region:'center'">
    <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
</div>
</body>
<script type="text/javascript">
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 500
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/System/kaodatalist?id='+${id} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'aduitName', title: '考核内容', sort: true}
                ,{field: 'empName', title: '员工姓名'}
                ,{field: 'Scores', title: '考核分数', sort: true}
                ,{field: 'auditDate', title: '考核时间',templet: function(d){return dateFormat(d.auditDate)}}
                ,{field: 'auditPerson', title: '录入人员'}
                ,{field: 'Remark', title: '说明'}
            ]]
        });
    });
</script>

<script type="text/javascript">
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
        dateTypeDate += " " + getHours(date);
        dateTypeDate += ":" + getMinutes(date);
        dateTypeDate += ":" + getSeconds(date);
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
