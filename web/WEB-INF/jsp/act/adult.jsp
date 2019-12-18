<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>sdfa</title>
    <%String yangshi = (String) session.getAttribute("color");%>
    <style>
        table td{
            padding: 5px;
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
    </style>
</head>
<body>
<h2 align="center" style="background-color: #D0E5F5;margin: 0;padding: 15px">审核员工请假单</h2>
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
            <td align="right">${job.goDate}</td>
            <td>:假期开始时间</td>
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
            <td align="right">${job.endDate}</td>
            <td >:假期结束时间</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假事由：</td>
            <td >${job.remark}</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">填单时间：</td>
            <td >${job.jobDate}</td>
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
            <td align="right">批注：</td>
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
        <th colspan="4"><h2 style="margin: 0">审批信息列表</h2></th>
    </tr>
    <tr bgcolor="#D0E5F5">
        <th>ID</th>
        <th>审批时间</th>
        <th>审批人</th>
        <th width="50%">批注内容</th>
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
