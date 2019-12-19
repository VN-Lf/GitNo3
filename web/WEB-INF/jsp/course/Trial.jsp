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
    <title>试讲和培训</title>
    <jsp:include page="../../../index.jsp"></jsp:include>
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <%
        HttpSession sess = request.getSession();
        String message = (String)sess.getAttribute("tianxdate");
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
            sess.setAttribute("tianxdate", "");
        }
    %>
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
                <form action="<%=request.getContextPath()%>/Trial/addTrial" method="post" id="addDor">
                    <table width="300px" align="center" border="0">
                        <tr>
                            <td>日期:&nbsp;&nbsp;</td>
                            <td>
                                <div style="margin-bottom:6px;" >
                                    <input type="date" class="easyui-textbox" id="trialDates"name="trialDates" style="width:100%" data-options="label:'Name:',required:true">
                                </div>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>时间:&nbsp;&nbsp;</td>
                            <td>
                                <select name="trialWeekDay" STYLE="width: 100PX;" >
                                    <option value="1"> 星期一</option>
                                    <option value="2"> 星期二</option>
                                    <option value="3"> 星期三</option>
                                    <option value="4"> 星期四</option>
                                    <option value="5"> 星期五</option>
                                    <option value="6"> 星期六</option>
                                    <option value="7"> 星期日</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>课程/章节:&nbsp;&nbsp;</td>
                            <td>
                                <select name="courseId" STYLE="width: 100PX;">
                                    <c:forEach items="${tcourselist}" var="li" >
                                        <option value=${li.get("courseId")}>${li.get("courseName")}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>授课类型:&nbsp;&nbsp;</td>
                            <td>
                                <select name="trialType" >
                                    <option value="1"> 试讲</option>
                                    <option value="2"> 培训</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>授课老师:&nbsp;&nbsp;</td>
                            <td>
                                <select name="empId" STYLE="width: 100PX;">
                                    <c:forEach items="${templist}" var="li" >
                                        <option value=${li.get("empId")}>${li.get("empName")}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>说明:&nbsp;&nbsp;</td>
                            <td>
                                <textarea name="trialRemark"  style=" width: 200px; height: 60px"></textarea>
                            </td>
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
                <form action="<%=request.getContextPath()%>/Trial/updateTrial" enctype="multipart/form-data" method="post" id="addform">
                    <input type="hidden" name="trialId" id="updtrialId" />
                    <table width="80%" align="center" border="0">
                        <tr>
                            <td>日期:&nbsp;&nbsp;</td>
                            <td>
                                <div style="margin-bottom:6px;" >
                                    <input type="date" id="updtrialDate" name="trialDates" style="width:100%" >
                                </div>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>时间:&nbsp;&nbsp;</td>
                            <td>
                                <select name="trialWeekDay" id="updtrialWeekDay" STYLE="width: 100PX;" >
                                    <option value="1"> 星期一</option>
                                    <option value="2"> 星期二</option>
                                    <option value="3"> 星期三</option>
                                    <option value="4"> 星期四</option>
                                    <option value="5"> 星期五</option>
                                    <option value="6"> 星期六</option>
                                    <option value="7"> 星期日</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>课程/章节:&nbsp;&nbsp;</td>
                            <td>
                                <select name="courseId" id="updcourseId" STYLE="width: 100PX;">
                                    <c:forEach items="${tcourselist}" var="li" >
                                        <option value=${li.get("courseId")}>${li.get("courseName")}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>授课类型:&nbsp;&nbsp;</td>
                            <td>
                                <select name="trialType" id="updtrialType" >
                                    <option value="1"> 试讲</option>
                                    <option value="2"> 培训</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>授课老师:&nbsp;&nbsp;</td>
                            <td>
                                <select name="empId" id="updempId" STYLE="width: 100PX;">
                                    <c:forEach items="${templist}" var="li" >
                                        <option value=${li.get("empId")}>${li.get("empName")}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>说明:&nbsp;&nbsp;</td>
                            <td>
                                <textarea name="trialRemark" id="updtrialRemark" style=" width: 200px; height: 60px"></textarea>
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
            ,url: '${pageContext.request.contextPath}/Trial/list' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',width:100}//复选框
                ,{field: 'trialId', title: '编号', width:100, sort: true}
                ,{field: 'trialDate', title: '日期  ', width:100,templet:function (row){
                        return createTime(row.trialDate);
                    }}
                ,{field: 'trialWeekDay', title: '工作日 ',templet:function (data) {
                        if( data.trialWeekDay ==1 ){
                            return '星期一'
                        }else if(data.trialWeekDay == 2){
                            return '星期二'
                        }else if(data.trialWeekDay == 3){
                            return '星期三'
                        }else if(data.trialWeekDay == 4){
                            return '星期四'
                        }else if(data.trialWeekDay == 5){
                            return '星期五'
                        }else if(data.trialWeekDay == 6){
                            return '星期六'
                        }else if(data.trialWeekDay == 7){
                            return '星期七'
                        }
                    }, width:100}
                ,{field: 'CourseName', title: '课程', width:100}
                ,{field: 'trialType', title: '授课类型', width:100,templet:function (data) {
                        if( data.trialType ==1 ){
                            return '试讲'
                        }else if(data.trialType == 2){
                            return '培训'
                        }
                    }
                }
                ,{field: 'empName', title: '授课老师', width:100}
                ,{field: 'trialRemark', title: '说明  ', width:100}
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
                            employeesId+=data[i].trialId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/Trial/delTrial',{
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
                $("#updtrialId").val(data.trialId);
                $("#updtrialDate").val(data.trialDate);
                $("#updtrialWeekDay").val(data.trialWeekDay);
                $("#updcourseId").val(data.courseId);
                $("#updtrialType").val(data.trialType);
                $("#updempId").val(data.empId);
                $("#updtrialRemark").val(data.trialRemark);

            }
        });
    });
    function sub() {
        var num = '';
        num = $("#updtrialDate").val();
        if(num == ''){
            alert("请选择时间");
            $("#wins").window("close");
            return ;
        }
        $("#addform").form("submit",{
            success : function () {
                $("#addform").form("clear");
                $("#wins").window("close");
                window.location.href="<%=request.getContextPath()%>/Trial/toTrial";
            }
        })

    }

    function close1 () {
        $("#wins").window("close");
    }
    //添加
    function add() {
        var num = '';
        num = $("#trialDates").val();
        if(num == ''){
            alert("请选择时间");
            $("#wins").window("close");
            return ;
        }
        $("#addDor").form("submit",{
            success : function () {
                $("#addDor").form("clear");
                window.location.href="<%=request.getContextPath()%>/Trial/toTrial";
            }
        })
    }
    //时间修改方法
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
