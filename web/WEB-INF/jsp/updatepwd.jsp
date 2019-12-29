<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/27
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>修改密码</title>
</head>
<body>
    <div>
        <form class="layui-form" id="f">
            原先密码<input type="text" name="oldpwd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"></br>
            新密码:<input type="text" name="newpwd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"></br>
            确认密码:<input type="text" name="newpwd1" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"></br>
            <input class="layui-btn layui-btn-normal" type="submit" id="pwd" value="修改" style="margin-left: 650px;width: 100px;height: 50px" />
        </form>
    </div>
</body>
<script type="text/javascript">
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;
        $("#pwd").click(
            function updatepqwd() {
                $("#f").form('submit',{
                    url:'${pageContext.request.contextPath}/emp/updatepwd',
                    method:'post',
                    //表单提交前进行的验证，true表示通过验证，false表示不通过验证
                    onSubmit:function () {
                        return $(this).form('validate');
                    },
                    success:function (data) {
                        layer.msg(data);
                    }
                })
            }
        )

        });
</script>
</html>
