<%@ page import="com.nothing.vo.Email.Email" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <%Email email = (Email) request.getAttribute("againEmail");%>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <form action="<%=request.getContextPath()%>/email/sendEmail"  enctype="multipart/form-data" id="addDor" method="post" style="width: 1205px;margin: 20px 0px 0px 10px">

            <div style="width: 400px; left:250px; top:15px;height: 100px;position: relative">
                <div>
                    标题 : <input type="text" name="topic" value="<%=email.getTopic()%>" required lay-verify="required" placeholder="请输人标题"  class="layui-input" style="width:180px;display:inline-block" />
                </div>
                <div>
                    接收人：
                    <input type="text" name="receId" id="receId" value="<%=email.getReceId()%>," required lay-verify="required"   class="layui-input" style="width:180px;display:inline-block" />
                    <%--<a>查找</a>--%>
                    <br>

                </div>
                <br>
                <div>
                    附件：<input type="file" name="face" id="file" >
                </div>
                <br>
                <div>
                    <h3> 邮件内容</h3>
                    <textarea name="content" id="content"  style=" left: 400px;width: 500px; height: 200px"><%=email.getContent()%></textarea>
                </div>
                <div>
                    <button type="button" class="layui-btn layui-btn-primary" onclick="add();">发送</button>
                    <button type="button" class="layui-btn layui-btn-primary" onclick="close1()">退出</button>
                </div>
            </div>


        </form>
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
                        var html = "<option value=\"" +this.empName + "\"> " + this.empName + "</option>";
                        //给省下拉框加上拼接的option
                        $("#empnames").append(html);
                    });
                }
            })
        })
    })
</script>
<script>
    var seleVal='';
    $("#adddept").on("click",function(){
        seleVal+=$("#empnames>option:selected").val()+',';
        $("#receId").val(seleVal);
    })
</script>
</body>
</html>
