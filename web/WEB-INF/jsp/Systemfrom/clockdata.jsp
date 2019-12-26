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
    <title>员工未打卡统计</title>
</head>
<body id="kaohe" class="easyui-layout">
    <div data-options="region:'center'">
        <form style="width: 1205px;margin: 20px 0px 0px 20px">
            员工姓名:<input type="text" name="empname" id="empname" required lay-verify="required" placeholder="请输人姓名"  class="layui-input" style="width:180px;display:inline-block" />
            <input type="radio"  name="month" value="">全部月份
            <input type="radio"  name="month" value="${month}" checked>本月(${month})
            <input type="radio"  name="month" value="${month-1}">上月(${month-1})
            <input class="layui-btn layui-btn-normal" id="selectexam" style="width: 80px" value="搜索" />
        </form>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="backclock">返回图表</button>
            </div>
        </script>
        <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
    </div>
        <h1 style="text-align: center" >单击数据查看详情</h1>
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
            ,url: '${pageContext.request.contextPath}/System/clockdatalist' //数据接口
            ,page: true //开启分页
            ,where:{empname:'',Depid:''}
            ,cols: [[ //表头
                {field: 'attId', title: '未打卡编号', sort: true}
                ,{field: 'empName', title: '员工姓名'}
                ,{field: 'punckClockTime', title: '未打卡时间', sort: true,templet: function(d){return dateFormat(d.punckClockTime)}}
                ,{field: 'cause', title: '原因'}
                ,{field: 'auditor', title: '审核人'}
                ,{field: 'examineExplain', title: '审核说明'}
                ,{field: 'examineTime', title: '审核时间',templet: function(d){return dateFormat(d.examineTime)}}
                ,{field: 'status', title: '审核状态',templet:function (data) {
                        if(data.status == 1){
                            return '审核成功'
                        }else if(data.status == 2) {
                            return '待审核'
                        }}}
                ]]
        });

        //监听头部按钮
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'backclock':
                    clock();
                    break;
            };
        });

        function clock() {
            document.getElementById("kaohe").innerHTML =
                '<object type="text/html" data="${pageContext.request.contextPath}/System/toclock" width="100%" height="100%"></object>';
        }
        //条件搜索
        $('#selectexam').click(function () {
            var empname=$('#empname').val();
            var month=$("input[name='month']:checked").val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/System/clockdatalist',
                where:{
                    empname:empname,
                    month:month,
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
