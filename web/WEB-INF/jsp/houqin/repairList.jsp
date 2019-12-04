<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/4
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../index.jsp"%>
<html>
<head>
    <title>报修列表</title>
</head>
<body>
    <table id="demo" lay-filter="test"></table>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '${pageContext.request.contextPath}/houqin/repairList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'equipmentId', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'equipmentType', title: '保修事项', width:100}
                ,{field: 'status', title: '修理状态', width:80}
                ,{field: 'classes', title: '班级', width:100}
                ,{field: 'student', title: '学生', width:100}
                ,{field: 'remark', title: '备注', width:100}
                ,{field: 'userType', title: '报修身份', width:100}
                ,{field: 'startTime', title: '保修时间', width:177, sort: true}
                ,{field: 'eedTime', title: '完成时间', width: 177, sort: true}
            ]]
        });

    });
</script>
</html>
