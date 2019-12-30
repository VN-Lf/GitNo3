<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/26
  Time: 8:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>无权限页面</title>
    <%String yangshi = (String) session.getAttribute("color");%>
    <style>
        body{
        <%if("dark-hive".equals(yangshi)){%>
            color: white;
        <%}else {%>
            color: black;
        <%}%>
        }
    </style>
</head>
<body>
<h1 align="left" style="width: 80%;margin: 50px auto">啊哦 您好像还没有该权限呢</h1>
<h2 align="right" style="width: 80%;margin: 0 auto">请联系你的上级叫ta为您开放吧</h2>
</body>
</html>
