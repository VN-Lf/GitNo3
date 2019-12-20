<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <title>宿舍管理</title>

    <%List<Map> list = (List) request.getAttribute("dlist");%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
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
            <%--信息显示表--%>
            <table id="demo" lay-filter="test"  ></table>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            </script>
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container" style="width: 800px;">
                    <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
                </div>
            </script>

        </div>
        <div data-options="region:'east',split:true,collapsed:true,title:'修改'" style="width:350px;">
            <div id="tt" class="easyui-tabs"  data-options="tools:'#tabs1'" style="height: 600px;">
                <div title="新增">
                    <form action="<%=request.getContextPath()%>/dormitory/dormadd" method="post" id="addDor">
                        <table width="300px" align="center" border="0">
                            <tr>
                                <td>地址:</td>
                                <td>
                                    <select name="addr" id="addrs">
                                        <%
                                            for(int i = 0;i<list.size();i++){
                                        %>
                                        <option value="<%=list.get(i).get("floorName")%>"><%=list.get(i).get("floorName")%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr><td> &nbsp;&nbsp;</td></tr>
                            <tr>
                                <td>所属楼栋:</td>
                                <td>
                                    <select name="floorId" id="floorIdss">
                                        <%
                                            for(int i = 0;i<list.size();i++){
                                        %>
                                        <option value="<%=list.get(i).get("floorId")%>"><%=list.get(i).get("floorId")%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr><td> &nbsp;&nbsp;</td></tr>
                            <tr>
                                <td>宿舍人数:</td>
                                <td><input id="counts" class="easyui-validatebox" type="text" name="count"></td>
                            </tr>
                            <tr><td> &nbsp;&nbsp;</td></tr>
                            <tr>
                                <td>序号:</td>
                                <td><input class="easyui-validatebox" type="text" name="hourIddsc" id="hourIddscs"></td>
                            </tr>
                            <tr><td> &nbsp;&nbsp;</td></tr>
                            <tr>
                                <td>宿舍房号:</td>
                                <td>
                                    <input type="text" name="hourName" id="hourNames"/><br>
                                </td>
                            </tr>
                            <tr><td> &nbsp;&nbsp;</td></tr>
                            <tr>
                                <td>床位数:</td>
                                <td>
                                    <input type="text" name="numberBeds" id="numberBedss"/>
                                </td>
                            </tr>
                        </table>
                    </form>
                    <button id="add"  class="layui-btn layui-btn-normal" style="margin: 20px 0 0 130px;" onclick="add()">添加数据</button>
                </div>
            </div>
        </div>
    </div>
<%--隐藏提交表单--%>
    <div id="wins" class="easyui-window"
         data-options="title:'修改',iconCls:'icon-save',modal:true,closed:true"
         style="width: 500px; height: 400px; padding: 5px; top: 20px;">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center',border:false"
                 style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form action="<%=request.getContextPath()%>/dormitory/dormupdate" enctype="multipart/form-data" method="post" id="addform">
                    <input type="hidden" name="HourId" id="HourId" />
                    <table width="80%" align="center" border="0">
                        <tr>
                            <td>地址</td>
                            <td>
                                <select name="addr" id="addr">
                                    <%
                                        for(int i = 0;i<list.size();i++){
                                        %>
                                    <option value="<%=list.get(i).get("floorName")%>"><%=list.get(i).get("floorName")%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td>所属楼栋</td>
                            <td>
                                <select name="floorId" id="floorId">
                                    <%
                                        for(int i = 0;i<list.size();i++){
                                    %>
                                    <option value="<%=list.get(i).get("floorId")%>"><%=list.get(i).get("floorId")%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>宿舍人数</td>
                            <td><input id="count" class="easyui-validatebox" type="text" name="count"></td>
                        </tr>
                        <tr>
                            <td>序号</td>
                            <td><input class="easyui-validatebox" type="text" name="hourIddsc" id="hourIddsc"></td>
                        </tr>

                        <tr>
                            <td>宿舍房号</td>
                            <td>
                                <input type="text" name="hourName" id="hourName"/>
                            </td>
                        </tr>

                        <tr>
                            <td>床位数</td>
                            <td>
                                <input type="text" name="numberBeds" id="numberBeds"/>
                            </td>
                        </tr>

                    </table>
                </form>
            </div>
            <div data-options="region:'south',border:false"
                 style="text-align: right; padding: 5px 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
                   href="javascript:void(0)" onclick="sub()">Ok</a> <a
                    class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
                    href="javascript:void(0)" onclick="close1()">Cancel</a>
            </div>
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
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/dormitory/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                 {type:'checkbox'}//复选框
                ,{field: 'stuHours', title: '编号', width:80, sort: true}
                ,{field: 'addr', title: '地址', width:120}
                ,{field: 'count', title: '宿舍人数', width:120, sort: true}
                ,{field: 'hourIddsc', title: '序号', width:80}
                ,{field: 'hourName', title: '宿舍房号', width:120}
                ,{field: 'numberBeds', title: '床位数', width: 80}
                ,{width:215, title: '操作',align:'center', fixed: 'right', toolbar: '#barDemo'}
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
                            employeesId+=data[i].stuHours+",";
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
    function sub() {
        $("#addform").form("submit",{
            success : function () {
                $("#addform").form("clear");
                $("#win").window("close");
                window.location.href="<%=request.getContextPath()%>/dormitory/todormitory";
            }
        })
    }

    function close1 () {
        $("#wins").window("close");
    }

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
