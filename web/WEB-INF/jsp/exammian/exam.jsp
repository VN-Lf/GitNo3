<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="source.jsp"%>
<head>
    <meta charset="utf-8">
    <title>考核指标</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
</head>
<body>
<%--表格数据--%>
<div>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container" style="float: left">
            <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="isAdd">新增指标</button>
        </div>
        <div class="layui-btn-container" style="float: left">
            <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
        </div>
    </script>
    <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
</div>
<%--弹出层--%>
<div style="display: none"  class="easyui-layout" id="update">
    <form class="layui-form" method="post" action="${pageContext.request.contextPath}/exam/updateexam" lay-filter="dataf">
        <input type="hidden" name="aduitModelid"/>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">考核内容</label>
            <div class="layui-input-block">
                <input type="text" name="aduitName" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">考核分数</label>
            <div class="layui-input-block">
                <input type="text" name="Scores" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  class="easyui-layout" style="width: 450px">
            <label class="layui-form-label">部门</label>
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元-->
                <select name="Depid" id="sxdept">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">说明</label>
            <div class="layui-input-block">
                <input type="text" name="Remark" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-btn-container">
            <input class="layui-btn layui-btn-normal" type="submit" value="修改" style="margin-left: 190px" />
            <input 	class="layui-btn layui-btn-primary" type="button" onclick="closeupdate()"  value="取消"/>
        </div>

    </form>
</div>

<%--弹出层--%>
<div style="display: none" id="add">
    <form class="layui-form" method="post" action="${pageContext.request.contextPath}/exam/addexam" lay-filter="dataf">
        <input type="hidden" name="aduitModelid"/>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">考核内容</label>
            <div class="layui-input-block">
                <input type="text" name="aduitName" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">考核分数</label>
            <div class="layui-input-block">
                <input type="text" name="Scores" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">部门</label>
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元-->
                <select id="sxdept2">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">说明</label>
            <div class="layui-input-block">
                <input type="text" name="Remark" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-btn-container">
            <input class="layui-btn layui-btn-normal" type="submit" value="新增" style="margin-left: 190px" />
            <input 	class="layui-btn layui-btn-primary" type="button" onclick="closeupdate()"  value="取消"/>
        </div>

    </form>
</div>


<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-bg-blue layui-btn-xs" lay-event="update">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="del">删除</a>
</script>
<script type="text/javascript">
    var index1="";
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/exam/examlist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',fixed:'left'}
                ,{field: 'aduitModelid', title: '编号', sort: true}
                ,{field: 'aduitName', title: '考核内容'}
                ,{field: 'Scores', title: '考核分数', sort: true}
                ,{field: 'deptName', title: '部门名称'}
                ,{field: 'Remark', title: '说明'}
                ,{ fixed: 'right', title: '操作', width: 180, align: 'center', toolbar: '#barDemo' }
            ]]
        });
        //监听行工具栏
        table.on('tool(test)',function (obj) {
            var data=obj.data;
            var layevent=obj.event;
            if(layevent=='del'){
                layer.confirm('确认删除  '+data.aduitModelid+'?',{icon: 3, title: '提示信息'},function (data1) {
                    $.post('${pageContext.request.contextPath}/exam/deleteexam',{aduitModelid:data.aduitModelid},function (data) {
                       layer.msg(data);
                        table.reload("demo");
                    })
                })
            }else if(layevent=='update'){
                console.log(data)
                openupdateexam(data);
            }
        });

        //批量删除，监听头部按钮
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].aduitModelid+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/exam/alldelete',{
                                id:employeesId
                            },function(data){
                                layer.msg(data);
                                table.reload("demo");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    openaddeexam();
                    break;
            };
        });

        function openupdateexam(data) {
                index1=layer.open({
                type: 1,
                title:'修改内容',
                area: ['500px', '300px'],
                content:$('#update') , //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                success:function (index) {
                    form.val('dataf',data)
                }
            });
        }

        layui.use(['form', 'upload', 'layer'], function () {
            var form = layui.form;
            $.ajax({
                url: '${pageContext.request.contextPath}/to/deptlist',
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    var json = data.data;
                    $.each(json, function (index, item) {
                        $('#sxdept').append(new Option(item.deptName,item.deptId));// 下拉菜单里添加元素
                        $('#sxdept2').append(new Option(item.deptName,item.deptId));// 下拉菜单里添加元素
                    });
                    form.render("select");
                }
            })
        });

        function openaddeexam(data) {
            index1=layer.open({
                type: 1,
                title:'修改内容',
                area: ['500px', '300px'],
                content:$('#add'),
            });
        }
    });

    function closeupdate() {
        layer.close(index1);
    }

</script>
</body>
</html>
