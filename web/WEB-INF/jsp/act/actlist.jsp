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
<div style="width: 250px;height: 50px;margin-left: 10%">
    <form action="${pageContext.request.contextPath}/upact" method="post" enctype="multipart/form-data">
        <input type="button" onclick="HuanTou();" id="ks" value="上传一个新流程" />
        <input type="file" name="pdFile" id="up" style="height: 0;width: 0" onchange="upload()"/>
        <input type="submit"  id="yes"  style="display: none;float: left;margin-right: 10px;" value="确认上传"/>
    </form>
</div>

<table style="width:80%;margin: 0 auto" cellspacing="1">
    <tr>
        <th colspan="6"><h2 style="margin: 10px">流程定义列表</h2></th>
    </tr>
    <c:if test="${zhi==0}">
        <tr>
            <td colspan="10">
                <h2 align="center" style="margin: 10px">还没有上传过流程</h2>
            </td>
        </tr>
    </c:if>
    <c:if test="${zhi==1}">
        <tr>
            <th>流程ID</th>
            <th>流程名称</th>
            <th>流程KEY</th>
            <th>删除流程</th>
            <th>查看流程图</th>
            <th>下载流程图</th>
        </tr>
        <c:forEach items="${processList}" var="pd">
            <tr>
                <td align="center">${pd.id}</td>
                <td align="center">${pd.name}</td>
                <td align="center">${pd.key}</td>
                <td align="center">
                    <a href="${pageContext.request.contextPath }/delProgressDefine?id=${pd.deploymentId}" onclick="return confirm('确认删除?')">删除流程</a>
                </td>
                <td align="center">
                    <a href="${pageContext.request.contextPath }/viewProcessImage?did=${pd.deploymentId}&imageName=${pd.diagramResourceName}">查看流程图</a>
                </td>
                <td align="center">
                    <a href="${pageContext.request.contextPath }/toExport?id=${pd.id}">下载流程图</a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
</table>
<script>
    var pand = 0;
    function HuanTou() {
        if(pand == 0){
            var it=document.getElementById("up");
            it.click();
            pand = 1;
        }else if(pand == 1){
            document.getElementById("ks").value="上传一个新流程";
            document.getElementById("yes").style.display="none";
            pand = 0;
        }
    }
    function upload() {
        var _name, _fileName, personsFile;
        personsFile = document.getElementById("up");
        _name = personsFile.value;
        _fileName = _name.substring(_name.lastIndexOf(".") + 1).toLowerCase();
        if (_fileName != "zip") {
            document.getElementById("yes").style.display="none";
            pand = 0;
            alert("上传格式不正确，请重新上传");
        } else {
            document.getElementById("ks").value="取消";
            document.getElementById("yes").style.display="block";
        }
    }
</script>
</body>
</html>
