<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/24
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>员工考核详情</title>
</head>
<body>
<div data-options="region:'center'">
    <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
</div>
</body>
<script type="text/javascript">
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/System/kaodatalist?id='+${id} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'aduitName', title: '考核内容', sort: true}
                ,{field: 'empName', title: '员工姓名'}
                ,{field: 'Scores', title: '考核分数', sort: true}
                ,{field: 'auditDate', title: '考核时间'}
                ,{field: 'auditPerson', title: '录入人员'}
                ,{field: 'Remark', title: '说明'}
            ]]
        });
    });
</script>
</html>
