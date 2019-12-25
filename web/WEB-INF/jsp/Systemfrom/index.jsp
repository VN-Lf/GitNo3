<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/2
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type ="text/javascript" src="<%=request.getContextPath()%>/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type ="text/javascript" src="<%=request.getContextPath()%>/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type ="text/javascript" src="<%=request.getContextPath()%>/jquery-easyui-1.3.0/locale/easyui-lang-zh_CN.js"></script>

<%String yangshi = (String) session.getAttribute("color");%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/jquery-easyui-1.3.0/themes/<%=yangshi%>/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jquery-easyui-1.3.0/themes/icon.css"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="<%=request.getContextPath()%>/jquery.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css"/>

<script  type="text/javascript" src="${pageContext.request.contextPath}/echarts.min.js"></script>

<style type="text/css">




















































    .layui-table-tool {
        z-index: 0;
    }
    .layui-table-box{
        z-index: 0;
    }
</style>
<script>
    //解决jquery包冲突
    jQuery.noConflict();
</script>