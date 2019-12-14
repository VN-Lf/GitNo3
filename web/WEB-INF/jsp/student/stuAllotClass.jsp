<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/13
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分配班级</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>


<div style="width: 14%;height: 500px;float: left;">
左边
</div>

<div style="width: 86%;float: left;">
    班级
    <table class="layui-hide" id="test"></table>
</div>


<div style="width: 86%;float: left;">
    学生
    <table class="layui-hide" id="studentData" lay-filter="test"></table>

</div >


<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
    </div>
</script>
</body>

<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>


<script>
    layui.use(['table','form','laydate','tree'], function(){
        var tree = layui.tree;
        $.ajax({
            url:'${pageContext.request.contextPath}/stu/?studId='+studId,
            type:'post',
            data:data.field,
            dataType:'json',
            success:function (data){
                var inst1 = tree.render({
                    elem: '#test1'  //绑定元素
                    ,data: [
                          data
                    ]})
            }
        });
        var table = layui.table;
        table.render({
            elem: '#studentData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/stu/student/toList' //数据接口
            ,page: true //开启分页
            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {field:'studId', title: 'ID', }
                ,{field:'stuName', title: '学生姓名'} //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                ,{field:'sourceType', title: '班级类别'}
                ,{field:'sex', title: '性别'}
                ,{field:'stuPhone', title: '电话号码'}
                ,{field:'stuHisSchool', title: '毕业院校'}
            ]]
        });
    });
</script>
</html>
