<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/13
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" method="post" action="/houqin/repUp" lay-filter="gg">
    <input type="hidden" name="equipmentId">
    <input type="hidden" name="student">
    <input type="hidden" name="classes">
    <input type="hidden" name="userType">
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">维修事项</label>
        <div class="layui-input-block">
            <input type="text" name="equipmentType" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">维修状态</label>
        <div class="layui-input-block">
            <select name="status" lay-verify="required" style="width: 250px">
                <option value="">请选择...</option>
                <option value="0">未完成</option>
                <option value="1">已完成</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">开始时间</label>
        <div class="layui-input-block">
            <input id="start" type="text" name="start" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">结束时间</label>
        <div class="layui-input-block">
            <input id="end" type="text" name="end" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <input type="text" name="remark" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</body>
<script>
    layui.use(['form','laydate'], function(){
        var form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate;

        form.val("gg",{
            "equipmentId":"${er.equipmentId}"
            ,"equipmentType":"${er.equipmentType}"
            ,"status":"${er.status}"
            ,"classes":"${er.classes}"
            ,"student":"${er.student}"
            ,"remark":"${er.remark}"
            ,"userType":"${er.userType}"
            ,"start":dateFormat(${er.startTime})
            ,"end":"${er.eedTime}"
        })

        //日期
        laydate.render({
            elem:'#start',
            trigger: 'click',
        });
        laydate.render({
            elem:'#end',
            trigger: 'click'
        });

        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return true;
        });
    });

    function tabClose() {
        $(".tabs-inner").dblclick(function() {
            var subtitle = $(this).children(".tabs-closable").text();
            $('#tabs').tabs('close', subtitle);
        })
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
