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
    <title>学生请假详情</title>
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
            ,url: '${pageContext.request.contextPath}/System/stuleadatalist?id='+${id} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'stuName', title: '学生姓名', sort: true}
                ,{field: 'day', title: '请假天数'}
                ,{field: 'goDate', title: '请假时间', sort: true}
                ,{field: 'endDate', title: '结束时间'}
                ,{field: 'remark', title: '说明'}
                ,{field: 'processFlag', title: '状态',templet:function (data) {
                        if(data.processFlag == 1){
                            return '审批中'
                        }else {
                            return '已完成'
                        }}}
            ]]
        });
    });
</script>
</html>
