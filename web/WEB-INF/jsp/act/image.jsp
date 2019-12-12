<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>查看图片</title>
</head>
<body>
<!-- 1.根据流程定义的ID和名字获取到规则流程图 -->
<!--top: 12px;left: 450px">-->
<img style="position: absolute;top: 0px;left: 0px;" src="${pageContext.request.contextPath }/viewProcessImage?did=${pd.deploymentId}&imageName=${pd.diagramResourceName}">

<!-- 2.根据当前活动的坐标，动态绘制DIV -->
<c:forEach items="${mapList}" var="d">
    <div style="position: absolute;border:2px solid red;top:${d.y-2}px;left: ${d.x-2}px;width: ${d.width}px;height:${d.height}px;"></div>
</c:forEach>
</body>
</html>
