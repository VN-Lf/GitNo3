<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/16
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" method="post" action="/emp/chatAdd" lay-filter="gg">
    <input type="hidden" name="Chatid">
    <input type="hidden" name="teacher">
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">学生</label>
        <div class="layui-input-block">
            <input id="name" onchange="n()" type="text" name="face" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">地点</label>
        <div class="layui-input-block">
            <input type="text" name="addr" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">时间</label>
        <div class="layui-input-block">
            <input id="start" type="text" name="chatDate" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">内容</label>
        <div class="layui-input-block">
            <input type="text" name="sayscon"required  lay-verify="required"  placeholder="请输入.." autocomplete="off" class="layui-input">
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
            layer = layui.layer,
            laydate = layui.laydate;

        form.val("gg",{
            "teacher":"${empId.empId}"
        })

        //日期
        laydate.render({
            elem:'#start',
            trigger: 'click',
        });

        //监听提交
        form.on('submit(formDemo)', function(data){
            window.parent.location.reload();
            return true;
        });
    });

    function tabClose() {
        $(".tabs-inner").dblclick(function() {
            var subtitle = $(this).children(".tabs-closable").text();
            $('#tabs').tabs('close', subtitle);
        })
    }

    function n(){
        $.post('${pageContext.request.contextPath}/emp/checkStudent',{name:$("#name").val()},function (data) {
            if (data.result=='查无此人！'){
                layer.msg(data.result);
            }
        },"json");
    }
</script>
</html>
