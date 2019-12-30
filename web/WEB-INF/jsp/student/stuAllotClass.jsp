<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/13
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>分配班级</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>

<div style="width: 14%;height: 500px;float: left;">
    <div id="test1"></div>
</div>

<div style="width: 86%;float: left;">
    <table class="layui-hide" id="test" lay-filter="cla"></table>
</div>


<div style="width: 86%;float: left;">
    学生
    <table class="layui-hide" id="studentData" lay-filter="stu"></table>
</div >


<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: left">
        <button class="layui-btn layui-btn-sm" lay-event="isChose">批量处理</button>
    </div>
    <!--4表的toolbar-->
    <div style="float: left;height: 20px;margin-top:-5px">
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">学生姓名</label>
            <div class="layui-input-block">
                <input id="stuSelectName" type="text" name="stuSelectName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">学生电话</label>
            <div class="layui-input-block">
                <input id="stuSelectPhone" type="text" name="stuSelectPhone" required  lay-verify="phone" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">班级类型</label>
            <div class="layui-input-block">
                <select name="claSelectType" lay-verify="required" placeholder=" " id="claSelectType">
                    <option> </option>
                    <c:forEach items="${classType}" var="ct">
                        <option value="${ct.classTypeName}">${ct.classTypeName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <button class="layui-btn layui-btn-sm" lay-event="isSelect">条件筛选</button>
    </div>
</script>

</body>

<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>

<!----><!---->
<script>
    layui.use(['table','form','tree'], function(){
        var tree = layui.tree;
        var table = layui.table;
        var cid;//班级Id
        var classN
        $.ajax({
            url:'${pageContext.request.contextPath}/stu/clatree',
            type:'post',
            data:"",
            dataType:'json',
            success:function (data){
                var inst1 = tree.render({
                    elem: '#test1'  //绑定元素
                    ,data:data
                    , click: function(obj){
                        cid = obj.data.id; //得到当前点击的节点数据
                        classN = obj.data.title;
                        table.render({
                            elem: '#test'
                            ,title:'此班级学生'
                            /*,toolbar: '#toolbarDemo'*/ //开启头部工具栏，并为其绑定左侧模板
                            ,url: '${pageContext.request.contextPath}/stu/stuByClass/select?studId='+cid //数据接口
                            ,page: true //开启分页
                            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                            ,cols: [[
                                {field:'studId', title: '学生ID'}
                                ,{field:'className', title: '班级'}
                                ,{field:'stuName', title: '学生姓名'} //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                                ,{field:'sourceType', title: '班级类别'}
                                ,{field:'stuSex', title: '性别'}
                                ,{field:'stuPhone', title: '电话号码'}
                                ,{field:'stuHisSchool', title: '毕业院校'}
                            ]]
                        });
                    }
                })
            }
        });



        table.render({
            elem: '#studentData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/stu/allotStu/toList' //数据接口
            ,page: true //开启分页
            ,title: '待分配学生'
            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {type:'checkbox'}//复选框
                ,{field:'enrollmentid', title: 'id'}
                ,{field:'stuName', title: '学生姓名'}
                ,{field:'cardId', title: '身份证'} //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                ,{field:'classTypeName', title: '班级类别'}
                ,{field:'status', title: '状态',
                    templet:function (row){
                        return allStatus(row.status);
                }}
                ,{field:'stuPhone', title: '电话号码'}
                ,{field:'school', title: '毕业院校'}
                ,{field:'stuSex', title: '性别'}
                 ,{field: 'MajorName', title: '专业类别', width:80}
                ,{field: 'enterEmp', title: '招生老师', width: 177}
                ,{field: 'score', title: '入学成绩', width: 177}
                ,{field: 'computer', title: '电脑', width: 177}
            ]]
        });

        //未分配班级学生头工具栏事件
        table.on('toolbar(stu)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isChose':
                    if(cid==0||cid==""||cid==null||cid==undefined){
                        layer.alert("请先选择班级");
                        return;
                    }
                    var checkStatus = table.checkStatus('studentData'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        layer.confirm('确定所选？', {icon: 3, title: '提示信息'},function (index){
                            $.post('${pageContext.request.contextPath}/stu/toClassAddStu',{
                                all: JSON.stringify(data),
                                cid:cid
                            },function(data){
                                table.reload("studentData");
                                table.reload("test")
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要添加的学生');
                    };
                    break;
                <!--条件筛选未分配学生-->
                case 'isSelect':
                    var stuSelectName = $('input[name="stuSelectName"]').val();
                    var stuSelectPhone = $('input[name="stuSelectPhone"]').val();
                    var claSelectType = $("#claSelectType").val();
                    table.reload('studentData',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: '${pageContext.request.contextPath}/stu/allotCon'
                        , method:'POST'
                        ,where:{
                            stuSelectName:stuSelectName,
                            stuSelectPhone:stuSelectPhone,
                            claSelectType:claSelectType
                        }
                    });
                    table.reload('studentData');
                    break;
            };
        });


        /*<!--班级头部工具栏-->
        table.on('toolbar(cla)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isChose':
                    var checkStatus = table.checkStatus('test'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].studId+",";
                        }
                        layer.confirm('确定从此班级移除学生？', {icon: 3, title: '提示信息'},function (index){
                            $.post('/stu/toDel/cla',{
                                studIds:employeesId,
                                cid :0
                            },function(data){
                                table.reload("studentData");
                                table.reload("test")
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要移除的学生');
                    };
                    break;
                <!--条件筛选此班级学生-->
                case 'isSelect':
                    var stuSelectName = $('input[name="stuSelectName"]').val();
                    var stuSelectPhone = $('input[name="stuSelectPhone"]').val();
                    table.reload('test',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: 'stu/con'
                        , method:'POST'
                        ,where:{
                            stuSelectName:stuSelectName,
                            stuSelectPhone:stuSelectPhone,
                            stuSelectCla:classN,
                            stuSelectFloor:""
                        }
                    });
                    table.reload('test');
                    break;
            };
        });
*/
    });


    function allStatus(v){
        if(v==1){
            return "意向学生"
        }else if(v==2){
            return "预定报名学生"
        }else if(v==3) {
            return "试学学生";
        }else if(v==4){
            return"在读学生"
        }else if(v==5){
            return"已毕业学生"
        }
        return"";
    }
</script>
</html>
