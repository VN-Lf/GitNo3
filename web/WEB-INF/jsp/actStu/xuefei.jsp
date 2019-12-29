<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/27
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        th{
             padding: 10px 0;
         }
        td{
            text-align: center;
            padding: 10px 0;
        }
    </style>
</head>
<body>
    <table border="1" cellspacing="0" cellpadding="0" style="width: 80%;">
        <thead>
            <tr>
                <th>编号</th>
                <th>学生</th>
                <th>时间</th>
                <th>学期</th>
                <th>支付方式</th>
                <th>缴费项</th>
                <th>金额</th>
            </tr>
        </thead>
        <c:forEach var="list" items="${fl}">
            <tr>
                <td>${list.financeId}</td>
                <td>${list.stuName}</td>
                <td>${list.financedate}</td>
                <td>${list.termName}</td>
                <td>${list.receipt}</td>
                <td>${list.financeId}</td>
                <td>${list.factMoney}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
