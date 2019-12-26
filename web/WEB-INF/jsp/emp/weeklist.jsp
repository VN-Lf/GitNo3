<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/4
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../index.jsp"%>
<html>
<head>
    <title>值班管理</title>
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
</head>
<body id="main" style="height: 100%;width: 100%" class="easyui-layout">
<div class="layui-form-item" style="width:324px;display:inline-block;margin-left: -30px;margin-right: 20px">
    <label class="layui-form-label" style="width: 97px;margin-left: 10px;"> 部门名称:</label>
    <div class="layui-input-block">
    </div>
</div>
    <div style="display: none" id="addweek">
        <form class="layui-form" method="post" action="${pageContext.request.contextPath}/emp/weekadd" lay-filter="dataf">
            <div class="layui-form-item"  style="width: 450px">
                <label class="layui-form-label">值班人</label>
                <div class="layui-input-block">
                    <select name="empId" id="empId" required lay-verify="required">
                        <option value=""></option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">排班名称</label>
                <div class="layui-input-block">
                    <input type="text" name="weekArrangeName" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">星期几值班</label>
                <div class="layui-input-block">
                    <select name="week" lay-verify="required">
                        <option value=""></option>
                        <option value="周日">周日</option>
                        <option value="周一">周一</option>
                        <option value="周二">周二</option>
                        <option value="周三">周三</option>
                        <option value="周四">周四</option>
                        <option value="周五">周五</option>
                        <option value="周六">周六</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">值班要求</label>
                <div class="layui-input-block">
                    <input type="text" name="ranges" required  lay-verify="required" placeholder="到哪个班巡查几次" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明</label>
                <div class="layui-input-block">
                    <textarea style="width: 340px;height: 135px" name="remark" placeholder="巡查范围" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-btn-container">
                <input class="layui-btn layui-btn-normal" type="submit" value="添加" style="width:150px;margin-left: 180px" />
            </div>
        </form>
    </div>
    <div data-options="region:'center',split:true">
        <form class="layui-form" style="width: 1205px;margin: 20px 0px 0px 10px">
            值班人:
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元素并不是必须的 -->
                <select id="sxemp">
                    <option value=""></option>
                </select>
            </div>
            值班周:
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元素并不是必须的 -->
                <select id="sxweek" name="week">
                    <option value=""></option>
                    <option value="周日">周日</option>
                    <option value="周一">周一</option>
                    <option value="周二">周二</option>
                    <option value="周三">周三</option>
                    <option value="周四">周四</option>
                    <option value="周五">周五</option>
                    <option value="周六">周六</option>
                </select>
            </div>
            <input class="layui-btn layui-btn-normal" id="shaixuan" style="width: 80px" value="筛选" />
        </form>
        <table id="demo" lay-filter="test"></table>
    </div>
    <div style="width: 100%;height: 300px;margin-top: 550px;display: none" id="upweek">
        <form class="layui-form" action="${pageContext.request.contextPath}/emp/weekup" lay-filter="formTest" method="post">
            <input type="hidden" id="weekid" name="weekArrangeId">
            <div style="float: left;width: 33%;height: 130px">
                <div class="layui-form-item"  style="width: 450px">
                    <label class="layui-form-label">值班人</label>
                    <div class="layui-input-block">
                        <select  name="empId" id="empname" required lay-verify="required">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item" style="width: 450px">
                    <label class="layui-form-label">排班名称</label>
                    <div class="layui-input-block">
                        <input type="text" id="weekname" name="weekArrangeName" required  lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div style="float: left;width: 33%;height: 130px">
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">值班说明</label>
                    <div class="layui-input-block">
                        <textarea style="width: 340px;height: 55px" id="remark" name="remark" placeholder="巡查范围" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">立即修改</button>
                    </div>
                </div>
            </div>
            <div style="float: left;width: 33%;height: 130px">
                <div class="layui-form-item" style="width: 450px">
                    <label class="layui-form-label">星期几值班</label>
                    <div class="layui-input-block">
                        <select id="week" name="week" lay-verify="required">
                            <option value=""></option>
                            <option value="周日">周日</option>
                            <option value="周一">周一</option>
                            <option value="周二">周二</option>
                            <option value="周三">周三</option>
                            <option value="周四">周四</option>
                            <option value="周五">周五</option>
                            <option value="周六">周六</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item" style="width: 450px">
                    <label class="layui-form-label">值班要求</label>
                    <div class="layui-input-block">
                        <input type="text"  name="ranges" id="ranges" required  lay-verify="required" placeholder="到哪个班巡查几次" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm layui-btn-danger" style="width: 100px" lay-event="del">删除</a>
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //生成动态按钮
        table.render({
            elem: '#demo'
            ,height:500
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/weeklist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'weekArrangeId', title: '编号', width:73, sort: true}
                ,{field: 'empId', title: '值班人', width:150}
                ,{field: 'week', title: '周几', width:87}
                ,{field: 'weekArrangeName', title: '排班名称', width:150}
                ,{field: 'startTime', title: '开始时间', width: 150}
                ,{field: 'endTime', title: '结束时间', width:150}
                ,{field: 'ranges', title: '值班要求', width:200}
                ,{field: 'remark', title: '说明'}
                ,{field: 'WeekArrangeId', title: '操作', width:150,toolbar:'#barOption'}
            ]]
        });
        $('#shaixuan').click(function () {
            var emp = $('#sxemp').val();
            var date = $('#sxweek').val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/emp/weeklistsx',
                where:{
                    emp:emp,
                    date:date
                },page:{
                    curr:1
                }
            });
        });
        table.on('rowDouble(test)',function(obj){
            var o = obj.data; //得到当前行数据
            openUpdate2(o);
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
                            employeesId+=data[i].weekArrangeId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/weekdelall',{
                                id:employeesId
                            },function(data){
                                table.reload("demo");
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    addWeek();
                    break;
            };
        });
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('确认删除该排班吗？', {icon: 3, title: '提示信息'}, function (index){
                    $.ajax({
                        url:'${pageContext.request.contextPath}/emp/weekdelete?id='+data.weekArrangeId,
                        type:'post',
                        dataType:'json',
                        success:function (data){
                            if(data.msg == 'you'){
                                layer.msg('删除成功', {icon: 1});
                                location.reload();
                            }else {
                                layer.msg('删除失败 请稍后再试', {icon: 5});
                            }
                        }
                    });
                });
            }
        });
    });
    layui.use(['form', 'upload', 'layer'], function () {
        var form = layui.form;
        $.ajax({
            url: '${pageContext.request.contextPath}/to/listemp',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                var json = data.data;
                $.each(json, function (index, item) {
                    $('#empId').append(new Option(item.empName,item.empName));// 下拉菜单里添加元素
                    $('#empname').append(new Option(item.empName,item.empName));// 下拉菜单里添加元素
                    $('#sxemp').append(new Option(item.empName,item.empName));// 下拉菜单里添加元素
                });
                form.render("select");
            }
        })

    });

    function addWeek() {
        index1=layer.open({
            type: 1,
            title:'新增值班',
            area: ['500px', '500px'],
            content:$('#addweek'),
            cancel:function () {
                window.location.reload();
            }
        });
    }
    function openUpdate2(data) {
        document.getElementById("upweek").style.display="block";
        $("#weekid").val(data.weekArrangeId);
        $("#weekname").val(data.weekArrangeName);
        $("#remark").val(data.remark);
        $("#ranges").val(data.ranges);
        $("#empname").val(data.empId);
        $("#week").val(data.week);
        layui.form.render();
    }
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="isDele">批量删除</button>
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增值班</button>
    </div>
</script>
</html>
