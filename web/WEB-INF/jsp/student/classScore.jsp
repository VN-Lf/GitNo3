<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/16
  Time: 19:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>录入成绩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<table id="demo" lay-filter="test">

</table>
</body>
<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>


    <script>
        layui.use(['table','form','tree'], function(){
            var table = layui.table;
            var openStuAc;
            var tableDemo;
            tableDemo = table.render({
                elem: '#demo'
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                ,url: '${pageContext.request.contextPath}/sco/score/classSco?classId='+'${requestScope.cla.classId}' //数据接口
                ,title: '${requestScope.cla.className}考试成绩'
                ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                ,cols: [[
                    {type:'checkbox'}//复选框
                    ,{field:'studId', title: '学生Id'}
                    ,{field:'stuName', title: '学生姓名'}
                    ,{field:'chengji', title: '成绩', edit: 'text'}
                    ,{field:'chengji2', title: '补考成绩', edit: 'text'}
                ]]
            });


            table.on('toolbar(test)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'yes':
                        console.log(JSON.stringify(table.cache.demo));
                        layer.confirm('确定提交？', {icon: 3, title: '提示信息'},function (index){
                            $.ajax({
                                url:'${pageContext.request.contextPath}/sco/toAddScore',
                                async:true,
                                method:'post',
                                dataType:'text',
                                data:{
                                    tableList:JSON.stringify(table.cache.demo),
                                    classId:'${requestScope.cla.classId}',
                                    testType:'${requestScope.studentScore.testType}',
                                    termId:'${requestScope.studentScore.termId}',
                                    testDH:'${requestScope.time}',
                                    courseId:'${requestScope.studentScore.courseId}'
                                },
                                success:function(data){
                                    window.open("${pageContext.request.contextPath}/sco/main","_self");
                                }
                            });
                        });
                     break;
                    case 'return':
                        window.open("${pageContext.request.contextPath}/sco/main","_self");
                        break;
                };
            });

            //监听单元格编辑
           /* table.on('edit(test)', function(obj){
                var value = obj.value //得到修改后的值
                    ,data = obj.data //得到所在行所有键值
                    ,field = obj.field; //得到更改的字段名
                layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
            });*/
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
            <label class="layui-form-label" style="width:100px"><h3>${requestScope.courseList.courseName}</h3></label>
        </div>
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px"><h3>${requestScope.term.termName}</h3></label>
        </div>
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px"><h3>${requestScope.cla.className}</h3></label>
        </div>
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:300px"><h3>${requestScope.time}</h3></label>
        </div>
        <div class="layui-form-item" style="display: inline-block">
        <label class="layui-form-label" style="width:100px">
            <c:if test="${requestScope.studentScore.testType==1}">
                <h3>笔试</h3>
            </c:if>
            <c:if test="${requestScope.studentScore.testType==2}">
                <h3>机试</h3>
            </c:if>
            <c:if test="${requestScope.studentScore.testType==3}">
                <h3>面试</h3>
            </c:if>
        </label>
        </div>
    </div>

    <button class="layui-btn layui-btn-sm" lay-event="yes">保存</button>
    <button class="layui-btn layui-btn-sm" lay-event="return">返回</button>
</script>
</html>
