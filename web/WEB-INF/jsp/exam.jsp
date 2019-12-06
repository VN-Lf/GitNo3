<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <title>table模块快速使用</title>
</head>
<body>
<h1>6666666666</h1>
<table id="demo" lay-filter="test"></table>

<script>
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '${pageContext.request.contextPath}/exam/examlist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'aduitModelid', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'Remark', title: '考核内容', width:80}
                ,{field: 'Scores', title: '考核分数', width:80, sort: true}
                ,{field: 'Depid', title: '部门id', width:80}
                ,{field: 'aduitName', title: '说明', width: 177}
            ]]
        });

    });
</script>
</body>
</html>
