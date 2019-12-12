<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2 align="center">审核请假申请</h2>
<hr/>
<form action="${pageContext.request.contextPath}/act/complete" theme="simple" method="post">
    <input type="hidden" name="jobId" value="${job.jobId}"/>
    <input type="hidden" name="taskId" value="${taskId}"/>
    <table width="90%" cellspacing="1" bgcolor="#6495ED">
        <tr>
            <td align="right">请假人</td>
            <td>${job.userId}</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假天数：</td>
            <td >${job.day}</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">填单时间：</td>
            <td >${job.jobDate} </td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假事由：</td>
            <td >${job.remark}</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">是否批准：</td>
            <td >
                <select name="flow">
                    <option value="批准">批准</option>
                    <option value="拒绝">拒绝</option>
                </select>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="right">备注：</td>
            <td ><textarea name="comment"></textarea></td>
        </tr>
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <input type="submit" value="审批">
            </td>
        </tr>
    </table>
</form>

<hr/>
<table width="90%" cellspacing="1" bgcolor="#6495ED">
    <tr bgcolor="#2F4F4F">
        <th colspan="2"><font color="white">历史审批信息</font></th>
    </tr>
    <tr bgcolor="#2F4F4F">
        <th><font color="white">ID</font></th>
        <th><font color="white">审批时间</font></th>
        <th><font color="white">审批人</font></th>
        <th><font color="white">批注内容</font></th>
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
            <td>${t.id }</td>
            <td>${t.time} </td>
            <td>${t.userId }</td>
            <td>${t.fullMessage }</td>
        </tr>
    </c:forEach>
</c:if>
</table>
</body>
</html>
