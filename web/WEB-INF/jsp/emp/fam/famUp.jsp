<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/9
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" method="post" action="/emp/famUp" lay-filter="gg">
    <input type="hidden" name="empFamImfId">
    <input type="hidden" name="empId">
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">联系人名称</label>
        <div class="layui-input-block">
            <input type="text" name="empContact" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">与员工关系</label>
        <div class="layui-input-block">
            <select name="empRelation" lay-verify="required" style="width: 250px">
                <option value="0">请选择...</option>
                <option value="父母">父母</option>
                <option value="夫妻">夫妻</option>
                <option value="子女">子女</option>
                <option value="兄弟姐妹">兄弟姐妹</option>
                <option value="其他">其他</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">联系电话</label>
        <div class="layui-input-block">
            <input type="text" name="empContactphone" required lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <input type="text" name="empFamImfRemark" placeholder="请输入.." autocomplete="off" class="layui-input">
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
    var d = parseInt(2019-12-02)
    layui.use(['form','laydate'], function(){
        var form = layui.form,
            layer = layui.layer;

        form.val("gg",{
            "empFamImfId":"${efi.empFamImfId}"
            ,"empId":"${efi.empId}"
            ,"empContact":"${efi.empContact}"
            ,"empRelation":"${efi.empRelation}"
            ,"empContactphone":"${efi.empContactphone}"
            ,"empFamImfRemark":"${efi.empFamImfRemark}"
        })

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
