<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/15
  Time: 20:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../index.jsp"%>
<html>
<head>
    <title>部门管理</title>
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
    <style>
        /*#xiugaidiv{
            width: 500px;
            height: 270px;
            padding:20px 0 50px 0;
            background-color: #9F9F9F;
            position: absolute;
            top: 100px;left:500px;
            display: none;
        }*/
    </style>
</head>
<body>
<div data-options="region:'center',split:true">
    <div style="width: 99%;margin: 0 auto">
        <table id="demo" lay-filter="test"></table>
    </div>
    <div style="display: none" id="adddept">
        <form class="layui-form" method="post" action="${pageContext.request.contextPath}/Tuition/deptadd" lay-filter="dataf">
            <input type="hidden" name="deptId">
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">部门名称</label>
                <div class="layui-input-block">
                    <input type="text" name="deptName" required  lay-verify="required" placeholder="请输入部门名称" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">部门描述</label>
                <div class="layui-input-block">
                    <textarea style="width: 340px;height: 135px" name="deptRemark" placeholder="请描述改部门的事务" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-btn-container">
                <input class="layui-btn layui-btn-normal" type="submit" value="添加" style="margin-left: 190px" />
                <input 	class="layui-btn layui-btn-primary" type="button" onclick="closeupdate()"  value="取消"/>
            </div>
        </form>
    </div>
</div>
</body>

<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm" lay-event="up">修改</a>
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
</script>
<script>
    layui.use('table', function(){
        var index = "";
        var table = layui.table;
        //生成动态按钮
        table.render({
            elem: '#demo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/Tuition/deptlist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'deptId', title: '编号', width:73, sort: true}
                ,{field: 'deptName', title: '部门名称'}
                ,{field: 'deptRemark', title: '描述'}
                ,{field: 'deptId', title: '操作',toolbar:'#barOption'}
            ]]
        });

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].deptId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/Tuition/deldeptall',{
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
                    addDept();
                    break;
            };
        });

        //监听工具条
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'up') {
                openUpdate(data,data.deptId);
            } else if (obj.event === 'del') {
                layer.confirm('确认删除该部门吗？', {icon: 3, title: '提示信息'}, function (index){
                    $.ajax({
                        url:'${pageContext.request.contextPath}/Tuition/deptdelete?id='+data.deptId,
                        type:'post',
                        dataType:'json',
                        success:function (data){
                            if(data.msg == 'you'){
                                layer.confirm('    该部门还存在'+data.data+' 请先移动到其它部门', {
                                    btn: ['我知道了'],anim: 6,icon: 5,btnAlign: 'c'
                                });
                            }else {
                                layer.msg('删除成功', {icon: 1});
                                location.reload();
                            }
                        }
                    });
                });
            }
        });
    });

    function openUpdate(data,id) {
        index1=layer.open({
            type: 2,
            title:'修改排班',
            area: ['500px', '300px'],
            content:'${pageContext.request.contextPath}/Tuition/deptxiu?id='+id, //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            anim: 2
        });
    }

    function addDept() {
        index1=layer.open({
            type: 1,
            title:'添加部门',
            area: ['500px', '300px'],
            content:$('#adddept')
        });
    }
    function closeupdate() {
        document.getElementById("adddate").style.display="none";
        layer.close(index1);
    }
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="isDele">批量删除</button>
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">添加部门</button>
    </div>
</script>
</html>
