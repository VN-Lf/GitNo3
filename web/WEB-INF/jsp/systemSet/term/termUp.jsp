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
<form class="layui-form" method="post" action="/sys/termUp" lay-filter="gg">
    <input type="hidden" name="termId">
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">学期</label>
        <div class="layui-input-block">
            <input id="name"type="text" name="termName" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">说明</label>
        <div class="layui-input-block">
            <input type="text" name="termRemark"required  lay-verify="required"  placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" >立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</body>
<script>
    layui.use(['form','laydate'], function(){
        var form = layui.form,
            layer = layui.layer;

        form.val("gg",{
            "termId":"${t.termId}",
            "termName":"${t.termName}",
            "termRemark":"${t.termRemark}"
        })
        //监听提交
        form.on('submit(formDemo)', function(data){
            window.parent.location.reload();
            return true;
        });
    });
</script>
</html>
