<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/14
  Time: 21:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<div class="layui-row">
</div>
<table id="demo" lay-filter="test">

</table>
</div>

<div class="layui-row" style="height:45%">

</div>


</body>
<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>


<script>
    layui.use(['table','form','tree'], function(){
        var table = layui.table;
        table.render({
            elem: '#test'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/stu/course/toList' //数据接口
            ,page: true //开启分页
            ,title: '待分配学生'
            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {type:'checkbox'}//复选框
                ,{field:'courseId', title: 'ID',}
                ,{field:'courseName', title: '课程名'} //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                ,{field:'courseIsNes', title: '是否必修'}
                ,{field:'courseTypeId', title: '课程类别'}
                ,{field:'stuPhone', title: '电话号码'}
                ,{field:'stuHisSchool', title: '毕业院校'}
            ]]
        });

        //未分配班级学生头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDel':
                    var checkStatus = table.checkStatus('test'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].studId+",";
                        }
                        layer.confirm('确定所选？', {icon: 3, title: '提示信息'},function (index){
                            $.post('${pageContext.request.contextPath}/stu/toClassAddStu',{
                                studIds:employeesId,
                                cid :cid
                            },function(data){
                                table.reload("test")
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要添加的学生');
                    };
                    break;
                <!--新增成绩-->
                case 'isAddTest':
                    layer.open({
                        type: 1,
                        title: "录入成绩",
                        area: ['700px', '400px'],
                        content: $("#addTextForm"),
                        closeBtn: 1,
                        success: function (layero, index){
                            document.getElementById("addTextForm").reset();
                        }
                    });
                    break;
            };
        });

        var form = layui.form;
        //监听提交
        form.on('submit(formDemoSco)',function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/stu/toScore',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){

                }
            });
            layer.close(openStuAc);
            return false;
        });

        laydate.render({
            elem: '#testDH' //指定元素o
        });

    });
</script>

<script type="text/html" id="toolbarDemo2">
    <div class="layui-btn-container">
        <button class="layui-btn  layui-btn-warm" lay-event="delFal">批量删除</button>

        <div style="float: left;height: 20px;margin-top:-5px">
            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">学生姓名</label>
                <div class="layui-input-block">
                    <input id="stuSelectName" type="text" name="stuSelectName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>


        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">所在班级</label>
            <div class="layui-input-block">
                <select name="stuSelectCla" lay-verify="required" placeholder=" " id="stuSelectCla">
                    <option></option>
                    <c:forEach items="${classList}" var="stuClass">
                        <option>${stuClass.className}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <button class="layui-btn layui-btn-s layui-btn-warm" lay-event="isAddText">新增成绩</button>
        <button class="layui-btn layui-btn-s layui-btn-warm" lay-event="isSelectText">查询成绩</button>
    </div>
</script>


</html>
