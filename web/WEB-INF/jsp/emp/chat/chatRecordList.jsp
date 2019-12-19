<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/16
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table id="chat" lay-filter="chat"></table>
</body>
<script>
    layui.use(['util','table'], function(){
        var table = layui.table;
        //第一个实例
        table.render({
            elem: '#chat'
            ,height: 312
            ,toolbar:'#toolbar'
            ,url: '${pageContext.request.contextPath}/emp/chatList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'chatid', title: '编号', width:80,sort: true, fixed: 'left'}
                ,{field: 'sayface', title: '学生', width:100,templet:function (d) { return d.stuName; }}
                ,{field: 'teacher', title: '老师', width:100,templet:function (d) { return d.empName; }}
                ,{field: 'addr', title: '地点', width:120}
                ,{field: 'sayscon', title: '内容', width:00}
                ,{field: 'chatDate', title: '时间', width: 120,sort: true}
                ,{field: 'chatDate', title: '操作', width: 150,toolbar:"#barOption"}
            ]]
        });
        //监听顶部按钮
        table.on('toolbar(chat)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('edu'),
                        data = checkStatus.data,
                        cid = "";
                    if(data.length > 0){
                        for (var i in data){
                            cid+=data[i].chatid+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/chatDel',{
                                id:cid
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
                    open('新增','${pageContext.request.contextPath}/emp/toChatAdd');
                    break;
            };
        });
        //监听工具条
        table.on('tool(chat)', function (obj) {
            var data = obj.data;
            if (obj.event === 'up'){
                open("修改",'${pageContext.request.contextPath}/emp/toChatUp?cid='+data.chatid);
            }else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.post('${pageContext.request.contextPath}/emp/chatDel',{id:data.chatid},function (data) {
                        //显示提示框
                        layer.msg("删除成功", {icon: 6});
                        table.reload("chat");
                    });
                    return false;
                });
            }
        });
    });
    function open(title,url) {
        index1=layer.open({
            type: 2,
            title:title,
            area:['500px','310px'],
            content:url,
            anim: 2
        });
    }
    function closeupdate() {
        layer.close(index1);
    }
</script>
<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm" lay-event="up">修改</a>
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
</script>
<!-- 表格头部工具栏 -->
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增记录</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
</script>
<script>

    /*
     * 时间格式化工具
     * 把Long类型的1527672756454日期还原yyyy-MM-dd格式日期
     */
    function dateFormat(longTypeDate){
        var dateTypeDate = "";
        var date = new Date();
        date.setTime(longTypeDate);
        dateTypeDate += date.getFullYear();   //年
        dateTypeDate += "-" + getMonth(date); //月
        dateTypeDate += "-" + getDay(date);   //日
        return dateTypeDate;
    }
    //返回 01-12 的月份值
    function getMonth(date){
        var month = "";
        month = date.getMonth() + 1; //getMonth()得到的月份是0-11
        if(month<10){
            month = "0" + month;
        }
        return month;
    }
    //返回01-30的日期
    function getDay(date){
        var day = "";
        day = date.getDate();
        if(day<10){
            day = "0" + day;
        }
        return day;
    }
    //小时
    function getHours(date){
        var hours = "";
        hours = date.getHours();
        if(hours<10){
            hours = "0" + hours;
        }
        return hours;
    }
    //分
    function getMinutes(date){
        var minute = "";
        minute = date.getMinutes();
        if(minute<10){
            minute = "0" + minute;
        }
        return minute;
    }
    //秒
    function getSeconds(date) {
        var second = "";
        second = date.getSeconds();
        if (second < 10) {
            second = "0" + second;
        }
        return second;
    }
</script>
</html>
