<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>任务</title>

    <%String yangshi = (String) session.getAttribute("color");%>
    <style>
        table a{
        <%if("dark-hive".equals(yangshi)){%>
            color: white;
        <%}else {%>
            color: black;
        <%}%>
            text-decoration:none;
            font-size: 15px;
            transition: 0.25s;
        }
        table tr{
        <%if("dark-hive".equals(yangshi)){%>
            background-color: black;
            color: white;
        <%}else {%>
            background-color: #f1f1f1;
            color: black;
        <%}%>
        }
        table th{
            padding: 10px 5px;
        }
        table a:hover{
        <%if("dark-hive".equals(yangshi)){%>
            color: yellow;
        <%}else {%>
            color: blue;
        <%}%>
        }
        table tr:hover{
        <%if("dark-hive".equals(yangshi)){%>
            background-color: #0972a5;
        <%}else {%>
            background-color: #D0E5F5;
        <%}%>
        }
    </style>
</head>
<body>
<table style="width: 60%;margin: 0 auto" cellspacing="1">
    <tr>
        <th colspan="6"><h2 style="margin: 10px" color="black">我的任务列表</h2></th>
    </tr>
    <tr>
        <th>任务ID</th>
        <th>任务名称</th>
        <th>任务执行人</th>
        <th style="width: 34%">任务创建时间</th>
        <th colspan="2">操作</th>
    </tr>
    <c:if test="${zhi==0}">
        <tr>
            <td colspan="10" style="height: 220px">
                <h2 align="center" style="margin: 10px">暂无需处理任务</h2>
            </td>
        </tr>
    </c:if>
    <c:if test="${zhi==1}">
        <c:forEach items="${taskList}" var="t">
            <tr>
                <td align='center'>${t.com.id}</td>
                <td align='center'>${t.com.name}</td>
                <td align='center'>${t.com.assignee }</td>
                <td align='center'>${t.sj}</td>
                <td align='center'><a href="${pageContext.request.contextPath}/taskDetail?taskId=${t.com.id}&instId=${t.com.processInstanceId}">查看详情</a></td>
                <td align='center'><a href="${pageContext.request.contextPath}/lookMyJob?instId=${t.com.processInstanceId}" target="_blank">办理进度</a></td>
            </tr>
        </c:forEach>
    </c:if>
    <tr>
        <td colspan="6"  align='center'>若想请假请前往 -个人中心-</td>
    </tr>
</table>
</body>
</html>
