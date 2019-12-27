<%@ page import="com.nothing.vo.emp.Post" %><%--
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
    <title>权限设置</title>
    <% Post post = (Post) session.getAttribute("post");%>
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
</head>
<body id="main" style="height: 100%;width: 100%" class="easyui-layout">
    <div data-options="region:'center',split:true">
        <form class="layui-form" style="width: 1205px;margin: 20px 0px 0px 10px">
            所在部门:
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元-->
                <select id="sxdept">
                    <option value=""></option>
                </select>
            </div>
            <input class="layui-btn layui-btn-normal" id="shaixuan" style="width: 80px" value="筛选" />
        </form>
        <table id="demo" class="layui-bg-black" lay-filter="test"></table>
    </div>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#demo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/Building/quanlist' //数据接口
            ,page: true //开启分页
            ,cols: [[
                {field: 'charId', title: '编号', width:80, sort: true}
                ,{field: 'empName', title: '姓名'}
                ,{field: 'deptId', title: '部门', width:100}
                ,{field: 'boss', title: '身份',event: 'setSign', width:70,templet:function (row){return postZhi(row.boss);}}
                ,{field: 'updateEmp', title: '员工管理',event: 'updateEmp', width:90,templet:function (row){return onclikId(row.updateEmp);}
                },{field: 'updateStu', title: '学生管理',event: 'updateStu', width:90,templet:function (row){return onclikId(row.updateStu);}
                },{field: 'actEmp', title: '请假审批',event: 'actEmp', width:90,templet:function (row){return onclikId(row.actEmp);}
                },{field: 'weekEmp', title: '周报审批',event: 'weekEmp', width:90,templet:function (row){return onclikId(row.weekEmp);}
                },{field: 'attkEmp', title: '员工考勤',event: 'attkEmp', width:90,templet:function (row){return onclikId(row.attkEmp);}
                },{field: 'weixiu', title: '维修管理',event: 'weixiu', width:90,templet:function (row){return onclikId(row.weixiu);}
                },{field: 'deptGuan', title: '部门管理',event: 'deptGuan', width:90,templet:function (row){return onclikId(row.deptGuan);}
                },{field: 'kaoheEmp', title: '纪检权限',event: 'kaoheEmp', width:90,templet:function (row){return onclikId(row.kaoheEmp);}
                },{field: 'stuBze', title: '班主任',event: 'stuBze', width:90,templet:function (row){return onclikId(row.stuBze);}
                },{field: 'stuJs', title: '教师权限',event: 'stuJs', width:90,templet:function (row){return onclikId(row.stuJs);}
                },{field: 'stuMoney', title: '学费管理',event: 'stuMoney', width:90,templet:function (row){return onclikId(row.stuMoney);}
                },{field: 'kecheng', title: '教务权限',event: 'kecheng', width:90,templet:function (row){return onclikId(row.kecheng);}
                },{field: 'zhiban', title: '值班管理',event: 'zhiban', width:90,templet:function (row){return onclikId(row.zhiban);}
                },{field: 'zhaosheng', title: '招生权限',event: 'zhaosheng', width:90,templet:function (row){return onclikId(row.zhaosheng);}}
            ]]
        });
        $('#shaixuan').click(function () {
            var dept = $('#sxdept').val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/Building/quanlists',
                where:{
                    dept:dept
                },page:{
                    curr:1
                }
            });
        });
        //监听单元格事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch(obj.event){
                case 'updateEmp':
                    if(data.updateEmp == '0') var tishi = "确认提供该权限吗？";
                    else if(data.updateEmp == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'updateEmp',
                            cid:data.charId,
                            zt:data.updateEmp
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'updateStu':
                    if(data.updateStu == '0') var tishi = "确认提供该权限吗？";
                    else if(data.updateStu == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'updateStu',
                            cid:data.charId,
                            zt:data.updateStu
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'actEmp':
                    if(data.actEmp == '0') var tishi = "确认提供该权限吗？";
                    else if(data.actEmp == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'actEmp',
                            cid:data.charId,
                            zt:data.actEmp
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'weekEmp':
                    if(data.weekEmp == '0') var tishi = "确认提供该权限吗？";
                    else if(data.weekEmp == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'weekEmp',
                            cid:data.charId,
                            zt:data.weekEmp
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'attkEmp':
                    if(data.attkEmp == '0') var tishi = "确认提供该权限吗？";
                    else if(data.attkEmp == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'attkEmp',
                            cid:data.charId,
                            zt:data.attkEmp
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'kaoheEmp':
                    if(data.kaoheEmp == '0') var tishi = "确认提供该权限吗？";
                    else if(data.kaoheEmp == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'kaoheEmp',
                            cid:data.charId,
                            zt:data.kaoheEmp
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'deptGuan':
                    if(data.deptGuan == '0') var tishi = "确认提供该权限吗？";
                    else if(data.deptGuan == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'deptGuan',
                            cid:data.charId,
                            zt:data.deptGuan
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'weixiu':
                    if(data.weixiu == '0') var tishi = "确认提供该权限吗？";
                    else if(data.weixiu == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'weixiu',
                            cid:data.charId,
                            zt:data.weixiu
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'stuBze':
                    if(data.stuBze == '0') var tishi = "确认提供该权限吗？";
                    else if(data.stuBze == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'stuBze',
                            cid:data.charId,
                            zt:data.stuBze
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'stuJs':
                    if(data.stuJs == '0') var tishi = "确认提供该权限吗？";
                    else if(data.stuJs == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'stuJs',
                            cid:data.charId,
                            zt:data.stuJs
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'stuMoney':
                    if(data.stuMoney == '0') var tishi = "确认提供该权限吗？";
                    else if(data.stuMoney == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'stuMoney',
                            cid:data.charId,
                            zt:data.stuMoney
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'kecheng':
                    if(data.kecheng == '0') var tishi = "确认提供该权限吗？";
                    else if(data.kecheng == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'kecheng',
                            cid:data.charId,
                            zt:data.kecheng
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'zhiban':
                    if(data.zhiban == '0') var tishi = "确认提供该权限吗？";
                    else if(data.zhiban == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'zhiban',
                            cid:data.charId,
                            zt:data.zhiban
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
                case 'zhaosheng':
                    if(data.zhaosheng == '0') var tishi = "确认提供该权限吗？";
                    else if(data.zhaosheng == '1') var tishi = "确认撤销该权限吗？";
                    layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                        $.post('${pageContext.request.contextPath}/Building/up',{
                            lie:'zhaosheng',
                            cid:data.charId,
                            zt:data.zhaosheng
                        },function(data){
                            layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                            location.reload();
                        });
                    },function () {
                        location.reload();
                    });
                    break;
            }

            if(obj.event === 'setSign'){
                layer.prompt({title: '输入密码以验证', formType: 1}, function(pass, index){
                    if(pass === "123456"){
                        layer.prompt({title: '填写新身份，只能是上级/校长', formType: 3}, function(text, index){
                            $.post('${pageContext.request.contextPath}/Building/updateboss',{
                                id:data.charId,
                                boss:text
                            },function(data){
                                alert("");
                                layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                                location.reload();
                            });
                        });
                    }else {
                        layer.msg('密码错误');
                    }

                });
            }
        });
    });
    layui.use(['form', 'upload', 'layer'], function () {
        var form = layui.form;
        $.ajax({
            url: '${pageContext.request.contextPath}/to/deptlist',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                var json = data.data;
                $.each(json, function (index, item) {
                    $('#sxdept').append(new Option(item.deptName,item.deptId));// 下拉菜单里添加元素
                });
                form.render("select");
            }
        });
    });
    function onclikId(v) {
        if(v == 0){
            var html = "<a>\n" +
                "        <input type=\"checkbox\" style='width: 50px' lay-filter='switchTest' lay-skin='switch' lay-text='有|无'>\n" +
                "    </a>"
        }else if(v == 1){
            var html = "<a>\n" +
                "        <input type=\"checkbox\" checked style='width: 50px' lay-filter='switchTest' lay-skin='switch' lay-text='有|无' >\n" +
                "    </a>"
        }
        return html;
    }
    function postZhi(v) {
        if(v == 0){
            return "校长";
        }else if(v == 1){
            return "上级";
        }else{
            return "无";
        }
    }
</script>
</html>
