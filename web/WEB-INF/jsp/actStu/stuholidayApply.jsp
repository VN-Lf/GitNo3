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
<head><!----><!----->
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
            <label class="layui-form-label">请假天数</label>
            <div class="layui-input-block">
                <input id="day" type="text" name="day" required  lay-verify="number" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">开始时间</label>
            <div class="layui-input-block">
                <input id="goDate" type="text" name="goDate" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">结束时间</label>
            <div class="layui-input-block">
                <input id="endDate" type="text" name="endDate"  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">请假事由</label>
            <div class="layui-input-block">
                <input id="remark" type="text" name="remark" required  lay-verify="required" placeholder="学生年纪" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div style="width: 100%;height: 20%;margin-top:3%;float: left">
            <div class="layui-form-item">
                <div class="layui-input-block" style="top: 85px;left: 800px">
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

            laydate.render({
                elem: '#endDate' //指定元素o
            });
        });
    </script>
</html>
