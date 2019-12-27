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
    <title>问题反馈</title>
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
    <%--<a id="myattedan"  onclick="fans();"  class="easyui-linkbutton" data-options="iconCls:'icon-add'">我的审批</a>--%>
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <div id="tabs" class="easyui-tabs" fit="true">
            <div title="发送的审批">
                <a id="add"  onclick="add();"  class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加反馈</a>
                <table id="demos" lay-filter="test2"  ></table>
            </div>
             <div title="我的审批">
                 <table id="Senddemo" lay-filter="test" ></table>
             </div>
        </div>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="width: 800px;">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>
        <script type="text/html" id="toolbarDemos">
            <div class="layui-btn-container" style="width: 800px;">
                <button class="layui-btn layui-btn-sm" lay-event="isDeles">批量删除</button>
            </div>
        </script>

    </div>

    <%--隐藏提交表单--%>
    <div id="winadd" class="easyui-window"
         data-options="title:'添加',iconCls:'icon-save',modal:true,closed:true"
         style="width: 600px; height: 400px; padding: 5px; top: 20px;">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center',border:false"
                 style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form action="<%=request.getContextPath()%>/feedback/addfeedback" enctype="multipart/form-data" method="post" id="addform">
                    <input type="hidden" name="namevalue" value="1" />
                    <table width="80%" align="center" border="0">
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>审核人&nbsp;&nbsp;</td>
                            <td>
                                部门：<select id="deptId" name="deptIds" style="width: 90px;height: 35px;margin: 10px">
                                    <option value=""> 选择部门</option>
                                <c:forEach items="${Edeptlist}" var="li">
                                    <option value=${li.get("deptId")}>${li.get("deptName")}</option>
                                </c:forEach>
                            </select>
                                员工：<select id="empnames" name="userIds" style="width: 90px;height: 35px">
                                    </select>
                            </td>
                        </tr>

                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>建议:&nbsp;&nbsp;</td>
                            <td>
                                <textarea name="remarks" id="remarks" style=" width: 200px; height: 60px"></textarea>
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
    <%--审核隐藏提交表单--%>
    <div id="wins" class="easyui-window"
         data-options="title:'添加',iconCls:'icon-save',modal:true,closed:true"
         style="width: 600px; height: 400px; padding: 5px; top: 20px;">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center',border:false"
                 style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form action="<%=request.getContextPath()%>/feedback/updfeedback"  method="post" id="updform">
                    <input type="hidden" name="feedbackId" id="feedbackId" />
                    <input type="hidden" name="feedBackType"  id="feedBackType" />
                    <input type="hidden" name="empname" id="empname" />
                    <input type="hidden" name="feedbackTimes"  id="feedbackTime"  />
                    <input type="hidden" name="status" id="status" />
                    <input type="hidden" name="deptId" id="deptIds" />
                    <input type="hidden" id="userId" name="userId"   >
                    <table width="80%" align="center" border="0">
                        <tr>
                            <td>申请人:</td>
                            <td>
                                <input type="text" id="empId" name="empId" readonly="true" style="width: 200px; height: 40px"/>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>申请说明:</td>
                            <td>

                                <input type="text" id="remark"  name="remark" readonly="true"style="width: 200px; height: 40px"/>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>审核说明:&nbsp;&nbsp;</td>
                            <td>
                                <textarea name="opinion" id="opinion" style=" width: 200px; height: 60px"></textarea>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div data-options="region:'south',border:false"
                 style="text-align: right; padding: 5px 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
                   href="javascript:void(0)" onclick="updsub()">同意</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
                   href="javascript:void(0)" onclick="updclose()">拒绝</a>
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
            elem: '#demos'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemos'
            ,url: '${pageContext.request.contextPath}/feedback/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'feedbackId', title: '编号', width:73, sort: true}
                ,{field: 'feedbackTime', title: '反馈时间', width:200,templet:function (row){
                        return createTime(row.feedbackTime);
                    }}
                ,{field: 'feedBackType', title: '类型', width:120,templet:function (row){
                        if(row.feedBackType == 1){
                            return"员工"
                        }else if(row.feedBackType == 2){
                            return "学生"
                        }
                    }}
                ,{field: 'empname', title: '姓名', width:120}
                ,{field: 'remark', title: '建议'}
                ,{field: 'status', title: '状态', width:100,templet:function (row){
                        if(row.status == 1){
                            return"未处理"
                        }else if(row.status == 2){
                            return "已处理"
                        }
                    }}
                ,{field: 'deptName', title: '部门',width:150}
                ,{field: 'opinion', title: '审批意见'}
            ]]
        });

        //第二个实例
        table.render({
            elem: '#Senddemo'
            ,height:'full-200'
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/feedback/mylist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',width:100}//复选框
                ,{field: 'feedbackId', title: '编号', width:73, sort: true}
                ,{field: 'feedbackTime', title: '反馈时间', width:200,templet:function (row){
                        return createTime(row.feedbackTime);
                    }}
                ,{field: 'feedBackType', title: '类型', width:120,templet:function (row){
                        if(row.feedBackType == 1){
                            return"员工"
                        }else if(row.feedBackType == 2){
                            return "学生"
                        }
                    }}
                ,{field: 'empname', title: '姓名', width:120}
                ,{field: 'remark', title: '建议'}
                ,{field: 'status', title: '状态', width:100,templet:function (row){
                        if(row.status == 1){
                            return"未处理"
                        }else if(row.status == 2){
                            return "已处理"
                        }
                    }}
                ,{field: 'deptName', title: '部门',width:150}
                ,{field: 'opinion', title: '审批意见'}
                ,{ title: '操作', width:75,
                    templet:function (row){
                        return chaozuoPand(row.feedbackId,row.status);
                    }
                }
            ]]
        });

        table.on('toolbar(test2)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDeles':
                    var checkStatus = table.checkStatus('demos'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].feedbackId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/feedback/delfeedback',{
                                id:employeesId
                            },function(data){
                                table.reload("demos");
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

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('Senddemo'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].feedbackId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/feedback/delfeedback',{
                                id:employeesId
                            },function(data){
                                table.reload("Senddemo");
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
                $("#feedbackId").val(data.feedbackId);
                $("#feedBackType").val(data.feedBackType);
                $("#empId").val(data.empId);
                $("#empname").val(data.empname);
                $("#feedbackTime").val(createTime(data.feedbackTime));
                $("#remark").val(data.remark);
                $("#status").val(data.status);
                $("#deptIds").val(data.deptId);
                $("#userId").val(data.userId);
            }
        });
    });

    $(function () {
        var data2 = 1;

        $("#deptId").change(function () {
            $("#empnames").empty();
            /*alert("选择了下拉框");
            $("#namevalue").val("2");
            alert( $("#namevalue").val())*/
            $("#empnames").empty();
            var options = $("#deptId option:selected");　　　　//获取选中项
            var deptId = options.val();　　　　　　　　　　　　　　//获取选中项的值　　　　　　　　　　　　　                  //检验是否获取到值
            $.ajax({
                url : "<%=request.getContextPath()%>/feedback/selsendfeedback",
                type: "post",
                data :{
                    deptname :deptId
                },
                dataType : "json",
                success : function (data) {
                    var List = data.data;

                    $.each(List,function(index,obj){
                        var html = "<option value=\"" +this.empId + "\"> " + this.empName + "</option>";
                        //给省下拉框加上拼接的option
                        sesslist =this.empName
                        $("#empnames").append(html);
                    });
                }
            })
        });



    })

    function sub() {
        var num ='';
        var options = $("#empnames option:selected");　　　　//获取选中项
        num = options.val();
        if(num == undefined){
            alert("请选择反馈人");
            $("#winadd").window("close")
            return;
        }
        $("#addform").form("submit",{
            success : function () {
                $("#addform").form("clear");
                window.location.href="<%=request.getContextPath()%>/feedback/tofeedback";
            }
        })

    }
    function updsub() {
        $("#updform").form("submit",{
            success : function () {
                $("#updform").form("clear");
                window.location.href="<%=request.getContextPath()%>/feedback/tofeedback";
            }
        })

    }
    function updclose () {
        $("#updform").form("submit",{
            success : function () {
                $("#wins").window("close");
                $("#updform").form("clear");
                window.location.href="<%=request.getContextPath()%>/feedback/tofeedback";
            }
        })
    }
    function time() {
        var time = new Date();
        var y = time.getFullYear();
        var m = time.getMonth()+1;
        var d = time.getDate();
        var H = time.getHours();
        var M = time.getMinutes();
        var S = time.getSeconds();
        return y+"-"+m+"-"+d+" "+H+":"+M+":"+S ;
    }

    function close1 () {
        $("#winadd").window("close");
    }
    //添加
    function add() {
        $("#winadd").window("open");

    }

    function chaozuoPand(id,zt) {
        if(zt === 1){
            var html = "<a class=\"layui-btn layui-btn-xs\" lay-event=\"edit\">审核</a>"
        }else{
            var html = "";
        }
        return html;
    }

    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var H = date.getHours();
        var M = date.getMinutes();
        var S = date.getSeconds();
        var str = y+"-"+m+"-"+d +" "+H +":"+M + ":" +S;
        return str;
    }
    //时间修改方法
    function createTimes(v){
        var date = new Date(v);
        var y = date.getHours();
        var m = date.getMinutes();
        m = m<10?'0'+m:m;
        var d = date.getSeconds();
        d = d<10?("0"+d):d;
        var str = y+"："+m+"："+d;
        return str;
    }
</script>
</body>
</html>
