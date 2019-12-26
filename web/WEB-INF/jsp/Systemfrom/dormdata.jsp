<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/24
  Time: 8:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>宿舍统计报表</title>
</head>
<body id="kaohe" class="easyui-layout">
    <div data-options="region:'center'">
        <form style="width: 1205px;margin: 20px 0px 0px 20px">
            楼栋: <select name="addr" id="addr"  lay-filter="demo" lay-verify="required" style="width: 250px">
            <option value="">选择楼栋</option>
            <c:forEach items="${addr}" var="addrname">
                <option value="${addrname}">${addrname}</option>
            </c:forEach>
            </select>
            宿舍房号: <select name="hourname" id="hourname"  lay-filter="demo" lay-verify="required" style="width: 250px">
            <option value="">请选择宿舍房号</option>
            <c:forEach items="${hourName}" var="hourName">
                <option value="${hourName}">${hourName}</option>
            </c:forEach>
        </select>
            <input class="layui-btn layui-btn-normal" id="selectexam" style="width: 80px" value="搜索" />
        </form>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="backclock">返回图表</button>
            </div>
        </script>
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
            ,method:'post'
            ,url: '${pageContext.request.contextPath}/System/dormdatalist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'addr', title: '宿舍楼栋', sort: true}
                ,{field: 'hourName', title: '宿舍房号'}
                ,{field: 'addr', title: '宿舍楼栋', sort: true}
                ,{field: 'count', title: '宿舍当前人数'}
                ,{field: 'numberBeds', title: '床位数'}
                ,{field: 'kong', title: '空位数'}
                ]]
        });

        //监听头部按钮
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'backclock':
                    dorm();
                    break;
            };
        });

        function dorm() {
            document.getElementById("kaohe").innerHTML =
                '<object type="text/html" data="${pageContext.request.contextPath}/System/todorm" width="100%" height="100%"></object>';
        }
        //条件搜索
        $('#selectexam').click(function () {
            var addr=$('#addr').val();
            var hourname=$('#hourname').val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/System/dormdatalist',
                where:{
                    addr:addr,
                    hourname:hourname,
                },page:{
                    curr:1
                }
            });
        })
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
