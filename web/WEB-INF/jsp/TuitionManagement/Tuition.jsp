<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/7
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学费管理</title>
    <jsp:include page="../../../index.jsp"></jsp:include>
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;">
        <%--信息显示表--%>
        <table id="demo" lay-filter="test"  ></table>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="width: 800px;">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>

    </div>
    <div data-options="region:'east',split:true,collapsed:true,title:'修改'" style="width:350px;">
        <div id="tt" class="easyui-tabs"  data-options="tools:'#tabs1'" style="height: 600px;">

        </div>
    </div>
</div>
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
            ,url: '${pageContext.request.contextPath}/Tuition/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'financeId', title: '编号', width:80, sort: true}
                ,{field: 'financedate', title: '地址', width:120}
                ,{field: 'stuid', title: '宿舍人数', width:120, sort: true}
                ,{field: 'termId', title: '序号', width:80}
                ,{field: 'receipt', title: '宿舍房号', width:120}
                ,{field: 'financeType', title: '床位数', width: 80}
                ,{field: 'factMoney', title: '床位数', width: 80}
                ,{field: 'empid', title: '床位数', width: 80}
                ,{field: 'remark', title: '床位数', width: 80}
                ,{field: 'Invalid', title: '床位数', width: 80}
                ,{field: 'tuitionTypeId', title: '床位数', width: 80}
            ]]
        });


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
                            $.post('${pageContext.request.contextPath}/Tuition/Tuitiondelete',{
                                id:financeId
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
        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'edit'){

                $("#wins").window("open");
                $("#count").val(data.count);
                $("#HourId").val(data.HourId);
                $("#hourIddsc").val(data.hourIddsc);
                $("#hourName").val(data.hourName);
                $("#numberBeds").val(data.numberBeds);
                $("#addr").val(data.addr);
                $("#floorId").val(data.floorId);
            }
        });

    });

    function add() {
        $("#addDor").form("submit",{
            success : function () {
                $("#addDor").form("clear");
                window.location.href="<%=request.getContextPath()%>/dormitory/todormitory";
            }
        })
    }
</script>
</body>
</html>
