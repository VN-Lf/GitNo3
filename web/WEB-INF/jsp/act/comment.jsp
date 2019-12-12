<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>历史审核信息</title>
</head>
<body>
<a href="${pageContext.request.contextPath }/myJobList">返回</a>
<table style="margin: 0 auto;width: 70%" cellspacing="1" bgcolor="#6495ED">
    <tr bgcolor="#D0E5F5">
        <th colspan="4"><h2 style="margin: 0" color="black">审批信息列表</h2></th>
    </tr>
    <tr bgcolor="#D0E5F5">
        <th><font color="black">ID</font></th>
        <th><font color="black">审批时间</font></th>
        <th><font color="black">审批人</font></th>
        <th><font color="black">批注内容</font></th>
    </tr>
<c:if test="${zhi==0}">
    <tr bgcolor="white">
        <td colspan="10">
            <h2 align="center" style="margin: 10px">暂无历史审批记录</h2>
        </td>
    </tr>
</c:if>
<c:if test="${zhi==1}">
    <c:forEach items="${commentList}" var="t">
        <tr bgcolor="white">
            <td style="width: 12%">${t.com.id }</td>
            <td style="width: 24%">${t.sj}</td>
            <td style="width: 24%">${t.com.userId}</td>
            <td>${t.com.fullMessage }</td>
        </tr>
    </c:forEach>
</c:if>
</table>
</body>
</html>
