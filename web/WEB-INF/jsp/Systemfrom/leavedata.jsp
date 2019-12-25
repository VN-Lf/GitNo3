<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/24
  Time: 8:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>员工请假统计</title>
</head>
<body id="kaohe" class="easyui-layout">
    <div data-options="region:'center'">
        <form style="width: 1205px;margin: 20px 0px 0px 20px">
            员工姓名:<input type="text" name="empname" id="empname" required lay-verify="required" placeholder="请输人姓名"  class="layui-input" style="width:180px;display:inline-block" />
            <input type="radio"  name="month" value="">全部月份
            <input type="radio"  name="month" value="${month}" checked>本月(${month})
            <input type="radio"  name="month" value="${month-1}">上月(${month-1})
            <input class="layui-btn layui-btn-normal" id="selectexam" style="width: 80px" value="搜索" />
        </form>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="backleave">返回图表</button>
            </div>
        </script>
        <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
    </div>
    <div id="east" data-options="region:'east',collapsed:true,title:'其他信息'" style="width: 650px;">
        <h1 style="text-align: center" >单击数据查看详情</h1>
    </div>
</body>
<script type="text/javascript">
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,toolbar: '#toolbarDemo'
            ,method:'post'
            ,url: '${pageContext.request.contextPath}/System/leavedatalist' //数据接口
            ,page: true //开启分页
            ,where:{empname:'',Depid:''}
            ,cols: [[ //表头
                {field: 'jobId', title: '请假编号', sort: true},
                {field: 'userId', title: '员工编号', sort: true}
                ,{field: 'empName', title: '员工姓名'}
                ,{field: 'count', title: '请假次数', sort: true}
                ,{field: 'day', title: '请假天数'}
                ,{field: 'time', title: '小时(包含4小时带薪假)'}
                ]]
        });

        //监听头部按钮
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'backleave':
                    leave();
                    break;
            };
        });

        var open=false;

        //监听单击行事件
        table.on('row(test)', function(obj){
            var leavedata=obj.data
            ortherInf(leavedata.userId);
            open=true;
        });

        function ortherInf(userId) {
            if(open==false){
                $('#kaohe').layout('expand','east');
            }
            load(userId);
        }

        function load(userId) {
            document.getElementById("east").innerHTML =
                '<object type="text/html" data="${pageContext.request.contextPath}/System/leadata?id='+userId+'" width="100%" height="100%"></object>';
        }

        function leave() {
            document.getElementById("kaohe").innerHTML =
                '<object type="text/html" data="${pageContext.request.contextPath}/System/toleave" width="100%" height="100%"></object>';
        }
        //条件搜索
        $('#selectexam').click(function () {
            var empname=$('#empname').val();
            var month=$("input[name='month']:checked").val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/System/leavedatalist',
                where:{
                    empname:empname,
                    month:month,
                },page:{
                    curr:1
                }
            });
        })
    });


</script>
</html>
