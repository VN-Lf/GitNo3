<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/11
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head><!----><!---->
    <title>班级管理/</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<style>
    .layui-table-tool {
        position: relative;
        z-index: 890;
        width: 100%;
        min-height: 50px;
        height: 60px;
        line-height: 30px;
        padding: 10px 15px;
        border-width: 0 0 1px;
    }
</style>
<body>
<table id="demo" lay-filter="test"></table>

<form  class="layui-form" id="addClaForm" style="display:none;height: 1000px;width: 800px" method="post">
    <input id="classId" type="hidden" name="classId">

    <div class="layui-form-item">
        <label class="layui-form-label">班级名</label>
        <div class="layui-input-block">
            <input id="className" type="text" name="className" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">班级人数</label>
        <div class="layui-input-block">
            <input id="classCount" type="text" name="classCount" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <input id="classRemark" type="text" name="classRemark" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>


    <label class="layui-form-label" style="width:100px">班主任</label>
    <div class="layui-input-block">
        <select name="classAdviser" lay-verify="required" placeholder=" " id="classAdviser">
            <c:forEach items="${bzrList}" var="bzr">
                <option value="${bzr.empId}">${bzr.names}</option>
            </c:forEach>
        </select>
    </div>

    <label class="layui-form-label" style="width:100px">授课教师</label>
    <div class="layui-input-block">
        <select name="classTeacher" lay-verify="required" placeholder=" " id="classTeacher">
            <c:forEach items="${jsList}" var="js">
                <option value="${js.empId}">${js.names}</option>
            </c:forEach>
        </select>
    </div>


    <label class="layui-form-label" style="width:100px">学期</label>
    <div class="layui-input-block">
        <select name="classTerm" lay-verify="required" placeholder=" " id="classTerm">
            <c:forEach items="${term}" var="te">
                <option value="${te.termId}">${te.termName}</option>
            </c:forEach>
        </select>
    </div>


    <label class="layui-form-label" style="width:100px">学年</label>
    <div class="layui-input-block">
        <select name="classFall" lay-verify="required" placeholder=" " id="classFall">
            <c:forEach items="${fall}" var="fa">
                <option value="${fa.fallId}">${fa.fallLevel}</option>
            </c:forEach>
        </select>
    </div>


    <label class="layui-form-label" style="width:100px">系别</label>
    <div class="layui-input-block">
        <select name="deptId" lay-verify="required" placeholder=" " id="deptId">
            <c:forEach items="${dept}" var="de">
                <option value="${de.deptId}">${de.deptName}</option>
            </c:forEach>
        </select>
    </div>

    <label class="layui-form-label" style="width:100px">班级类型</label>
    <div class="layui-input-block">
        <select name="classType" lay-verify="required" placeholder=" " id="classType">
            <c:forEach items="${classType}" var="ct">
                <option value="${ct.classType}">${ct.classTypeName}</option>
            </c:forEach>
        </select>
    </div>


    <label class="layui-form-label" style="width:100px">专业</label>
    <div class="layui-input-block">
        <select name="MajorId" lay-verify="required" placeholder=" " id="MajorId">
            <c:forEach items="${majorList}" var="ma">
                <option value="${ma.MajorId}">${ma.MajorName}</option>
            </c:forEach>
        </select>
    </div>


    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemoCla">确定</button>
        </div>
    </div>


</form>

</body>

<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>


