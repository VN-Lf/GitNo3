<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <title>答辩成绩</title>
    <jsp:include page="../../../index.jsp"></jsp:include>
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <%--信息显示表--%>
        <table id="demo" lay-filter="test"  ></table>
    </div>

</div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>

    jQuery.noConflict();
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,url: '${pageContext.request.contextPath}/Stureply/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',width:0}//复选框
                ,{field: 'stuReplyId', title: '编号', width:50, }
                ,{field: 'stuName', title: '姓名  ', width:150}
                ,{field: 'projectName', title: '答辩项目 '}
                ,{field: 'empName', title: '打分老师', width:100}
                ,{field: 'score1', title: '功能完善', width:100}
                ,{field: 'Score2', title: '技术难度',width:100}
                ,{field: 'Score3', title: '界面完美  ', width:100}
                ,{field: 'Score4', title: '回答问题  ', width:100}
                ,{field: 'Score5', title: '演示方法  ', width:100}
                ,{field: 'Score6', title: '语言表达  ', width:100}
                ,{field: 'Score7', title: '总分  ', width:100}
                ,{field: 'replyScoreRemark', title: '备注  ', width:100}
            ]]
        });
    });

</script>

</body>
</html>
