<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/9
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>我的周报</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <jsp:include page="${pageContext.request.contextPath}/index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >

        <form  method="post" style="width: 1205px;margin: 20px 0px 0px 10px">
            <%--员工姓名:<input type="text" name="empname" id="empname" required lay-verify="required" placeholder="请输人姓名"  class="layui-input" style="width:180px;display:inline-block" />--%>

            开始时间:
            <div class="layui-inline" style="width:180px;display:inline-block;"> <!-- 注意：这一层元素并不是必须的 -->
                <input type="text" name="starttime" id="starttime" class="layui-input">
            </div>
            结束时间:
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元素并不是必须的 -->
                <input type="text" name="endtime" id="endtime"  class="layui-input">
            </div>
            <input class="layui-btn layui-btn-normal" id="selectexam"  style="width: 80px" value="搜索" />
        </form>
        <%--信息显示表--%>
        <table id="demo" lay-filter="test"  ></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        </script>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="left: 300px">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>

    </div>
    <div data-options="region:'east',split:true,collapsed:true,title:'修改'" style="width:500px;">
        <div id="tt" class="easyui-tabs"  data-options="tools:'#tabs1'" style="height: 600px;">
            <div title="新增">
                <a id="add"  class="easyui-linkbutton" onclick="add()" data-options="iconCls:'icon-add'">新增周报</a>
                <form action="<%=request.getContextPath()%>/Weekly/Weeklyadd" method="post" id="addDor">
                    <input type="hidden" name="weekCycleD" id="weekCycleDadd" value="1999-1-1"/>
                    <input type="hidden" name="empId" id="empIdadd" value="0" />
                    <table width="300px" align="center" border="0">
                        <tr>
                            <td><h4 style="width: 100px">工作描述</h4></td>
                            <td>
                                <textarea name="weekDescription" id="weekDescriptionadd" style="width: 400px; height: 80px"></textarea>
                                <%--<input id="weekDescriptionadd"  type="text" name="weekDescription">--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>工作意见</td>
                            <td>
                                <textarea name="weekOption" id="weekOptionadd" style="width: 400px; height: 80px"></textarea>
                                <%--<input id="weekOptionadd" type="text" name="weekOption">--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>学生问题</td>
                            <td>
                                <textarea name="weekStudentQuestion" id="weekStudentQuestionadd" style="width: 400px; height: 80px"></textarea>
                                <%--<input type="text" name="weekStudentQuestion" id="weekStudentQuestionadd">--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>下周工作计划</td>
                            <td>
                                <textarea name="weekNextPlan" id="weekNextPlanadd" style="width: 400px; height: 80px"></textarea>
                                <%--<input type="text" name="weekNextPlan" id="weekNextPlanadd"/>--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>工作学期</td>
                            <td>
                                <select name="weekTerm" id="weekTermadd" style="width: 150px">
                                    <option> 第一学期</option>
                                    <option> 第二学期</option>
                                    <option> 第三学期</option>
                                    <option> 第四学期</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
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
                <form action="<%=request.getContextPath()%>/Weekly/Weeklyupdate" enctype="multipart/form-data" method="post" id="addform">
                    <input type="hidden" name="weekPaperId" id="weekPaperId" />
                    <input type="hidden" name="empId" id="empId" />
                    <table width="80%" align="center" border="0">
                        <tr>
                            <td>填写日期:</td>
                            <td>
                                <input type="date" id="weekCycleD" name="weekCycleD" style="width: 200px; height: 40px"/>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td> <h4 style="width: 100px">工作描述</h4></td>
                            <td>
                                <textarea name="weekDescription" id="weekDescription" style="width: 400px; height: 80px"></textarea>
                                <%--<input   type="text" name="weekDescription" >--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>工作意见</td>
                            <td>
                                <textarea name="weekOption" id="weekOption" style=" left: 200px;width: 400px; height: 80px"></textarea>
                                <%--<input id="weekOption" type="text" name="weekOption">--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>学生问题</td>
                            <td>
                                <textarea name="weekStudentQuestion" id="weekStudentQuestion" style="left: 200px; width: 400px; height: 80px"></textarea>
                                <%--<input type="text" name="weekStudentQuestion" id="weekStudentQuestion">--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>下周工作计划</td>
                            <td>
                                <textarea name="weekNextPlan" id="weekNextPlan" style="width: 400px; height: 80px"></textarea>
                                <%--<input type="text" name="weekNextPlan" id="weekNextPlan"/>--%>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>工作学期:</td>
                            <td>
                                <textarea name="weekTerm" id="weekTerm" style="width: 400px; height: 80px"></textarea>
                                <%--<input type="text" name="weekTerm" id="weekTerm"/>--%>
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

    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        //解决jquery包冲突
        jQuery.noConflict();
        function sub() {
            var num = '';
            num = $("#weekCycleD").val();
            if(num == ''){
                alert("请选择时间");
                $("#wins").window("close");
                return ;
            }
            $("#addform").form("submit",{
                success : function () {
                    $("#addform").form("clear");
                    $("#wins").window("close");
                    window.location.href="<%=request.getContextPath()%>/Weekly/toWeekly";
                }
            })
        }

        function close1 () {
            $("#wins").window("close");
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
        function add() {
            $("#addDor").form("submit",{
                success : function () {
                    $("#addDor").form("clear");
                    window.location.href="<%=request.getContextPath()%>/Weekly/toWeekly";
                }
            })
        }
        layui.use(['table','laydate'], function(){
            var table = layui.table;
            var laydate = layui.laydate;
            //第一个实例
            table.render({
                elem: '#demo'
                ,height: 312
                ,toolbar: '#toolbarDemo'
                ,url: '${pageContext.request.contextPath}/Weekly/list' //数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {type:'checkbox'}//复选框
                    ,{field: 'weekPaperId', title: '编号', width:80, sort: true}
                    ,{field: 'empNames', title: '员工', width:80, sort: true}
                    ,{field: 'weekCycle', title: '填写日期', width:120,templet:function (row){
                            return createTime(row.weekCycle);
                        }, sort: true}
                    ,{field: 'weekDescription', title: '工作描述', width:80}
                    ,{field: 'weekOption', title: '工作意见', width:120}
                    ,{field: 'weekStudentQuestion', title: '学生问题', width: 80}
                    ,{field: 'weekNextPlan', title: '下周工作计划', width: 80}
                    ,{field: 'weekTerm', title: '工作学期', width: 80}
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
                                employeesId+=data[i].weekPaperId+",";
                            }
                            layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                                $.post('${pageContext.request.contextPath}/Weekly/WeeklyDelete',{
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



            //时间选择器
            laydate.render({
                elem: '#starttime' //指定元素
            });

            laydate.render({
                elem: '#endtime' //指定元素
            });
            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'edit'){
                        $("#wins").window("open");
                        $("#weekPaperId").val(data.weekPaperId);
                        $("#weekCycleD").val(data.weekCycleD);
                        $("#weekDescription").val(data.weekDescription);
                        $("#weekOption").val(data.weekOption);
                        $("#weekStudentQuestion").val(data.weekStudentQuestion);
                        $("#weekNextPlan").val(data.weekNextPlan);
                        $("#weekTerm").val(data.weekTerm);
                        $("#weekCycle").val(data.weekCycle);
                        $("#empId").val(data.empId);
                }
            });

            $('#selectexam').click(function () {
                /*var empname=$('#empname').val();*/
                /* var Depid=$('#Depid').val();*/
                var starttime=$('#starttime').val();
                var endtime=$('#endtime').val();
                table.reload('demo',{
                    url:'${pageContext.request.contextPath}/Weekly/MyWeeklist',
                    where:{
                        /*empname:empname,*/
                        /*Depid:Depid,*/
                        starttime:starttime,
                        endtime:endtime
                    },page:{
                        curr:1
                    }
                });
            });

        });


    </script>
</body>
</html>
