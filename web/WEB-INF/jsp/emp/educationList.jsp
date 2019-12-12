<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/6
  Time: 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="./../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
        <div id="empTabs" class="easyui-tabs" fit="true">
            <div title="教育经历">
                <table id="edu" lay-filter="edu"></table>
            </div>
            <div title="工作经历">
                <table id="his" lay-filter="job"></table>
            </div>
        </div>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#edu'
            ,height: 312
            ,toolbar: '#toolbarEdu' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/empEducationList?eid='+${currActEmpId} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'empUniversity', title: '学校名称', width:110}
                ,{field: 'empDegree', title: '文凭', width:100}
                ,{field: 'empEucStartDay', title: '入校时间', width:110}
                ,{field: 'empEucEndDay', title: '毕业时间', width:110}
                ,{field: 'empEucRemark', title: '说明', width:100}
                ,{field: 'empId', title: '操作', width: 120, templet:
                     function (row){
                         return eduAct(row.empEduId);
                    }
                }
            ]]
        });
        table.render({
            elem: '#his'
            ,height: 312
            ,toolbar: '#toolbarJH' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/emp/empHis?eid='+${currActEmpId} //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'empHisCompany', title: '公司名称', width:110}
                ,{field: 'empHisDegree', title: '职务', width:100}
                ,{field: 'empHisStartDay', title: '入职时间', width:110}
                ,{field: 'empHisEndDay', title: '离职时间', width:110}
                ,{field: 'empLiftReason', title: '离职原因', width:100}
                ,{field: 'empHisRemark', title: '说明', width:100}
                ,{field: 'empId', title: '操作', width: 120, templet:
                        function (row){
                            return jobAct(row.empHisId);
                        }
                }
            ]]
        });

        table.on('toolbar(edu)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('edu'),
                        data = checkStatus.data,
                        eduId = "";
                    if(data.length > 0){
                        for (var i in data){
                            eduId+=data[i].empEduId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/eduDel',{
                                id:eduId
                            },function(data){
                                alert("删除"+data);
                                table.reload("edu");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    addTab("新增记录","${pageContext.request.contextPath}/emp/eduAddPage");
                    break;
            };
        });
        table.on('toolbar(job)', function(obj){//注：tool 是工具条事件名，job 是 table 原始容器的属性 lay-filter="对应的值"
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('job'),
                        data = checkStatus.data,
                        HisId = "";
                    if(data.length > 0){
                        for (var i in data){
                            HisId+=data[i].empHisId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/emp/jobDel',{
                                id:HisId
                            },function(data){
                                alert("删除"+data);
                                table.reload("job");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    addTab("新增记录","${pageContext.request.contextPath}/emp/jobAddPage");
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

    function addTab(title, url) {
        if ($('#empTabs').tabs('exists', title)) { //如果存在
            $('#empTabs').tabs('select', title); //让标签页选中

            var currTab = $('#empTabs').tabs('getSelected'); //获取当前选中的选项页(返回panel对象)
            $('#empTabs').tabs('update', {
                tab: currTab,
                options: {
                    content: createFrame(url)
                }
            })
        } else { //如果这个标题的选项卡不存在
            var content = createFrame(url);
            $('#empTabs').tabs('add', {
                title: title, //标题
                content: content, //内容
                closable: true //显示关闭按钮
            });
        }
        tabClose();
    }

    function createFrame(url) { //创建窗口
        var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:99%;"></iframe>';
        return s;
    }

    function tabClose() {
        $(".tabs-inner").dblclick(function() {
            var subtitle = $(this).children(".tabs-closable").text();
            $('#empTabs').tabs('close', subtitle);
        })
    }
    //edu生成操作按钮
    function eduAct(id) {
        return "<div class=\"layui-btn-group\">\n" +
            "  <button onclick='eduUp("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe642;</i>\n" +
            "  </button>\n" +
            "  <button onclick='eduDel("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe640;</i>\n" +
            "  </button>\n"
            "</div>"
    }
    function eduUp(id) {
        addTab("修改记录","${pageContext.request.contextPath}/emp/eduUpPage?eid="+id)
    }
    function eduDel(id) {
        layer.confirm('确认删除  ',{icon: 3, title: '提示信息'},function (d) {
            $.post('${pageContext.request.contextPath}/emp/eduDel',{id:id},function (data) {
                layer.msg(data);
                table.reload("edu");
            })
        })
    }
    //job生成操作按钮
    function jobAct(id) {
        return "<div class=\"layui-btn-group\">\n" +
            "  <button onclick='jobUp("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe642;</i>\n" +
            "  </button>\n" +
            "  <button onclick='jobDel("+id+")' type=\"button\" class=\"layui-btn layui-btn-sm\">\n" +
            "    <i class=\"layui-icon\">&#xe640;</i>\n" +
            "  </button>\n"
        "</div>"
    }
    function jobUp(id) {
        addTab("修改记录","${pageContext.request.contextPath}/emp/jobUpPage?eid="+id)
    }
    function jobDel(id) {
        layer.confirm('确认删除  ',{icon: 3, title: '提示信息'},function (d) {
            $.post('${pageContext.request.contextPath}/emp/jobDel',{id:id},function (data) {
                layer.msg(data);
                table.reload("his");
            })
        })
    }
</script>

<script type="text/html" id="toolbarEdu">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增记录</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
</script>
<script type="text/html" id="toolbarJH">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增记录</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
</script>
</html>
