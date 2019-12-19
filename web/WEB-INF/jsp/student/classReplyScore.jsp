<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/18
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head><!---->
    <title>录入答辩成绩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<table id="demo" lay-filter="test">

</table>

<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>

</body>
<script>
    layui.use(['table','form','tree'], function(){
        var table = layui.table;
        var openStuAc;
        var tableDemo;
        tableDemo = table.render({
            elem: '#demo'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/sco/reply/classSco?classId='+'${requestScope.cla.classId}' //数据接口
            ,title: '${requestScope.cla.className}答辩成绩'
            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {type:'checkbox'}//复选框
                ,{field:'sid',title:'学生编号'}
                ,{field:'stuName',title:'学生姓名'}
                ,{field:'s1',title:'功能完善50',edit:'text'}
                ,{field:'s2',title:'技术难度10',edit:'text'}
                ,{field:'s3',title:'界面完美10',edit:'text'}
                ,{field:'s4',title:'回答问题10',edit:'text'}
                ,{field:'s5',title:'演示方法10',edit:'text'}
                ,{field:'s6',title:'语言表达10',edit:'text'}
                ,{field:'s7',title:'总分100',edit:'text'}
                ,{field:'rs',title:'备注',edit:'text'}
            ]]
        });

        //未分配班级学生头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'yes':
                    console.log(JSON.stringify(table.cache.demo));
                    layer.confirm('确定提交？', {icon: 3, title: '提示信息'},function (index){
                        $.ajax({
                            url:'${pageContext.request.contextPath}/sco/toAddReplyScore',
                            async:true,
                            method:'post',
                            dataType:'text',
                            data:{
                                tableList:JSON.stringify(table.cache.demo),
                                projectId:${requestScope.pro.projectId}
                            },
                            success:function(data){
                                window.open("${pageContext.request.contextPath}/sco/main","_self");
                            }
                        });
                    });
                    break;
            };
        });

    });
    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var str = y+"-"+m+"-"+d;
        return str;
    }

</script>
<script type="text/html" id="toolbarDemo">
    <div style="float: left;height: 20px;margin-top:-5px;align:center">
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px"><h2>${requestScope.cla.className}</h2></label>
        </div>
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:350px"><h2>${requestScope.pro.proName}项目答辩成绩</h2></label>
        </div>
    </div>
    <button class="layui-btn layui-btn-sm" lay-event="yes">保存</button>
</script>

</html>
