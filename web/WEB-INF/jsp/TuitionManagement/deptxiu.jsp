<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/16
  Time: 19:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../index.jsp"%>
<html>
<head>
    <title>修改部门</title>
</head>
<body>
<form class="layui-form" action="${pageContext.request.contextPath}/Tuition/deptup" lay-filter="formTest" method="post">
    <input type="hidden" name="deptId" id="deptid">
    <div class="layui-form-item" style="width: 450px">
        <label class="layui-form-label">部门名称</label>
        <div class="layui-input-block">
            <input type="text" name="deptName" id="deptname" required  lay-verify="required" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">部门描述</label>
        <div class="layui-input-block">
            <textarea style="width: 340px;height: 135px" name="deptRemark" id="miaoshu" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-btn-container">
        <button class="layui-btn" lay-submit lay-filter="formDemo" style="width:150px;margin-left: 180px">立即修改</button>
    </div>
</form>

<script>
    layui.use(['form','layer'], function(){
        $ = layui.jquery;
        var form = layui.form
            ,layer = layui.layer;

        form.on('submit(formDemo)', function(data){
            window.parent.location.reload();
            return true;
        });

        form.val("formTest",{//formTest 即 class="layui-form" 所在元素属性 lay-filter="" 对应的值
            "deptId":${requestScope.dept.deptId}
            ,"deptName":'${requestScope.dept.deptName}'
            ,"deptRemark":'${requestScope.dept.deptRemark}'
        });
    });
</script>
</body>
</html>
