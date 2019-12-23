<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/22
  Time: 20:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="./../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" method="post" action="/finance/tuitionAdd" lay-filter="gg">
    <input type="hidden" name="financeId">
    <input type="hidden" name="financedate">
    <input type="hidden" name="empid">
    <input type="hidden" name="Invalid">
    <div class="layui-inline" style="margin-bottom: 15px;">
        <label class="layui-form-label">班级</label>
        <div class="layui-input-inline" style="width:340px">
            <select id="class" required  lay-filter="classFilter">
                <option value="">请选择班级</option>
                <c:forEach items="${c}" var="cc">
                    <option value="${cc.classId}">${cc.className}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">学生</label>
        <div class="layui-input-block">
            <select  name="stuid" id="student" required  lay-filter="studentFilter">
                <option value="">请选择学生</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">付款方式</label>
        <div class="layui-input-block">
            <select name="receipt" required lay-verify="required" style="width: 250px">
                <option value="支付宝支付">支付宝</option>
                <option value="微信支付">微信支付</option>
                <option value="银行卡转账">银行卡转账</option>
                <option value="pos刷卡">pos刷卡</option>
                <option value="现金">现金</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">收费项</label>
        <div class="layui-input-block">
            <select name="tuitionTypeId" required  lay-verify="required" style="width: 250px">
                <option value="1">学费</option>
                <option value="2">白费</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">类型</label>
        <div class="layui-input-block">
            <select name="financeType" required lay-verify="required" style="width: 250px">
                <option value="1">缴费</option>
                <option value="2">退费</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">学期</label>
        <div class="layui-input-block">
            <select name="termId" required  lay-verify="required" style="width: 250px">
                <option value="1">第一学期</option>
                <option value="2">第二学期</option>
                <option value="3">第三学期</option>
                <option value="4">第四学期</option>
                <option value="5">第五学期</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">说明</label>
        <div class="layui-input-block">
            <input type="text" name="remark" placeholder="请输入.." autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">实交金额</label>
        <div class="layui-input-block">
            <input type="number" name="money" placeholder="请输入.." autocomplete="off" class="layui-input">
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
            "empid":"${empId.empId}"
        })

        //监听提交
        form.on('submit(formDemo)', function(data){
            window.parent.tabsClose();
            return true;
        });
        var classText = "";
        //监听下拉框
        form.on('select(classFilter)', function(data){
            //移除学生下拉框所有选项
            $("#student").empty();
            var studentHtml = '<option value="">请选择学生</option>';
            $("#student").html(studentHtml);
            var value = $("#class").val();
            //异步加载下拉框数据
            $.post('${pageContext.request.contextPath}/finance/getS',{id:value},function (data) {
                var $html = "";
                if(data.data != null) {
                    $.each(data.data, function (index, item) {
                        $html += "<option value='" + item.studId + "'>" + item.stuName + "</option>";
                    });
                    $("#student").append($html);
                    //append后必须从新渲染
                    form.render('select');
                }

            },"json");
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
