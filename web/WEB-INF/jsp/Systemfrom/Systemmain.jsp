<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/23
  Time: 8:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>系统报表</title>
</head>
<body>
    <div style="margin-top: 50px">
        <table style="text-align: center;">
            <tr>
                <td>
                    <a href="${pageContext.request.contextPath}/System/tokaohe" style="text-decoration: none;color: black">
                        <img src="${pageContext.request.contextPath}/upload/20191216/0e67ba19e87c84788718bf62.jpg" style="width: 200px;height: 150px;margin: 30px 0px 0px 130px">
                        <h3 style="margin-left: 130px">日常考核统计</h3>
                    </a>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/System/toleave" style="text-decoration: none;color: black">
                        <img src="${pageContext.request.contextPath}/upload/20191216/0e67ba19e87c84788718bf62.jpg" style="width: 200px;height: 150px;margin: 30px 0px 0px 150px">
                        <h3 style="margin-left: 130px">员工请假统计</h3>
                    </a>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/System/toclock" style="text-decoration: none;color: black">
                        <img src="${pageContext.request.contextPath}/upload/20191216/0e67ba19e87c84788718bf62.jpg" style="width: 200px;height: 150px;margin: 30px 0px 0px 150px">
                        <h3 style="margin-left: 130px">未打卡说明</h3>
                    </a>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/System/todorm" style="text-decoration: none;color: black">
                        <img src="${pageContext.request.contextPath}/upload/20191216/0e67ba19e87c84788718bf62.jpg" style="width: 200px;height: 150px;margin: 30px 0px 0px 150px">
                        <h3 style="margin-left: 130px">宿舍统计报表</h3>
                    </a>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="${pageContext.request.contextPath}/System/tostuleave" style="text-decoration: none;color: black">
                        <img src="${pageContext.request.contextPath}/upload/20191216/0e67ba19e87c84788718bf62.jpg" style="width: 200px;height: 150px;margin: 30px 0px 0px 130px">
                        <h3 style="margin-left: 130px">学生请假统计</h3>
                    </a>
                </td>
            </tr>

        </table>
    </div>
</body>
</html>
