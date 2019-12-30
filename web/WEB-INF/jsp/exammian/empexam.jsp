<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/9
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>考核录入</title>
</head>
<body>
    <%--表格数据--%>
    <div>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="isAdd">新建考评</button>
            </div>
            <div class="layui-btn-container" style="float: left">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>
        <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
    </div>
    <%--弹出层--%>
    <div style="display: none;margin-left: 60px;margin-top: 40px" id="add">
        <form  class="layui-form" method="post" action="${pageContext.request.contextPath}/exam/addkaohu" lay-filter="dataf">
            <input type="hidden" name="aduitModelid"/>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">班主任/任课老师:</label>
                <div class="layui-input-block">
                    <input name="empName" type="hidden" id="empNamekh">
                    <select name="empId" id="empIdkh"  lay-filter="demo" lay-verify="required" style="width: 250px">
                        <c:forEach items="${empnamelist}" var="list">
                            <option value="${list.empId}">${list.empName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">考核班级:</label>
                <div class="layui-input-block">
                    <select name="classname" id="class" lay-verify="required" style="width: 250px">
                        <option value="">请选择班级</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item" style="width: 450px">
                <label class="layui-form-label">结束时间:</label>
                <div class="layui-input-block" style="padding-top:7px">
                    <input id="godate" onblur="panduanDate()" name="date" type="date"/>
                    <input id="gotime" onblur="panduanTime()" name="time" value="00:00" type="time"/>
                </div>
            </div>
            <div class="layui-btn-container">
                <input class="layui-btn layui-btn-normal" type="submit" value="发起考核" style="margin-left: 150px" />
                <input 	class="layui-btn layui-btn-primary" type="button" onclick="closekaohu()"  value="取消"/>
            </div>

        </form>
    </div>
</body>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-bg-blue  layui-btn-xs"  lay-event="endexam">结束考核</a>
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
            ,url: '${pageContext.request.contextPath}/exam/emplistexam' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox',fixed:'left'}
                ,{field: 'empAssessId', title: '考核编号', sort: true}
                ,{field: 'empexamid', title: '员工类型'}
                ,{field: 'empName', title: '任课老师/班主任'}
                ,{field: 'classid', title: '任课班级'}
                ,{field: 'scores', title: '总评分(50满分)',templet:function (data) {
                        if(data.scores == 0){
                            return '考核中'
                        }else if(data.scores==null){
                            return  '0'
                        }else{
                            return  data.scores
                        }}}
                ,{ fixed: 'right', title: '操作', width: 380, align: 'center',templet:function (data) {
                        if(data.scores == 0){
                            return '<a class="layui-btn layui-bg-blue  layui-btn-xs"  lay-event="endexam">结束考核</a>\n' +
                                '    <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="del">删除</a>'
                        }else {
                            return  '<a class="layui-btn layui-bg-blue  layui-btn-xs">考核已结束</a>\n' +
                                '    <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="del">删除</a>'
                        }} }
            ]]
        });
        //监听行工具栏
        table.on('tool(test)',function (obj) {
            var data=obj.data;
            var layevent=obj.event;
            if(layevent=='del'){
                layer.confirm('确认删除  '+data.empAssessId+'?',{icon: 3, title: '提示信息'},function (data1) {
                    $.post('${pageContext.request.contextPath}/exam/deleteemp',{empAssessId:data.empAssessId},function (data) {
                        layer.msg(data);
                        table.reload("demo");
                    })
                })
            }
            if(layevent=='endexam'){
                layer.confirm('确认结束考核  '+data.empAssessId+'?',{icon: 3, title: '提示信息'},function (data1) {
                    $.post('${pageContext.request.contextPath}/exam/endexam',{empAssessId:data.empAssessId},function (data) {
                        layer.msg(data);
                        table.reload("demo");
                    })
                })
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
                            employeesId+=data[i].empAssessId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/exam/alldeleteemp',{
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
                    openkaohuexam();
                    break;
            };
        });


        function openkaohuexam() {
                index1=layer.open({
                type: 1,
                title:'录入考核',
                area: ['600px', '400px'],
                content:$('#add'),
                cancel:function () {
                    window.location.reload();
                }
            });
        }

        //下拉框监听
        form.on('select(demo)', function(data){
            var index=document.getElementById("empIdkh").selectedIndex;//获取当前选择项的索引.
            var name = document.getElementById("empIdkh").options[index].text;//获取当前选择项的文本
            document.getElementById("empNamekh").value=name;

            $("#class").empty();
            $.post('${pageContext.request.contextPath}/exam/classlist',{
                empname:data.value
            },function(data){
                var classlist=data;
                $.each(classlist,function(key,val){
                    //回调函数有两个参数,第一个是元素索引,第二个为当前值
                    var str="<option value='"+val+"'>"+val+"</option>";
                    $("#class").append(str);
                    form.render('select');
                });
            },"json");
            form.render('select');
        });

    });

    function closekaohu() {
        window.location.reload();
    }

    function panduanDate() {
        var gd = document.getElementById("godate").value;
        var date = new Date();
        var year = date.getFullYear();
        var day = date.getDate();
        var yue = date.getMonth()+1;
        var godt = year+"-"+yue+"-"+day;
        var cha =(new Date(gd)).getTime()-(new Date(godt)).getTime();
        if(cha < 0){
            alert("不能填写过去的时间为结束时间");
            document.getElementById("godate").value = "";
        }
    }

    function panduanTime() {
        var ti = document.getElementById("gotime").value+":00";
        var da = document.getElementById("godate").value;
        var date = new Date();
        var year = date.getFullYear();
        var day = date.getDate();
        var yue = date.getMonth()+1;
        var godt = year+"-"+yue+"-"+day;
        if(date.getHours() < 10){
            var hh = "0"+date.getHours();
        }else {
            var hh = ""+date.getHours();
        }
        if(date.getMinutes() < 10){
            var mm = "0"+date.getMinutes();
        }else {
            var mm = ""+date.getMinutes();
        }
        var xz = hh+":"+mm+":00";
        var cha = (new Date(da+" "+ti)).getTime() - (new Date(godt+" "+xz)).getTime();
        if(cha < 0){
            alert("不能填写过去的时间为结束时间");
            document.getElementById("gotime").value = "";
        }
    }
</script>
</html>
