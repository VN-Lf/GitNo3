<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table width="90%" cellspacing="1" bgcolor="#6495ED">
    <tr bgcolor="#D0E5F5">
        <th colspan="6"><h2 style="margin: 10px" color="black">我的任务列表</h2></th>
    </tr>
    <tr bgcolor="#D0E5F5">
        <th>任务ID</th>
        <th>任务名称</th>
        <th>任务执行人</th>
        <th>任务创建时间</th>
        <th>查看详情</th>
        <th>办理进度</th>

    </tr>
    <c:if test="${zhi==0}">
        <tr bgcolor="white">
            <td colspan="10">
                <h2 align="center" style="margin: 10px">暂无需处理任务</h2>
            </td>
        </tr>
    </c:if>
    <c:if test="${zhi==1}">
        <c:forEach items="${taskList}" var="t">
            <tr bgcolor="white">
                <td>${t.id}</td>
                <td>${t.name}</td>
                <td>${t.assignee }</td>
                <td>${t.createTime}</td>
                <td><a href="${pageContext.request.contextPath}/taskDetail?taskId=${t.id}&instId=${t.processInstanceId}">查看详情</a></td>
                <td><a href="${pageContext.request.contextPath}/lookMyJob?instId=${t.processInstanceId}" target="_blank">办理进度</a></td>
            </tr>
        </c:forEach>
    </c:if>
</table>
</body>
</html>
