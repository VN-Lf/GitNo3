<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/13
  Time: 19:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的邮件</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">

    <%
        HttpSession sess = request.getSession();
        String message = (String)sess.getAttribute("Repeat");
        if(message == "" ){
        }else{
    %>
    <script type="text/javascript">
        var a = "<%=message%>"
        if(a !="null" ){
            alert(a);
        }
    </script>
    <%
            sess.setAttribute("Repeat", "");
        }
    %>
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
    <div class="easyui-layout" data-options="fit:true" >
        <div data-options="region:'center',title:'信息管理'" style="background:#eee;">
            <a id="add"  onclick="fans();"  class="easyui-linkbutton" data-options="iconCls:'icon-add'">发送邮件</a>
            <div id="tabs" class="easyui-tabs" fit="true">
                <div title="收到的邮件">
                    <%--信息显示表--%>
                    <table id="demo" lay-filter="test"  ></table>
                </div>
                <div title="发送的邮件">

                    <%--信息显示表--%>
                    <table id="Senddemo" lay-filter="test" ></table>
                </div>
            </div>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">再次发送</a>
            </script>
            <script type="text/html" id="ServletDemo">
                <a class="layui-btn layui-btn-xs" <%--onclick="SelvetEmail();"--%> lay-event="selectedit">内容阅览</a>
            </script>
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container" style="width: 800px;">
                    <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
                </div>
            </script>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script>
        //解决jquery包冲突
        jQuery.noConflict();
        layui.use('table', function(){
            var table = layui.table;

            //第一个实例
            table.render({
                elem: '#demo'
                ,height: 312
                ,toolbar: '#toolbarDemo'
                ,url: '${pageContext.request.contextPath}/email/obtainEmail' //数据接口
                ,page: true //开启分页
                ,cols: [[ //表头-
                    {type:'checkbox'}//复选框
                    ,{field: 'emailId', title: '编号', width:80, sort: true}
                    ,{field: 'receId', title: '接收人', width:120, sort: true}
                    ,{field: 'topic', title: '标题', width:80}
                    ,{field: 'sendtime', title: '时间', width:120,templet:function (row){
                            return createTime(row.sendtime);
                        }}
                    ,{field: 'isRead', title: '是否已读',templet:function (data) {
                        if( data.isRead ==1 ){
                            return '已读'
                        }else if(data.isRead == 2){
                            return '未读'
                        }
                    },width:120}
                    ,{width:215, title: '查看',align:'center', fixed: 'right', toolbar: '#ServletDemo'}
                    /*,{width:215, title: '操作',align:'center', fixed: 'right', toolbar: '#barDemo'}*/
                    ,{field: 'image', title: '下载文件',templet:function (data) {
                        if(data.image == null){
                            return '未收到文件'
                        }
                        return '<a href="${pageContext.request.contextPath}\\'+data.image+'" download="'+data.oldFileName+'" class="layui-btn layui-bg-blue layui-btn-xs" >下载文件</a>'}}
                ]]
            });
            //第二个实例
            table.render({ //我收 到的邮件
                elem: '#Senddemo'
                ,height: 312
                ,toolbar: '#toolbarDemo'
                ,url: '${pageContext.request.contextPath}/email/SendEmail' //数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {type:'checkbox'}//复选框
                    ,{field: 'emailId', title: '编号', width:80, sort: true}
                    ,{field: 'empId', title: '发送人', width:120, sort: true}
                    ,{field: 'topic', title: '标题', width:80}
                    ,{field: 'sendtime', title: '时间', width:120,templet:function (row){
                            return createTime(row.sendtime);
                        }}
                    ,{field: 'isRead', title: '是否已读',templet:function (data) {
                            if( data.isRead ==1 ){
                                return '已读'
                            }else if(data.isRead == 2){
                                return '未读'
                            }
                        },width:120}
                    ,{width:215, title: '操作',align:'center', fixed: 'right', toolbar: '#barDemo'}
                ]]
            });
            //删除的方法
            table.on('toolbar(test)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'isDele':
                        var checkStatus = table.checkStatus('demo'),
                            data = checkStatus.data,
                            employeesId = " ";
                        if(data.length > 0){
                            for (var i in data){
                                employeesId+=data[i].HourId+",";
                            }
                            layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                                $.post('${pageContext.request.contextPath}/dormitory/dormitorydelete',{
                                    id:employeesId
                                },function(data){
                                    table.reload("demo");
                                    layer.close(index);
                                });
                            });
                        }else{
                            layer.msg('请选择需要删除的数据');
                        }
                        break;
                    case 'isAdd':
                        window.open("${pageContext.request.contextPath}/stu/toAdd");
                        break;
                };
            });

            //删除l
            table.on('toolbar(test)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'isDele':
                        var checkStatus = table.checkStatus('demo'),
                            data = checkStatus.data,
                            employeesId = " ";
                        if(data.length > 0){
                            for (var i in data){
                                employeesId+=data[i].emailId+",";
                            }
                            layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                                $.post('${pageContext.request.contextPath}/email/deleteEmail',{
                                    id:employeesId
                                },function(data){
                                    table.reload("demo");
                                    layer.close(index);
                                });
                            });
                        }else{
                            layer.msg('请选择需要删除的数据!');
                        }
                        break;
                    case 'isAdd':
                        window.open("${pageContext.request.contextPath}/stu/toAdd");
                        break;
                };
            });

            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'selectedit'){
                    var emailId = data.emailId;
                    window.location.href="<%=request.getContextPath()%>/email/toemailServlet?emailId="+emailId;
                }else if(obj.event === 'edit'){
                    var emailId = data.emailId;
                    window.location.href="<%=request.getContextPath()%>/email/againEmail?emailId="+emailId;
                }
            });

        });
        function fans() {
            window.location.href="<%=request.getContextPath()%>/email/toemailadd";
        }
        function createTime(v){
            var date = new Date(v);
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            m = m<10?'0'+m:m;
            var d = date.getDate();
            d = d<10?("0"+d):d;
            var str = y+"-"+m+"-"+d;
            return str;
        }
    </script>
</body>
</html>
