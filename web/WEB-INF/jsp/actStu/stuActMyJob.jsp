<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/20
  Time: 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的请假单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<div class="layui-row">
</div>
<table id="demo" lay-filter="test">

</table>
</div>

<div class="layui-row" style="height:45%">
    下面部分的
    <div class="layui-tab">
        <ul class="layui-tab-title">
            <li>批注</li>
            <li>进度</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <table id="commentT" lay-filter="test"></table>
            </div>
            <div class="layui-tab-item">
                <table id="progressT" lay-filter="test"></table>
            </div>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>

<script>
    layui.use(['table'], function(){
        var table = layui.table;
        var openStuAc;
        var tableDemo;
        tableDemo = table.render({
            elem: '#demo'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/actStu/myJobList' //数据接口
            ,title: '我的请假单'
            ,cols: [[
                ,{field:'jobId',  title: '单据编号'}
                ,{field:'jobName', title: '单据名称'}
                ,{field:'day', title: '请假天数'}
                ,{field:'stuName',  title: '申请人'}
                ,{field:'jobDate ', title: '申请时间'}
                ,{field:'processFlag', title: '审批状态',templet:function (row){
                        return process(row.processFlag);
                        }
                 }
                ,{field:'remark',title: '申请说明'}
                ,{width:150, title: '操作',align:'center',fixed: 'right', toolbar: '#barDemo'}
            ]]
        });


        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'yes':
                    console.log(JSON.stringify(table.cache.demo));
                    layer.confirm('确定提交？', {icon: 3, title: '提示信息'},function (index){
                        $.ajax({
                            url:'${pageContext.request.contextPath}/sco/toAddScore',
                            async:true,
                            method:'post',
                            dataType:'text',
                            data:{
                                tableList:JSON.stringify(table.cache.demo),
                                classId:'${requestScope.cla.classId}',
                                testType:'${requestScope.studentScore.testType}',
                                termId:'${requestScope.studentScore.termId}',
                                testDH:'${requestScope.time}',
                                courseId:'${requestScope.studentScore.courseId}'
                            },
                            success:function(data){
                                window.open("${pageContext.request.contextPath}/sco/main","_self");
                            }
                        });
                    });
                    break;
            };
        });

        table.on('tool(test)', function(obj){
            var data = obj.data;
            jId = data.jobId;
            var name = data.jobName;
            switch(obj.event){
                case 'comment':
                    table.render({
                        elem: '#commentT'
                        ,url: '${pageContext.request.contextPath}/actStu/lookComment?jobId='+jId //数据接口
                        ,title: '批注'
                        ,cols: [[
                            ,{field:' ',  title: '单据编号',
                                templet: function (){
                                    return jId;
                                }
                            }
                            , {
                                field: ' ', title: '单据名称',
                                templet: function (){
                                    return name;
                                }
                            }
                            ,{field:'sj',  title: '审批时间 ',
                                templet: function (row){
                                    return createTime(row.sj);
                                }
                            }
                            ,{field:'empName', title:   '审批人 '}
                            ,{field:'fullMessage', title:'批注内容'}
                        ]]
                    });
                    break;
                case 'progress':
                    window.open('${pageContext.request.contextPath}/lookMyJob?jobId='+jId,'self');
                    break;
                }
        });
    })

    layui.use(['element','tab'], function(){
        var element = layui.element;
        var tab = layui.tab;
        tab.render({
            elem: '#commodity',
            toolbar: '#toolbarDemo5'
        })
    });

    function process(v){
        if(v==1){
            return "审批中"
        }else if(v==2){
            return "审批通过"
        }else if(v==3) {
            return "审批否决";
        }
        return""
    }
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

<script type="text/html" id="barDemo">
    <button type="button" class="layui-btn layui-btn-s" lay-event="comment">
       查看批注
    </button>
   <%-- <button type="button" class="layui-btn layui-btn-s" lay-event="progress">
        查看进度
    </button>--%>
</script>
</body>
</html>
