<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/17
  Time: 19:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>考核邮件</title>
</head>
<body>
    <div>
        <table class="layui-table" id="demo" lay-data="{id: 'idTest'}" lay-filter="test"></table>
    </div>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="openemail">打开邮件</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="del">删除</a>
    </script>
</body>
<script type="text/javascript">
    layui.use(['table','form','laydate'], function(){
        var table = layui.table;
        var form=layui.form;
        var laydate = layui.laydate;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,method:'post'
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/exam/kaohulist' //数据接口
            ,page: true //开启分页
            ,where:{empname:'',Depid:'',starttime:'',endtime:''}
            ,cols: [[ //表头
                {type:'checkbox',fixed:'left'}
                ,{field: 'emailId', title: '编号', sort: true}
                ,{field: 'content', title: '内容'}
                ,{field: 'empId', title: '发送人'}
                ,{field: 'topic', title: '标题', sort: true}
                ,{field: 'sendtime', title: '发送时间',templet: function(d){return dateFormat(d.sendtime)}}
                ,{ fixed: 'right', title: '操作', width: 380, align: 'center', toolbar: '#barDemo' }
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
            }else if(layevent=='openemail'){
                $.post('${pageContext.request.contextPath}/exam/empdeleteexam',{aduitLogid:data.aduitLogid},function (data) {
                    layer.msg(data);
                    table.reload("demo");
                })
            }
        });
    });

    function closekaohu() {
        window.location.reload();
    }
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
</html>
