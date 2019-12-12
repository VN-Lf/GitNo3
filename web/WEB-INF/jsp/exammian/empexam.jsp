<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/9
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="source.jsp"%>
<html>
<head>
    <title>考核录入</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
</head>
<body>
    <%--表格数据--%>
    <div>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="isAdd">录入考核</button>
            </div>
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>
        <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
    </div>
    <%--弹出层--%>
    <div style="display: none;margin-left: 60px;margin-top: 40px" id="add">
        <form class="layui-form" method="post" action="${pageContext.request.contextPath}/exam/updateexam" lay-filter="dataf">
            <input type="hidden" name="aduitModelid"/>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">班主任/任课老师:</label>
                <div class="layui-input-block">
                    <select name="empname" lay-verify="required" style="width: 250px">
                        <c:forEach items="${empnamelist}" var="empname">
                            <option value="${empname}">${empname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">员工类型:</label>
                <div class="layui-input-block">
                    <select name="empexamid" lay-verify="required" style="width: 250px">
                        <option value="1">班主任</option>
                        <option value="2">任课老师</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">考核班级:</label>
                <div class="layui-input-block">
                    <select name="classname" lay-verify="required" style="width: 250px">
                        <option value="">请选择班级</option>
                        <c:forEach items="${classnamelist}" var="classname">
                            <option value="${classname}">${classname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-btn-container">
                <input class="layui-btn layui-btn-normal" type="submit" value="录入考核" style="margin-left: 190px" />
                <input 	class="layui-btn layui-btn-primary" type="button" onclick="closeupdate()"  value="取消"/>
            </div>

        </form>
    </div>
</body>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="del">删除</a>
</script>
<script type="text/javascript">
    var index1="";
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/exam/emplistexam' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',fixed:'left'}
                ,{field: 'empAssessId', title: '考核编号', sort: true}
                ,{field: 'empexamname', title: '员工类型'}
                ,{field: 'empName', title: '任课老师/班主任', sort: true}
                ,{field: 'classRemark', title: '任课班级'}
                ,{field: 'scores', title: '总评分'}
                ,{ fixed: 'right', title: '操作', width: 180, align: 'center', toolbar: '#barDemo' }
            ]]
        });
        //监听行工具栏
        table.on('tool(test)',function (obj) {
            var data=obj.data;
            var layevent=obj.event;
            if(layevent=='del'){
                layer.confirm('确认删除  '+data.empAssessId+'?',{icon: 3, title: '提示信息'},function (data1) {
                    $.post('${pageContext.request.contextPath}/exam/deleteemp',{empAssessId:data.empAssessId},function (data) {
                        layer.msg(data);
                        table.reload("demo");
                    })
                })
            }
        });

        //批量删除，监听头部按钮
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].empAssessId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/exam/alldeleteemp',{
                                id:employeesId
                            },function(data){
                                layer.msg(data);
                                table.reload("demo");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    openupdateexam();
                    break;
            };
        });

        function openupdateexam() {
                layer.open({
                type: 1,
                title:'录入考核',
                area: ['600px', '400px'],
                content:$('#add'),
            });
        }
    });

</script>
</html>
