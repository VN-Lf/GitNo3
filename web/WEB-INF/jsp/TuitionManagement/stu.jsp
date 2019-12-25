<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/23
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div class="layui-inline" style="margin-bottom: 15px;">
        <label class="layui-form-label">班级</label>
        <div class="layui-input-inline" style="width:100px">
            <select name="class" id="class"  lay-filter="classFilter" lay-search="">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-inline" style="margin-bottom: 15px;">
        <label class="layui-form-label" style="color: black">学生</label>
        <div class="layui-input-inline" style="width:100px">
            <select name="student" id="student" lay-filter="studentFilter" lay-search="">
                <option value=""></option>
            </select>
        </div>
    </div>
</body>
<script>
    layui.use('layer', function(){
        var layer = layui.layer;

        function getC() {
            $.ajax({
                url: '${pageContext.request.contextPath}/finance/getC',
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    $.each(data, function (index, item) {
                        $('#class').append(new Option(item.className, item.classId));// 下拉菜单里添加元素
                    });
                    layui.form.render("select");//重新渲染 固定写法
                }
            });
        };
// 得到房门号
        function getS(data) {
            var params={
                class:data.value
            }
            //检查项目添加到下拉框中
            $.ajax({
                url:'${pageContext.request.contextPath}/finance/getS',
                dataType: 'json',
                data : JSON.stringify(params),
                contentType: "application/json",
                type: 'post',
                success: function (data) {
                    $("#student").empty();//清空下拉框的值
                    $.each(data, function (index, item) {
                        $('#student').append(new Option(item.stuName, item.studId));// 下拉菜单里添加元素
                    });
                    layui.form.render("select");//重新渲染 固定写法
                }
            });
        };
// 联动
        layui.use('form', function(){
            form.on('select(classFilter)', function(data){
                this.getS(data);
            });
        });
    });
</script>
</html>
