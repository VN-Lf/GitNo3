<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/10
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>上传文件</title>
</head>
<body>
    <form id="f" method="post" enctype="multipart/form-data" style="text-align: center;margin-top: 50px">
        选择图片:<input type="file" name="face" id="FM2" style="margin-right: -92px;margin-bottom: 20px" class="easyui-validatebox" data-options="required:true"></br>
        备注:<input type="area" name="remark" style="width: 200px;height:50px;margin-bottom: 40px" class="easyui-validatebox" data-options="required:true"></br>
        <input class="layui-btn layui-btn-normal" onclick="uploadfile()" value="上传文档" style="margin-left: 60px "/>
    </form>
</body>
<script type="text/javascript">
    function uploadfile() {
        $("#f").form('submit',{
            url:'${pageContext.request.contextPath}/upload/addupload',
            method:'post',
            //表单提交前进行的验证，true表示通过验证，false表示不通过验证
            onSubmit:function () {
                return $(this).form('validate');
            },
            success:function () {
                window.parent.location.reload(); //新增成功后刷新父界面
            }
        })

    }
</script>
</html>
