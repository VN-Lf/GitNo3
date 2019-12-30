<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.nothing.vo.Email.Email" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/15
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include  file="index.jsp"%>
<html>
<head>
    <title>查看Email界面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div>
    <div style="width: 600px;margin: 0 auto">
        <h1 style="text-align: center;">标题:${emalilist.topic}</h1>
        <h3 style="text-align: right;">发送人：${emalilist.empName}</h3>
        <textarea readonly style="width: 100%;height: 500px;margin-top:30px;background-color: transparent;overflow:hidden;resize:none;outline: none;">
            ${emalilist.content}
        </textarea>
        <h3 style="text-align: right;margin-top: 30px">发送时间：${emalilist.sendtime}</h3>
    </div>
</div>
</body>
</html>