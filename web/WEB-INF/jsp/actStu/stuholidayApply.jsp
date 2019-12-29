<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/19
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>学生请假</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<div  class="layui-form-item" style="align-content: center;margin-top: 100px;width: 300px;margin-left: 300px">
    <form class="layui-form" action="${pageContext.request.contextPath}/actStu/apply" method="post" target="_self">

        <input type="hidden" name="jobType" id="jobType" value="stuLeave">
        <input type="hidden" name="jobName" id="jobName" value="stuLeave">
        <input type="hidden" name="userId" id="userId" value="${sessionScope.stuId.studId}">

        <div class="layui-form-item">
            <label class="layui-form-label">开始时间</label>
            <div class="layui-input-block">
                <input id="goDate" type="text" name="goDate" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">请假天数</label>
            <div class="layui-input-block">
                <input id="day" oninput="chuangTime()" type="text" name="day" required  lay-verify="number" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>



        <div class="layui-form-item">
            <label class="layui-form-label">结束时间</label>
            <div class="layui-input-block">
                <input id="endDate" readonly type="text" name="endDate"  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">请假事由</label>
            <div class="layui-input-block">
                <input id="remark" type="text" name="remark" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div style="width: 100%;height: 20%;margin-top:3%;float: left">
            <div class="layui-form-item">
                <div class="layui-input-block" style="top: 60px;">
                    <button class="layui-btn" lay-submit type="submit">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </div>

    </form>
</div>
</body>
    <script src="${pageContext.request.contextPath}/layui/layui.js">

    </script>

    <script>
        layui.use(['form','laydate'], function(){
            laydate.render({
                elem: '#goDate' //指定元素
            });
        });
        function gel(id) {return document.getElementById(id);}

        function chuangTime() {
            var gd = gel("goDate").value;
            var time = gel("day").value;
            if(time !== ""){
                var godt = gd+" 00:00:00";
                var cha = (new Date(godt)).getTime() + time*24*60*60*1000;//时间差
                var d = new Date(cha);//新时间
                var enddate = d.getFullYear()+"-";
                if((d.getMonth()+1) < 10){
                    enddate = enddate+"0"+(d.getMonth()+1)+'-';
                }else {
                    enddate = enddate+(d.getMonth()+1)+'-';
                }
                if(d.getDate() < 10){
                    enddate = enddate+"0"+d.getDate();
                }else {
                    enddate = enddate+d.getDate();
                }
                gel("endDate").value = enddate;
            }else {
                gel("endDate").value = "";
            }
        }
    </script>
</html>
