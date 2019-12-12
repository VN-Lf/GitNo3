<%--
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
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
</head>
<body id="main" class="easyui-layout">
    <div data-options="region:'center',split:true">
        <div style="width: 99%;margin: 0 auto">
            <table id="demo" lay-filter="test"></table>
        </div>
    </div>
    <div id="east" data-options="region:'east',collapsed:true,title:'其他信息'" style="width: 650px;">
        <h1 style="text-align: center" >There's nothing here</h1>
    </div>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //生成动态按钮
        table.render({
            elem: '#demo'
            ,height: 312
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/emplist' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'empId', title: '编号', width:73, sort: true}
                ,{field: 'empName', title: '姓名', width:87}
                ,{field: 'deptName', title: '部门', width:87}
                ,{field: 'postName', title: '职务', width:87}
                ,{field: 'empSex', title: '性别', width: 63}
                ,{field: 'empPhone', title: '手机号码', width:122}
                ,{field: 'empAddress', title: '家庭地址', width:140}
                ,{field: 'empLoginStatus', title: '当前状态', width:87,
                    templet:function (row){
                        return loginStatus(row.empLoginStatus);
                    }
                },{field: 'empId', title: '是否禁用', width:87,
                    templet:function (row){
                        return onclikId(row.empId);
                    }
                },{field: 'empId', title: '密码', width:88,
                    templet:function (row){
                        return "<a class=\"layui-btn layui-btn-danger layui-btn-xs\" style='margin-top: 3px' onclick='chonZhi("+row.empId+")' lay-event=\"del\">重置密码</a>";
                    }
                },,{field: 'empId', title: '操作', width:150,
                    templet:function (row){
                        return chaoZuo(row.empId);
                    }
                }
            ]]
        });

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = "";
                    alert(employeesId);
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].empId+",";
                        }
                        alert(employeesId);
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/toDel',{
                                id:employeesId
                            },function(data){
                                alert("删除"+data);
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

        table.on('checkbox(filter)', function(data){
            //console.log(data.elem); //得到checkbox原始DOM对象
            if(data.elem.checked == true){
                alert("打开："+data.value);
            }else if(big.checked == false){
                alert("关闭"+data.value);
            }
            //console.log(data.value); //复选框value值，也可以通过data.elem.value得到
            //console.log(data.othis); //得到美化后的DOM对象
        });
    });
    //判断当前用户的状态
    function loginStatus(v){
        if(v == 1){
            return '正常';
        }else if(v == 0){
            return '禁用'
        }
    }
    function onclikId(v) {
        return "<div style=\"margin-top: 2px\">\n" +
            "            <input type=\"checkbox\" id='ban"+v+"' value='ban"+v+"' style=\"width: 50px\" lay-filter=\"filter\" lay-skin=\"switch\" lay-text=\"禁用|未禁\" >\n" +
            "        </div>";
    }

    function chaoZuo(id) {
        return "<div class=\"layui-btn-group\">\n" +
            "  <button onclick='updateUser("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe642;</i>\n" +
            "  </button>\n" +
            "  <button onclick='delUser("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe640;</i>\n" +
            "  </button>\n" +
            "  <button onclick='ortherInf("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe615;</i>\n" +
            "  </button>\n" +
            "</div>"
    }

    function updateUser(id) {
        alert("编辑用户id："+id);
    }

    function delUser(id) {
        alert("删除用户id："+id);
    }

    function chonZhi(id) {
        if (confirm("重置密码后为123456 确认吗？")) {
            var xmlHttp = createXMLHttp();
            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                    if (xmlHttp.responseText == "true") {
                        alert("重置成功");
                        location.reload();
                    }
                }
            }
            var url = "${pageContext.request.contextPath}/emp/czpwd?sid="+id;
            xmlHttp.open("post", url, true);
            xmlHttp.send();
        }
    }

    //查看其他信息
    function ortherInf(empid) {
        $('#main').layout('expand','east');
        load(empid);
    }
    function load(empid) {
        document.getElementById("east").innerHTML =  '<object type="text/html" data="empEdu?id='+empid+'" width="100%" height="100%"></object>';
    }
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="isDele">批量删除</button>
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增员工</button>
        <button class="layui-btn layui-btn-sm"><a style="color: white" href="${pageContext.request.contextPath}/to/empadd">本页新增</a></button>
    </div>
</script>
</html>