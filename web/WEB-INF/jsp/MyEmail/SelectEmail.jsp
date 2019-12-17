<%@ page import="com.nothing.vo.Email.Email" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/15
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看Email</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <%Email email = (Email) request.getAttribute("emalilist");%>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <div>
            标题：<%=email.getTopic()%>
        </div><br>
        <div>
            内容：<%=email.getContent()%>
        </div><br>
        <div>
            <a href="${pageContext.request.contextPath}/email/toemail"  class="layui-btn layui-bg-blue layui-btn-xs" >返回</a>
        </div>
    </div>
</div>
</body>
</html>
