<%@ page import="com.nothing.vo.emp.Emp" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/19
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<% Emp use = (Emp) session.getAttribute("empId");%>
<form action="${pageContext.request.contextPath}/apply" theme="simple" method="post">
    <input type="hidden" name="jobName" value="请假单"/>
    <input type="hidden" name="userId" value="<%=use.getEmpId()%>"/>
    <input type="hidden" name="dept" value="<%=use.getEmpDeptId()%>"/>
    <input type="hidden" name="jobType" value="empact"/>
    <table width="90%" cellspacing="1" bgcolor="#6495ED">
        <tr bgcolor="white">
            <td style="width: 700px" align="right">请假天数：</td>
            <td ><input type="text" name="day"/></td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假事由：</td>
            <td><input type="text" name="remark"/></td>
        </tr>
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <input type="submit" value="保存">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
