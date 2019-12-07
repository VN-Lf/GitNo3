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
    <title>员工考核</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
</head>
<body>
<%--表格数据--%>
<div>
    <form style="width: 1205px;margin: 20px 0px 0px 10px">
        员工姓名:<input type="text" name="empname" id="empname" required lay-verify="required" placeholder="请输人姓名"  class="layui-input" style="width:180px;display:inline-block" />
        <div class="layui-form-item" style="width:280px;display:inline-block;margin-left: -30px;margin-right: 20px">
            <label class="layui-form-label" style="width: 97px;margin-left: 10px;"> 部门名称:</label>
            <div class="layui-input-block">
                <select name="Depid" id="Depid" lay-filter="aihao" style="width: 180px;height: 38px;border: 1px solid rgba(216,216,216,0.5)">
                    <option value="">请选择部门</option>
                    <option value="1">教研部</option>
                    <option value="2">财务部</option>
                    <option value="3">体育部</option>
                    <option value="4">咨询部</option>
                </select>
            </div>
        </div>
        开始时间:
        <div class="layui-inline" style="width:180px;display:inline-block;"> <!-- 注意：这一层元素并不是必须的 -->
            <input type="text" name="starttime" id="starttime" class="layui-input">
        </div>
        结束时间:
        <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元素并不是必须的 -->
            <input type="text" name="endtime" id="endtime"  class="layui-input">
        </div>
        <input class="layui-btn layui-btn-normal" id="selectexam" value="搜索" />
    </form>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
        </div>
    </script>
    <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
</div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="del">删除</a>
</script>
<script type="text/javascript">
    layui.use(['table','form','laydate'], function(){
        var table = layui.table;
        var form=layui.form;
        var laydate = layui.laydate;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/exam/empexamlist' //数据接口
            ,page: true //开启分页
            ,where:{empname:'',Depid:'',starttime:'',endtime:''}
            ,cols: [[ //表头
                {type:'checkbox',fixed:'left'}
                ,{field: 'aduitLogid', title: '编号', sort: true}
                ,{field: 'Remark', title: '考核内容'}
                ,{field: 'empid', title: '员工id'}
                ,{field: 'Scores', title: '考核分数', sort: true}
                ,{field: 'auditDate', title: '考核时间',templet: function(d){return dateFormat(d.auditDate)}}
                ,{field: 'auditPerson', title: '录入人员'}
                ,{field: 'aduitName', title: '说明'}
                ,{ fixed: 'right', title: '操作', width: 180, align: 'center', toolbar: '#barDemo' }
            ]]
        });
        //监听行工具栏
        table.on('tool(test)',function (obj) {
            var data=obj.data;
            var layevent=obj.event;
            if(layevent=='del'){
                layer.confirm('确认删除  '+data.aduitLogid+'?',{icon: 3, title: '提示信息'},function (data1) {
                    $.post('${pageContext.request.contextPath}/exam/empdeleteexam',{aduitLogid:data.aduitLogid},function (data) {
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
                            employeesId+=data[i].aduitLogid+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/exam/empalldelete',{
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
            };
        });

        //时间选择器
        laydate.render({
            elem: '#starttime' //指定元素
        });

        laydate.render({
            elem: '#endtime' //指定元素
        });

        $('#selectexam').click(function () {
            var empname=$('#empname').val();
            var Depid=$('#Depid').val();
            var starttime=$('#starttime').val();
            var endtime=$('#endtime').val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/exam/empexamlist',
                where:{
                    empname:empname,
                    Depid:Depid,
                    starttime:starttime,
                    endtime:endtime
                },page:{
                    curr:1
                }
            });
        })
    });
</script>

<script type="text/javascript">
    /*
    * 时间格式化工具
    * 把Long类型的1527672756454日期还原yyyy-MM-dd格式日期
    */
    function dateFormat(longTypeDate){
        var dateTypeDate = "";
        var date = new Date();
        date.setTime(longTypeDate);
        dateTypeDate += date.getFullYear();   //年
        dateTypeDate += "-" + getMonth(date); //月
        dateTypeDate += "-" + getDay(date);   //日
        return dateTypeDate;
    }
    //返回 01-12 的月份值
    function getMonth(date){
        var month = "";
        month = date.getMonth() + 1; //getMonth()得到的月份是0-11
        if(month<10){
            month = "0" + month;
        }
        return month;
    }
    //返回01-30的日期
    function getDay(date){
        var day = "";
        day = date.getDate();
        if(day<10){
            day = "0" + day;
        }
        return day;
    }
    //小时
    function getHours(date){
        var hours = "";
        hours = date.getHours();
        if(hours<10){
            hours = "0" + hours;
        }
        return hours;
    }
    //分
    function getMinutes(date){
        var minute = "";
        minute = date.getMinutes();
        if(minute<10){
            minute = "0" + minute;
        }
        return minute;
    }
    //秒
    function getSeconds(date) {
        var second = "";
        second = date.getSeconds();
        if (second < 10) {
            second = "0" + second;
        }
        return second;
    }
</script>
</body>
</html>
