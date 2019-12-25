<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/24
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="./../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
    <style>
        .td{
            text-align: center;
            padding: 50px;
        }
    </style>
</head>
<body>
<table style="text-align: center;width: 100%;">
    <tr>
        <td class="td">
            <a href="javascript:void(0)" onclick="toFallList('届别设置','${pageContext.request.contextPath}/sys/toFallList')">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                届别设置
            </a>
        </td>
        <td class="td">
            <a href="">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                班级类型
            </a>
        </td>
        <td class="td">
            <a href="">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                班级类型
            </a>
        </td>
        <td class="td">
            <a href="">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                班级类型
            </a>
        </td>
    </tr>
    <tr>
        <td class="td">
            <a href="">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                届别设置
            </a>
        </td>
        <td class="td">
            <a href="">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                班级类型
            </a>
        </td>
        <td class="td">
            <a href="">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                班级类型
            </a>
        </td>
        <td class="td">
            <a href="">
                <i class="layui-icon" style="font-size: 50px;">&#xe716;</i><br>
                班级类型
            </a>
        </td>
    </tr>
</table>
</body>
<script>

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
    function toFallList(title,url){
        if(self.parent.tab){
            alert('冲突了')
        }
        self.parent.addTab(title,url);
        // $('#tabs').tabs('add', {
        //     title: title, //标题
        //     content: url, //内容
        //     closable: true //显示关闭按钮
        // });
    }
</script>
</html>
