<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>课程管理</title>
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
                <form action="<%=request.getContextPath()%>/courseManage/addCourse" method="post" id="addDor">
                    <table width="300px" align="center" border="0">
                        <tr>
                            <td>课程名称:&nbsp;&nbsp;</td>
                            <td>
                                <div style="margin-bottom:6px;" >
                                    <input class="easyui-textbox" name="courseName" style="width:100%" data-options="label:'Name:',required:true">
                                </div>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>是否必修:&nbsp;&nbsp;</td>
                            <td>
                                <select name="courseIsNes" STYLE="width: 100PX;" >
                                    <option value="1"> 是</option>
                                    <option value="2"> 否</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>课程类别:&nbsp;&nbsp;</td>
                            <td>
                                <select name="courseTypeId" STYLE="width: 100PX;">
                                    <c:forEach items="${courseList}" var="li" >
                                        <option value=${li.get("courseTypeId")}>${li.get("courseTypeName")}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>说明:&nbsp;&nbsp;</td>
                            <td>
                                <textarea name="courseRemark" id="content" style=" width: 200px; height: 60px"></textarea>
                            </td>
                        </tr>
                    </table>
                </form>
                <button id="add"  class="layui-btn layui-btn-normal" style="margin: 20px 0 0 130px;" onclick="add()">添加数据</button>
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
                <form action="<%=request.getContextPath()%>/courseManage/updateCourse" enctype="multipart/form-data" method="post" id="addform">
                    <input type="hidden" name="courseId" id="updtecourseTypeId" />
                    <table width="80%" align="center" border="0">
                        <tr>
                            <td>课程名称:&nbsp;&nbsp;</td>
                            <td>
                                <div style="margin-bottom:6px;" >
                                    <input class="easyui-textbox" name="courseName" id="updatecourseName" style="width:100%" data-options="label:'Name:',required:true">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>是否必修:&nbsp;&nbsp;</td>
                            <td>
                                <select name="courseIsNes" id="updcourseIsNes">
                                    <option value="1"> 是</option>
                                    <option value="2"> 否</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>课程类别:&nbsp;&nbsp;</td>
                            <td>
                                <select name="courseTypeId"  id="updcourseTypeId">
                                    <c:forEach items="${courseList}" var="li" >
                                        <option value=${li.get("courseTypeId")}>${li.get("courseTypeName")}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>说明:&nbsp;&nbsp;</td>
                            <td>
                                <textarea name="courseRemark" id="updcourseRemark"  style=" width: 200px; height: 60px"></textarea>
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
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/courseManage/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',width:100}//复选框
                ,{field: 'courseId', title: '编号', width:100, sort: true}
                ,{field: 'courseName', title: '课程名  ', width:200}
                ,{field: 'courseIsNes', title: '是否必修 ',templet:function (data) {
                        if( data.courseIsNes ==1 ){
                            return '是'
                        }else if(data.courseIsNes == 2){
                            return '否'
                        }
                    }, width:100}
                ,{field: 'typeName', title: '课程', width:150}
                ,{field: 'courseRemark', title: '说明  '}
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
                            employeesId+=data[i].courseId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/courseManage/delCourse',{
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
                $("#updtecourseTypeId").val(data.courseId);
                $("#updatecourseName").val(data.courseName);
                $("#updcourseIsNes").val(data.courseIsNes);
                $("#updcourseTypeId").val(data.courseTypeId);
                $("#updcourseRemark").val(data.courseRemark);
            }
        });
    });
    function sub() {
        $("#addform").form("submit",{
            success : function () {
                $("#addform").form("clear");
                $("#wins").window("close");
                window.location.href="<%=request.getContextPath()%>/courseManage/toCourse";
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
                window.location.href="<%=request.getContextPath()%>/courseManage/toCourse";
            }
        })
    }
</script>

</body>
</html>
