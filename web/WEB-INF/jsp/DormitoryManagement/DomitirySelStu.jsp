<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>查看宿舍学生</title>

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
        <button type="button"  onclick="close1()" style="width: 80px; height: 40px">返回</button>
        <button type="button"  onclick="close2()" style="width: 80px; height: 40px">添加学生</button>
        <table id="demo" lay-filter="test"  ></table>
    </div>
</div>
<%--隐藏提交表单--%>
<div id="wins" class="easyui-window"
     data-options="title:'添加宿舍学员',iconCls:'icon-save',modal:true,closed:true"
     style="width: 600px; height: 400px; padding: 5px; top: 20px;">
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'center',border:false"
             style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form action="<%=request.getContextPath()%>/dormitory/dormStu/${deptname}" enctype="multipart/form-data" method="post" id="addform">
                <input type="hidden" name="weekPaperId" id="weekPaperId" />
                <input type="hidden" name="empId" id="empId" />
                <table width="80%" align="center" border="0">
                    班级：<select id="deptId" style="width: 80px;height: 35px">
                    <c:forEach items="${Edeptlist}" var="li">
                        <option value=${li.get("classId")}>${li.get("className")}</option>
                    </c:forEach>
                        </select>
                    学生：<select id="empnames" style="width: 80px;height: 35px"></select>
                    <tr><td> &nbsp;&nbsp;</td></tr>
                    <div style="margin: 10px 48px">
                        <a style="font-size: 16px;cursor: pointer;" id="adddept" name="adddept">添加</a>
                        <a style="font-size: 16px;margin-left: 102px;color: red;cursor: pointer;" id="deldept" name="deldept" style="left: 225px">重 置</a>
                    </div>
                    <div style="margin-top: 15px">
                        接收人：
                        <input type="hidden" name="receId" id="receId">
                        <input type="hidden" name="receName" id="receName2">
                        <input type="text" id="receName" autocomplete="off" disabled required style="width:228px;height:30px;
                    display:inline-block;padding-left:10px;background-Color: transparent;border: none;border-bottom: 1px solid #000;" />
                    </div>
                </table>
            </form>
        </div>
        <div data-options="region:'south',border:false"
             style="text-align: right; padding: 5px 0;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
               href="javascript:void(0)" onclick="updsub()">Ok</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               href="javascript:void(0)" onclick="close3()">Cancel</a>
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
            ,url: '${pageContext.request.contextPath}/dormitory/stulist/${deptname}' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'HourName', title: '宿舍房号', width:80, sort: true}
                ,{field: 'stuName', title: '学生姓名', width:120, sort: true}
                ,{field: 'className', title: '所在班级', width:120, sort: true}
                ,{field: 'stuPhone', title: '学生号码', width:200}
            ]]
        });

    });
    function close1 () {
        window.location.href="<%=request.getContextPath()%>/dormitory/todormitory";
    }
    function close2 () {
        $("#wins").window("open");
    }
    function updsub() {
        $("#addform").form("submit",{
            success : function () {
                $("#addform").form("clear");
                window.location.href="<%=request.getContextPath()%>/dormitory/todormitory";
            }
        })
    }
    function close3 () {
        $("#wins").window("close");
    }

</script>
</body>
<script type="text/javascript">
    $(function () {
        var data2;
        $("#deptId").change(function () {
            $("#empnames").empty();
            var options = $("#deptId option:selected");　　　　//获取选中项
            var deptId = options.val();　　　　　　　　　　　　　　//获取选中项的值
            $.ajax({
                url: "<%=request.getContextPath()%>/dormitory/domselsen",
                type: "post",
                data: {
                    deptname: deptId
                },
                dataType: "json",
                success: function (data) {
                    var List = data.data;

                    $.each(List, function (index, obj) {
                        var html = "<option value=\"" + this.studId + "\"> " + this.stuName + "</option>";
                        //给省下拉框加上拼接的option
                        sesslist = this.empName;
                        $("#empnames").append(html);
                    });
                }
            })
        });
    });
    var seleVal='';
    var NameVal='';
    $("#adddept").on("click",function(){
        //var  id = $("#empnames>option:selected").val()+',';
        var id = $('#empnames').val()+',';
        var index=document.getElementById("empnames").selectedIndex;//获取当前选择项的索引.
        var name = document.getElementById("empnames").options[index].text;//获取当前选择项的文本.
        if(id == seleVal){
            alert("不能添加相同的用户");
            return;
        }
        seleVal+=id;
        NameVal+=name+',';
        $("#receId").val(seleVal);
        $("#receName").val(NameVal);
        $("#receName2").val(NameVal);
    });

    $("#deldept").on("click",function(){
        seleVal = '';
        $("#receId").val(" ");
    })
</script>
</html>
