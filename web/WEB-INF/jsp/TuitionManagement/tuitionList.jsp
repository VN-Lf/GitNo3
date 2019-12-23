<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/21
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="./../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body id="tuition">
<div>
    <table id="tt" lay-filter="tt"></table>
</div>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#tt'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/finance/tuitionList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'financeId', title: '编号', width:110}
                ,{field: 'financedate', title: '时间', width:110}
                ,{field: 'stuid', title: '学生', width:110,templet:function (d) { return d.stuName; }}
                ,{field: 'termId', title: '学期', width:110,templet:function (d) { return d.termName; }}
                ,{field: 'receipt', title: '付款方式', width:110}
                ,{field: 'financeType', title: '类型', width:110,templet:function (d) {if(d.financeType==1){return "缴费";}else {return "退费"}}}
                ,{field: 'factMoney', title: '金额(元)', width:110}
                ,{field: 'empid', title: '收款人', width:100,templet:function (d) { return d.empName; }}
                ,{field: 'remark', title: '说明', width:110}
                ,{field: 'tuitionTypeId', title: '收款项', width:100,templet:function (d) { return d.typeName; }}
                ,{field: 'Invalid', title: '状态', width:110,templet:function (d) {if(d.Invalid==1){return "有效";}else {return "作废"}}}
                ,{field: 'empId', title: '操作', width: 200, toolbar: '#barOption'}
            ]]
        });
        //监听顶部按钮
        table.on('toolbar(tt)', function(obj){
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
                    self.parent.addTab('新增记录','${pageContext.request.contextPath}/finance/toTuitionAdd');
                    break;
            };

        });
        //监听工具条
        table.on('tool(tt)', function (obj) {
            var data = obj.data;
            if (obj.event === 'cancel') {
                layer.confirm('真的作废该记录吗？', function (index) {
                    $.post('${pageContext.request.contextPath}/finance/cencal',{id:data.financeId},function (data) {
                        //显示提示框
                        layer.msg("操作成功", {icon: 6});
                        table.reload("tt");
                    });
                    return false;
                });
            }else if (obj.event === 'back'){
                layer.confirm('确认为学生'+data.stuName+'办理退款吗？', function (index) {
                    $.post('${pageContext.request.contextPath}/finance/back',{id:data.financeId},function (data) {
                        //显示提示框
                        layer.msg("操作成功", {icon: 6});
                        table.reload("tt");
                    });
                    return false;
                });
            }
        });
    });
    function addTab(title, url) {
        if ($('#tabs').tabs('exists', title)) { //如果存在
            $('#tabs').tabs('select', title); //让标签页选中

            var currTab = $('#tabs').tabs('getSelected'); //获取当前选中的选项页(返回panel对象)
            $('#tabs').tabs('update', {
                tab: currTab,
                options: {
                    content: createFrame(url)
                }
            })
        } else { //如果这个标题的选项卡不存在
            var content = createFrame(url);
            $('#tabs').tabs('add', {
                title: title, //标题
                content: content, //内容
                closable: true //显示关闭按钮
            });
        }
        tabClose();
    }
    function createFrame(url) { //创建窗口
        var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:99%;"></iframe>';
        return s;
    }
</script>
<!-- 表格头部工具栏 -->
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增收费</button>
    </div>
</script>

<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm" lay-event="cancel">作废</a>
    <a class="layui-btn layui-btn-sm" lay-event="back">退款</a>
</script>
</html>
