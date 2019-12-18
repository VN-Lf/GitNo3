<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>历史审核信息</title>
    <%String yangshi = (String) session.getAttribute("color");%>
    <style>
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
<a href="${pageContext.request.contextPath }/myJobList">返回</a>
<table style="margin: 0 auto;width: 60%" cellspacing="1">
    <tr>
        <th colspan="4"><h2 style="margin: 0" color="black">审批信息列表</h2></th>
    </tr>
    <tr>
        <th>ID</th>
        <th>审批时间</th>
        <th>审批人</th>
        <th width="50%">批注内容</th>
    </tr>
<c:if test="${zhi==0}">
    <tr>
        <td colspan="10">
            <h2 align="center" style="margin: 10px">暂无历史审批记录</h2>
        </td>
    </tr>
</c:if>
<c:if test="${zhi==1}">
    <c:forEach items="${commentList}" var="t">
        <tr>
            <td align='center' style="width: 12%">${t.com.id }</td>
            <td align='center' style="width: 24%">${t.sj}</td>
            <td align='center' style="width: 24%">${t.com.userId}</td>
            <td>${t.com.fullMessage }</td>
        </tr>
    </c:forEach>
</c:if>
</table>
</body>
</html>
