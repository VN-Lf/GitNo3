<%@ page import="com.nothing.vo.emp.Post" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/4
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../index.jsp"%>
<html>
<head>
    <title>员工列表页</title>
    <% Post post = (Post) session.getAttribute("post");%>
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
</head>
<body id="main" style="height: 100%;width: 100%" class="easyui-layout">
    <div data-options="region:'center',split:true">
        <form class="layui-form" style="width: 1205px;margin: 20px 0px 0px 10px">
            所在部门:
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元-->
                <select id="sxdept">
                    <option value=""></option>
                </select>
            </div>
            员工姓名:
            <input type="text" id="sxname" required lay-verify="required" placeholder="请输人姓名"  class="layui-input" style="width:180px;display:inline-block" />
            手机号码:
            <input type="text" id="sxphone" required lay-verify="required" placeholder="请输人手机号码"  class="layui-input" style="width:180px;display:inline-block" />
            账号状态:
            <div class="layui-inline" style="width:90px;display:inline-block"> <!-- 注意：这一层元素并不是必须的 -->
                <select id="sxzt">
                    <option value=""></option>
                    <option value="1">可用</option>
                    <option value="0">封禁</option>
                </select>
            </div>
            <input class="layui-btn layui-btn-normal" id="shaixuan" style="width: 80px" value="筛选" />
        </form>
        <table id="demo" class="layui-bg-black" lay-filter="test"></table>
    </div>
    <div id="east" data-options="region:'east',collapsed:true,title:'其他信息'" style="width: 650px;">
        <h1 style="text-align: center" >单击操作最右侧图标以查看</h1>
    </div>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#demo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/emplist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'empId', title: '编号', width:73, sort: true}
                ,{field: 'empName', title: '姓名', width:150}
                ,{field: 'deptName', title: '部门', width:87}
                ,{field: 'postName', title: '职务', width:150}
                ,{field: 'empSex', title: '性别', width: 63}
                ,{field: 'empPhone', title: '手机号码', width:150}
                ,{field: 'empAddress', title: '家庭地址',width:400}
                ,{field: 'empLoginStatus', title: '当前状态', width:87,
                    templet:function (row){
                        return loginStatus(row.empLoginStatus);
                    }}
                <%if(post.getPostName().indexOf("部长")!=-1 || post.getPostName().indexOf("校长")!=-1){%>
                ,{field: 'empLoginStatus', title: '是否禁用', width:95,templet:function (row){
                        return onclikId(row.empLoginStatus);
                    }
                },{field: 'empId', title: '密码', width:88,
                    templet:function (row){
                        return "<a class=\"layui-btn layui-btn-danger layui-btn-xs\" style='margin-top: 3px' onclick='chonZhi("+row.empId+")' lay-event=\"del\">重置密码</a>";
                    }
                },{field: 'empId', title: '操作', width:150,
                    templet:function (row){
                        return chaoZuo(row.empId,0);
                    }
                }
                <%}else {%>
                ,{field: 'empId', title: '操作', width:150,
                    templet:function (row){
                        return chaoZuo(row.empId,1);
                    }
                }
                <%}%>
            ]]
        });
        $('#shaixuan').click(function () {
            var emp = $('#sxname').val();
            var dept = $('#sxdept').val();
            var phone = $('#sxphone').val();
            var zt = $('#sxzt').val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/emp/emplistsx',
                where:{
                    emp:emp,
                    dept:dept,
                    phone:phone,
                    zt:zt
                },page:{
                    curr:1
                }
            });
        });
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].empId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/toDel',{
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
                    window.open("${pageContext.request.contextPath}/to/empadd");
                    break;
            };
        });
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'ban') {
                if(data.empLoginStatus == '1') var tishi = "确认禁用该用户吗？";
                else if(data.empLoginStatus == '0') var tishi = "确认解禁该用户吗？";

                layer.confirm(tishi, {icon: 3, title: '提示信息'}, function (index){
                    $.post('${pageContext.request.contextPath}/emp/banemp',{
                        id:data.empId,
                        zt:data.empLoginStatus
                    },function(data){
                        layer.msg('<div style="padding: 20px 100px;">'+"操作成功"+'</div>');
                        location.reload();
                    });
                },function () {
                    location.reload();
                });
            }
        });
    });
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
                });
                form.render("select");
            }
        })

    });
    //判断当前用户的状态
    function loginStatus(v){
        if(v == 1){
            return '<span style="color: black">正常</span>';
        }else if(v == 0){
            return '<span style="color: red">禁用</span>'
        }
    }
    function onclikId(v) {
        if(v == 1){
            var html = "<a lay-event=\"ban\">\n" +
                "        <input type=\"checkbox\"  style=\"width: 50px\" lay-filter=\"switchTest\" lay-skin=\"switch\" lay-text=\"禁用|未禁\" >\n" +
                "    </a>"
        }else if(v == 0){
            var html = "<a lay-event=\"ban\">\n" +
                "        <input type=\"checkbox\" checked style=\"width: 50px\" lay-filter=\"switchTest\" lay-skin=\"switch\" lay-text=\"禁用|未禁\" >\n" +
                "    </a>"
        }
        return html;
    }

    function chaoZuo(id,pand) {
        var html =  "<div class=\"layui-btn-group\">\n" +
            "  <button onclick='updateUser("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe642;</i>\n" +
            "  </button>\n" +
            "  <button onclick='delUser("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe640;</i>\n" +
            "  </button>\n" +
            "  <button onclick='ortherInf("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe615;</i>\n" +
            "  </button>\n" +
            "</div>";
        if(pand == 1){
            if(id == <%=post.getEmpId()%>){
                return html;
            }else {
                return "";
            }
        }else {
            return html;
        }
    }

    function updateUser(id) {
        window.location.href="${pageContext.request.contextPath}/emp/empup?id="+id;
    }
    function delUser(id) {
        layer.confirm('确定删除该员工吗？', {icon: 3, title: '提示信息'}, function (index){
            $.ajax({
                url:'${pageContext.request.contextPath}/emp/toDelon?sid='+id,
                type:'post',
                dataType:'json',
                success:function (data){
                    if(data.msg == 'you'){
                        layer.msg('删除成功', {icon: 1});
                        location.reload();
                    }else {
                        layer.confirm('删除失败 请重试', {
                            btn: ['我知道了'],anim: 6,icon: 5,btnAlign: 'c'
                        });
                    }
                }
            });
        })
    }
    function chonZhi(id) {
        layer.confirm('重置密码后为123456 确认吗？', {icon: 3, title: '提示信息'}, function (index){
            $.post('${pageContext.request.contextPath}/emp/czpwd',{
                sid:id
            },function(data){
                layer.msg('<div style="padding: 20px 100px;">'+"重置成功"+'</div>');
            });
        });
    }
    $("#ban19").change(function() {
        alert("checked");
    });
    //查看其他信息
    function ortherInf(empid) {
        $('#main').layout('expand','east');
        load(empid);
    }
    function load(empid) {
        document.getElementById("east").innerHTML =
            '<object type="text/html" data="${pageContext.request.contextPath}/to/empEdu?id='+empid+'" width="100%" height="100%"></object>';
    }
</script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: left">
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="isDele">批量删除</button>
        <button class="layui-btn layui-btn-sm"><a style="color: white" href="${pageContext.request.contextPath}/to/empadd">新增员工</a></button>
    </div>
</script>
</html>
