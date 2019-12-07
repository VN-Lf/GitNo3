<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <title>table模块快速使用</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="http://localhost:8888/jquery.js"></script>
</head>
<body>
<h1></h1>
<table id="demo" lay-filter="test"></table>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    jQuery.noConflict();
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 400
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/stu/toList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'studId', title: 'ID', width:100, sort: true}
                ,{field: 'stuName', title: '名字', width:100, sort: true}
                ,{field: 'stuHisSchool', title:'毕业院校', width:80}
                ,{field: 'stuSex', title: '性别', width:80, sort: true}
                ,{field: 'stuAge', title: '年龄', width:80}
                ,{field: 'stuBirthday', title: '生日', width: 177, templet:function (row){
                        return createTime(row.stuBirthday);
                    }
                }
                ,{field: 'stuPhone', title:'电话', width:80}
                ,{field: 'stuAddr', title: '地址', width: 177}
                ,{field: 'stuCla', title:'班级', width:80}
                ,{field: 'stuHouse', title: '寝室', width:80, sort: true}
                ,{field: 'stuEnterTime', title: '入学时间', width:80,
                    templet:function (row){
                        return createTime(row.stuEnterTime);
                    }
                }
                ,{field: 'interTecher', title: '介绍老师', width: 177}
                ,{field: 'stuStu', title: '状态', width:80}
                ,{field: 'stuNation', title: '民族', width: 177}
                ,{field: 'stuNatives', title: '籍贯', width:80, sort: true}
                ,{field: 'residence', title: '户籍性质', width:80}
                ,{field: 'cardId', title: '身份证', width: 177}
                ,{field: 'stuProfessional', title:'专业', width:80}
                ,{field: 'stuProLevel', title: '专业类别', width:80, sort: true}
                ,{field: 'studyType', title: '学习类别', width:80}
                ,{field: 'audition', title: '面试人', width: 177}
                ,{field: 'isvocational', title: '是否中专', width:80, sort: true}
                ,{field: 'qkMoney', title: '欠款金额', width:80}
                ,{field: 'score', title: '入学成绩', width: 177}
                ,{field: 'dibao', title: '低保', width:80, sort: true}
                ,{field: 'sourceType', title: '成绩类型', width:80}
                ,{field: 'danbaoren', title: '担保人', width: 177}
                ,{field: 'soldier', title:'兵役', width:80}
                ,{field: 'baominghao', title: '报名号', width:80, sort: true}
                ,{field: 'zhuxiao', title: '是否住校', width:80}
                ,{field: 'StuRemark', title: '说明', width:80}
                ,{field: 'zhuxuejin', title: '助学金', width:80}
                ,{field: 'tuixue', title: '是否退学', width:80}
                ,{field: 'xiuxue', title: '是否休学', width:80}
                ,{field: 'isComputer', title: '是否发放电脑', width:80}
                ,{field: 'collar', title: '是否领走电脑', width:80}
                ,{width:150, title: '操作',align:'center',fixed: 'right', toolbar: '#barDemo'}
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
                            employeesId+=data[i].studId+",";
                        }
                        alert(employeesId);
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/stu/toDel',{
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
                        var sid = 0;
                        window.open("${pageContext.request.contextPath}/stu/toAdd?stuId="+sid);
                    break;
            };
        });


        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch(obj.event){
                case 'edit':
                    var stuId = data.studId;
                    window.open("${pageContext.request.contextPath}/stu/toAdd?stuId="+stuId);
                    break;
                case 'fal':

                    break;
            }
        });

    });


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

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增员工</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <button type="button" data-method="notice" class="layui-btn layui-btn-sm" lay-event="fal">
        <i class="layui-icon">&#xe654;</i>家庭
    </button>
    <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">
        <i class="layui-icon">&#xe642;</i>
    </button>
</script>
</body>
</html>
