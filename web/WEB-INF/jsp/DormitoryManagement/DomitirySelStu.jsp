<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <title>查看宿舍学生</title>

    <%List<Map> list = (List) request.getAttribute("dlist");%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;">
        <button type="button"  onclick="close1()" style="width: 80px; height: 40px">返回</button>
        <table id="demo" lay-filter="test"  ></table>
    </div>

</div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    //解决jquery包冲突
    jQuery.noConflict();
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/dormitory/stulist/${deptname}' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'HourName', title: '宿舍房号', width:80, sort: true}
                ,{field: 'stuName', title: '学生姓名', width:120, sort: true}
                ,{field: 'stuPhone', title: '学生号码', width:200}
            ]]
        });

    });
    function close1 () {
        window.location.href="<%=request.getContextPath()%>/dormitory/todormitory";
    }
</script>
</body>
</html>
