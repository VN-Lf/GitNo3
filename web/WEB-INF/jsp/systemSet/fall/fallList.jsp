<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/25
  Time: 8:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <table id="sf" lay-filter="sf"></table>
</div>
</body>
<script>
    layui.use(['table','laypage'], function(){
        var table = layui.table,
            laypage = layui.laypage;
        table.render({
            elem: '#sf'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/sys/fallList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'fallId', title: '编号', width:110}
                ,{field: 'fallLevel', title: '学期', width:110}
                ,{field: 'fallRemark', title: '说明', width:110}
                ,{field: 'fallId', title: '操作', width: 200,toolbar: '#barOption'}
            ]]
        });
        //监听顶部按钮
        table.on('toolbar(sf)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('edu'),
                        data = checkStatus.data,
                        eduId = "";
                    if(data.length > 0){
                        for (var i in data){
                            eduId+=data[i].empEduId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/eduDel',{
                                id:eduId
                            },function(data){
                                alert("删除"+data);
                                table.reload("edu");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    open('新增学期','${pageContext.request.contextPath}/sys/toFallAdd');
                    break;
            };

        });
        //监听工具条
        table.on('tool(sf)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('确定删除记录吗？', function (index) {
                    $.post('${pageContext.request.contextPath}/sys/fallDel',{id:data.fallId},function (data) {
                        //显示提示框
                        layer.msg("操作成功", {icon: 6});
                        table.reload("sf");
                    });
                    return false;
                });
            }else if (obj.event === 'up'){
                open("学期编辑",'${pageContext.request.contextPath}/sys/toFallUp?id='+data.fallId)
            }
        });
    });

    function open(title,url) {
        index1=layer.open({
            type: 2,
            title:title,
            area:['500px','210px'],
            content:url,
            anim: 2
        });
    }
</script>
<!-- 表格头部工具栏 -->
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增</button>
    </div>
</script>

<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-sm" lay-event="up">编辑</a>
</script>
</html>
