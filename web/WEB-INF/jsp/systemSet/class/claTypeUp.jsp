<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/25
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" method="post" action="/sys/CTUp" lay-filter="gg">
    <input type="hidden" name="classType">
    <div class="layui-form-item" style="width: 300px">
        <label class="layui-form-label">类型名称</label>
        <div class="layui-input-block">
            <input id="name"type="text" name="classTypeName" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="margin: 20px;">
            <button class="layui-btn" lay-submit lay-filter="formDemo" >确认</button>
    </div>
</form>
</body>
<script>
    layui.use(['form','laydate'], function(){
        var form = layui.form,
            layer = layui.layer;

        form.val("gg",{
            "classType":"${ct.classType}",
            "classTypeName":"${ct.classTypeName}",
        })
        //监听提交
        form.on('submit(formDemo)', function(data){
            window.parent.location.reload();
            return true;
        });
    });
</script>
</html>
