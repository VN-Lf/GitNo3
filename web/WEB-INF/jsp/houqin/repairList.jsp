<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/4
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../index.jsp"%>
<html>
<head>
    <title>报修列表</title>
</head>
<body id="main" class="easyui-layout">
    <div data-options="region:'center',split:true">
        <div style="width: 99%;margin: 0 auto">
            <table id="rep" lay-filter="rep"></table>
        </div>
    </div>
    <div id="east" data-options="region:'east',collapsed:true,title:'操作区'" style="width: 650px;">
        <div id="repTabs" class="easyui-tabs" fit="true" style="visibility: hidden;">
            <h1 id="leftTitle" style="text-align: center;visibility: visible;" >There's nothing here</h1>
        </div>
    </div>
</body>
<!-- 表格头部工具栏 -->
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">申请报修</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
</script>
<!-- 表格操作按钮集 -->
<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-sm" lay-event="up">修改</a>
    <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
</script>
<script>
    layui.use(['util','table'], function(){
        var table = layui.table;
        //第一个实例
        table.render({
            elem: '#rep'
            ,height: 312
            // ,toolbar:"#toolbar"
            ,url: '${pageContext.request.contextPath}/houqin/repairList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'equipmentId', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'equipmentType', title: '保修事项', width:100}
                ,{field: 'status', title: '修理状态', width:100,templet:function (d) {if (d.status==1){return'已完成'}else{return'未完成'}}}
                ,{field: 'classes', title: '部门班级', width:100}
                ,{field: 'student', title: '学生', width:100}
                ,{field: 'remark', title: '备注', width:100}
                ,{field: 'userType', title: '报修身份', width:100}
                ,{field: 'startTime', title: '保修时间', width:150,sort:true,templet: function(d){return dateFormat(d.startTime)}}
                ,{field: 'eedTime', title: '完成时间', width: 150,sort:true,templet: function(d){
                    if (d.eedTime==null){
                        return "";}
                        else {
                        return dateFormat(d.eedTime)}
                }}
                ,{field: 'eedTime', title: '操作', width: 150,toolbar:"#barOption"}
            ]]
        });
        //监听顶部按钮
        table.on('toolbar(rep)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('edu'),
                        data = checkStatus.data,
                        er = "";
                    if(data.length > 0){
                        for (var i in data){
                            er+=data[i].equipmentId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/eduDel',{
                                id:er
                            },function(data){
                                alert("删除"+data);
                                table.reload("rep");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    $('#main').layout('expand','east');
                    var tabs= document.getElementById('repTabs');
                    tabs.style.cssText = "visibility: visible;"
                    var title= document.getElementById('leftTitle');
                    title.style.cssText = "text-align: center;visibility: hidden;"
                    addTab("报修申请","${pageContext.request.contextPath}/houqin/repAddPage");
                    break;
            };
        });
        //监听工具条
        table.on('tool(rep)', function (obj) {
            var data = obj.data;
            if (obj.event === 'up') {
                $('#main').layout('expand','east');
                $('#main').layout('expand','east');
                var tabs= document.getElementById('repTabs');
                tabs.style.cssText = "visibility: visible;"
                var title= document.getElementById('leftTitle');
                title.style.cssText = "text-align: center;visibility: hidden;"
                addTab("修改记录","${pageContext.request.contextPath}/houqin/repUpPage?rid="+data.equipmentId)
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.post('${pageContext.request.contextPath}/houqin/repDel',{id:data.equipmentId},function (data) {
                        //显示提示框
                        layer.msg("删除成功", {icon: 6});
                        table.reload("rep");
                    });
                    return false;
                });
            }
        });
    });
    function addTab(title, url) {
        if ($('#repTabs').tabs('exists', title)) { //如果存在
            $('#repTabs').tabs('select', title); //让标签页选中

            var currTab = $('#repTabs').tabs('getSelected'); //获取当前选中的选项页(返回panel对象)
            $('#repTabs').tabs('update', {
                tab: currTab,
                options: {
                    content: createFrame(url)
                }
            })
        } else { //如果这个标题的选项卡不存在
            var content = createFrame(url);
            $('#repTabs').tabs('add', {
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
    function tabClose() {
        $(".tabs-inner").dblclick(function() {
            var subtitle = $(this).children(".tabs-closable").text();
            $('#empTabs').tabs('close', subtitle);
        })
    }
</script>
<script>
    // 解决easyui 页面加载的时候布局乱 一闪而过
    var shadeDiv = "<div id='PageLoadingTip' style='position: absolute; z-index: 1000; top: 0px; left: 0px; width: 100%; height: 100%; background: gray; text-align: center;'> <h1 style='top: 48%; position: relative; color: white;'>页面加载中···</h1> </div>"

    document.write(shadeDiv );

    function _PageLoadingTip_Closes() {
        $("#PageLoadingTip").fadeOut("normal", function() {
            $(this).remove();
        });
    }

    var _pageloding_pc;

    $.parser.onComplete = function() {
        if (_pageloding_pc)
            clearTimeout(_pageloding_pc);
        _pageloding_pc = setTimeout(_PageLoadingTip_Closes, 200);
    }
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
