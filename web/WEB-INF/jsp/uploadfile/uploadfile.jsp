<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/10
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>公告信息</title>
</head>
<body class="easyui-layout" id="main">
    <%--表格数据--%>
    <div data-options="region:'center'" style="width:800px">
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-sm" lay-event="isAdd">上传文件</button>
            </div>
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>
        <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
    </div>
    <div id="east" data-options="region:'east',collapsed:true,title:'其他信息'" style="width: 650px;">
        <h1 style="text-align: center" >There's nothing here</h1>
    </div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-bg-blue layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/upload/uploadlist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',fixed:'left'}
                ,{field: 'docId', title: '编号', sort: true}
                ,{field: 'dataName', title: '资料名称'}
                ,{field: 'optime', title: '上传时间', sort: true,templet: function(d){return dateFormat(d.optime)}}
                ,{field: 'remark', title: '备注'}
                ,{field: 'empid', title: '上传人'}
                ,{field: 'url', title: '下载文件',templet:function (data) {
                        return '<a href="${pageContext.request.contextPath}\\'+data.url+'" download="'+data.dataName+'" class="layui-btn layui-bg-blue layui-btn-xs" >下载文件</a>'
                    }}
                ,{ fixed: 'right', title: '操作', width: 180, align: 'center', toolbar: '#barDemo' }

            ]]
        });
        //监听行工具栏
        table.on('tool(test)',function (obj) {
            var data=obj.data;
            var layevent=obj.event;
            if(layevent=='del'){
                layer.confirm('确认删除  '+data.docId+'?',{icon: 3, title: '提示信息'},function (data1) {
                    $.post('${pageContext.request.contextPath}/upload/filedelete',{docId:data.docId},function (data) {
                        layer.msg(data);
                        table.reload("demo");
                    })
                })
            }else if(layevent=='downfile'){
                $.post('${pageContext.request.contextPath}/upload/downfile',{
                    docId:data.docId
                },function(data){
                    layer.msg(data);
                    table.reload("demo");
                });
            }
        });

        //批量删除，监听头部按钮
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].docId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/upload/allfiledelete',{
                                id:employeesId
                            },function(data){
                                layer.msg(data);
                                table.reload("demo");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    console.log(66666666666);
                    $('#main').layout('expand','east');
                    load();
                    break;
            };
            function load() {
                console.log("11111111111111")
                document.getElementById("east").innerHTML =  '<object type="text/html" data="toaddupload" width="100%" height="100%"></object>';
            }
        });
    });

    function addTab(title, url){
        if ($('#tabs').tabs('exists', title)) { //如果存在
            $('#tabs').tabs('select', title); //让标签页选中

            var currTab = $('#tabs').tabs('getSelected'); //获取当前选中的选项页(返回panel对象)
            var url = $(currTab.panel('options').content).attr('src');
            if (url != undefined && currTab.panel('options').title != 'Home'){
                $('#tabs').tabs('update', {
                    tab: currTab,
                    options: {
                        content: createFrame(url)
                    }
                })
            }
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

    function createFrame(url){ //创建窗口
        var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:99%;"></iframe>';
        return s;
    }

    function tabClose(){
        $(".tabs-inner").dblclick(function() {
            var subtitle = $(this).children(".tabs-closable").text();
            $('#tabs').tabs('close', subtitle);
        })
    }

</script>
    <script type="text/javascript">
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
</body>
</html>
</body>
</html>
