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
    <table id="rep" lay-filter="rep"></table>
</body>
<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm" lay-event="up">修改</a>
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
</script>
<script>
    layui.use(['util','table'], function(){
        var table = layui.table;

        var util = layui.util;
        //第一个实例
        table.render({
            elem: '#rep'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,url: '${pageContext.request.contextPath}/houqin/repairList' //数据接口
            ,page: true //开启分页
            ,done: function (res, curr, count) {
                $("table").css("width", "100%");
            }
            ,cols: [[ //表头
                {field: 'equipmentId', title: '编号',sort: true, fixed: 'left'}
                ,{field: 'equipmentType', title: '保修事项'}
                ,{field: 'status', title: '修理状态',templet:function (d) {if (d.status==1){return'已完成'}else{return'未完成'}}}
                ,{field: 'classes', title: '部门班级',templet:function (d) {if (d.userType==1){return d.classId;}else{return d.empDeptId;}}}
                ,{field: 'student', title: '报修人',templet:function (d) {if (d.userType==1){return d.stuName;}else{return d.empName;}}}
                ,{field: 'remark', title: '备注'}
                ,{field: 'userType', title: '报修身份',templet:function (d) {if (d.userType==1){return'学生';}else{return'员工';}}}
                ,{field: 'startTime', title: '保修时间',sort:true,templet: function(d){return dateFormat(d.startTime)}}
                ,{field: 'eedTime', title: '完成时间',sort:true,templet: function(d){if (d.eedTime==null){return "";}else {return dateFormat(d.eedTime)}}}
                ,{field: 'eedTime', title: '操作', width: 150,toolbar:"#barOption"}
            ]]
        });
        //监听工具条
        table.on('tool(rep)', function (obj) {
            var data = obj.data;
            if (obj.event === 'up') {
                openUpdate(data.equipmentId);
            } else if (obj.event === 'del') {
                layer.confirm('真的要删除该记录吗？', function (index) {
                    $.post('${pageContext.request.contextPath}/houqin/repDel',{id:data.equipmentId},function (data) {
                        //显示提示框
                        layer.msg("删除成功", {icon: 6});
                        table.reload("rep");
                    });
                    return false;
                });
            }
        });
    });
    function openUpdate(id) {
        index1=layer.open({
            type: 2,
            title:'修改记录',
            area: ['500px', '400px'],
            content:'${pageContext.request.contextPath}/houqin/repUpPage?rid='+id, //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            anim: 2
        });
    }
</script>
<script>


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