<script>
    layui.use('table', function(){
        var table = layui.table;
        var tId = layui.table.id;
        var openStuAc;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 400
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/stu/cla/toList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'classId', title: 'ID', width:100}
                ,{field: 'classNo', title: '班级编号', width:100}
                ,{field: 'bzr', title:'班主任', width:80}
                ,{field: 'js', title: '授课教师', width:80}
                ,{field: 'classCount', title: '班级人数', width:80}
                ,{field: 'className', title:'班级名字', width:150}
                ,{field: 'stuAddr', title: '地址', width: 177}
                ,{field: 'className', title:'班级名', width:80}
                ,{field: 'tnames', title: '学期', width:80,}
                ,{field: 'deptName', title: '系别', width:80}
                ,{field: 'fallLevel', title: '学年', width:80}
                ,{field: 'classTypeName', title: '班级类型', width:80}
                ,{field: 'MajorName', title: '专业', width:80}
                ,{width:150, title: '操作',align:'center',fixed: 'right', toolbar: '#barDemo'}
            ]]
        });
        //头部事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].classId+",";
                        }
                        alert(employeesId);
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'},function (index){
                            $.post('${pageContext.request.contextPath}/stu/toDel/cla',{
                                id:employeesId
                            },function(data){
                                table.reload("demo");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    openStuAc =layer.open({
                        type: 1,
                        title:"新增",
                        area:['1000px','800px'],
                        content: $("#addClaForm"),
                        closeBtn :1,
                        success: function(layero, index){
                            $("#classId").val(0);
                        }
                    });
                    break;
                case 'isSelect':
                    var claSelectName = $('#claSelectName').val();
                    var claSelectAdviser = $("#claSelectAdviser").val();
                    var claSelectTeacher = $('#claSelectTeacher').val();
                    var claSelectTerm = $("#claSelectTerm").val();
                    var claSelectType = $('#claSelectType').val();
                    var claSelectFall = $("#claSelectFall").val();
                    table.reload('demo',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: '${pageContext.request.contextPath}/stu/classCon'
                        , method:'POST'
                        ,where:{
                            claSelectName:claSelectName,
                            claSelectAdviser:claSelectAdviser,
                            claSelectTeacher:claSelectTeacher,
                            claSelectTerm:claSelectTerm,
                            claSelectType:claSelectType,
                            claSelectFall:claSelectFall
                        }
                    });
                    break;
            };
        });

        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch(obj.event){
                case 'edit':
                    var classId = data.classId;
                    openStuAc = layer.open({
                        type: 1,
                        title:'班级管理修改',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['1000px', '800px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#addClaForm'),
                        success: function(layero, index){
                            $(data).each(function (index,elemnt){
                                $("#classId").val(elemnt.classId);
                                $("#classAdviser").val(elemnt.classAdviser);
                                $("#className").val(elemnt.className);
                                $("#classCount").val(elemnt.classCount);
                                $("#classTeacher").val(elemnt.classTeacher);
                                $("#classTerm").val(elemnt.classTerm);
                                $("#classType").val(elemnt.classType);
                                $("#classRemark").val(elemnt.classRemark);
                                $("#classFall").val(elemnt.classFall);
                                $("#MajorId").val(elemnt.MajorId);
                                $("#deptId").val(elemnt.deptId);
                            });
                        }
                    });
                    break;
            }
        });

        var form = layui.form;
        //监听提交
        form.on('submit(formDemoCla)',function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/stu/toStuCla',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){
                    document.getElementById("addClaForm").reset();
                    layer.close(openStuAc);
                    setTimeout(function(){
                        table.reload('demo');
                    })
                }
            });
            return true;
        });
    })

</script>

<script type="text/html" id="toolbarDemo" class=".layui-table-tool">
    <div class="layui-btn-container" style="float: left">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>

    <div style="float: left;height: 50px;width: 1600px;margin-top:-5px">
        <div class="layui-form-item" style="display: inline-block;width: 250px">
            <label class="layui-form-label" style="width:90px">班级名称</label>
            <div class="layui-input-block">
                <input id="claSelectName" type="text" name="claSelectName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block;width: 250px">
            <label class="layui-form-label" style="width:90px">班主任</label>
            <div class="layui-input-block">
                <select name="claSelectAdviser" lay-verify="required" placeholder=" " id="claSelectAdviser">
                    <option> </option>
                <c:forEach items="${bzrList}" var="bzr">
                    <option value="${bzr.names}">${bzr.names}</option>
                </c:forEach>
            </select>
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block;width: 250px">
            <label class="layui-form-label" style="width:90px">授课教师</label>
            <div class="layui-input-block">
                <select name="claSelectTeacher" lay-verify="required" placeholder=" " id="claSelectTeacher">
                    <option> </option>
                    <c:forEach items="${jsList}" var="js">
                        <option value="${js.names}">${js.names}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block;width: 250px">
            <label class="layui-form-label" style="width:90px">学期</label>
            <div class="layui-input-block">
                <select name="claSelectTerm" lay-verify="required" placeholder=" " id="claSelectTerm">
                    <option> </option>
                    <c:forEach items="${term}" var="te">
                        <option value="${te.termName}">${te.termName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block;width: 250px">
            <label class="layui-form-label" style="width:90px">班级类型</label>
            <div class="layui-input-block">
                <select name="claSelectType" lay-verify="required" placeholder=" " id="claSelectType">
                    <option> </option>
                    <c:forEach items="${classType}" var="ct">
                        <option value="${ct.classTypeName}">${ct.classTypeName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>



        <div class="layui-form-item" style="display: inline-block;width: 250px">
            <label class="layui-form-label" style="width:90px">学年</label>
            <div class="layui-input-block">
            <select name="claSelectFall" lay-verify="required" placeholder="" id="claSelectFall">
                <option> </option>
                <c:forEach items="${fall}" var="fa">
                    <option value="${fa.fallLevel}">${fa.fallLevel}</option>
                </c:forEach>
            </select>
            </div>
        </div>

        <button class="layui-btn layui-btn-sm" lay-event="isSelect">条件筛选</button>
    </div>
</script>


<script type="text/html" id="barDemo">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">
        <i class="layui-icon">&#xe642;</i>
    </button>
</script>

</html>
