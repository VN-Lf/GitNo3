<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <title>楼栋管理</title>
    <jsp:include page="../../../index.jsp"></jsp:include>
    <%String num = (String) request.getAttribute("num");%>
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <%--信息显示表--%>
        <table id="demo" lay-filter="test"  ></table>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="left: 300px">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>

    </div>
    <div data-options="region:'east',split:true,collapsed:true,title:'修改'" style="width:350px;">
        <div id="tt" class="easyui-tabs"  data-options="tools:'#tabs1'" style="height: 600px;">
            <div title="新增">
                <a id="add"  class="easyui-linkbutton" onclick="add()" data-options="iconCls:'icon-add'">Add</a>
                <form action="<%=request.getContextPath()%>/Building/Buildingadd" method="post" id="addDor">
                    <table width="300px" align="center" border="0">
                        <tr>
                            <td>楼栋:&nbsp;&nbsp;</td>
                            <td><input id="counts" class="easyui-validatebox" type="text" name="floorName"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>

    jQuery.noConflict();
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/Building/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',width:100}//复选框
                ,{field: 'floorId', title: '编号', width:200, sort: true}
                ,{field: 'floorName', title: '楼栋名称  ', width:300}

            ]]
        });

        //楼栋删除
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].floorId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/Building/Buildingdelete',{
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
    });

    //添加
    function add() {
        /*var num = ;
        if(num.eq("1")){
            alert("数据重复");
            return;
        }
        */
        $("#addDor").form("submit",{
            success : function () {
                $("#addDor").form("clear");
                window.location.href="<%=request.getContextPath()%>/Building/toys";
            }
        })
    }
</script>
<%--<script>
    $(function(){
        var num = document.getElementById("num");
        alert(num);
        if(num.eq("1")){
            alert("数据重复,请重新添加")
        }
    }
</script>--%>
</body>
</html>
