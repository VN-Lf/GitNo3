<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/11
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="./../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" method="post" action="/emp/jobAdd" lay-filter="gg">
    <input type="hidden" name="empId">
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">公司名称</label>
        <div class="layui-input-block">
            <input type="text" name="empHisCompany" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">职务</label>
            <div class="layui-input-block">
                <input type="text" name="empHisDegree" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
            </div>
        </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">入职时间</label>
        <div class="layui-input-block">
            <input id="start" type="text" name="empHisStartDay" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">离职时间</label>
        <div class="layui-input-block">
            <input id="end" type="text" name="empHisEndDay" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">离职原因</label>
        <div class="layui-input-block">
            <input type="text" name="empLiftReason" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <input type="text" name="empHisRemark" placeholder="请输入.." autocomplete="off" class="layui-input">
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
            "empId":"${currActEmpId}"
        })

        //日期
        laydate.render({
            elem:'#start',
            trigger: 'click'
        });
        laydate.render({
            elem:'#end',
            trigger: 'click'
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
</script>
</html>
