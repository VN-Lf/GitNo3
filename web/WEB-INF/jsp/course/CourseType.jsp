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
    <title>课程类别</title>
    <jsp:include page="../../../index.jsp"></jsp:include>
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
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        </script>
    </div>
    <div data-options="region:'east',split:true,collapsed:true,title:'修改'" style="width:350px;">
        <div id="tt" class="easyui-tabs"  data-options="tools:'#tabs1'" style="height: 600px;">
            <div title="新增">
                <a id="add"  class="easyui-linkbutton" onclick="add()" data-options="iconCls:'icon-add'">Add</a>
                <form action="<%=request.getContextPath()%>/course/addCourseType" method="post" id="addDor">
                    <table width="300px" align="center" border="0">
                        <tr>
                            <td>类别名称:&nbsp;&nbsp;</td>
                            <td><input id="courseTypeName" class="easyui-validatebox" type="text" name="courseTypeName"></td>
                        </tr>
                        <tr>
                            <td>说明:&nbsp;&nbsp;</td>
                            <td><input id="courseRemark" class="easyui-validatebox" type="text" name="courseRemark"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>

    <%--隐藏提交表单--%>
    <div id="wins" class="easyui-window"
         data-options="title:'修改',iconCls:'icon-save',modal:true,closed:true"
         style="width: 600px; height: 400px; padding: 5px; top: 20px;">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center',border:false"
                 style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form action="<%=request.getContextPath()%>/course/UpdateCourseType" enctype="multipart/form-data" method="post" id="addform">
                    <input type="hidden" name="courseTypeId" id="updtecourseTypeId" />
                    <table width="80%" align="center" border="0">
                        <tr>
                            <td>填写日期:</td>
                            <td>

                                <input type="text" id="updtcourseTypeName" name="courseTypeName" style="width: 200px; height: 40px"/>
                            </td>
                        </tr>
                        <tr>
                            <td>填写日期:</td>
                            <td>
                                <input type="text" id="updtcourseRemark" name="courseRemark" style="width: 200px; height: 40px"/>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div data-options="region:'south',border:false"
                 style="text-align: right; padding: 5px 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
                   href="javascript:void(0)" onclick="sub()">Ok</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
                   href="javascript:void(0)" onclick="close1()">Cancel</a>
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
            ,url: '${pageContext.request.contextPath}/course/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',width:100}//复选框
                ,{field: 'courseTypeId', title: '编号', width:200, sort: true}
                ,{field: 'courseTypeName', title: '课程类型  ', width:200}
                ,{field: 'courseRemark', title: '说明  ', width:200}
                ,{width:215, title: '操作',align:'center', fixed: 'right', toolbar: '#barDemo'}
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
                            employeesId+=data[i].courseTypeId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/course/courseTypedel',{
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
            if(obj.event === 'edit'){
                $("#wins").window("open");
                $("#updtecourseTypeId").val(data.courseTypeId);
                $("#updtcourseTypeName").val(data.courseTypeName);
                $("#updtcourseRemark").val(data.courseRemark);
            }
        });

    });

    function sub() {
        $("#addform").form("submit",{
            success : function () {
                $("#addform").form("clear");
                $("#win").window("close");
                window.location.href="<%=request.getContextPath()%>/course/toCourseType";
            }
        })
    }

    function close1 () {
        $("#wins").window("close");
    }
    //添加
    function add() {
        $("#addDor").form("submit",{
            success : function () {
                $("#addDor").form("clear");
                window.location.href="<%=request.getContextPath()%>/course/toCourseType";
            }
        })
    }

</script>

</body>
</html>
