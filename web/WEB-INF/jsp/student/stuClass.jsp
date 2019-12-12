<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/11
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<table id="demo" lay-filter="test"></table>

<form  class="layui-form" id="addClaForm" style="display:none;height: auto;width: 600px" method="post">
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
            <input id="relation" type="text" name="relation" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>


    <label class="layui-form-label" style="width:100px">班主任</label>
    <div class="layui-input-block">
        <select name="classAdviser" lay-verify="required" placeholder=" " id="classAdviser">
            <c:forEach items="${bzrList}" var="bzr">
                <option value="${bzr.empId}">${bzr.empName}</option>
            </c:forEach>
        </select>
    </div>

    <label class="layui-form-label" style="width:100px">授课教师</label>
    <div class="layui-input-block">
        <select name="classTeacher" lay-verify="required" placeholder=" " id="classTeacher">
            <c:forEach items="${jsList}" var="bzr">
                <option value="${js.empId}">${js.empName}</option>
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
            <c:forEach items="${fall}" var="fall">
                <option value="${fall.fallId}">${fall.fallLevel}</option>
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

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>


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
            ,url: '${pageContext.request.contextPath}/stu/claMian/toList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'classId', title: 'ID', width:100, sort: true}
                ,{field: 'classNo', title: '班级编号', width:100}
                ,{field: 'bzr', title:'班主任', width:80}
                ,{field: 'js', title: '授课教师', width:80, sort: true}
                ,{field: 'classCount', title: '班级人数', width:80}
                ,{field: 'className', title:'班级名字', width:80}
                ,{field: 'stuAddr', title: '地址', width: 177}
                ,{field: 'classNames', title:'班级名', width:80}
                ,{field: 'tnames', title: '学期', width:80, sort: true}
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
                        area:['900px','800px'],
                        content: $("#addClaForm"),
                        closeBtn :1,
                        success: function(layero, index){
                            $("#classId").val(0);
                        }
                    });
                    break;
                /*case 'isSelect':
                    var stuSelectName = $('input[name="stuSelectName"]').val();
                    var stuSelectPhone = $('input[name="stuSelectPhone"]').val();
                    var stuSelectCla = $('input[name="stuSelectCla"]').val();
                    var stuSelectFloor = $('input[name="stuSelectFloor"]').val();
                    table.reload('demo',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: '/stu/con'
                        , method:'POST'
                        ,where:{
                            stuSelectName:stuSelectName,
                            stuSelectPhone:stuSelectPhone,
                            stuSelectCla:stuSelectCla,
                            stuSelectFloor:stuSelectFloor
                        }
                    });
                    break;*/
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
                        area: ['700px', '400px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#addFalForm'),
                        success: function(layero, index){
                            $(data).each(function (index,elemnt){
                                $("#classId").val(elemnt.classId);
                                $("#classNo").val(elemnt.classNo);
                                $("#bzr").val(elemnt.bzr);
                                $("#js").val(elemnt.js);
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
                url:'${pageContext.request.contextPath}/stu/toStuClss',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){
                }
            });
            document.getElementById("addClaForm").reset();
            layer.close(openStuAc);
            table.reload('demo');
            return false;
        });

    })
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: left">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
</script>


<script type="text/html" id="barDemo">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">
        <i class="layui-icon">&#xe642;</i>
    </button>
</script>

</html>
