<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/11
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>流程列表</title>
</head>
<body>
<div style="width: 150px;height: 50px;margin-left: 10%">
    <form action="${pageContext.request.contextPath}/upact" method="post" enctype="multipart/form-data">
        <input type="button" onclick="HuanTou();" value="上传一个新流程" />
        <input type="file" name="pdFile" id="up" style="height: 0;width: 0" onchange="upload()"/>
        <input type="submit"  id="yes"  style="display: none" value="确认上传"/>
    </form>
</div>

<table style="width:80%;margin: 0 auto" cellspacing="1" bgcolor="#6495ED">
    <tr bgcolor="#D0E5F5">
        <th colspan="6"><h2 style="margin: 10px" color="black">流程定义列表</h2></th>
    </tr>
    <c:if test="${zhi==0}">
        <tr bgcolor="white">
            <td colspan="10">
                <h2 align="center" style="margin: 10px">还没有上传过流程</h2>
            </td>
        </tr>
    </c:if>
    <c:if test="${zhi==1}">
        <tr bgcolor="#D0E5F5">
            <th><font color="black">流程ID</font></th>
            <th><font color="black">流程名称</font></th>
            <th><font color="black">流程KEY</font></th>
            <th><font color="black">删除流程</font></th>
            <th><font color="black">查看流程图</font></th>
            <th><font color="black">下载流程图</font></th>
        </tr>
        <c:forEach items="${processList}" var="pd">
            <tr bgcolor="white">
                <td>${pd.id }</td>
                <td>${pd.name }</td>
                <td>${pd.key }</td>
                <td><a href="${pageContext.request.contextPath }/delProgressDefine?id=${pd.deploymentId}" onclick="return confirm('确认删除?')">删除流程</a></td>
                <td><a href="${pageContext.request.contextPath }/viewProcessImage?did=${pd.deploymentId}&imageName=${pd.diagramResourceName}">查看流程图</a>
                <td><a href="${pageContext.request.contextPath }/toExport?id=${pd.id}">下载流程图</a>
                </td>
            </tr>

        </c:forEach>
    </c:if>
</table>
<script>

    function HuanTou() {
        var it=document.getElementById("up");
        it.click();
    }
    function upload() {
        var _name, _fileName, personsFile;
        personsFile = document.getElementById("up");
        _name = personsFile.value;
        _fileName = _name.substring(_name.lastIndexOf(".") + 1).toLowerCase();
        if (_fileName != ".zip") {
            document.getElementById("yes").style.display="none";
            alert("上传格式不正确，请重新上传");
        } else {
            document.getElementById("yes").style.display="block";
        }
    }
</script>
</body>
</html>
