<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/10
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form class="layui-form" method="post" action="/emp/eduAdd" lay-filter="gg">
        <input type="hidden" name="empEduId">
        <input type="hidden" name="empId">
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">学校名称</label>
            <div class="layui-input-block">
                <input type="text" name="empUniversity" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">学历水平</label>
            <div class="layui-input-block">
                <select name="empDegree" lay-verify="required" style="width: 250px">
                    <option value="0">请选择...</option>
                    <option value="高中及以下">高中及以下</option>
                    <option value="大专">大专</option>
                    <option value="本科">本科</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">入学时间</label>
            <div class="layui-input-block">
                <input id="start" type="text" name="empEucStartDay" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">毕业时间</label>
            <div class="layui-input-block">
                <input id="end" type="text" name="empEucEndDay" required  lay-verify="required" placeholder="请选择..." autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" name="empEucRemark" placeholder="请输入.." autocomplete="off" class="layui-input">
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
</html>
