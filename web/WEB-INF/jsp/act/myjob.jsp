<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/19
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的申请单</title>
    <script src="http://localhost:8888/jquery.js"></script>
    <style>
        table a{
            color: black;
            text-decoration:none;
            font-size: 15px;
            transition: 0.25s;
        }
    </style>
</head>
<body>
<table style="width: 80%;margin: 0 auto" cellspacing="1" bgcolor="#6495ED">
    <tr bgcolor="#D0E5F5">
        <th colspan="9"><h2 style="margin: 10px" color="black">我的申请单</h2></th>
    </tr>
    <tr bgcolor="#D0E5F5">
        <th><font color="black">单据编号</font></th>
        <th><font color="black">单据名称</font></th>
        <th><font color="black">请假天数</font></th>
        <th><font color="black">申请人</font></th>
        <th><font color="black">申请时间</font></th>
        <th><font color="black">审批状态</font></th>
        <th width="30%"><font color="black">申请说明</font></th>
        <th><font color="black">查看批注</font></th>
        <th>办理进度</th>
    </tr>
    <c:if test="${zhi==0}">
        <tr bgcolor="white">
            <td colspan="10">
                <h2 align="center" style="margin: 10px">暂无上传过申请单</h2>
            </td>
        </tr>
    </c:if>
    <c:if test="${zhi==1}">
        <c:forEach items="${jobList}" var="t">
            <tr bgcolor="white">
                <td>${t.jobId }</td>
                <td>${t.jobName }</td>
                <td>${t.day }</td>
                <td>${t.userId }</td>
                <td>${t.jobDate}</td>
                <td>
                    <c:if test="${t.processFlag==1}">
                        <font color="fcaf17">审批中</font>
                    </c:if>
                    <c:if test="${t.processFlag==2}">
                        <font color="green">审批通过</font>
                    </c:if>
                    <c:if test="${t.processFlag==3}">
                        <font color="red">审批未通过</font>
                    </c:if>
                </td>
                <td>${t.remark }</td>
                <td><a href="${pageContext.request.contextPath}/lookComment?jobId=${t.jobId}">查看批注</a></td>
                <td><a href="${pageContext.request.contextPath}/lookMyJob?jobId=${t.jobId}" target="_blank">办理进度</a></td>

            </tr>
        </c:forEach>
    </c:if>

    <tr bgcolor="#D0E5F5">
        <td colspan="9" style="padding: 5px" align="center">
            <a id="abt" href="${pageContext.request.contextPath}/addjia">>  申请假期  <</a>
        </td>
    </tr>
</table>
<script>
    document.getElementById("abt").onmouseenter=function(){
        $("#abt").css("color","blue");
        document.getElementById("abt").innerText =">申请假期<";
    };
    document.getElementById("abt").onmouseleave=function(){
        $("#abt").css("color","black");
        document.getElementById("abt").innerText =">  申请假期  <";
    };
</script>
</body>
</html>
