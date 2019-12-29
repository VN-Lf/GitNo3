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
    <title>学生成绩</title>
    <jsp:include page="../../../index.jsp"></jsp:include>
    <%String num = (String) request.getAttribute("num");%>
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
            ,url: '${pageContext.request.contextPath}/scourse/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',width:0}//复选框
                ,{field: 'scoreId', title: '编号', width:70 }
                ,{field: 'scoreTime', title: '考试时间  ', width:150,templet:function (row){
                        return createTimes(row.scoreTime);
                    }}
                ,{field: 'score', title: '学生成绩 ', width:100}
                ,{field: 'bukao', title: '补考成绩', width:100}
                ,{field: 'courseName', title: '课程', width:100}
                ,{field: 'testType', title: '类型',width:100,templet:function (row){
                       if(row.testType == 1){
                           return"笔试"
                       }else if(row.testType == 2){
                           return"机试"
                       }else if(row.testType == 3){
                           return"模拟面试"
                       }
                    }}
                ,{field: 'termName', title: '学期  ', width:100}
                ,{field: 'stuName', title: '学生姓名  ', width:100}
                ,{field: 'empName', title: '录入人员  ', width:100}
                ,{field: 'remark', title: '备注  '}
            ]]
        });
    });

    //时间修改方法
    function createTimes(v){
        var date = new Date(v);
        var y = date.getHours();
        var m = date.getMinutes();
        m = m<10?'0'+m:m;
        var d = date.getSeconds();
        d = d<10?("0"+d):d;
        var str = y+"："+m+"："+d;
        return str;
    }
</script>

</body>
</html>
