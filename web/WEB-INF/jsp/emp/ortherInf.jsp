<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/6
  Time: 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="./../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div id="empTabs" class="easyui-tabs" fit="true">
        <div title="教育经历">
            <table id="edu" lay-filter="edu"></table>
        </div>
        <div title="工作经历">
            <table id="job" lay-filter="job"></table>
        </div>
        <div title="家庭信息">
            <table id="fam" lay-filter="fam"></table>
        </div>
    </div>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#edu'
            ,height: 312
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/empEducationList?eid='+${currActEmpId} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'empUniversity', title: '学校名称', width:110}
                ,{field: 'empDegree', title: '文凭', width:100}
                ,{field: 'empEucStartDay', title: '入校时间', width:110}
                ,{field: 'empEucEndDay', title: '毕业时间', width:110}
                ,{field: 'empEucRemark', title: '说明', width:100}
                ,{field: 'empId', title: '操作', width: 200, toolbar: '#barOption'}
            ]]
        });
        table.render({
            elem: '#job'
            ,height: 312
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/empHis?eid='+${currActEmpId} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'empHisCompany', title: '公司名称', width:110}
                ,{field: 'empHisDegree', title: '职务', width:100}
                ,{field: 'empHisStartDay', title: '入职时间', width:110}
                ,{field: 'empHisEndDay', title: '离职时间', width:110}
                ,{field: 'empLiftReason', title: '离职原因', width:100}
                ,{field: 'empHisRemark', title: '说明', width:100}
                ,{field: 'empId', title: '操作', width: 200, toolbar: '#barOption'}
            ]]
        });
        table.render({
            elem: '#fam'
            ,height: 312
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/famInf?eid='+${currActEmpId} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'empContact', title: '联系人', width:110}
                ,{field: 'empRelation', title: '关系', width:110}
                ,{field: 'empContactphone', title: '联系电话', width:100}
                ,{field: 'empFamImfRemark', title: '说明', width:100}
                ,{field: 'empId', title: '操作', width: 200, toolbar: '#barOption'}
            ]]
        });
        //监听顶部按钮
        table.on('toolbar(edu)', function(obj){
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
                    openUpdate(data,'补充教育经历',"${pageContext.request.contextPath}/emp/eduAddPage");
                    break;
            };
        });
        table.on('toolbar(job)', function(obj){//注：tool 是工具条事件名，job 是 table 原始容器的属性 lay-filter="对应的值"
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('job'),
                        data = checkStatus.data,
                        HisId = "";
                    if(data.length > 0){
                        for (var i in data){
                            HisId+=data[i].empHisId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/jobDel',{
                                id:HisId
                            },function(data){
                                alert("删除"+data);
                                table.reload("job");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    openUpdate(data,'补充工作经历',"${pageContext.request.contextPath}/emp/jobAddPage");
                    break;
            };
        });
        table.on('toolbar(fam)', function(obj){//注：tool 是工具条事件名，job 是 table 原始容器的属性 lay-filter="对应的值"
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('fam'),
                        data = checkStatus.data,
                        famId = "";
                    if(data.length > 0){
                        for (var i in data){
                            famId+=data[i].empFamImfId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/famDel',{
                                id:famId
                            },function(data){
                                alert("删除"+data);
                                table.reload("fam");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    openUpdate(data,'补充家庭信息',"${pageContext.request.contextPath}/emp/famAddPage");
                    table.reload("fam")
                    break;
            };
        });
        //监听工具条
        table.on('tool(edu)', function (obj) {
            var data = obj.data;
            if (obj.event === 'up') {
                openUpdate(data,'修改教育经历',"${pageContext.request.contextPath}/emp/eduUpPage?eid="+data.empEduId);
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.post('${pageContext.request.contextPath}/emp/eduDel',{id:data.empId},function (data) {
                        //显示提示框
                        layer.msg("删除成功", {icon: 6});
                        table.reload("edu");
                    });
                    return false;
                });
            }
        });
        table.on('tool(job)', function (obj) {
            var data = obj.data;
            if (obj.event === 'up') {
                openUpdate(data,'修改工作经历',"${pageContext.request.contextPath}/emp/jobUpPage?eid="+data.empHisId);
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.post('${pageContext.request.contextPath}/emp/jobDel',{id:data.empHisId},function (data) {
                        //显示提示框
                        layer.msg("删除成功", {icon: 6});
                        table.reload("up");
                    });
                    return false;
                });
            } else if (obj.event === 'edit') {

            }
        });
        table.on('tool(fam)', function (obj) {
            var data = obj.data;
            if (obj.event === 'up') {
                openUpdate(data,'修改家庭信息',"${pageContext.request.contextPath}/emp/famUpPage?eid="+data.empFamImfId);
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.post('${pageContext.request.contextPath}/emp/famDel',{id:data.empFamImfId},function (data) {
                        //显示提示框
                        layer.msg("删除成功", {icon: 6});
                        table.reload("fam");
                    });
                    return false;
                });
            }
        });
        //监听复选框
        table.on('checkbox(filter)', function(data){
            //console.log(data.elem); //得到checkbox原始DOM对象
            if(data.elem.checked == true){
                alert("打开："+data.value);
            }else if(big.checked == false){
                alert("关闭"+data.value);
            }
            //console.log(data.value); //复选框value值，也可以通过data.elem.value得到
            //console.log(data.othis); //得到美化后的DOM对象
        });
    });
    function openUpdate(data,title,url) {
        index1=layer.open({
            type: 2,
            title:title,
            area: ['500px', '300px'],
            content: url, //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
            anim: 2
        });
    }
    function closeupdate() {
        layer.close(index1);
    }
</script>
<!-- 表格头部工具栏 -->
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增记录</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
</script>

<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm" lay-event="up">修改</a>
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
</script>
</html>
