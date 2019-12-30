<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/25
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" method="post" action="/sys/majorAdd" lay-filter="gg" style="margin-top: 20px;">
    <input type="hidden" name="majorId">
    <div class="layui-form-item" style="width: 400px">
        <label class="layui-form-label">专业名称</label>
        <div class="layui-input-block">
            <input type="text" name="majorName" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 400px">
        <label class="layui-form-label">院系</label>
        <div class="layui-input-block">
            <select name="deptId" lay-verify="required" style="width: 300px">
                <c:forEach items="${deptName}" var="cc">
                    <option value="${cc.depId}">${cc.depName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 400px">
        <label class="layui-form-label">说明</label>
        <div class="layui-input-block">
            <input type="text" name="majorRemark" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" >确认</button>
        </div>
    </div>
</form>
</body>
<script>
    layui.use(['form','laydate'], function(){
        var form = layui.form,
            layer = layui.layer;

        //监听提交
        form.on('submit(formDemo)', function(data){
            window.parent.location.reload();
            return true;
        });
    });
</script>
</html>
