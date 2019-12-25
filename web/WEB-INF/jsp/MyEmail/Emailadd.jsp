<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/14
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加Email</title>
    <%String yangshi = (String) session.getAttribute("color");%>
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
    <style>
        div{
        <%if("dark-hive".equals(yangshi)){%>
            color: white;
        <%}else {%>
            color: black;
        <%}%>
        }
    </style>
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <form action="<%=request.getContextPath()%>/email/sendEmail"  enctype="multipart/form-data" id="addDor" method="post" style="width: 1205px;margin: 20px 0px 0px 10px">

            <div style="width: 400px; left:250px; top:15px;height: 100px;position: relative;font-size: 14px">
                <div>
                    标题 :
                    <input type="text" name="topic"  required lay-verify="required" placeholder="请输人标题" class="layui-input"
                                style="width:238px;display:inline-block;margin-left: 10px;" />
                </div>
                <div>
                    部门：<select id="deptId" style="width: 90px;height: 35px;margin: 10px">
                            <c:forEach items="${Edeptlist}" var="li">
                                <option value=${li.get("deptId")}>${li.get("deptName")}</option>
                            </c:forEach>
                        </select>
                    员工：<select id="empnames" style="width: 90px;height: 35px"></select>
                </div>
                <div style="margin: 10px 48px">
                    <a style="font-size: 16px;cursor: pointer;" id="adddept" name="adddept">添加</a>
                    <a style="font-size: 16px;margin-left: 102px;color: red;cursor: pointer;" id="deldept"
                       name="deldept" style="left: 225px">重 置</a>
                </div>
                <div style="margin-top: 15px">
                    接收人：
                    <input type="hidden" name="receId" id="receId">
                    <input type="hidden" name="receName" id="receName2">
                    <input type="text" id="receName" autocomplete="off" disabled required style="width:228px;height:30px;
                    display:inline-block;padding-left:10px;background-Color: transparent;border: none;border-bottom: 1px solid #000;" />
                </div>
                <div style="margin-top: 15px">
                    附件：<input type="file" name="face" id="file" >
                </div>
                    <br>
                <div style="margin-top: 15px">
                    <h3> 邮件内容:</h3>
                    <textarea name="content" id="content" style=" left: 400px;width: 500px; height: 200px"></textarea>
                </div>
                <div>
                    <button type="button" class="layui-btn layui-btn-primary" onclick="add();">发送</button>
                    <button type="button" class="layui-btn layui-btn-primary" onclick="close1()">退出</button>
                </div>
            </div>


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
</div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    //解决jquery包冲突
    jQuery.noConflict();

    function close1 () {
        window.location.href="<%=request.getContextPath()%>/email/toemail";
    }
    function add() {
        $("#addDor").form("submit",{
            success : function () {
                $("#addDor").form("clear");
                window.location.href="<%=request.getContextPath()%>/email/toemail";
            }
        })
    }
    $(function () {
       /* $('#cc').combo({
            required:true,
            multiple:true
        });*/
        var data2;
        $("#deptId").change(function () {
            $("#empnames").empty();
            /* var myselect = document.getElementById("#deptId");
             alert(myselect)*/
            var options = $("#deptId option:selected");　　　　//获取选中项
            var deptId = options.val();　　　　　　　　　　　　　　//获取选中项的值
            /*alert(deptname)　　　　*/　　　　　　　　　　　　　　                  //检验是否获取到值
            $.ajax({
                url : "<%=request.getContextPath()%>/email/selsendEmail",
                type: "post",
                data :{
                    deptname :deptId
                },
                dataType : "json",
                success : function (data) {
                    var List = data.data;

                    $.each(List,function(index,obj){
                        /*alert(this.empName);*/
                        var html = "<option value=\"" +this.empId + "\"> " + this.empName + "</option>";
                        //给省下拉框加上拼接的option
                        sesslist =this.empName;
                        /*data2= {"value": this.empName, "title": this.empName}*/
                        $("#empnames").append(html);
                    });
                }
            })
        });

    })



</script>
<script>
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
</body>
</html>
