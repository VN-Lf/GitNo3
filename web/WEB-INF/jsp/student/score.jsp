<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/16
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>考试成绩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<table id="demo" lay-filter="test">

</table>

<!----><!---->
<!--考试成绩表单-->
<form  class="layui-form" id="addTextForm" style="display:none;height: auto;width: 600px" method="post" action="${pageContext.request.contextPath}/sco/toScoreMa" target="_self">

    <div class="layui-form-item">
        <label class="layui-form-label" style="width:100px">班级名</label>
        <div class="layui-input-block">
            <select name="classId" lay-verify="required" placeholder=" " id="classId">
                <option></option>
                <c:forEach items="${classList}" var="stuClass">
                    <option value="${stuClass.classId}">${stuClass.className}</option>
                </c:forEach>
            </select>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">课程名称</label>
        <div class="layui-input-block">
            <select name="courseId" lay-verify="required" placeholder=" " id="courseId">
                <option></option>
                <c:forEach items="${courseList}" var="course">
                    <option value="${course.courseId}">${course.courseName}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">考试类别</label>
        <div class="layui-input-block">
            <select name="testType" lay-verify="required" placeholder=" " id="testType">
                <option></option>
                        <option value="1">笔试</option>
                        <option value="2">机试</option>
                        <option value="3">面试</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">学期</label>
        <div class="layui-input-block">
            <select name="termId" lay-verify="required" placeholder=" " id="termId">
                <option> </option>
                <c:forEach items="${termList}" var="term">
                    <option value="${term.termId}">${term.termName}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">考试时间</label>
        <div class="layui-input-block">
            <input id="testDH" type="text" name="testDH" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit type="submit">确定</button>
        </div>
    </div>
</form>
</body>

<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>

<script>
    layui.use(['table','form','tree'], function(){
        var table = layui.table;
        var openStuAc;
        table.render({
            elem: '#demo'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/sco/main/toList' //数据接口
            ,page: true //开启分页
            ,title: '全部成绩'
            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {type:'checkbox'}//复选框
                ,{field:'scoreId', title: 'Id'}
                ,{field:'sName', title: '学生名字'}
                 //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                ,{field:'score', title: '成绩'}
                ,{field:'bukao', title: '补考成绩'}
                ,{field:'cName', title: '课程'}
                ,{field:'className', title: '班级'}
                ,{field:'tName', title: '学期'}
                ,{field:'scoreTime', title: '考试时间', templet:function (row){
                        return createTime(row.scoreTime);
                    }
                }
                ,{field:'eName', title: '录入教师'}
            ]]
        });

        //未分配班级学生头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case'isSelect':
                        var stuSelectName = $('input[name="stuSelectName"]').val();
                        var stuSelectCla = $('#stuSelectCla').val();
                        var stuSelectCour  = $('#stuSelectCour').val();
                        var stuSelectTerm = $('#stuSelectTerm').val();
                    table.reload('demo',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: '${pageContext.request.contextPath}/sco/scoCon'
                        , method:'POST'
                        ,where:{
                            stuSelectName:stuSelectName,
                            stuSelectCla:stuSelectCla,
                            stuSelectCour:stuSelectCour,
                            stuSelectTerm:stuSelectTerm
                        }
                    });
                    break;
                case 'isDel':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].scoreId+",";
                        }
                        layer.confirm('确定所选？', {icon: 3, title: '提示信息'},function (index){
                            $.post('${pageContext.request.contextPath}/sco/score/del',{
                                id:employeesId,
                            },function(data){
                                table.reload("demo")
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的的成绩');
                    };
                    break;
                <!--新增成绩-->
                case 'isAddText':
                    openStuAc=  layer.open({
                        type: 1,
                        title: "录入成绩",
                        area: ['700px', '400px'],
                        content: $("#addTextForm"),
                        closeBtn: 1,
                        success: function (layero, index){

                        }
                    });
                    break;
            };
        });

        var form = layui.form;
        //监听提交
        laydate.render({
            elem: '#testDH' //指定元素o
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
    <div>
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-s layui-btn-warm" lay-event="isAddText">批量录入</button>
        <button class="layui-btn  layui-btn-warm" lay-event="isDel">批量删除</button>
    </div>

        <div style="float: left;height:10px;margin-top:-40px;margin-left:300px">
            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">学生姓名</label>
                <div class="layui-input-block">
                    <input id="stuSelectName" type="text" name="stuSelectName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">班级</label>
                <div class="layui-input-block">
                    <select name="stuSelectCla" lay-verify="required" placeholder=" " id="stuSelectCla">
                        <option> </option>
                        <c:forEach items="${classList}" var="stuClass">
                            <option>${stuClass.className}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">课程</label>
                <div class="layui-input-block">
                    <select name="stuSelectCour" lay-verify="required" placeholder=" " id="stuSelectCour">
                        <option> </option>
                        <c:forEach items="${courseList}" var="course">
                            <option>${course.courseName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">学期</label>
                <div class="layui-input-block">
                    <select name="stuSelectTerm" lay-verify="required" placeholder=" " id="stuSelectTerm">
                        <option> </option>
                        <c:forEach items="${termList}" var="term">
                            <option>${term.termName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <button class="layui-btn layui-btn-s" lay-event="isSelect" style="margin-left: 30px">条件查询</button>
        </div>
    </div>
</script>
</html>
