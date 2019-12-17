<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        table td{
            padding: 5px;
        }
    </style>
</head>
<body>
<h2 align="center" style="background-color: #D0E5F5;margin: 0;padding: 15px">审核请假申请</h2>
<hr/>
<form action="${pageContext.request.contextPath}/complete" theme="simple" method="post">
    <input type="hidden" name="jobId" value="${job.jobId}"/>
    <input type="hidden" name="taskId" value="${taskId}"/>
    <table style="width: 50%;margin: 0 auto" cellspacing="1" bgcolor="#6495ED">
        <tr bgcolor="white">
            <td align="right" style="width: 35%">请假人：</td>
            <td>${job.userId}</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假天数：</td>
            <td>
                <c:if test="${job.day==0}">
                    4小时带薪假
                </c:if>
                <c:if test="${job.day!=0}">
                    ${job.day}天
                </c:if>
            </td>
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
                <select style="width: 70px" name="flow">
                    <option value="批准">批准</option>
                    <option value="拒绝">拒绝</option>
                </select>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 60px">
            <td align="right">备注：</td>
            <td ><textarea style="height: 55px;width: 250px" name="comment"></textarea></td>
        </tr>
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <input style="width: 200px;height: 30px;font-size: 16px;" type="submit" value="审批">
            </td>
        </tr>
    </table>
</form>

<hr/>
<table style="margin: 0 auto;width: 50%" cellspacing="1" bgcolor="#6495ED">
    <tr bgcolor="#D0E5F5">
        <th colspan="4"><h2 style="margin: 0" color="black">审批信息列表</h2></th>
    </tr>
    <tr bgcolor="#D0E5F5">
        <th><font color="black">ID</font></th>
        <th><font color="black">审批时间</font></th>
        <th><font color="black">审批人</font></th>
        <th width="50%"><font color="black">批注内容</font></th>
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
