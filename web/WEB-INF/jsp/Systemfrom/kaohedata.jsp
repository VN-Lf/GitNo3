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
    <title>员工考核统计详情</title>
</head>
<body id="kaohe" class="easyui-layout">
    <div data-options="region:'center'">
        <form style="width: 1205px;margin: 20px 0px 0px 20px">
            员工姓名:<input type="text" name="empname" id="empname" required lay-verify="required" placeholder="请输人姓名"  class="layui-input" style="width:180px;display:inline-block" />
            <div class="layui-form-item" style="width:324px;display:inline-block;margin-left: -30px;margin-right: 20px">
                <label class="layui-form-label" style="width: 97px;margin-left: 10px;"> 部门名称:</label>
                <div class="layui-input-block">
                    <select name="Depid" id="Depid" lay-filter="aihao" style="width: 180px;height: 38px;border: 1px solid rgba(216,216,216,0.5)">
                        <option value="">请选择部门</option>
                        <c:forEach items="${dept}" var="deptname">
                            <option value="${deptname.deptId}">${deptname.deptName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <input class="layui-btn layui-btn-normal" id="selectexam" style="width: 80px" value="搜索" />
        </form>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="backkaohe">返回图表</button>
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
            ,url: '${pageContext.request.contextPath}/System/kaohedatalist' //数据接口
            ,page: true //开启分页
            ,where:{empname:'',Depid:''}
            ,cols: [[ //表头
                {field: 'empId', title: '员工编号', sort: true}
                ,{field: 'name', title: '员工姓名'}
                ,{field: 'postName', title: '部门名称', sort: true}
                ,{field: 'empSex', title: '员工性别'}
                ,{field: 'empPhone', title: '员工手机号'}
                ,{field: 'value', title: '考核总分'}
                ]]
        });

        //监听头部按钮
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'backkaohe':
                    kaohe();
                    break;
            };
        });

        var open=false;

        //监听单击行事件
        table.on('row(test)', function(obj){
            var kaohedata=obj.data
            ortherInf(kaohedata.empId);
            open=true;
        });

        function ortherInf(empid) {
            if(open==false){
                $('#kaohe').layout('expand','east');
            }

            load(empid);
        }

        function load(empid) {
            document.getElementById("east").innerHTML =
                '<object type="text/html" data="${pageContext.request.contextPath}/System/kaodata?id='+empid+'" width="100%" height="100%"></object>';
        }

        function kaohe() {
            document.getElementById("kaohe").innerHTML =
                '<object type="text/html" data="${pageContext.request.contextPath}/System/tokaohe" width="100%" height="100%"></object>';
        }
        //条件搜索
        $('#selectexam').click(function () {
            var empname=$('#empname').val();
            var Depid=$('#Depid').val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/System/kaohedatalist',
                where:{
                    empname:empname,
                    Depid:Depid,
                },page:{
                    curr:1
                }
            });
        })
    });


</script>
</html>
