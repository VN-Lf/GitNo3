<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/18
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>答辩成绩/</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<table id="demo" lay-filter="test">

</table>

!--考试成绩表单-->
<form  class="layui-form" id="addTextForm" style="display:none;height: auto;width: 600px" method="post"  target="_self">

    <div class="layui-form-item">
        <label class="layui-form-label" style="width:100px">班级</label>
        <div class="layui-input-block">
            <select name="classId" lay-verify="required" placeholder=" " id="classId">
                <option></option>
                <c:forEach items="${classList}" var="stuClass">
                    <option value="${stuClass.classId}">${stuClass.className}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width:100px">项目</label>
        <div class="layui-input-block">
            <select name="projectId" lay-verify="required" placeholder=" " id="projectId">
                <option> </option>
                <c:forEach items="${projectList}" var="pro">
                    <option value="${pro.projectId}">${pro.proName}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formSub">确定</button>
        </div>
    </div>
</form>

</body>
<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>
<script>
    layui.use(['table','form'], function(){
        var table = layui.table;
        var openStuAc;
        setTimeout(function(){
        table.render({
            elem: '#demo'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/sco/reply/toList' //数据接口
            ,page: true //开启分页
            ,title: '全部成绩'
            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {type:'checkbox'}//复选框
                ,{field:'stuReplyId', title: 'Id'}
                ,{field:'stuName', title: '学生'}
                ,{field:'className', title: '班级'}
                ,{field:'proName', title: '项目'}
                ,{field:'empName', title: '录入教师'}
                ,{field:'score1',title:'功能完善50'}
                ,{field:'Score2',title:'技术难度10'}
                ,{field:'Score3',title:'界面完美10'}
                ,{field:'Score4',title:'回答问题10'}
                ,{field:'Score5',title:'演示方法10'}
                ,{field:'Score6',title:'语言表达10'}
                ,{field:'Score7',title:'总分100'}
                ,{field:'replyScoreRemark',title:'备注'}
            ]]
        }),3000})

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case'isSelect':
                    var stuSelectName = $('input[name="stuSelectName"]').val();
                    var stuSelectCla = $('#stuSelectCla').val();
                    var stuSelectPro = $('#stuSelectPro').val();
                    table.reload('demo',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: '${pageContext.request.contextPath}/sco/repCon'
                        , method:'POST'
                        ,where:{
                            stuSelectName:stuSelectName,
                            stuSelectCla:stuSelectCla,
                            stuSelectPro:stuSelectPro
                        }
                    });
                    break;
                case 'isDel':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].stuReplyId+",";
                        }
                        layer.confirm('确定所选？', {icon: 3, title: '提示信息'},function (index){
                            $.post('${pageContext.request.contextPath}/sco/reply/del',{
                                id:employeesId,
                            },function(data){
                                table.reload("demo")
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的的成绩');
                    };
                    break;
                <!--新增成绩-->
                case 'isAddText':
                    openStuAc=  layer.open({
                        type: 1,
                        title: "录入成绩",
                        area: ['700px', '400px'],
                        content: $("#addTextForm"),
                        closeBtn: 1,
                        success: function (layero, index){

                        }
                    });
                    break;
            };
        });

        form.on('submit(formSub)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/sco/toReplyMa',
                type:'post',
                data:data.field,
                dataType:'text',
                success:function (da){
                    var d = da
                    if(d=='no'){
                        alert("此班级已有此答辩成绩存在");
                        return;
                    }else{
                        var classId =$('#classId').val();
                        var projectId = $('#projectId').val();
                        self.location= "${pageContext.request.contextPath}/sco/toClassRepScoByCid?classId="+classId+"&projectId="+projectId;
                    }
                }
            });
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
    <div>
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-s layui-btn-warm" lay-event="isAddText">批量录入</button>
            <button class="layui-btn  layui-btn-warm" lay-event="isDel">批量删除</button>
        </div>

        <div style="float: left;height:10px;margin-top:-40px;margin-left:300px">
            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">学生姓名</label>
                <div class="layui-input-block">
                    <input id="stuSelectName" type="text" name="stuSelectName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">班级</label>
                <div class="layui-input-block">
                    <select name="stuSelectCla" lay-verify="required" placeholder=" " id="stuSelectCla">
                        <option> </option>
                        <c:forEach items="${classList}" var="stuClass">
                            <option>${stuClass.className}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item" style="display: inline-block">
                <label class="layui-form-label" style="width:100px">项目</label>
                <div class="layui-input-block">
                    <select name="stuSelectPro" lay-verify="required" placeholder=" " id="stuSelectPro">
                        <option> </option>
                        <c:forEach items="${projectList}" var="pro">
                            <option>${pro.proName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <button class="layui-btn layui-btn-s" lay-event="isSelect" style="margin-left: 30px">条件查询</button>
        </div>
    </div>
</script>

</html>
